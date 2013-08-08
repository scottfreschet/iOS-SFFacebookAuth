//
//  SFLogin.h
//  iOS-SFFacebookAuth
//
//  Created by Scott Freschet on 8/8/13.
//  Copyright (c) 2013 Scott Freschet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookUtils.h"

@interface SFLogin : UIViewController

// IBOutlets.
@property (strong, nonatomic) IBOutlet UIImageView* xImageView_Login;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer* xGesture_LoginTap;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView* xSpinner;

// IBActions.
-(IBAction)loginTapped:(id)sender;


@end
