//
//  profileVC.h
//  Sheela Foam
//
//  Created by Apple on 11/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface profileVC : UIViewController
- (IBAction)backBtn:(id)sender;
- (IBAction)changePassword:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sumitBtn;
- (IBAction)sumitBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imagePic;

@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *emailIDTxt;
@property (weak, nonatomic) IBOutlet UITextField *roleNameTxt;
@property (weak, nonatomic) IBOutlet UIScrollView *landingScrollView;
- (IBAction)pickImg:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *mobiletxt;
@property (weak, nonatomic) IBOutlet UIButton *changePassword;
@end
