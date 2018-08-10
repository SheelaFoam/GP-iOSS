//
//  changePasswordVC.h
//  Sheela Foam
//
//  Created by Apple on 11/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface changePasswordVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *landingScrollView;
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;


@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;

- (IBAction)profileBtn:(id)sender;
- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@end
