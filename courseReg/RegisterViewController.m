//
//  RegisterViewController.m
//  courseReg
//
//  Created by Mingsheng Xu on 9/19/13.
//  Copyright (c) 2013 Mingsheng Xu. All rights reserved.
//

#import "RegisterViewController.h"
#import "API.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize username_TextField;
@synthesize password_TextField;
@synthesize email_TextField;
@synthesize gender_SegmentedControl;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)cancel_Button:(UIBarButtonItem *)sender {
[self dismissViewControllerAnimated:YES completion:nil];
   
}

- (IBAction)signup_Button:(UIButton *)sender {
    NSLog(@"%d",gender_SegmentedControl.selectedSegmentIndex);
    NSString* command = @"register";
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  command, @"command",
                                  username_TextField.text, @"username",
                                  password_TextField.text, @"password",
                                  email_TextField.text,@"email",
                                  [NSNumber numberWithInteger:gender_SegmentedControl.selectedSegmentIndex],@"gender",
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
                                                                             //show message to the user
                                       
                                       
                                       [self performSegueWithIdentifier:@"RegisterToMain"sender:self];
                                       [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

                                   } else {
                                       //error
                                       UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"My Error" message: [json objectForKey:@"error"] delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
                                       [alertView show];
                                       
                                       
                                   }
                                   
                               }];

}
@end
