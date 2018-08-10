//
//  OpinionVC.m
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "OpinionVC.h"
#import "historyModel.h"
#import "opinionCell.h"
#import "HomeViewController.h"


@implementation OpinionVC
{
    MyWebServiceHelper *helper;
    NSArray*info;
    NSDictionary*dataDic;
    opinionCell*cellAttachment;
    long selectedindex;
    NSString*poolValuSet;
    NSString*selectedPoolID;
    NSString*PoolID;
    UIButton *submitYourVote;
    UIView *footerView;
    HomeViewController*home;
    NSString*selectStr;


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{ self = [super initWithFrame:frame];
    
    if (self)
    { UIView *ViewName = [[[NSBundle mainBundle] loadNibNamed:@"OpinionVC" owner:self options:nil] objectAtIndex:0];
        CGRect frame= ViewName.frame; frame.size.width=self.frame.size.width; frame.size.height=self.frame.size.height; ViewName.frame=frame;
        [self addSubview:ViewName];
        home=[[HomeViewController alloc]init];
        selectedindex=100;
        helper = [[MyWebServiceHelper alloc] init];
        helper.webApiDelegate = self;
        
        UILabel *blueSeparator = [[UILabel alloc]initWithFrame:CGRectMake(13,self.headerTitle.frame.size.height+self.headerTitle.frame.origin.y+5,[UIScreen mainScreen].bounds.size.width-60,1)];
        blueSeparator.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:76.0/255.0f blue:164.0/255.0f alpha:1.0];
        [self addSubview:blueSeparator];

       
        self.pooleTable.delegate=self;
        self.pooleTable.dataSource=self;
        
        
        self.pooleTable.tableFooterView.frame = CGRectMake(0, 0, 320, 88);
        NSLog(@"mail6");


        
    }
    
    return self;
}


