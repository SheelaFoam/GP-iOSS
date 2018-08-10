//
//  PasswordLogin.m
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "PasswordLogin.h"
#import "HomeViewController.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "historyModel.h"
#import "changePasswordVC.h"
#import "GreatPlusSharedPostRequestManager.h"
#import "JsonBuilder.h"
#import "GreatPlusSharedHeader.h"
#import "UserDefaultStorage.h"
#import "MailClassViewController.h"


@interface PasswordLogin ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSArray*info;
    BOOL hide;
    NSDictionary *inputData;
}
@end
@implementation PasswordLogin
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.passwordTxt.delegate=self;
    self.passwordTxt.secureTextEntry = YES;
    hide=NO;
    self.passwordTxt.delegate=self;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.passwordTxt.leftView = paddingView;
    self.passwordTxt.leftViewMode = UITextFieldViewModeAlways;
    [self.passwordTxt setBackgroundColor:[UIColor colorWithRed:246/255.0
                                                         green:248/255.0
                                                          blue:249/255.0
                                                         alpha:1.0]];
    
    self.passwordTxt.layer.borderColor = [UIColor colorWithRed:246/255.0
                                                         green:246/255.0
                                                          blue:246/255.0
                                                         alpha:1.0].CGColor;
    
    [self.passwordTxt.layer setCornerRadius:5.0f];
    if ([self.passWordORopt isEqualToString:@"EMAIL"])
    {
        self.passwordTxt.placeholder = @"Password";
        [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn"] forState:UIControlStateNormal];
    }
    if (([self.passWordORopt isEqualToString:@"OTP"]))
    {
          [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"OTPBtn"] forState:UIControlStateNormal];
        self.passwordTxt.placeholder = @"Enter OTP";
        self.passwordTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.otpMessagelab.hidden=NO;
    }
    
    if (_autoLogin) {
        NSString *paswrd = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
        self.passwordTxt.text=paswrd;
        self.userName = _userNameText;
        [self LoginBtn:_loginBtn];
    }
}
-(void)LoginVerification:(NSDictionary*)dataString
{
    inputData = dataString;
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    [self loginInOldApp:dataString[@"password"]];
    [helper loginApi:dataString];
    
}

