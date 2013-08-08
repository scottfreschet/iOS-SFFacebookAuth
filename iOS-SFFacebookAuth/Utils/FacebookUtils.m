//
//  FacebookUtils.m
//  iOS-SFFacebookAuth
//
//  Created by Scott Freschet on 8/8/13.
//  Copyright (c) 2013 Scott Freschet. All rights reserved.
//

#import "FacebookUtils.h"

/////////////////////////////////////////
#pragma mark - Notification Constants.
/////////////////////////////////////////
NSString* const NOTIFICATION_FACEBOOK_SESSION_STATE_CHANGED = @"notification_facebook_session_state_changed";
NSString* const NOTIFICATION_FACEBOOK_USER_DETAILS = @"notification_facebook_user_details";
NSString* const NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USERID = @"notification_facebook_user_details_dk_userId";
NSString* const NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USERNAME = @"notification_facebook_user_details_dk_userName";
NSString* const NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USERGENDER = @"notification_facebook_user_details_dk_userGender";
NSString* const NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USEREMAIL = @"notification_facebook_user_details_dk_userEmail";


@implementation FacebookUtils

// Opens a Facebook session.
-(void)facebook_OpenSession:(BOOL)allowLoginUI
{
    NSArray* permissions = [[NSArray alloc] initWithObjects:@"email", nil];
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:allowLoginUI
                                  completionHandler:^(FBSession* session, FBSessionState state, NSError* error)
     {
         [self facebookSessionStateChanged:session state:state error:error];
     }];
}

// Closes the Facebook session.
-(void)facebook_CloseSession
{
    [FBSession.activeSession closeAndClearTokenInformation];
}

//////////////////////////////////////////////////////
#pragma mark - Helper Methods
//////////////////////////////////////////////////////

// Callback for session changes.
- (void) facebookSessionStateChanged:(FBSession*)session state:(FBSessionState)state error:(NSError*)error
{
    switch (state)
    {
        case FBSessionStateOpen:
            if (!error)
            {
                // Application now has a valid Facebook user session.
            }
            break;
        case FBSessionStateClosed:
            break;
        case FBSessionStateClosedLoginFailed:
            // Clear out the Facebook user session.
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    // Send out notification with session details.
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_SESSION_STATE_CHANGED object:session];
    
    // Display error message if applicable.
    if (error)
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [alertView show];
    }
}



// A function for parsing URL parameters.
- (NSDictionary*) parseURLParams:(NSString*)query
{
    NSArray* pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    for (NSString* pair in pairs)
    {
        NSArray* keyValue = [pair componentsSeparatedByString:@"="];
        NSString* value = [[keyValue objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [params setObject:value forKey:[keyValue objectAtIndex:0]];
    }
    return params;
}

// Handle the request call back
- (void) dialogCompleteWithUrl:(NSURL*)url
{
    NSDictionary* params = [self parseURLParams:[url query]];
    NSLog(@"params is: %@", params);
    NSString* requestID = [params valueForKey:@"request"];
    NSString* sentTo = [params valueForKey:@"to"];
    NSLog(@"Request ID: %@ and sent to: %@", requestID, sentTo);
}


//////////////////////////////////////////////////////
#pragma mark - NSURLConnection Delegate Methods
//////////////////////////////////////////////////////

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Fail..
    NSLog(@"error is: %@", error);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Request performed.
    NSLog(@"requestPerformed");
}

@end