-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);

    if([apiName isEqualToString:@"poolselection"])
    {
        info=[dataDic objectForKey:@"info"];
        
        if (info.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==1)
                {
                    [self.pooleTable reloadData];
                    [historyModel sharedhistoryModel].poolstr=@"";
                    poolValuSet=@"pool";
                    [MyCustomClass SVProgressMessageDismissWithSuccess:[[info objectAtIndex:0]objectForKey:@"msg"] timeDalay:3.0];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] count]==0)
    {
        return 0;
    }
    
    else
    return [[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"polls_option"] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
        return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"cellAttachment";
    cellAttachment = (opinionCell *)[self.pooleTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"opinionCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        //self.opinionTable.allowsSelection = NO;
        
    }
    [cellAttachment.opinionBtn addTarget:self action:@selector(selectopinion:) forControlEvents:UIControlEventTouchUpInside];
    
    cellAttachment.opinoinLab.text=[[[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"polls_option"] objectAtIndex:indexPath.row] objectForKey:@"name"];
    cellAttachment.opinionBtn.tag=indexPath.row;
    
    
    if (selectedindex==indexPath.row)
    {
        cellAttachment.opinionImg.image = [UIImage imageNamed:@"radio"];
    }
    else
    {
        cellAttachment.opinionImg.image = [UIImage imageNamed:@"radioBtn"];
        
    }
    
    if ([[historyModel sharedhistoryModel].poolstr isEqualToString:@"homepool"])
    {
        if ([[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"id_poll_options"]isEqualToString:@""])
        {
            cellAttachment.poolValue.hidden=YES;
            cellAttachment.opinoinLab.text=[[[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"polls_option"] objectAtIndex:indexPath.row] objectForKey:@"name"];
            
        }
        else
        {
            [historyModel sharedhistoryModel].poolTable=@"hide";
            NSString*one=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"id_poll_options"];
            NSString*one22=[[[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"polls_option"]  objectAtIndex:indexPath.row] objectForKey:@"id"];
            [[self.pooleTable tableFooterView] setHidden:YES];
            
            self.pooleTable.userInteractionEnabled = NO;
            
            
            if (one==one22)
            {
                selectedindex=indexPath.row;
                cellAttachment.opinionImg.image = [UIImage imageNamed:@"radio"];
                cellAttachment.view.layer.borderWidth = 1;
                cellAttachment.view.layer.borderColor =   [[UIColor colorWithRed:30/255.0f green:175/255.0f blue:180/255.0f alpha:1.0f]CGColor];
            }
            cellAttachment.poolValue.hidden=NO;
            NSString*str=[NSString stringWithFormat:@"%@%@",[[[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"polls_option"]  objectAtIndex:indexPath.row] objectForKey:@"percent"],@"%"];
            cellAttachment.poolValue.text=str;
        }
    }
    
  else if ([poolValuSet isEqualToString:@"pool"])
        {
            [historyModel sharedhistoryModel].poolTable=@"hide";

            cellAttachment.poolValue.hidden=NO;
            NSString*str=[NSString stringWithFormat:@"%@%@",[[[[info objectAtIndex:0] objectForKey:@"percent"] objectAtIndex:indexPath.row] objectForKey:@"percent"],@"%"];
            cellAttachment.poolValue.text=str;
            self.pooleTable.userInteractionEnabled = YES;
            
            NSString*one=[[info objectAtIndex:0] objectForKey:@"id_poll_options"];
            NSString*one22=[[[[info objectAtIndex:0] objectForKey:@"percent"] objectAtIndex:indexPath.row] objectForKey:@"id_poll_options"];
            [[self.pooleTable tableFooterView] setHidden:YES];
            
            self.pooleTable.userInteractionEnabled = NO;
            
            
            if (one==one22)
            {
                selectedindex=indexPath.row;
                cellAttachment.opinionImg.image = [UIImage imageNamed:@"radio"];
                cellAttachment.view.layer.borderWidth = 1;
                cellAttachment.view.layer.borderColor =   [[UIColor colorWithRed:30/255.0f green:175/255.0f blue:180/255.0f alpha:1.0f]CGColor];
                
                

                
            }
           


    
        }
    else
    {
        [historyModel sharedhistoryModel].poolTable=@"hide";
        NSString*one=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"id_poll_options"];
        NSString*one22=[[[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"polls_option"]  objectAtIndex:indexPath.row] objectForKey:@"id"];
        [[self.pooleTable tableFooterView] setHidden:YES];
        
        self.pooleTable.userInteractionEnabled = NO;

        
        if (one==one22)
        {
            selectedindex=indexPath.row;
            cellAttachment.opinionImg.image = [UIImage imageNamed:@"radio"];
            cellAttachment.view.layer.borderWidth = 1;
            cellAttachment.view.layer.borderColor =   [[UIColor colorWithRed:30/255.0f green:175/255.0f blue:180/255.0f alpha:1.0f]CGColor];
            
            


        }
        cellAttachment.poolValue.hidden=NO;
                NSString*str=[NSString stringWithFormat:@"%@%@",[[[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"polls_option"]  objectAtIndex:indexPath.row] objectForKey:@"percent"],@"%"];
        cellAttachment.poolValue.text=str;

    }
    
    

    return  cellAttachment;
    
    
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([[historyModel sharedhistoryModel].poolTable isEqualToString:@"hide"])
    {
        return [[UIView alloc]initWithFrame:CGRectZero];
    
    }
    else
    {
    CGFloat width = self.pooleTable.frame.size.width;
    footerView = [[UIView alloc] initWithFrame:CGRectMake(50,40, width,80)];
    footerView.backgroundColor = [UIColor clearColor];
    
    submitYourVote = [[UIButton alloc] initWithFrame:CGRectMake(footerView.frame.size.width/2-75, 10,150, 40)];
    [submitYourVote addTarget:self action:@selector(submitYourVoteAction) forControlEvents:UIControlEventTouchUpInside];
    UIImage *buttonImage = [UIImage imageNamed:@"submit-ur-vote"];
    [submitYourVote setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [footerView addSubview:submitYourVote];
    
    return footerView;
    }
}

-(void)selectopinion:(id)sender
{
    selectStr=@"selected";

    selectedindex=[sender tag];
    selectedPoolID=[[[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"polls_option"] objectAtIndex:selectedindex] objectForKey:@"id"];
    
   
    PoolID=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"id_polls"];
    [self.pooleTable reloadData];
    
}
-(void)submitYourVoteAction
{

    [self opinion];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    selectStr=@"selected";
    selectedindex=indexPath.row;
    selectedPoolID=[[[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"polls_option"] objectAtIndex:selectedindex] objectForKey:@"id"];
    
    
    PoolID=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"id_polls"];
    [self.pooleTable reloadData];
    
    
}


-(void)opinion
{

    if ([selectStr isEqualToString:@"selected"])
    {
        NSDictionary*dataString= @{@"action":@"submit_poll",/*@"email":[historyModel sharedhistoryModel].userEmail,*/@"user_id":[historyModel sharedhistoryModel].uid,@"id_polls":PoolID,@"id_poll_options":selectedPoolID,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token};
    
    NSLog(@"homeData%@",dataString);
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper poolselection:dataString];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"select your opinion"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}




@end
