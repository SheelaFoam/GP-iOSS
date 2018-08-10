//
//  myTaskVC.m
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//
#import "myTaskVC.h"
#import "CommonTableViewCell.h"
#import "historyModel.h"
#import "mytaskCellTableViewCell.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "HomeViewController.h"
@implementation myTaskVC
{
    mytaskCellTableViewCell*cellAttachment;
    NSInteger *IndexValu;
    NSDictionary*dataDic;
    MyWebServiceHelper *helper;
    NSMutableArray*info;
    NSString*approve;
}
- (void)drawRect:(CGRect)rect {

    // Drawing code
}
-(id)initWithFrame:(CGRect)frame
{ self = [super initWithFrame:frame];
    if (self)
    {
        helper = [[MyWebServiceHelper alloc] init];
        helper.webApiDelegate = self;
        UIView *ViewName = [[[NSBundle mainBundle] loadNibNamed:@"myTaskVC" owner:self options:nil] objectAtIndex:0];
        CGRect frame= ViewName.frame; frame.size.width=self.frame.size.width; frame.size.height=self.frame.size.height; ViewName.frame=frame; [self addSubview:ViewName];
        self.mytaskTable.delegate=self;
        self.mytaskTable.dataSource=self;
        UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(13,self.headerView.frame.size.height-5,[UIScreen mainScreen].bounds.size.width-60,1)];
        fromLabel.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:76.0/255.0f blue:164.0/255.0f alpha:1.0];
        [self.headerView addSubview:fromLabel];
        self.mytaskTable.tableHeaderView=self.headerView;
        self.mytaskTable.tableFooterView=self.footerView;
        NSLog(@"mail2");

    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"task"] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 73;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"mytaskCellTableViewCell";
    cellAttachment = (mytaskCellTableViewCell *)[self.mytaskTable dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"mytaskCellTableViewCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        self.mytaskTable.allowsSelection = NO;
    }
    [cellAttachment.approveBtn addTarget:self
                                  action:@selector(approveAction:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [cellAttachment.disApprove addTarget:self
                                  action:@selector(disApprove:)
                        forControlEvents:UIControlEventTouchUpInside];
    cellAttachment.approveBtn.tag=indexPath.row;
    cellAttachment.disApprove.tag=indexPath.row;
  if ([approve isEqualToString:@"approve"])
  {
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
  }
    else
    {
//        if ([[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"task"] objectAtIndex:indexPath.row] objectForKey:@"AUTHORIZE_YN"] intValue]==0)
//        {
//            cellAttachment.approveBtn.hidden=YES;
//            cellAttachment.disApprove.hidden=YES;
//        }
//        else
//        {
//            cellAttachment.approveBtn.hidden=NO;
//            cellAttachment.disApprove.hidden=NO;
//        }
    }
    NSLog(@"TASKDATA>>>>%@",[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"task"] objectAtIndex:indexPath.row] objectForKey:@"TASK_DATETIME"]);
    cellAttachment.timeLab.text=[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"task"] objectAtIndex:indexPath.row] objectForKey:@"TASK_DATETIME"];
    cellAttachment.nameLab.text=[historyModel sharedhistoryModel].displayname;
    cellAttachment.taskDesk.text=[[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"task"] objectAtIndex:indexPath.row] objectForKey:@"TASK_DESC"] lowercaseString];
    cellAttachment.taskTitle.text=[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"task"] objectAtIndex:indexPath.row] objectForKey:@"TASK_TITLE"];
    if (indexPath.row==[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"task"] count]-1)
    {
        cellAttachment.sapraterLab.hidden=YES;
    
    }
    return  cellAttachment;
}
-(void)approveAction:(id)sender
{
    NSString*taskId=[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"task"] objectAtIndex:[sender tag]] objectForKey:@"TASK_ID"];
     NSDictionary*dataString= @{@"mode":@"approve",@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"task_status":@"",@"task_id":taskId,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    [self myTask:dataString];
 }

-(void)disApprove:(id)sender
{
    NSString*taskId=[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"task"] objectAtIndex:[sender tag]] objectForKey:@"TASK_ID"];
    NSDictionary*dataString= @{@"mode":@"disapprove",@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"task_status":@"",@"task_id":taskId,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    [self myTask:dataString];
}
-(void)myTask:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    [helper approveApi:dataString];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
   NSString* myString = [[NSString alloc] initWithData:responseDictionary encoding:NSASCIIStringEncoding];
    NSLog(@"data>>>%@",myString);
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    info=[dataDic objectForKey:@"info"];
    if([apiName isEqualToString:@"approveApi"])
    {
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                info=[dataDic objectForKey:@"info"];
                approve=@"approve";
               // [info removeAllObjects];
                info=[dataDic objectForKey:@"task"];
                [self.mytaskTable reloadData];
//              cellAttachment.approveBtn.hidden=YES;
//              cellAttachment.disApprove.hidden=YES;
                [SVProgressHUD dismiss];
            });
        }
        else
        {
            [MyCustomClass SVProgressMessageDismissWithError:@"" timeDalay:3.0];
        }
    }
}
-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknow Error" timeDalay:2.0];
}

@end
