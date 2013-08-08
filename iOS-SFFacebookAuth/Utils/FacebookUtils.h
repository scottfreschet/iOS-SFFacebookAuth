//
//  FacebookUtils.h
//  iOS-SFFacebookAuth
//
//  Created by Scott Freschet on 8/8/13.
//  Copyright (c) 2013 Scott Freschet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

// Notification Constants.
extern NSString* const NOTIFICATION_FACEBOOK_SESSION_STATE_CHANGED;
extern NSString* const NOTIFICATION_FACEBOOK_USER_DETAILS;
extern NSString* const NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USERID;
extern NSString* const NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USERNAME;
extern NSString* const NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USERGENDER;
extern NSString* const NOTIFICATION_FACEBOOK_USER_DETAILS_DK_USEREMAIL;


@interface FacebookUtils : NSObject <NSURLConnectionDelegate>

// Public methods.
-(void)facebook_OpenSession:(BOOL)allowLoginUI;
-(void)facebook_CloseSession;



@end
