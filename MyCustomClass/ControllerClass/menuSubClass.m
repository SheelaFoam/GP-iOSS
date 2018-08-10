//
//  menuSubClass.m
//  Sheela Foam
//
//  Created by Apple on 29/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "menuSubClass.h"
#import "HomeViewController.h"
#import "historyModel.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "menuWebData.h"
#import "telephoneDirVC.h"
#import "UIImageView+WebCache.h"
#import "profileVC.h"



@interface menuSubClass ()<WebServiceResponseProtocal>
{
    NSDictionary*dataDic;
    MyWebServiceHelper *helper;
    NSArray*info;
}

@end

@implementation menuSubClass

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noDataLab.hidden=YES;
    self.navigationController.navigationBarHidden=YES;
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height /2;
    self.profileImg.layer.masksToBounds = YES;
    self.profileImg.layer.borderWidth = 0;
    self.detailTable.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
    self.detailTable.layer.borderWidth = 2.0f;

    
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.detailTable.delegate=self;
    self.detailTable.dataSource=self;
    self.titleLab.text=[[historyModel sharedhistoryModel].menuTitle uppercaseString];
    
    NSLog(@"mail11");

    NSDictionary*dataString= @{@"user_email":[historyModel sharedhistoryModel].userEmail,@"uid":[historyModel sharedhistoryModel].uid,@"mode":@"list",@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    
    NSLog(@"homeData%@",dataString);
    if ([[historyModel sharedhistoryModel].menuTitle isEqualToString:@"Learning References"])
    {
        self.noDataLab.text=@"Learning References does not exist!.....";
        [self LearningAPI:dataString];

    
    }
    else
    {
        self.noDataLab.text=@"policy and procedure does not exist!.....";

    [self policieApi:dataString];
    }

}

-(void)policieApi:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper policiesApi:dataString];
}

-(void)LearningAPI:(NSDictionary*)dataString
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
        if ([[dataDic objectForKey:@"status"] isEqual:@1])
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                info=[dataDic objectForKey:@"info"];
               
                [self.detailTable reloadData];

                [self.detailTable setFrame:CGRectMake(self.detailTable.frame.origin.x, self.detailTable.frame.origin.y, self.detailTable.frame.size.width,(40.0f*([info count])))];

                [SVProgressHUD dismiss];
                
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{

            self.noDataLab.hidden=NO;
            self.detailTable.hidden=YES;
            [SVProgressHUD dismiss];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [info count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        cell.textLabel.textColor=[UIColor grayColor];
    }
    
    cell.textLabel.text = [[info objectAtIndex:indexPath.row]objectForKey:@"name"];
    UIFont *myFont = [ UIFont systemFontOfSize:13];
    cell.textLabel.font  = myFont;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    if ([[historyModel sharedhistoryModel].menuTitle isEqualToString:@"Learning References"])
    {
        menuWebData*webVC=[[menuWebData alloc]init];
        [self.navigationController pushViewController:webVC animated:NO];
        webVC.idStr=[[info objectAtIndex:indexPath.row] objectForKey:@"id"];
        
    }
    else{
        menuWebData*webVC=[[menuWebData alloc]init];
        [self.navigationController pushViewController:webVC animated:NO];
        webVC.idStr=[[info objectAtIndex:indexPath.row] objectForKey:@"id"];    }

        }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)backBtn:(id)sender
{
//    HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
//
//    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
//
//    HomeViewControllerVC.menuString=@"Left";
    [self.navigationController popViewControllerAnimated:YES];
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