-(void)loginInOldApp:(NSString *)passwod
{
    [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_AUTH_INIT withDictionaryInfo:[JsonBuilder buildAuthJsonObject:EmptyString andPassword:passwod] andTagName:AuthServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
        if (statusCode == StatusCode) {
            if ([[NSString stringWithFormat:@"%@",[result objectForKey:op_authorised_ynKey]] boolValue]) {
                [UserDefaultStorage setDelearCategory:[NSString stringWithFormat:@"%@",[result objectForKey:@"op_dealer_category"]]];
                [UserDefaultStorage setDealerID:([MailClassViewController checkNull:[result objectForKey:@"op_dealer_id"]]) ? [result objectForKey:@"op_dealer_id"]: EmptyString];
                
                if([result objectForKey:@"op_dealer_id"] != Nil && ![[result objectForKey:@"op_dealer_id"] isKindOfClass:[NSNull class]])
                {
                    [UserDefaultStorage setDealerID: [result objectForKey:@"op_dealer_id"]];
                }
                else
                {
                    [UserDefaultStorage setDealerID: EmptyString];
                }
                
//                [self moveToNextPage:result];
                [UserDefaultStorage setUserToken:[NSString stringWithFormat:@"%@",[result objectForKey:tokenKey]]];
            } else {
       //         [MailClassViewController toastWithMessage:[NSString stringWithFormat:@"%@",[result objectForKey:op_messageKey]] AndObj:self.view];
            }
            [UserDefaultStorage setUserToken:[NSString stringWithFormat:@"%@",[result objectForKey:tokenKey]]];
        } else {
     //       [MailClassViewController toastWithMessage:message AndObj:self.view];
        }
    }];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"Login"])
    {
        
        
        info = [dataDic objectForKey:@"info"];
        NSLog(@"loginApi--->,%@",info);
        // [SVProgressHUD dismiss];
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==0)
                {
                    
                    [MyCustomClass SVProgressMessageDismissWithError:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"] timeDalay:2.0];
                }
                else if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==1)
                {
                    HomeViewController*passWordVc=[[HomeViewController alloc]init];
                    [self.navigationController pushViewController:passWordVc animated:NO];
                    
                    NSDictionary *dict = inputData;
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"user_login_12"];
                    [[NSUserDefaults standardUserDefaults] setObject:_passwordTxt.text forKey:@"password"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    
                    NSArray*userInfo=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"user_info"];//objectForKey:@"user_info"];
                    
                    NSLog(@"%@", userInfo);
                    
                    if (![[[userInfo objectAtIndex:0] objectForKey:@"op_dealer_category"] isKindOfClass:[NSNull class]]) {
                        [UserDefaultStorage setDelearCategory:[[userInfo objectAtIndex:0] objectForKey:@"op_dealer_category"]];
                    }
                    
                    [historyModel sharedhistoryModel].uid=[[userInfo objectAtIndex:0] objectForKey:@"uid"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[userInfo objectAtIndex:0] objectForKey:@"uid"] forKey:@"uid"];
                    NSLog(@"ddd%@",passWordVc.uid);
                    [historyModel sharedhistoryModel].token=[[userInfo objectAtIndex:0] objectForKey:@"token"];
                    
                    [self logData];
                    NSLog(@"%@", userInfo);
                    [historyModel sharedhistoryModel].authType=[[userInfo objectAtIndex:0] objectForKey:@"auth_type"];
                    [historyModel sharedhistoryModel].displayname=[[userInfo objectAtIndex:0] objectForKey:@"displayname"];
                    [historyModel sharedhistoryModel].opRoleName=[[userInfo objectAtIndex:0] objectForKey:@"op_role_name"];
                    [historyModel sharedhistoryModel].opUserType = [[userInfo objectAtIndex:0] objectForKey:@"op_user_type"];
                    [historyModel sharedhistoryModel].opUserEmpGroupCode=[[userInfo objectAtIndex:0] objectForKey:@"op_user_emp_group_code"];
                    [historyModel sharedhistoryModel].opGreatplususerId=[[userInfo objectAtIndex:0] objectForKey:@"op_greatplus_user_id"];
                    [historyModel sharedhistoryModel].userEmail=[[userInfo objectAtIndex:0] objectForKey:@"user_email"];
                    [historyModel sharedhistoryModel].opUserzone=[[userInfo objectAtIndex:0] objectForKey:@"op_user_zone"];
                    [historyModel sharedhistoryModel].opuserRoleName=[[userInfo objectAtIndex:0] objectForKey:@"op_user_role_name"];
                    [historyModel sharedhistoryModel].userName=[[userInfo objectAtIndex:0] objectForKey:@"op_user_name"];[historyModel sharedhistoryModel].opuseremailid=[[userInfo objectAtIndex:0] objectForKey:@"op_user_email_id"];
                    [historyModel sharedhistoryModel].mobileNo=[[userInfo objectAtIndex:0] objectForKey:@"op_user_mobile_number"];
                    NSString *saveImgUrl =[[userInfo objectAtIndex:0] objectForKey:@"op_user_profile_image"];
                    NSString *imageUrlStr =saveImgUrl;
                    NSString *profilePicUrl = [imageUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [[NSUserDefaults standardUserDefaults] setObject:profilePicUrl forKey:@"preferenceName"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    NSObject *obj = [historyModel sharedhistoryModel];
                    NSData *dataNew = [NSKeyedArchiver archivedDataWithRootObject:obj];
                    [[NSUserDefaults standardUserDefaults] setObject:dataNew forKey:@"user_model"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    if ([userInfo count]>0) {
                        if([[userInfo firstObject] objectForKey:@"op_dealer_id"] != Nil && ![[[userInfo firstObject] objectForKey:@"op_dealer_id"] isKindOfClass:[NSNull class]])
                        {
                            [UserDefaultStorage setDealerID: [[userInfo firstObject] objectForKey:@"op_dealer_id"]];
                        }
                        else
                        {
                            [UserDefaultStorage setDealerID: EmptyString];
                        }
                    }
                    
                    
                    
                    [MyCustomClass SVProgressMessageDismissWithSuccess:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"] timeDalay:3.0];
                }
            });
        }
        else
        {
            NSString *msg = [dataDic objectForKey:@"msg"];
            [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:3.0];
        }
    }
}
-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknow Error" timeDalay:2.0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)LoginBtn:(id)sender {
    [SVProgressHUD show];
    NSDictionary*dic;
    if(self.passwordTxt.text==nil || [self.passwordTxt.text length]<=0)
    {
        [self.passwordTxt resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Password" timeDalay:1.0f];
    }
    else
    {
        
       // if ([self.passWordORopt isEqualToString:@"EMAIL"])
        //{
            //dic= @{@"username":self.userName,@"password":self.passwordTxt.text,@"mode":@"step2",@"area":self.area};
        //}
       /// else
        //{
        // dic= @{@"username":self.userName,@"password":self.passwordTxt.text,@"mode":@"step2",@"area":self.area};
        
        dic= @{@"username":self.userName,@"password":self.passwordTxt.text,@"mode":@"step2",@"area":self.area};
       // }

        [self LoginVerification:dic];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.landingScroll.contentSize= CGSizeMake(0, self.view.frame.size.height);
    [super viewWillAppear:animated];
}

-(void)logData
{
    [historyModel sharedhistoryModel].deviceName=[[UIDevice currentDevice] name];
    
    [historyModel sharedhistoryModel].deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    [historyModel sharedhistoryModel].deviceOS = [[UIDevice currentDevice] systemVersion];
}
#pragma mark -
#pragma mark UITextFieldDelegate

- (void) scrollViewAdaptToStartEditingTextField:(UITextField*)textField
{
     CGPoint point = CGPointMake(0, textField.frame.origin.y -3.5*textField.frame.size.height);
    [self.landingScroll setContentOffset:point animated:YES];
}

- (void) scrollVievEditingFinished:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, 0);
    [self.landingScroll setContentOffset:point animated:YES];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    [self scrollViewAdaptToStartEditingTextField:textField];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self scrollVievEditingFinished:textField];
    
    return YES;
}

-(IBAction)resignKeyboard:(id)sender
{
    [self.passwordTxt resignFirstResponder];
    
}

- (IBAction)changePassword:(id)sender {
    
}

- (IBAction)passwordShowTxt:(id)sender {
    
    if(hide==NO)
    {
        self.passwordTxt.secureTextEntry = NO;
        hide=YES;
        self.eyeView.image = [UIImage imageNamed: @"eye"];
    }
    else
    {
        self.passwordTxt.secureTextEntry = YES;
        self.eyeView.image = [UIImage imageNamed: @"eyeClose"];
        hide=NO;
    }
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
