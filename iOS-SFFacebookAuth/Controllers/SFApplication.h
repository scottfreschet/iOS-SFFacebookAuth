//
//  SFApplication.h
//  iOS-SFFacebookAuth
//
//  Created by Scott Freschet on 8/8/13.
//  Copyright (c) 2013 Scott Freschet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFLogin.h"

@interface SFApplication : UIViewController

// IBOutlets.
@property (strong, nonatomic) IBOutlet UILabel* xLabel_UserId;
@property (strong, nonatomic) IBOutlet UILabel* xLabel_UserName;
@property (strong, nonatomic) IBOutlet UILabel* xLabel_UserGender;
@property (strong, nonatomic) IBOutlet UILabel* xLabel_UserEmail;


@end
