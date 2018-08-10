//
//  MyAppoinmentVC.m
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "MyAppoinmentVC.h"
#import "MyApponment.h"
#import "historyModel.h"

@implementation MyAppoinmentVC
{
    MyApponment*MyApponmenttableVC;
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
    { UIView *ViewName = [[[NSBundle mainBundle] loadNibNamed:@"MyAppoinmentVC" owner:self options:nil] objectAtIndex:0];
        CGRect frame= ViewName.frame; frame.size.width=self.frame.size.width; frame.size.height=self.frame.size.height; ViewName.frame=frame; [self addSubview:ViewName];
        self.myAppoinmentTable.delegate=self;
        self.myAppoinmentTable.dataSource=self;
        
        UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(13,self.headerTitle.frame.size.height-5,[UIScreen mainScreen].bounds.size.width-60,1)];
        fromLabel.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:76.0/255.0f blue:164.0/255.0f alpha:1.0];
        [self.headerTitle addSubview:fromLabel];
          self.myAppoinmentTable.tableHeaderView =self.headerTitle;
        NSLog(@"mail3");

        
    }
    
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"appointment"] count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"MyApponment";
    MyApponmenttableVC = (MyApponment *)[self.myAppoinmentTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (MyApponmenttableVC == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"MyApponment" owner:self options:nil];
        MyApponmenttableVC = [cellArray objectAtIndex:0];
        self.myAppoinmentTable.allowsSelection = NO;
    }
    
    if (indexPath.row==[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"appointment"] count]-1)
    {
        MyApponmenttableVC.sepraterLab.hidden=YES;
    }
    if (!([[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"appointment"] count]<=0))
    {

     MyApponmenttableVC.appoinmentDetail.text=[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"appointment"] objectAtIndex:indexPath.row]objectForKey:@"desc"];
    
         MyApponmenttableVC.dateLab.text=[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"appointment"] objectAtIndex:indexPath.row]objectForKey:@"day"];
    
    MyApponmenttableVC.monthLab.text=[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"appointment"] objectAtIndex:indexPath.row]objectForKey:@"month"];
    
    
    MyApponmenttableVC.appoinmentTime.text=[NSString stringWithFormat:@"%@-%@",[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"appointment"] objectAtIndex:indexPath.row]objectForKey:@"time"],[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"appointment"] objectAtIndex:indexPath.row]objectForKey:@"end_time"]];
        
    }
    return  MyApponmenttableVC;
    
}

@end
