//
//  holidayCalenderDetail.m
//  Sheela Foam
//
//  Created by Apple on 01/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "holidayCalenderDetail.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "historyModel.h"
#import "CommonTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "profileVC.h"
@interface holidayCalenderDetail ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSArray*info;
    NSDictionary*dataDic;
    CommonTableViewCell*cellAttachment;
}
@end
@implementation holidayCalenderDetail

- (IBAction)logout:(id)sender{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height /2;
    self.profileImg.layer.masksToBounds = YES;
    self.profileImg.layer.borderWidth = 0;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.holidayTable.bounces = NO;
    self.holidayTable.layer.borderWidth = 2.0;
    self.holidayTable.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(13,self.headerView.frame.size.height-5,[UIScreen mainScreen].bounds.size.width-60,1)];
    fromLabel.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:76.0/255.0f blue:164.0/255.0f alpha:1.0];
    [self.headerView addSubview:fromLabel];
    self.holidayTable.tableHeaderView = self.headerView;
    NSLog(@"mail16");

    // NSDictionary*dataString= @{@"mode":@"appointments",@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,};
    //  {"mode":"appointments","uid":"ROSHNI.SHRESHTHA","token":"TkVXQEluZGlh"}
  //  self.titleLab.text=[[historyModel sharedhistoryModel].menuTitle uppercaseString];
    self.titleLab.text=@"Upcoming Holidays";
    NSDictionary*dataString= @{@"mode":@"holiday_list",@"op_user_zone":[historyModel sharedhistoryModel].opUserzone,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    NSLog(@"homeData%@",dataString);
    [self appoinmentApi:dataString];
    self.holidayTable.delegate=self;
    self.holidayTable.dataSource=self;
}
-(void)appoinmentApi:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    [helper myAppoinmentDetail:dataString];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"myAppoinmentDetail"])
    {
        if (dataDic.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                info=[dataDic objectForKey:@"info"];
                [self.holidayTable reloadData];
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
    return 80.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [info count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"CommonTableViewCell";
    cellAttachment = (CommonTableViewCell *)[self.holidayTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"CommonTableViewCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        self.holidayTable.allowsSelection = NO;
        cellAttachment.nameLab.textColor=[UIColor redColor];
    }
    cellAttachment.timeLab.hidden=YES;
    cellAttachment.nameLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"HOLIDAY_DATE"];
    cellAttachment.detailLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"HOLIDAY_NAME"];;
    return  cellAttachment;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtn:(id)sender {
    HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
    if ([[historyModel sharedhistoryModel].checkHomeORMenu isEqualToString:@"home"])
    {
        [self.navigationController popViewControllerAnimated:YES];
        [historyModel sharedhistoryModel].checkHomeORMenu=@"";
    }
    else
    {
    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
    HomeViewControllerVC.menuString=@"Left";
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString*getImgUrl = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceName"];
    [self.profileImg setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    NSString*pageName=@"holiday calender Page";
    [MyCustomClass logApi:pageName];
}
- (IBAction)profileBtn:(id)sender
{
    profileVC*profile=[[profileVC alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
}
@end
