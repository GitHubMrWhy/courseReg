//
//  RegisterViewController.h
//  courseReg
//
//  Created by Mingsheng Xu on 9/19/13.
//  Copyright (c) 2013 Mingsheng Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterViewController;



@interface RegisterViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *username_TextField;
@property (strong, nonatomic) IBOutlet UITextField *password_TextField;
@property (strong, nonatomic) IBOutlet UITextField *email_TextField;

@property (strong, nonatomic) IBOutlet UISegmentedControl *gender_SegmentedControl;



- (IBAction)cancel_Button:(UIBarButtonItem *)sender;
- (IBAction)signup_Button:(UIButton *)sender;
@end
