//
//  LoginViewController.m
//  Sheela Foam
//
//  Created by Apple on 17/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "PasswordLogin.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "historyModel.h"
#import "GreatPlusSharedPostRequestManager.h"
#import "JsonBuilder.h"
#import "GreatPlusSharedHeader.h"
#import "UserDefaultStorage.h"

@interface LoginViewController ()<WebServiceResponseProtocal,UITextFieldDelegate>
{
    MyWebServiceHelper *helper;
    NSArray*info;
    
    NSString *message;
    NSString *newVersion;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.userNameTxt.delegate=self;
    
     UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
     self.userNameTxt.leftView = paddingView;
     self.userNameTxt.leftViewMode = UITextFieldViewModeAlways;
    [self.userNameTxt setBackgroundColor:[UIColor colorWithRed:246/255.0
                                                         green:248/255.0
                                                          blue:249/255.0
                                                         alpha:1.0]];
    
    self.userNameTxt.layer.borderColor = [UIColor colorWithRed:246/255.0
                                                         green:246/255.0
                                                          blue:246/255.0
                                                         alpha:1.0].CGColor;

    [self.userNameTxt.layer setCornerRadius:5.0f];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString * build = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    [self checkVersion:version andBuild:build completionHandler:^(BOOL updateStatus) {
        [self showUpdateAlert:updateStatus andVersion:version withMessage:[NSString stringWithFormat:@"\n%@", message]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showUpdateAlert:(BOOL)update andVersion: (NSString *)version withMessage: (NSString *)message {
    
    if (update) {
        
        UIAlertController *alert = [[UIAlertController alloc] init];
        alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"New version available - V(%@)", newVersion] message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *download = [UIAlertAction actionWithTitle:@"Download" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/in/app/greatplus/id1325457129?mt=8"]];
        }];
        [alert addAction:download];
        
        [self presentViewController:alert animated:true completion:nil];
    }
}

-(void) checkVersion:(NSString *)version andBuild: (NSString *)build completionHandler: (void (^)(BOOL updateStatus)) completion {
    
    NSDictionary *headers = @{ @"content-type": @"application/json",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"ee673415-edf2-dc3c-373e-cce8dc1a0d38" };
    NSDictionary *parameters = @{ @"os_type": @"I",
                                  @"version_code": build,
                                  @"version_name": version };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://greatplus.com/warranty_log_api/app_update_alert.php"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        message = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"ver_update"];
                                                        newVersion = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"version_name"];
                                                        if ([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"update_status"] == true) {
                                                            completion(true);
                                                        } else {
                                                            completion(false);
                                                        }
                                                    }
                                                }];
    [dataTask resume];
}

-(void) checkVersion:(NSString *)version andBuild: (NSString *)build {
    
    NSDictionary *headers = @{ @"content-type": @"application/json",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"ee673415-edf2-dc3c-373e-cce8dc1a0d38" };
    NSDictionary *parameters = @{ @"os_type": @"I",
                                  @"version_code": build,
                                  @"version_name": version };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://greatplus.com/warranty_log_api/app_update_alert.php"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                    }
                                                }];
    [dataTask resume];
}

-(void)OTPVerification:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper loginApi:dataString];
    
    [self loginInOldApp:dataString[@"username"]];
    
}

-(void)loginInOldApp:(NSString *)username
{
    [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_LOGIN_INIT withDictionaryInfo:[JsonBuilder buildLoginJsonObject:username andPassword:EmptyString] andTagName:LoginServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
      //  [activityIndicator hideView];
        if (statusCode == StatusCode) {
            if ([[NSString stringWithFormat:@"%@",[result objectForKey:op_authorised_ynKey]] boolValue]) {
                [UserDefaultStorage setUserDealerID:username];
                [self moveToNextPage:result];
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:result];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"oldAppLoginResponse"];
                [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                //...
            } else {
//                [MailClassViewController toastWithMessage:[NSString stringWithFormat:@"%@",[result objectForKey:op_messageKey]] AndObj:self.view];
            }
        } else {
      //      [MailClassViewController toastWithMessage:message AndObj:self.view];
        }
    }];
}

- (void) moveToNextPage :(NSDictionary *)tempDic {
    NSLog(@"%@", tempDic);
    [UserDefaultStorage setUserDealerType:[NSString stringWithFormat:@"%@",[tempDic objectForKey:op_role_nameKey]]];
    NSLog(@"%@", [UserDefaultStorage getUserDealerType]);
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"Login"])
    {
        info = [dataDic objectForKey:@"info"];
        NSLog(@"loginApi--->,%@",info);
        if (info.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
        if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==0)
                {
                    
                    [MyCustomClass SVProgressMessageDismissWithError:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"] timeDalay:2.0];

                    
                    
                }
        else if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==1)
                {
                    
                [MyCustomClass SVProgressMessageDismissWithSuccess:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"] timeDalay:2.0];
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataDic];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"webApiLoginResponse"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                    
                
                
                
                PasswordLogin*passWordVc=[[PasswordLogin alloc]init];
                [self.navigationController pushViewController:passWordVc animated:YES];
                passWordVc.passWordORopt=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"area"];
                passWordVc.userName=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"email_login"];
                passWordVc.area=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"area"];
                    [historyModel sharedhistoryModel].area=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"area"];
                passWordVc.oprolename=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"op_role_name"];
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



- (IBAction)loginBtn:(id)sender
{
    
    [SVProgressHUD show];
    
    if(self.userNameTxt.text==nil || [self.userNameTxt.text length]<=0)
    {
        [self.userNameTxt resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Username" timeDalay:1.0f];
    }
   
    else{

       NSDictionary*dic=  @{@"username":self.userNameTxt.text,@"mode":@"step1"};
        [self OTPVerification:dic];
}
}

-(void)viewWillAppear:(BOOL)animated
{
    self.landingScroll.contentSize= CGSizeMake(0, self.view.frame.size.height);
    [super viewWillAppear:animated];

    
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
    [self.userNameTxt resignFirstResponder];
    
}




@end
