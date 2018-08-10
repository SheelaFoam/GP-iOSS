//
//  opinionDetailVC.m
//  Sheela Foam
//
//  Created by Apple on 02/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "opinionDetailVC.h"
#import "HomeViewController.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "historyModel.h"
#import "opinionCell.h"
#import "UIImageView+WebCache.h"
#import "profileVC.h"



@interface opinionDetailVC ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSArray*info;
    NSDictionary*dataDic;
    opinionCell*cellAttachment;
    long selectedindex;
    NSString*selectedPoolID;
    NSString*PoolID;
    NSString*poolValuSet;
    NSArray*info2;
    NSString*selectStr;


    
}

@end

@implementation opinionDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height /2;
    self.profileImg.layer.masksToBounds = YES;
    self.profileImg.layer.borderWidth = 0;
   selectedindex=100;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    
    self.boarderView.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
    self.boarderView.layer.borderWidth = 2.0f;

NSDictionary*dataString= @{@"mode":@"polls",@"user_email":[historyModel sharedhistoryModel].userEmail,@"uid":[historyModel sharedhistoryModel].uid,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    self.opinionTable.delegate=self;
    self.opinionTable.dataSource=self;
    
    
    NSLog(@"homeData%@",dataString);
    
    [self appoinmentApi:dataString];
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
    {   info=[dataDic objectForKey:@"info"];

        if (info.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                info=[dataDic objectForKey:@"info"];
                self.titleDetal.text=[[info objectAtIndex:0] objectForKey:@"name"];
                [self.opinionTable reloadData];
                [SVProgressHUD dismiss];
                
            });
        }
    }
    if([apiName isEqualToString:@"poolselection"])
    {
        info=[dataDic objectForKey:@"info"];

        if (info.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{

                if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==1)
                {
                    [historyModel sharedhistoryModel].poolTable=@"hide";

                self.titleDetal.text=[[info objectAtIndex:0] objectForKey:@"name"];
                    [self.opinionTable reloadData];
                    
                    [MyCustomClass SVProgressMessageDismissWithSuccess:[[info2 objectAtIndex:0]objectForKey:@"msg"] timeDalay:3.0];

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
    return [[[info objectAtIndex:0] objectForKey:@"polls_option"] count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"cellAttachment";
    cellAttachment = (opinionCell *)[self.opinionTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"opinionCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        //self.opinionTable.allowsSelection = NO;
        
    }
    [cellAttachment.opinionBtn addTarget:self action:@selector(selectopinion:) forControlEvents:UIControlEventTouchUpInside];

    cellAttachment.opinoinLab.text=[[[[info objectAtIndex:0] objectForKey:@"polls_option"] objectAtIndex:indexPath.row] objectForKey:@"name"];
    cellAttachment.opinionBtn.tag=indexPath.row;
    

    

    if (selectedindex==indexPath.row)
    {
        cellAttachment.opinionImg.image = [UIImage imageNamed:@"radio"];
 
        
    }
    else
    {
        cellAttachment.opinionImg.image = [UIImage imageNamed:@"radioBtn"];

    
    }
    
    if (![[[info  objectAtIndex:0] objectForKey:@"id_poll_options"]isEqualToString:@""])
    {
       
        
        [historyModel sharedhistoryModel].poolTable=@"hide";
        
        cellAttachment.poolValue.hidden=NO;
        cellAttachment.poolValue.text=[NSString stringWithFormat:@"%@%@",[[[[info objectAtIndex:0] objectForKey:@"polls_option"] objectAtIndex:indexPath.row] objectForKey:@"percent"],@"%"];
        NSString*str=[NSString stringWithFormat:@"%@%@",[[[[info objectAtIndex:0] objectForKey:@"polls_option"] objectAtIndex:indexPath.row] objectForKey:@"percent"],@"%"];
        cellAttachment.poolValue.text=str;
        self.opinionTable.userInteractionEnabled = YES;
        
        NSString*one=[[info objectAtIndex:0] objectForKey:@"id_poll_options"];
        NSString*one22=[[[[info objectAtIndex:0] objectForKey:@"polls_option"] objectAtIndex:indexPath.row] objectForKey:@"id"];
        
        self.opinionTable.userInteractionEnabled = NO;
        
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
        cellAttachment.poolValue.hidden=YES;

    }
    
          return  cellAttachment;
  

   
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if ([[historyModel sharedhistoryModel].poolTable isEqualToString:@"hide"])
    {
        return [[UIView alloc]initWithFrame:CGRectZero];
        
    }
    else if ([[[info objectAtIndex:0] objectForKey:@"id_poll_options"] isEqualToString:@""])
    {
        CGFloat width = self.opinionTable.frame.size.width;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50,10, width, 44)];
        view.backgroundColor = [UIColor clearColor];
        
        UIButton *submitYourVote = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width/2-75,10,150,40)];
        [submitYourVote addTarget:self action:@selector(submitYourVoteAction) forControlEvents:UIControlEventTouchUpInside];
        UIImage *buttonImage = [UIImage imageNamed:@"submit-ur-vote"];
        [submitYourVote setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [view addSubview:submitYourVote];
        
        return view;
    }
    else
    {
    CGFloat width = self.opinionTable.frame.size.width;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50,10, width, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *submitYourVote = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width/2-50,10, width-120,30)];
      [submitYourVote addTarget:self action:@selector(submitYourVoteAction) forControlEvents:UIControlEventTouchUpInside];
    UIImage *buttonImage = [UIImage imageNamed:@"submit-ur-vote"];
    [submitYourVote setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [view addSubview:submitYourVote];

    return view;
    }
}

-(void)selectopinion:(id)sender
{
    selectStr=@"selected";

    selectedindex=[sender tag];
selectedPoolID=[[[[info objectAtIndex:0] objectForKey:@"polls_option"] objectAtIndex:selectedindex] objectForKey:@"id"];
    PoolID=[[info objectAtIndex:0] objectForKey:@"id_polls"];
    [self.opinionTable reloadData];

}
-(void)submitYourVoteAction
{
    [self opinion];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectStr=@"selected";

    selectedindex=indexPath.row;
    selectedPoolID=[[[[info objectAtIndex:0] objectForKey:@"polls_option"] objectAtIndex:selectedindex] objectForKey:@"id"];
    PoolID=[[info objectAtIndex:0] objectForKey:@"id_polls"];
    [tableView reloadData];
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender
{
    HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
    
    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
    
    HomeViewControllerVC.menuString=@"Left";
    

}
-(void)opinion
{
    if ([selectStr isEqualToString:@"selected"])
    {
    
   NSDictionary*dataString= @{@"action":@"submit_poll",@"email":[historyModel sharedhistoryModel].userEmail,@"user_id":[historyModel sharedhistoryModel].uid,@"id_polls":PoolID,@"id_poll_options":selectedPoolID,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token};
 
    
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

-(void)viewWillAppear:(BOOL)animated
{
    NSString*getImgUrl = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceName"];
    [self.profileImg setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    NSString*pageName=@"opinion Page";
    [MyCustomClass logApi:pageName];
    
  }

- (IBAction)profileBtn:(id)sender
{
    profileVC*profile=[[profileVC alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
}


@end
