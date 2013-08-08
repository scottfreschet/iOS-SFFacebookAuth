//
//  SFApplication.m
//  iOS-SFFacebookAuth
//
//  Created by Scott Freschet on 8/8/13.
//  Copyright (c) 2013 Scott Freschet. All rights reserved.
//

#import "SFApplication.h"

@interface SFApplication ()

@end

@implementation SFApplication

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
    
    // Register notification callbacks.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification_Facebook_User_Details:) name:NOTIFICATION_FACEBOOK_USER_DETAILS object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///////////////////////////////////////////////////////////////////
#pragma mark - Notification Handlers.
///////////////////////////////////////////////////////////////////

- (void)notification_Facebook_User_Details:(NSNotification*)notification
{
    // Grab the notification data.
    NSDictionary* data = [notification object];
    NSLog(@"username is: %@", [data objectForKey:NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USERNAME]);
    
    self.xLabel_UserId.text = [data objectForKey:NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USERID];
    self.xLabel_UserName.text = [data objectForKey:NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USERNAME];
    self.xLabel_UserGender.text = [data objectForKey:NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USERGENDER];
    self.xLabel_UserEmail.text = [data objectForKey:NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USEREMAIL];
    
    
}

@end
