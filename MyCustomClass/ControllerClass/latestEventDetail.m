//
//  latestEventDetail.m
//  Sheela Foam
//
//  Created by Apple on 01/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "latestEventDetail.h"
#import "latestEventCell.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "historyModel.h"
#import "UIImageView+WebCache.h"
#import "profileVC.h"
#import  "QuartzCore/QuartzCore.h"

@interface latestEventDetail ()<WebServiceResponseProtocal>
{

    MyWebServiceHelper *helper;
    NSArray*info;
    NSDictionary*dataDic;
    float RowheightValue;

    latestEventCell*cellAttachment;
    CGSize labelHeightDesc;
    CGSize labelHeightTitle;


}

@end

@implementation latestEventDetail
- (IBAction)logout:(id)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataAvailabilityLAb.hidden=YES;
    self.navigationController.navigationBarHidden=YES;
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height /2;
    self.profileImg.layer.masksToBounds = YES;
    self.profileImg.layer.borderWidth = 0;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.latestEventTable.bounces = NO;
    self.latestEventTable.layer.borderWidth = 2.0;
    self.latestEventTable.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
    NSDictionary*dataString;
   
    if ([[historyModel sharedhistoryModel].menuTitle isEqualToString:@"Sankalp Stories"])
    {
    
    dataString= @{@"mode":@"sankalp_stories",@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
        self.titleLab.text=[[historyModel sharedhistoryModel].menuTitle uppercaseString];
        self.imageView.image=[UIImage imageNamed:@"sankalp"];

        self.eventLab.text=[historyModel sharedhistoryModel].menuTitle;


    }
    else
    {
       dataString= @{@"mode":@"lastes_event",@"user_email":[historyModel sharedhistoryModel].userEmail,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
        self.titleLab.text=[[historyModel sharedhistoryModel].menuTitle uppercaseString];
        self.eventLab.text=[historyModel sharedhistoryModel].menuTitle;


    }
    
    
    if ([[historyModel sharedhistoryModel].menuTitle isEqualToString:@"Sankalp Stories"])
    {
        ///
        _dataAvailabilityLAb.text=@"No Stories!";
        UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.latestEventTable.bounds.size.width,60)];
        self.latestEventTable.tableHeaderView = headerView;
        
        UIImageView *orderLab=[[UIImageView alloc]initWithFrame:CGRectMake(headerView.frame.origin.x+20,headerView.frame.origin.y+15,15,20)];
        orderLab.image = [UIImage imageNamed: @"sankalp"];
        
        
        UILabel *itemLab=[[UILabel alloc]initWithFrame:CGRectMake(43,headerView.frame.origin.y+10,200,30)];
        itemLab.textColor = [UIColor blackColor];
        itemLab.font = [UIFont systemFontOfSize:15];
        itemLab.text=@"Sankalp Stories";
        
        UILabel *blueSeparator = [[UILabel alloc]initWithFrame:CGRectMake(13,headerView.frame.size.height-5,[UIScreen mainScreen].bounds.size.width-60,1)];
        blueSeparator.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:76.0/255.0f blue:164.0/255.0f alpha:1.0];
        [headerView addSubview:blueSeparator];
        [headerView addSubview:orderLab];
        [headerView addSubview:itemLab];


    }
    else
    {
        _dataAvailabilityLAb.text=@"No Events!";

        UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.latestEventTable.bounds.size.width,60)];
        self.latestEventTable.tableHeaderView = headerView;
        UILabel *blueSeparator = [[UILabel alloc]initWithFrame:CGRectMake(13,headerView.frame.size.height-5,[UIScreen mainScreen].bounds.size.width-60,1)];
        blueSeparator.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:76.0/255.0f blue:164.0/255.0f alpha:1.0];
        [headerView addSubview:blueSeparator];
        
        UIImageView *orderLab=[[UIImageView alloc]initWithFrame:CGRectMake(headerView.frame.origin.x+20,headerView.frame.origin.y+15,15,20)];
        orderLab.image = [UIImage imageNamed: @"menulatest-event"];
        
        
        UILabel *itemLab=[[UILabel alloc]initWithFrame:CGRectMake(43,headerView.frame.origin.y+10,200,30)];
        itemLab.textColor = [UIColor blackColor];
        itemLab.font = [UIFont systemFontOfSize:15];
        itemLab.text=@"Latest Events";
        
        [headerView addSubview:orderLab];
        [headerView addSubview:itemLab];
        
        
       }
    
   // {"mode":"lastes_event","user_email":"roshni.shreshtha@sheelafoam.com"}

    NSLog(@"homeData%@",dataString);
    
    [self appoinmentApi:dataString];
    self.latestEventTable.delegate=self;
    self.latestEventTable.dataSource=self;
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
        info= [dataDic objectForKey:@"info"];
        if (info.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{


                [self.latestEventTable reloadData];
                [SVProgressHUD dismiss];
                
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{

            _dataAvailabilityLAb.hidden=NO;
            [MyCustomClass SVProgressMessageDismissWithError:@"" timeDalay:1.0];
            });

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
    NSMutableString *detailLab;
    NSString*titleStr;
     if ([[historyModel sharedhistoryModel].menuTitle isEqualToString:@"Sankalp Stories"])
     {
     detailLab =[[info objectAtIndex:indexPath.row] objectForKey:@"desc"];
         titleStr= [[info objectAtIndex:indexPath.row] objectForKey:@"title"];

         
         
     }
    else
    {
        detailLab =[[info objectAtIndex:indexPath.row] objectForKey:@"short_desc"];
        titleStr= [[info objectAtIndex:indexPath.row] objectForKey:@"title"];

    }
    
        labelHeightTitle=[self heigtForCellwithString:titleStr withFont:[UIFont systemFontOfSize:17]];
  labelHeightDesc = [self heigtForCellwithString:detailLab withFont:[UIFont systemFontOfSize:14]];


    return labelHeightTitle.height+labelHeightDesc.height+cellAttachment.imageLab.frame.size.height+cellAttachment.dateLab.frame.size.height+60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [info count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"latestEventCell";
    cellAttachment = (latestEventCell *)[self.latestEventTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"latestEventCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        self.latestEventTable.allowsSelection = NO;
        
    }
    
    if ([[historyModel sharedhistoryModel].menuTitle isEqualToString:@"Sankalp Stories"])
    {
        NSString *ImageURL;
         if ([[[info objectAtIndex:0]objectForKey:@"image"] isEqual:[NSNull null]])
         {
         ImageURL=@"";
         
         }
        else
        {
            ImageURL = [[info objectAtIndex:0]objectForKey:@"image"];

        }
        
    
         [cellAttachment.imageLab setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"sankalpImg"]];
        
        cellAttachment.titleLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"title"];

        cellAttachment.dateLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"date"];


        cellAttachment.detailLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"desc"];
        

    }
    else
    {
        NSString *ImageURL;
        if ([[[info objectAtIndex:0]objectForKey:@"image"] isEqual:[NSNull null]])
        {
            ImageURL=@"";
            
        }
        else
        {
            ImageURL = [[info objectAtIndex:0]objectForKey:@"image"];
            
        }
        
        
         [cellAttachment.imageLab setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"sankalpImg"]];
        cellAttachment.titleLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"title"];

        cellAttachment.dateLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"event_date"];

        cellAttachment.detailLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"short_desc"];
        
       
    }
    
    cellAttachment.titleLab.frame=CGRectMake(15,cellAttachment.imageLab.frame.origin.y+cellAttachment.imageLab.frame.size.height+5,[UIScreen mainScreen].bounds.size.width-60,labelHeightTitle.height);
    [cellAttachment.titleLab sizeToFit];
    
    cellAttachment.dateLab.frame=CGRectMake(15,cellAttachment.titleLab.frame.origin.y+cellAttachment.titleLab.frame.size.height+15,cellAttachment.dateLab.frame.size.width,cellAttachment.dateLab.frame.size.height);
    
    
    // [cellAttachment.dateLab sizeToFit];
    
    cellAttachment.detailLab.frame=CGRectMake(15,cellAttachment.dateLab.frame.origin.y+cellAttachment.dateLab.frame.size.height+15,[UIScreen mainScreen].bounds.size.width-60,labelHeightDesc.height);
    [cellAttachment.detailLab sizeToFit];
    
    
    cellAttachment.sapraterLab.frame=CGRectMake(15,cellAttachment.frame.size.height-10,cellAttachment.sapraterLab.frame.size.width-10,cellAttachment.sapraterLab.frame.size.height);
  
    
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


-(CGSize)heigtForCellwithString:(NSString *)stringValue withFont:(UIFont*)font{
    CGSize constraint = CGSizeMake(259,2000); // Replace 300 with your label width
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [stringValue boundingRectWithSize:constraint
                                            options:         (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil];
    return rect.size;
    
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
    NSString*pageName=@"Latest Event Page";
    [MyCustomClass logApi:pageName];
    
}

- (IBAction)profileBtn:(id)sender
{
    profileVC*profile=[[profileVC alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
}
@end
