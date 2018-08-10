//
//  myPerformenceDetail.m
//  Sheela Foam
//
//  Created by Apple on 25/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "myPerformenceDetail.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "historyModel.h"
#import "UIImageView+WebCache.h"
#import "profileVC.h"


@interface myPerformenceDetail ()<WebServiceResponseProtocal>

{
    MyWebServiceHelper *helper;
    NSArray*info;
    NSDictionary*dataDic;
    performenceDetailCell*MyPerformance;
    UIView *view1;
    CGSize nameLabHight;

}

@end

@implementation myPerformenceDetail

- (IBAction)logout:(id)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height /2;
    self.profileImg.layer.masksToBounds = YES;
    self.profileImg.layer.borderWidth = 0;
    self.performenceTable.delegate=self;
    self.performenceTable.dataSource=self;
    [self tableheader];
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.performenceTable.bounces = NO;

    self.boarderView.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
    self.boarderView.layer.borderWidth = 2.0f;
   self.titleLab.text=[[historyModel sharedhistoryModel].menuTitle uppercaseString];
    self.performenceTable.tableHeaderView=self.headerView;
    //self.titleLab.text=[historyModel sharedhistoryModel].menuTitle;
    NSDictionary*dataString= @{@"mode":@"my_performance",@"op_user_emp_group_code":[historyModel sharedhistoryModel].opUserEmpGroupCode,@"op_default_fin_year":@"2016-2017",@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    NSLog(@"mail10");

    NSLog(@"homeData%@",dataString);
    
    [self appoinmentApi:dataString];
    if (_homeView) {
        CGRect frame = self.performenceTable.frame;
        frame.origin.y =0;
        self.performenceTable.frame=frame;
        self.headerView.hidden=YES;
    }

    
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
                info=[dataDic objectForKey:@"info"];
                
                [self.performenceTable reloadData];
                [SVProgressHUD dismiss];
                
            });
        }
        else
        {
            NSString *msg = [dataDic objectForKey:@"msg"];
            [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:3.0];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"count>>>%lu",[[[info objectAtIndex:0]objectForKey:@"performace"] count]);
    return [info count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
     nameLabHight = [self heigtForCellwithString:[[info objectAtIndex:section]valueForKey:@"KPI"] withFont:[UIFont systemFontOfSize:12]];
    return nameLabHight.height;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[info objectAtIndex:section]objectForKey:@"performace_detail"] count];
   // NSInteger*inte=&section;
  }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"performenceDetailCell";
    MyPerformance = (performenceDetailCell *)[self.performenceTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (MyPerformance == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"performenceDetailCell" owner:self options:nil];
        MyPerformance = [cellArray objectAtIndex:0];
        self.performenceTable.allowsSelection = NO;
    }
    self.performenceTable.allowsSelection = NO;
   
    NSLog(@"dddd>>>%@",[[[[info objectAtIndex:indexPath.section]objectForKey:@"performace_detail"] objectAtIndex:indexPath.row]objectForKey:@"PRODUCT_SEGMENT"]);
    MyPerformance.detailLab.text=[[[[info objectAtIndex:indexPath.section]objectForKey:@"performace_detail"] objectAtIndex:indexPath.row]objectForKey:@"PRODUCT_SEGMENT"];
    
        MyPerformance.percentageLab.text=[NSString stringWithFormat:@"%@%@", [[[[info objectAtIndex:indexPath.section]objectForKey:@"performace_detail"] objectAtIndex:indexPath.row]objectForKey:@"GROWTH"],@"%"];
   // MyPerformance.yearPerformence.text=[NSString stringWithFormat:@"%@%@", [[[[info objectAtIndex:indexPath.section]objectForKey:@"performace_detail"] objectAtIndex:indexPath.row]objectForKey:@"LAST_YEAR_SALE"],@""];
    if([[[[[info objectAtIndex:indexPath.section]objectForKey:@"performace_detail"] objectAtIndex:indexPath.row]objectForKey:@"GROWTH"] intValue] <=25)
    {
        MyPerformance.percentageColour.backgroundColor=[UIColor redColor];
    }
   else if([[[[[info objectAtIndex:indexPath.section]objectForKey:@"performace_detail"] objectAtIndex:indexPath.row]objectForKey:@"GROWTH"] intValue] <=75)
    {
        MyPerformance.percentageColour.backgroundColor=[UIColor yellowColor];
    }
    else if ([[[[[info objectAtIndex:indexPath.section]objectForKey:@"performace_detail"] objectAtIndex:indexPath.row]objectForKey:@"GROWTH"] intValue] <=100)
    {
        MyPerformance.percentageColour.backgroundColor=[UIColor greenColor];
    }
    
    
    
    return  MyPerformance;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,0)];

    UILabel *KPILab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width/2-30,nameLabHight.height)];
    UILabel *KPIvalueLab = [[UILabel alloc] initWithFrame:CGRectMake(KPILab.frame.origin.x+KPILab.frame.size.width,0,60,20)];
    [KPILab setFont:[UIFont boldSystemFontOfSize:12]];
    
    UILabel *KPIpercentLab = [[UILabel alloc] initWithFrame:CGRectMake(KPIvalueLab.frame.origin.x+KPIvalueLab.frame.size.width+15,0,30,15)];
    KPIvalueLab.numberOfLines=0;
    
     UILabel *kpiColourLab = [[UILabel alloc] initWithFrame:CGRectMake(KPIpercentLab.frame.origin.x+KPIpercentLab.frame.size.width+17,3,20,8)];
    
    [KPILab setFont:[UIFont boldSystemFontOfSize:12]];
    [KPIpercentLab setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *KpiPercent;
    if([[[info objectAtIndex:section]valueForKey:@"ACH_DETAIL"]isEqual:[NSNull null] ])
    {
        KpiPercent =[NSString stringWithFormat:@"%@%@",@"0",@"%"];
    }
    else
    {
    KpiPercent =[NSString stringWithFormat:@"%@%@", [[info objectAtIndex:section]valueForKey:@"ACH_DETAIL"],@"%"];
    }
   
    NSString *string =[[info objectAtIndex:section]valueForKey:@"KPI"];
    NSString *target;

    if ([[[info objectAtIndex:section]valueForKey:@"TARGET"] isEqual:[NSNull null]])
    {
        target =@"";

    }
    else
    {
        target=[[info objectAtIndex:section]valueForKey:@"TARGET"];
    }
    NSString *string1=  [NSString stringWithFormat:@"%@    %@", [[info objectAtIndex:section] objectForKey:@"WEIGHTAGE"],target];
    KPIvalueLab.font = [UIFont systemFontOfSize:12];
    
    
    
    KPILab.numberOfLines = 0;
    KPIvalueLab.numberOfLines = 0;
    KPILab.textColor=[UIColor darkGrayColor];
    [KPIvalueLab setText:string1];
    [KPILab setText:string];
    [KPILab sizeToFit];
    [KPIpercentLab setText:KpiPercent];
    [KPIvalueLab sizeToFit];
    UILabel*sepraterLab=[[UILabel alloc]initWithFrame:CGRectMake(KPILab.frame.origin.x, KPILab.frame.origin.y+KPILab.frame.size.height+2,MyPerformance.frame.size.width, 1)];
    sepraterLab.backgroundColor=[UIColor grayColor];
    
    KPIvalueLab.textColor=[UIColor darkGrayColor];
    [view1 addSubview:KPILab];
    [view1 addSubview:KPIvalueLab];
    [view1 addSubview:KPIpercentLab];
    [view1 addSubview:kpiColourLab];
    [view1 addSubview:sepraterLab];
    
    if([[[info objectAtIndex:section]valueForKey:@"ACH_DETAIL"]isEqual:[NSNull null] ])
    {
        kpiColourLab.backgroundColor=[UIColor redColor];

    }
   else if([[[info objectAtIndex:section]valueForKey:@"ACH_DETAIL"] intValue] <=25)
    {
        kpiColourLab.backgroundColor=[UIColor redColor];
    }
    else if([[[info objectAtIndex:section]valueForKey:@"ACH_DETAIL"] intValue]<=75)
    {
        kpiColourLab.backgroundColor=[UIColor yellowColor];
    }
    else if ([[[info objectAtIndex:section]valueForKey:@"ACH_DETAIL"] intValue] <=100)
    {
        kpiColourLab.backgroundColor=[UIColor greenColor];
    }

    
    
    return view1;
}

