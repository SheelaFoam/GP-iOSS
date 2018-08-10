//
//  PasswordLogin.h
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordLogin : UIViewController<UIScrollViewDelegate,UITextFieldDelegate>
@property(strong,nonatomic)NSString*passWordORopt;
- (IBAction)LoginBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
@property (weak, nonatomic) IBOutlet UIScrollView *landingScroll;
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property(strong,nonatomic)NSString*area;
- (IBAction)passwordShowTxt:(id)sender;
@property(strong,nonatomic)NSString*oprolename;
@property (weak, nonatomic) IBOutlet UIImageView *eyeView;
@property (weak, nonatomic) IBOutlet UIButton *passwordShowTxt;
@property (weak, nonatomic) IBOutlet UILabel *otpMessagelab;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *changePassword;
@property (nonatomic,assign) BOOL autoLogin;
@property (nonatomic,strong) NSString *userNameText;

- (IBAction)changePassword:(id)sender;

@end
