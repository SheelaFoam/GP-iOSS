//
//  menuWebData.m
//  Sheela Foam
//
//  Created by Apple on 30/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "menuWebData.h"
#import "historyModel.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "UIImageView+WebCache.h"
#import "profileVC.h"



@interface menuWebData ()<WebServiceResponseProtocal,UIWebViewDelegate,UIGestureRecognizerDelegate>
{
    NSDictionary*dataDic;
    MyWebServiceHelper *helper;
    NSArray*info;

}

@end

@implementation menuWebData

- (IBAction)logout:(id)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height /2;
    self.profileImg.layer.masksToBounds = YES;
    self.profileImg.layer.borderWidth = 0;
    
   self.webviewData.delegate=self;
    
    self.landingView.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
    self.landingView.layer.borderWidth = 2.0f;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flip)];
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [self.webviewData addGestureRecognizer:tap];


    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
      NSDictionary*dataString= @{@"user_email":[historyModel sharedhistoryModel].userEmail,@"uid":[historyModel sharedhistoryModel].uid,@"id":self.idStr,@"mode":@"detail",@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    NSLog(@"homeData%@",dataString);
    
    NSLog(@"mail12");

    
    if ([[historyModel sharedhistoryModel].menuTitle isEqualToString:@"Learning References"])
    {
        [self learningApi:dataString];
    }
    else
    {
    
        [self policieApi:dataString];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)policieApi:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper policiesApi:dataString];
}

-(void)learningApi:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper learningReferencesAPI:dataString];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"policiesApi"])
    {
        if (dataDic.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                ;
                
                self.titleLab.text=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"name"];
                [self.webviewData loadHTMLString:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"message"]baseURL:nil];

                [MyCustomClass SVProgressMessageDismissWithSuccess:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"] timeDalay:3.0];
                
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

-(void)flip
{
    if (![[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"link"] isEqual:[NSNull null]])
    {
    
        NSString*urlmail=[NSString stringWithFormat:@"%@", [[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"link"]];
        NSURL*url=[NSURL URLWithString:urlmail];
        
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }

    }


}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer    shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{

    return YES;
}



- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString*getImgUrl = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceName"];
    [self.profileImg setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    
}
- (IBAction)profileBtn:(id)sender
{
    profileVC*profile=[[profileVC alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
}
@end
