//
//  SFLogin.m
//  iOS-SFFacebookAuth
//
//  Created by Scott Freschet on 8/8/13.
//  Copyright (c) 2013 Scott Freschet. All rights reserved.
//

#import "SFLogin.h"

@interface SFLogin ()

@end

@implementation SFLogin

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Setup view.
    self.xSpinner.hidden = YES;
    
    // Register notification callbacks.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification_Facebook_Session_State_Changed:) name:NOTIFICATION_FACEBOOK_SESSION_STATE_CHANGED object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///////////////////////////////////////////////////////////////////
#pragma mark - Notification Handlers.
///////////////////////////////////////////////////////////////////

- (void)notification_Facebook_Session_State_Changed:(NSNotification*)notification
{
    if (FBSession.activeSession.isOpen)
    {
        // Hide xImageView_Login.
        self.xImageView_Login.hidden = YES;
        
        // Show xSpinner.
        self.xSpinner.hidden = NO;
        [self.xSpinner startAnimating];
        
        // Create a new user if it does not exist in the DMUser DynamoDB table.
        //__block BOOL dismissLoginViewController = NO;
        [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser>* fbUser, NSError *error)
         {
             if (!error)
             {
                 NSLog(@"---------- Facebook Login Information ----------");
                 NSLog(@"User Id:     %@", fbUser.id);
                 NSLog(@"User Name:   %@", fbUser.name);
                 NSLog(@"User Gender: %@", [fbUser objectForKey:@"gender"]);
                 NSLog(@"User Email:  %@", [fbUser objectForKey:@"email"]);
                 NSLog(@"------------------------------------------------");
                 
                 // Save Facebook Login Information.
                 NSString* userId = fbUser.id;
                 NSString* userName = fbUser.name;
                 NSString* userGender = [fbUser objectForKey:@"gender"];
                 NSString* userEmail = [fbUser objectForKey:@"email"];
                 
                 // Prepare data for notification.
                 NSDictionary* data = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       userId, NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USERID,
                                       userName, NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USERNAME,
                                       userGender, NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USERGENDER,
                                       userEmail, NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USEREMAIL,
                                       nil];
                 
                 // Present appropriate viewController.
                 UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                 UIViewController* SFApplication = [storyboard instantiateViewControllerWithIdentifier:@"SFApplication"];
                 [self presentViewController:SFApplication animated:NO completion:^
                  {
                      [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_USER_DETAILS object:data];
                  }];
                 
             }
         }];
    }
}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark - IBActions.
////////////////////////////////////////////////////////////////////////////////////

-(IBAction)loginTapped:(id)sender
{
    FacebookUtils* facebookUtils = [[FacebookUtils alloc]init];
    [facebookUtils facebook_OpenSession:YES];
}


@end
