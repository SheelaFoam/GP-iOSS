//
//  mytaskMenuVC.m
//  Sheela Foam
//
//  Created by Apple on 01/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "mytaskMenuVC.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "historyModel.h"
#import "mytaskCellTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "profileVC.h"



@interface mytaskMenuVC ()<WebServiceResponseProtocal>
{
    NSDictionary*dataDic;
    MyWebServiceHelper *helper;
    NSArray*info;
    mytaskCellTableViewCell*cellAttachment;
    CGSize labelHeight;
    CGSize nameLabHight;

}
@end

@implementation mytaskMenuVC

- (IBAction)logout:(id)sender{
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height /2;
    self.profileImg.layer.masksToBounds = YES;
    self.profileImg.layer.borderWidth = 0;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.mytasktable.bounces = NO;
    self.messageLab.hidden=YES;
    self.mytasktable.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
    self.mytasktable.layer.borderWidth = 2.0f;
    self.titleLab.text=[[historyModel sharedhistoryModel].menuTitle uppercaseString];
    NSLog(@"mail14");


    [self taskApi];
    self.mytasktable.delegate=self;
    self.mytasktable.dataSource=self;
    UILabel *blueSeparator = [[UILabel alloc]initWithFrame:CGRectMake(13,self.headerView.frame.size.height-5,[UIScreen mainScreen].bounds.size.width-60,1)];
    blueSeparator.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:76.0/255.0f blue:164.0/255.0f alpha:1.0];
    [self.headerView addSubview:blueSeparator];

    self.mytasktable.tableHeaderView=self.headerView;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)taskApi
{
    NSDictionary*dataString= @{@"mode":@"task",@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"uid":[historyModel sharedhistoryModel].uid,@"displayname":[historyModel sharedhistoryModel].displayname,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
        NSLog(@"homeData%@",dataString);
    
        [self myTask:dataString];
}

-(void)myTask:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper myTaskApi:dataString];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
//    NSString*str=[[NSString alloc] initWithData:responseDictionary encoding:NSUTF8StringEncoding];
    
    
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"myTaskApi"])
    {
        info=[dataDic objectForKey:@"info"];

        if (info.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                info=[dataDic objectForKey:@"info"];
                
               [self.mytasktable reloadData];
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
    if([apiName isEqualToString:@"approveApi"])
    {
       // if (dataDic.count>0)
        
        if ([[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"status"] intValue]==1)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cellAttachment.approveBtn.hidden=YES;
                cellAttachment.disApprove.hidden=YES;
                [self taskApi];
                [MyCustomClass SVProgressMessageDismissWithError:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"] timeDalay:3.0];
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
    nameLabHight = [self heigtForCellwithString:[[info objectAtIndex:indexPath.row] objectForKey:@"displayname"] withFont:[UIFont systemFontOfSize:14]];
  labelHeight = [self heigtForCellwithString:[[info objectAtIndex:indexPath.row] objectForKey:@"TASK_DESC"] withFont:[UIFont systemFontOfSize:13]];
    return labelHeight.height+nameLabHight.height+50;
    }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [info count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"mytaskCellTableViewCell";
    cellAttachment = (mytaskCellTableViewCell *)[self.mytasktable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"mytaskCellTableViewCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        self.mytasktable.allowsSelection = NO;
        
    }
    cellAttachment.pendingLab.hidden=NO;
    [cellAttachment.approveBtn addTarget:self
                                  action:@selector(approveAction:)
                        forControlEvents:UIControlEventTouchUpInside];
    [cellAttachment.disApprove addTarget:self
                                  action:@selector(disApprove:)
                        forControlEvents:UIControlEventTouchUpInside];
    cellAttachment.approveBtn.tag=indexPath.row;
    cellAttachment.disApprove.tag=indexPath.row;
    if ([[[info objectAtIndex:indexPath.row] objectForKey:@"AUTHORIZE_YN"] intValue]==0)
    {
        cellAttachment.approveBtn.hidden=YES;
        cellAttachment.disApprove.hidden=YES;
    }
    else
    {
        cellAttachment.approveBtn.hidden=NO;
        cellAttachment.disApprove.hidden=NO;
    }
    
    cellAttachment.timeLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"TASK_DATETIME"];
    //cellAttachment.nameLab.numberOfLines=2;
     cellAttachment.nameLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"displayname"];
    cellAttachment.taskDesk.text=[[info objectAtIndex:indexPath.row] objectForKey:@"TASK_DESC"];
     cellAttachment.nameLab.frame=CGRectMake(15,5,cellAttachment.nameLab.frame.size.width-40,cellAttachment.nameLab.frame.size.height);
     cellAttachment.taskDesk.frame=CGRectMake(15,cellAttachment.nameLab.frame.origin.y+cellAttachment.nameLab.frame.size.height+15,cellAttachment.taskDesk.frame.size.width-80,cellAttachment.taskDesk.frame.size.height);
     cellAttachment.timeLab.frame=CGRectMake(210,11,cellAttachment.timeLab.frame.size.width-20,cellAttachment.timeLab.frame.size.height);
    [cellAttachment.taskDesk sizeToFit];
    [cellAttachment.nameLab sizeToFit];
    cellAttachment.sapraterLab.frame=CGRectMake(15,cellAttachment.frame.size.height-10,cellAttachment.frame.size.width-30,cellAttachment.sapraterLab.frame.size.height);
    return  cellAttachment;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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

-(void)approveAction:(id)sender
{
    NSString*taskId=[[info objectAtIndex:[sender tag]] objectForKey:@"TASK_ID"];
    
      NSDictionary*dataString= @{@"mode":@"approve",@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"task_status":@"",@"task_id":taskId,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    
  
    
    [helper approveApi:dataString];
    
    
}
-(void)disApprove:(id)sender
{
    NSString*taskId=[[info objectAtIndex:[sender tag]] objectForKey:@"TASK_ID"];
    
    NSDictionary*dataString= @{@"mode":@"disapprove",@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"task_status":@"",@"task_id":taskId,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    
    [helper approveApi:dataString];
    
    
    }

-(void)viewWillAppear:(BOOL)animated
{
    NSString*getImgUrl = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceName"];
    [self.profileImg setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    NSString*pageName=@"My Task Page";
    [MyCustomClass logApi:pageName];
    
}

- (IBAction)profileBtn:(id)sender
{
    profileVC*profile=[[profileVC alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
}

-(CGSize)heigtForCellwithString:(NSString *)stringValue withFont:(UIFont*)font{
    CGSize constraint = CGSizeMake(cellAttachment.taskDesk.frame.size.width,2000); // Replace 300 with your label width
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [stringValue boundingRectWithSize:constraint
                                            options:         (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil];
    return rect.size;
    
}

@end
