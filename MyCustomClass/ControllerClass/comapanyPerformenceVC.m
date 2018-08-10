//
//  comapanyPerformenceVC.m
//  Sheela Foam
//
//  Created by Apple on 03/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "comapanyPerformenceVC.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "historyModel.h"
#import "compenyPerCell.h"
#import "UIImageView+WebCache.h"
#import "profileVC.h"
@interface comapanyPerformenceVC ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSArray*info;
    NSDictionary*dataDic;
    compenyPerCell*cellAttachment;
    NSString*checkData;
//    UILabel *value1;
//    UILabel *value2;
//    UILabel *value3;
//    UILabel *value4;
    long selectedindex;
}
@end
@implementation comapanyPerformenceVC

- (IBAction)logout:(id)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.performenceTable.bounces = NO;

    self.boarderView.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
    self.boarderView.layer.borderWidth = 2.0f;
    
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height /2;
    self.profileImg.layer.masksToBounds = YES;
    self.profileImg.layer.borderWidth = 0;
    self.performenceTable.tableFooterView=self.footerView;
    
    NSDictionary*dataString= @{@"mode":@"company_performance",@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    [self appoinmentApi:dataString];
    self.performenceTable.delegate=self;
    self.performenceTable.dataSource=self;
    checkData=@"thisWeek";

    // Do any additional setup after loading the view from its nib.
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
        info=[dataDic objectForKey:@"info"];

        if (info.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
               // info=[dataDic objectForKey:@"info"];
                self.tpHeading.text=[[[dataDic objectForKey:@"company_performance_heading"] objectAtIndex:0] objectForKey:@"TP"];
                self.rcvHeading.text=[[[dataDic objectForKey:@"company_performance_heading"] objectAtIndex:0] objectForKey:@"RCV"];
                checkData=@"thisWeek";
                [self totalResult];
            [self.performenceTable reloadData];
                [SVProgressHUD dismiss];
            });
        }
        else
        {
            [SVProgressHUD dismiss];

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
    return 84;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [info count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"compenyPerCell";
    cellAttachment = (compenyPerCell *)[self.performenceTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"compenyPerCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        self.performenceTable.allowsSelection = NO;
    }
    if ([checkData isEqualToString:@"thisWeek"])
    {
    
    cellAttachment.titlelab.text=[NSString stringWithFormat:@"  %@",[[info objectAtIndex:indexPath.row] objectForKey:@"0"]];
      cellAttachment.tpAchive.text=[[info objectAtIndex:indexPath.row] objectForKey:@"TP_WEEK_ACH"];
      cellAttachment.tpTarget.text=[[info objectAtIndex:indexPath.row] objectForKey:@"TP_WEEK_TARGET"];
      cellAttachment.RCVAchive.text=[[info objectAtIndex:indexPath.row] objectForKey:@"RCV_WEEK_ACH"];
        cellAttachment.RCVTarget.text=[[info objectAtIndex:indexPath.row] objectForKey:@"RCV_WEEK_TARGET"];
    }
    if ([checkData isEqualToString:@"YTD"])
    {
        
        cellAttachment.titlelab.text=[NSString stringWithFormat:@"  %@",[[info objectAtIndex:indexPath.row] objectForKey:@"0"]];
        cellAttachment.tpAchive.text=[[info objectAtIndex:indexPath.row] objectForKey:@"TP_YTD_ACH"];
        cellAttachment.tpTarget.text=[[info objectAtIndex:indexPath.row] objectForKey:@"TP_YTD_TARGET"];
        cellAttachment.RCVAchive.text=[[info objectAtIndex:indexPath.row] objectForKey:@"RCV_YTD_ACH"];
        cellAttachment.RCVTarget.text=[[info objectAtIndex:indexPath.row] objectForKey:@"RCV_YTD_TARGET"];
    }
    [cellAttachment.titlelab sizeToFit];
    cellAttachment.titlelab.frame=CGRectMake(cellAttachment.titlelab.frame.origin.x, cellAttachment.titlelab.frame.origin.y, cellAttachment.titlelab.frame.size.width+20,cellAttachment.titlelab.frame.size.height+5);
    
     cellAttachment.tpTarget.frame=CGRectMake(cellAttachment.tpTarget.frame.origin.x, cellAttachment.titlelab.frame.origin.y+cellAttachment.titlelab.frame.size.height+5, cellAttachment.tpTarget.frame.size.width+10,cellAttachment.tpTarget.frame.size.height);
    
    cellAttachment.tpAchive.frame=CGRectMake(cellAttachment.tpAchive.frame.origin.x, cellAttachment.titlelab.frame.origin.y+cellAttachment.titlelab.frame.size.height+5, cellAttachment.tpAchive.frame.size.width+10,cellAttachment.tpAchive.frame.size.height);
    
 cellAttachment.RCVAchive.frame=CGRectMake(cellAttachment.RCVAchive.frame.origin.x, cellAttachment.titlelab.frame.origin.y+cellAttachment.titlelab.frame.size.height+5, cellAttachment.RCVAchive.frame.size.width+10,cellAttachment.RCVAchive.frame.size.height);
    
    
    cellAttachment.RCVTarget.frame=CGRectMake(cellAttachment.RCVTarget.frame.origin.x, cellAttachment.titlelab.frame.origin.y+cellAttachment.titlelab.frame.size.height+5, cellAttachment.RCVTarget.frame.size.width+10,cellAttachment.RCVTarget.frame.size.height);
    
    if (indexPath.row==[info count]-1) {
        cellAttachment.sepraterLab.hidden=YES;
    }

    if (indexPath.row==[info count]-2) {
        cellAttachment.sepraterLab.backgroundColor=[UIColor blueColor];
    }
    selectedindex=indexPath.row;
    
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
    
    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
    
    HomeViewControllerVC.menuString=@"Left";
}
- (IBAction)thisWeek:(id)sender
{
    checkData=@"thisWeek";
    self.thisWeek.backgroundColor = [UIColor colorWithRed:30/255.0f green:175/255.0f blue:180/255.0f alpha:1.0f];
    self.ytdBtn.backgroundColor=[UIColor colorWithRed:226/255.0f green:234/255.0f blue:244/255.0f alpha:1.0f];
    [self.performenceTable reloadData];
}
- (IBAction)ytdAction:(id)sender {
    checkData=@"YTD";
    self.ytdBtn.backgroundColor = [UIColor colorWithRed:30/255.0f green:175/255.0f blue:180/255.0f alpha:1.0f];
    self.thisWeek.backgroundColor=[UIColor colorWithRed:226/255.0f green:234/255.0f blue:244/255.0f alpha:1.0f];
    [self.performenceTable reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString*getImgUrl = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceName"];
    [self.profileImg setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    NSString*pageName=@"Company Performance page";
    [MyCustomClass logApi:pageName];
}
-(void)totalResult
{
    if (!(dataDic.count==0))
            {
        
            if ([checkData isEqualToString:@"thisWeek"])
            {
                    self.value1.text=[NSString stringWithFormat:@"%@", [[info objectAtIndex:selectedindex] objectForKey:@"TP_WEEK_TARGET"]];
        
                    self.value2.text=[NSString stringWithFormat:@"%@", [[info objectAtIndex:selectedindex] objectForKey:@"TP_WEEK_ACH"]];
        
                    self.value3.text=[NSString stringWithFormat:@"%@", [[info objectAtIndex:selectedindex] objectForKey:@"RCV_WEEK_TARGET"]];
        
                    self.value4.text=[NSString stringWithFormat:@"%@", [[info objectAtIndex:selectedindex] objectForKey:@"RCV_WEEK_ACH"]];
                }
            }
            if ([checkData isEqualToString:@"YTD"])
            {
                self.value1.text=[NSString stringWithFormat:@"%@", [[info objectAtIndex:selectedindex] objectForKey:@"TP_YTD_TARGET"]];
                self.value2.text=[NSString stringWithFormat:@"%@", [[info objectAtIndex:selectedindex] objectForKey:@"TP_YTD_ACH"]];
                self.value3.text=[NSString stringWithFormat:@"%@", [[info objectAtIndex:selectedindex] objectForKey:@"RCV_YTD_TARGET"]];
                self.value4.text=[NSString stringWithFormat:@"%@", [[info objectAtIndex:selectedindex] objectForKey:@"RCV_YTD_ACH"]];
            }
        
}

- (IBAction)profileBtn:(id)sender
{
    profileVC*profile=[[profileVC alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
}
@end
