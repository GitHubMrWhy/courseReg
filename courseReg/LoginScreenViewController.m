//
//  LoginScreenViewController.m
//  courseReg
//
//  Created by Mingsheng Xu on 9/18/13.
//  Copyright (c) 2013 Mingsheng Xu. All rights reserved.
//

#import "LoginScreenViewController.h"
#import "API.h"

@interface LoginScreenViewController ()

@end

@implementation LoginScreenViewController
@synthesize username_TextField;
@synthesize password_TextField;
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
    
    //focus on the username field / show keyboard
    [username_TextField becomeFirstResponder];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login_Click:(UIButton *)sender {
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 
                                  username_TextField.text, @"username",
                                  password_TextField.text, @"password",
                                  nil];
    //make the call to the web API
    [[API sharedInstance] commandWithParams:params
                               onCompletion:^(NSDictionary *json) {
                                   //handle the response
                                   //result returned
                                   NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
                                   if ([json objectForKey:@"error"]==nil && [[res objectForKey:@"userID"] intValue] > 0) {
                                       //success
                                       [[API sharedInstance] setUser: res];
                                       [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                                       //show message to the user
                                       [[[UIAlertView alloc] initWithTitle:@"Logged in"
                                                                   message:[NSString stringWithFormat:@"Welcome %@",[res objectForKey:@"username"] ]
                                                                  delegate:nil 
                                                         cancelButtonTitle:@"Close" 
                                                         otherButtonTitles: nil] show];
                                       
                                   } else {
                                       //error
                                       UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"My Error" message: [json objectForKey:@"error"] delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
                                       [alertView show];
                                       
                                       
                                   }
                                   
                               }];
}

- (IBAction)reg_Click:(UIButton *)sender {
}
@end
