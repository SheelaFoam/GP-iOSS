//
//  approveTaskVC.m
//  Sheela Foam
//
//  Created by Apple on 14/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//
#import "approveTaskVC.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "historyModel.h"
#import "mytaskCellTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "profileVC.h"
@interface approveTaskVC ()<UITableViewDelegate,UITableViewDataSource,WebServiceResponseProtocal>
{
    NSDictionary*dataDic;
    MyWebServiceHelper *helper;
    NSArray*info;
    mytaskCellTableViewCell*cellAttachment;
    CGSize labelHeight;
}
@end
@implementation approveTaskVC

- (IBAction)logout:(id)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height /2;
    self.profileImg.layer.masksToBounds = YES;
    self.profileImg.layer.borderWidth = 0;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.taskApproveTable.delegate=self;
    self.taskApproveTable.dataSource=self;
    self.taskApproveTable.bounces = NO;
    self.messageLab.hidden=YES;
    self.taskApproveTable.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
    self.taskApproveTable.layer.borderWidth = 2.0f;
    NSDictionary*dataString= @{@"mode":@"approve_task",@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"uid":[historyModel sharedhistoryModel].uid,@"displayname":[historyModel sharedhistoryModel].displayname,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    [self myTask:dataString];
    
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(13,self.headerView.frame.size.height-5,[UIScreen mainScreen].bounds.size.width-60,1)];
    fromLabel.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:76.0/255.0f blue:164.0/255.0f alpha:1.0];
    [self.headerView addSubview:fromLabel];

    self.taskApproveTable.tableHeaderView=self.headerView;
    
    //{"mode":"approve_task","op_greatplus_user_id":"ROSHNIS","op_user_role_name":"WEB ADMIN","uid":"ROSHNI.SHRESHTHA","displayname":"ROSHNI SHRESHTHA"}


    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)myTask:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper myTaskApi:dataString];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"myTaskApi"])
    {
        info=[dataDic objectForKey:@"info"];

        if (info.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                info=[dataDic objectForKey:@"info"];
                
                [self.taskApproveTable reloadData];
                
                
                [SVProgressHUD dismiss];
                
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.messageLab.hidden=NO;
                [SVProgressHUD dismiss];
            });
//            NSString *msg = [dataDic objectForKey:@"msg"];
//            [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:3.0];
        }
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
    labelHeight = [self heigtForCellwithString:[[info objectAtIndex:indexPath.row] objectForKey:@"TASK_DESC"] withFont:[UIFont systemFontOfSize:13]];
    return labelHeight.height+cellAttachment.nameLab.frame.size.height+40 ;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if ([info count]==0)
//    {
//        self.messageLab.hidden=NO;
//        return 0;
//    }
    //else
    //{
       // self.messageLab.hidden=YES;

        return [info count];

   // }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"mytaskCellTableViewCell";
    cellAttachment = (mytaskCellTableViewCell *)[self.taskApproveTable dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"mytaskCellTableViewCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        self.taskApproveTable.allowsSelection = NO;
    }
    cellAttachment.approveLab.hidden=NO;
    cellAttachment.approveBtn.hidden=YES;
    cellAttachment.disApprove.hidden=YES;
    cellAttachment.timeLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"TASK_DATETIME"];
    cellAttachment.nameLab.text=[historyModel sharedhistoryModel].displayname;
    cellAttachment.taskDesk.text=[[info objectAtIndex:indexPath.row] objectForKey:@"TASK_DESC"];
//cellAttachment.taskDesk.frame=CGRectMake(56,20,cellAttachment.taskDesk.frame.size.width,cellAttachment.taskDesk.frame.size.height);
    [cellAttachment.taskDesk sizeToFit];
    
    cellAttachment.approveLab.frame=CGRectMake(230,cellAttachment.approveLab.frame.origin.y,cellAttachment.approveLab.frame.size.width,cellAttachment.approveLab.frame.size.height);
    cellAttachment.sapraterLab.frame=CGRectMake(15,cellAttachment.frame.size.height-10,cellAttachment.sapraterLab.frame.size.width,cellAttachment.sapraterLab.frame.size.height);
    return  cellAttachment;
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString*getImgUrl = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceName"];
    [self.profileImg setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    NSString*pageName=@"Approve Task Page";
    [MyCustomClass logApi:pageName];
}
- (IBAction)profileBtn:(id)sender
{
    profileVC*profile=[[profileVC alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
}
-(CGSize)heigtForCellwithString:(NSString *)stringValue withFont:(UIFont*)font
{
    CGSize constraint = CGSizeMake(145,2000); // Replace 300 with your label width
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [stringValue boundingRectWithSize:constraint
                                            options:         (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil];
    return rect.size;
    
}
@end
