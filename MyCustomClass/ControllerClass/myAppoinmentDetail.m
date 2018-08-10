//
//  myAppoinmentDetail.m
//  Sheela Foam
//
//  Created by Apple on 01/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "myAppoinmentDetail.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "historyModel.h"
#import "MyApponment.h"
#import "UIImageView+WebCache.h"
#import "profileVC.h"

@interface myAppoinmentDetail ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSArray*info;
    NSDictionary*dataDic;
    CGSize labelHeight;

    MyApponment*cellAttachment;
}

@end

@implementation myAppoinmentDetail

- (IBAction)logout:(id)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.messageLab.hidden=YES;
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height /2;
    self.profileImg.layer.masksToBounds = YES;
    self.profileImg.layer.borderWidth = 0;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;

    self.myAppoinmentTable.bounces = NO;

    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(13,self.headerView.frame.size.height-5,[UIScreen mainScreen].bounds.size.width-60,1)];
    fromLabel.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:76.0/255.0f blue:164.0/255.0f alpha:1.0];
    [self.headerView addSubview:fromLabel];

    
    self.myAppoinmentTable.tableHeaderView=self.headerView;
    
    NSLog(@"mail15");

   NSDictionary*dataString= @{@"mode":@"appointments",@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    

self.titleLab.text=[historyModel sharedhistoryModel].menuTitle;
  
    NSLog(@"homeData%@",dataString);
    
    [self appoinmentApi:dataString];
    self.myAppoinmentTable.delegate=self;
    self.myAppoinmentTable.dataSource=self;
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
                [self.myAppoinmentTable reloadData];
                
                
                
                //                [self.detailTable setFrame:CGRectMake(self.detailTable.frame.origin.x, self.detailTable.frame.origin.y, self.detailTable.frame.size.width,(40.0f*([info count])))];
                
                [SVProgressHUD dismiss];
                
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.messageLab.hidden=NO;

                
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
    
    labelHeight = [self heigtForCellwithString:[[info objectAtIndex:indexPath.row]objectForKey:@"desc"] withFont:[UIFont systemFontOfSize:14]];
    return 70+labelHeight.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if ([info count]==0)
//    {
//        self.messageLab.hidden=NO;
//        return 0;
//    }
//    else
//    {
        //self.messageLab.hidden=YES;

    return [info count];
    //}
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"MyApponment";
    cellAttachment = (MyApponment *)[self.myAppoinmentTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"MyApponment" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        self.myAppoinmentTable.allowsSelection = NO;
    }
    cellAttachment.dateLab.text=[[info objectAtIndex:indexPath.row]objectForKey:@"day"];
    
    cellAttachment.monthLab.text=[[info objectAtIndex:indexPath.row]objectForKey:@"month"];
    
    
    cellAttachment.appoinmentTime.text=[NSString stringWithFormat:@"%@-%@",[[info objectAtIndex:indexPath.row]objectForKey:@"time"],[[info objectAtIndex:indexPath.row]objectForKey:@"end_time"]];
    
    cellAttachment.appoinmentDetail.text=[[info objectAtIndex:indexPath.row]objectForKey:@"desc"];
    [cellAttachment.appoinmentDetail sizeToFit];
    cellAttachment.sepraterLab.frame=CGRectMake(15,cellAttachment.frame.size.height-10,cellAttachment.sepraterLab.frame.size.width,cellAttachment.sepraterLab.frame.size.height);

    return  cellAttachment;
}

-(CGSize)heigtForCellwithString:(NSString *)stringValue withFont:(UIFont*)font{
    CGSize constraint = CGSizeMake(238,2000); // Replace 300 with your label width
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [stringValue boundingRectWithSize:constraint
                                            options:         (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil];
    return rect.size;
    
}
- (IBAction)backBtn:(id)sender {
    HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
    
    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
    
    HomeViewControllerVC.menuString=@"Left";
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString*getImgUrl = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceName"];
    [self.profileImg setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    NSString*pageName=@"My Appointment Page";
    [MyCustomClass logApi:pageName];
    
    
}

- (IBAction)profileBtn:(id)sender
{
    profileVC*profile=[[profileVC alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
}
@end
