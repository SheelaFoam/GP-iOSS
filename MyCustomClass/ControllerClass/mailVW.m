//
//  mailVW.m
//  Sheela Foam
//
//  Created by Apple on 18/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "mailVW.h"
#import "CommonTableViewCell.h"
#import "historyModel.h"


@implementation mailVW
{
    CommonTableViewCell*cellAttachment;

}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    // Drawing code
}

-(id)initWithFrame:(CGRect)frame
{ self = [super initWithFrame:frame];
    
    if (self)
    {
        UIView *ViewName = [[[NSBundle mainBundle] loadNibNamed:@"mailVW" owner:self options:nil] objectAtIndex:0];
        CGRect frame= ViewName.frame; frame.size.width=self.frame.size.width; frame.size.height=self.frame.size.height; ViewName.frame=frame; [self addSubview:ViewName];
        
       
        //[ViewName addSubview:self.mailTable];
        //self.mailDetail.hidden=YES;
        self.mailTable.delegate=self;
        self.mailTable.dataSource=self;
        UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(13,self.headerView.frame.size.height-5,[UIScreen mainScreen].bounds.size.width-60,1)];
        fromLabel.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:76.0/255.0f blue:164.0/255.0f alpha:1.0];
        [self.headerView addSubview:fromLabel];

        self.mailTable.tableHeaderView=self.headerView;
        self.mailTable.tableFooterView=self.footerView;

        NSLog(@"mail");

    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"inbox"] count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"CommonTableViewCell";
    cellAttachment = (CommonTableViewCell *)[self.mailTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"CommonTableViewCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        cellAttachment.selectionStyle=NO;
    }
     if  (!([[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"inbox"] count]==0))
     {
         
         NSString * timeStampString =[[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"inbox"] objectAtIndex:indexPath.row]objectForKey:@"d"] stringValue];
         
         NSString *newString = [timeStampString substringToIndex:[timeStampString length]-3];
         
         NSTimeInterval _interval=[newString doubleValue];
         
         NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
         NSLog(@"%@", date);
         NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
         NSDate *currDate = [NSDate date];
         
         
         [dateformate setDateFormat:@"dd MMMM yyyy"];
         NSString *displayDate = [dateformate stringFromDate:date]; // Convert date to string
         NSString *displayDate2 = [dateformate stringFromDate:currDate]; // Convert date to string
         NSLog(@"date :%@",date);
        // HH:mm:ss.SSS"
         NSLog(@"Display time = %@", displayDate);
         
    cellAttachment.nameLab.text=[[[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"inbox"] objectAtIndex:indexPath.row]objectForKey:@"e"] objectAtIndex:0] objectForKey:@"p"];

         if ([displayDate isEqualToString: displayDate2])
         {
             //[dateformate setDateFormat:@"HH:mm:ss.SSS"];
             [dateformate setDateFormat:@"hh:mm a"];

             NSString *displayDate = [dateformate stringFromDate:date]; // Convert date to string
             cellAttachment.timeLab.text=displayDate;

         }
         else
         {
        
         cellAttachment.timeLab.text=displayDate;
         }
    
    NSLog(@"subject%@",cellAttachment.nameLab.text);
    cellAttachment.detailLab.text=[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"inbox"] objectAtIndex:indexPath.row]objectForKey:@"su" ];
         if (indexPath.row==[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"inbox"] count]-1)
         {
             cellAttachment.sepraterLab.hidden=YES;
         }
         
        
     }
    
    return  cellAttachment;
    
}


- (IBAction)mailDetail:(id)sender {
}
@end
