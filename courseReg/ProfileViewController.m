//
//  ProfileViewController.m
//  courseReg
//
//  Created by Mingsheng Xu on 14-4-30.
//  Copyright (c) 2014年 Mingsheng Xu. All rights reserved.
//

#import "ProfileViewController.h"
#import "API.h"
#import "UIAlertView+error.h"

@interface ProfileViewController ()
-(void)takePhoto;
-(void)uploadPhoto;

@end

@implementation ProfileViewController

@synthesize logout_Button;
@synthesize profileImageView;

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
    
    UIColor* mainColor = [UIColor colorWithRed:50.0/255 green:102.0/255 blue:147.0/255 alpha:1.0f];
    
    NSString* fontName = @"Optima-Italic";
    NSString* boldFontName = @"Optima-ExtraBlack";
    
    self.realNameLabel.textColor =  [UIColor whiteColor];
    self.realNameLabel.font =  [UIFont fontWithName:boldFontName size:18.0f];
    self.realNameLabel.text = @"Maria Llewellyngot";
    
    self.usernameLabel.textColor =  [UIColor whiteColor];
    self.usernameLabel.font =  [UIFont fontWithName:fontName size:14.0f];
    self.usernameLabel.text = @"Maria Llewellyngot";
    
    self.bioLabel.textColor =  mainColor;
    self.bioLabel.font =  [UIFont fontWithName:fontName size:14.0f];
    self.bioLabel.text = @"Founder, CEO of Mavin Records, Entrepreneur mom and action gal";
    
    self.collegeLable.textColor =  mainColor;
    self.collegeLable.font =  [UIFont fontWithName:fontName size:14.0f];
    self.collegeLable.text = @"College of Science";
    
    
    self.profileBgImageView.image = [UIImage imageNamed:@"bridge.jpg"];
    self.profileBgImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(handleSingleFingerEvent:)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    singleFingerOne.delegate= self;
     [self.view addGestureRecognizer:singleFingerOne];
    
    self.profileImageView.image = [UIImage imageNamed:@"default_profile.png"];
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.cornerRadius = 48.0f;
    self.profileImageView.layer.borderWidth = 4.0f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
     self.profileImageView.userInteractionEnabled = YES;
    [ self.profileImageView addGestureRecognizer:singleFingerOne];
    
    

    
    self.overlayView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    
    self.bioContainer.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.7].CGColor;
    self.bioContainer.layer.borderWidth = 1.0f;
    
    
    self.functionContainer.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.7].CGColor;
    self.functionContainer.layer.borderWidth = 1.0f;
    
    UIColor* imageBorderColor = [UIColor colorWithRed:50.0/255 green:102.0/255 blue:147.0/255 alpha:0.4f];
    
        
    self.scrollView.contentSize = CGSizeMake(320, 590);
    
    self.logout_Button.titleLabel.font=[UIFont fontWithName:fontName size:14.0f];
    self.logout_Button.titleLabel.textColor=mainColor;

    [self loadPhoto];
    
    
}
-(void)styleFriendProfileImage:(UIImageView*)imageView withImageNamed:(NSString*)imageName andColor:(UIColor*)color{
    
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    //imageView.layer.cornerRadius = 30.0f;
    imageView.layer.borderWidth = 4.0f;
    imageView.layer.borderColor = color.CGColor;
}

- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender{
	if(sender.numberOfTapsRequired == 1) {
      	//单指单击
        NSLog(@"单指单击");
        
        [[[UIActionSheet alloc] initWithTitle:nil
                                     delegate:self
                            cancelButtonTitle:@"Close"
                       destructiveButtonTitle:nil
                            otherButtonTitles:@"Take photo", @"Upload From photos",nil]
         showInView:self.view];
        }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButton_press:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void) loadPhoto {
    
    NSString *photoURL1 = @"http://www.mingshengxu.com/promos/img/";
    NSString *photoURL = [NSString stringWithFormat:@"%@%@_profile-thumb",photoURL1,[[API sharedInstance].user objectForKey:@"username"]];
    [profileImageView setImageWithURL:[NSURL URLWithString:photoURL] ];
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self takePhoto]; break;
        case 1:
            [self pickPhoto]; break;
        
    }
}

-(void)takePhoto {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
#if TARGET_IPHONE_SIMULATOR
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
#endif
    imagePickerController.editing = YES;
    imagePickerController.delegate = (id)self;
    
    [self presentModalViewController:imagePickerController animated:YES];
}

-(void) pickPhoto{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.editing = YES;
    imagePickerController.delegate = (id)self;
    
    [self presentModalViewController:imagePickerController animated:YES];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    // Resize the image from the camera
    /*UIImage *scaledImage = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(photo.frame.size.width, photo.frame.size.height) interpolationQuality:kCGInterpolationHigh];
     // Crop the image to a square (yikes, fancy!)
     UIImage *croppedImage = [scaledImage croppedImage:CGRectMake((scaledImage.size.width -photo.frame.size.width)/2, (scaledImage.size.height -photo.frame.size.height)/2, photo.frame.size.width, photo.frame.size.height)];
     // Show the photo on the screen*/
    profileImageView.image = image;
    [picker dismissModalViewControllerAnimated:NO];
    [self uploadPhoto];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:NO];
}


-(void)uploadPhoto {
    
    //upload the image and the title to the web service
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                             @"photoUpload",@"command",
                                             [[API sharedInstance].user objectForKey:@"username"],@"username",
                                             UIImageJPEGRepresentation(profileImageView.image,250),@"file",
                                             @"profile", @"title",
                                             nil]
                               onCompletion:^(NSDictionary *json) {
                                   if (![json objectForKey:@"error"]) {
                                       
                                       //success
                                       [[[UIAlertView alloc]initWithTitle:@"Success!"
                                                                  message:@"Your photo is uploaded"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil] show];
                                       
                                   } else {
                                       //error, check for expired session and if so - authorize the user
                                       NSString* errorMsg = [json objectForKey:@"error"];
                                       [UIAlertView error:errorMsg];
                                   }
                               }];
}
@end