- (IBAction)backBtn:(id)sender {
    
     HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
    
    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
    HomeViewControllerVC.menuString=@"Left";


}
-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)tableheader
{
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.performenceTable.bounds.size.width,60)];
    self.performenceTable.tableHeaderView = headerView;
    
   // headerView.backgroundColor=[UIColor blueColor];
    
    UILabel *itemLab=[[UILabel alloc]initWithFrame:CGRectMake(headerView.frame.origin.x+10,headerView.frame.origin.y+27,100,30)];
    itemLab.textColor = [UIColor blackColor];
    itemLab.font = [UIFont systemFontOfSize:13];
    itemLab.text=@"KPI";
    
    UILabel *itemLab2=[[UILabel alloc]initWithFrame:CGRectMake(itemLab.frame.size.width+35,headerView.frame.origin.y+27,200,30)];
    
     UILabel *itemLab1=[[UILabel alloc]initWithFrame:CGRectMake(headerView.frame.origin.x+10,headerView.frame.size.height-2,self.performenceTable.bounds.size.width,1)];
    itemLab1.backgroundColor = [UIColor blackColor];
    itemLab2.textColor=[UIColor blackColor];
    itemLab2.font = [UIFont systemFontOfSize:13];
    

    itemLab2.text=@"W/A";
    [headerView addSubview:itemLab];
    [headerView addSubview:itemLab2];
    [headerView addSubview:itemLab1];


}

-(CGSize)heigtForCellwithString:(NSString *)stringValue withFont:(UIFont*)font{
    CGSize constraint = CGSizeMake(90,2000); // Replace 300 with your label width
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [stringValue boundingRectWithSize:constraint
                                            options:         (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil];
    return rect.size;
    
}

-(void)viewWillAppear:(BOOL)animated
{
   NSString*getImgUrl = [[NSUserDefaults standardUserDefaults]
                 stringForKey:@"preferenceName"];
    [self.profileImg setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    NSString*pageName=@"my performance Page";
    [MyCustomClass logApi:pageName];


}

- (IBAction)profileBtn:(id)sender
{
    profileVC*profile=[[profileVC alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
    
    
}
@end
