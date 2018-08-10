//
//  changePasswordVC.m
//  Sheela Foam
//
//  Created by Apple on 11/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "changePasswordVC.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "historyModel.h"
#import "profileVC.h"
#import "UIImageView+WebCache.h"




@interface changePasswordVC ()<UIScrollViewDelegate,UITextFieldDelegate,WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSArray*info;
    NSDictionary*dataDic;

}

@end

@implementation changePasswordVC


- (IBAction)logout:(id)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.submitBtn.layer.cornerRadius = 8;//half of the width
    self.navigationController.navigationBarHidden=YES;
    
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height /2;
    self.profileImg.layer.masksToBounds = YES;
    self.profileImg.layer.borderWidth = 0;

    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.landingScrollView.delegate=self;
    self.password.delegate=self;
    self.oldPassword.delegate=self;
    self.confirmPassword.delegate=self;
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)submitBtn:(id)sender {
    [SVProgressHUD show];
    
    if(self.oldPassword.text==nil || [self.oldPassword.text length]<=0)
    {
        [self.oldPassword resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter OldPassword" timeDalay:1.0f];
    }
    else if(self.password.text==nil || [self.password.text length]<=0)
    {
        [self.password resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter OldPassword" timeDalay:1.0f];
    }
    else if(self.confirmPassword.text==nil || [self.confirmPassword.text length]<=0)
    {
        [self.confirmPassword resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter OldPassword" timeDalay:1.0f];
    }
    else
    {
        
        NSDictionary*dataString= @{@"mode":@"change_password",@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"old_password":self.oldPassword.text,@"new_password":self.password.text,@"confirm_password":self.confirmPassword.text,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
        [self changePassword:dataString];
        
        NSLog(@"changePassword%@",dataString);
    }
    
    
}

-(void)changePassword:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper changePassword:dataString];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"changePassword"])
    {
        [SVProgressHUD dismiss];
        if (dataDic.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                info=[dataDic objectForKey:@"info"];
                
                if ([[[info objectAtIndex:0] objectForKey:@"status"] intValue]==1)
                {
                    
                    [historyModel sharedhistoryModel].token=[[info objectAtIndex:0] objectForKey:@"token"];
                    [self showMessage:[[info objectAtIndex:0] objectForKey:@"msg"]withTitle:@""];

                }
                else
                {
                    [self showMessage:[[info objectAtIndex:0] objectForKey:@"msg"]withTitle:@"Error"];

                
                }

                
            });
        }
    }
    
    
    else
    {
        NSString *msg = [dataDic objectForKey:@"msg"];
        [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:3.0];
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


- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark -
#pragma mark UITextFieldDelegate
- (void) scrollViewAdaptToStartEditingTextField:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, textField.frame.origin.y +2.5 * textField.frame.size.height);
    [self.landingScrollView setContentOffset:point animated:YES];
}

- (void) scrollVievEditingFinished:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, 0);
    [self.landingScrollView setContentOffset:point animated:YES];
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
    [self.oldPassword resignFirstResponder];
    [self.password resignFirstResponder];
    [self.confirmPassword resignFirstResponder];

    
}
-(void)showMessage:(NSString*)message withTitle:(NSString *)title
{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //do something when click button
    }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString*getImgUrl = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceName"];
    [self.profileImg setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    NSString*pageName=@"Change password Page";
    [MyCustomClass logApi:pageName];

    
}

- (IBAction)profileBtn:(id)sender
{
    profileVC*profile=[[profileVC alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
}


@end
