//
//  ProfileTableViewController.h
//  courseReg
//
//  Created by Mingsheng Xu on 9/29/13.
//  Copyright (c) 2013 Mingsheng Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTableViewController : UITableViewController<UIImagePickerControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>
{
    IBOutlet UIImageView* photo;
}

@property (strong, nonatomic) IBOutlet UIButton *logout_Button;
- (IBAction)logoutButton_press:(UIButton *)sender;
- (IBAction)uploadPhoto:(id)sender;
@end
