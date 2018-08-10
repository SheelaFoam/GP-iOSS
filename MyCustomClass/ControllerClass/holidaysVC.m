//
//  holidaysVC.m
//  Sheela Foam
//
//  Created by Apple on 22/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "holidaysVC.h"
#import "historyModel.h"

@implementation holidaysVC
{
    CommonTableViewCell*cellAttachment;
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
    {
        UIView *ViewName = [[[NSBundle mainBundle] loadNibNamed:@"holidaysVC" owner:self options:nil] objectAtIndex:0];
        CGRect frame= ViewName.frame; frame.size.width=self.frame.size.width; frame.size.height=self.frame.size.height; ViewName.frame=frame; [self addSubview:ViewName];
        self.holidaysTable.delegate=self;
        self.holidaysTable.dataSource=self;
        
        UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(13,self.HeaderView.frame.size.height-5,[UIScreen mainScreen].bounds.size.width-60,1)];
        fromLabel.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:76.0/255.0f blue:164.0/255.0f alpha:1.0];
        [self.HeaderView addSubview:fromLabel];
        self.holidaysTable.tableFooterView=self.footerView;
        self.holidaysTable.tableHeaderView=self.HeaderView;
        
        NSLog(@"mail7");
        
    }return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"upcoming_holiday"] count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"CommonTableViewCell";
    cellAttachment = (CommonTableViewCell *)[self.holidaysTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"CommonTableViewCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        self.holidaysTable.allowsSelection = NO;
        cellAttachment.nameLab.textColor=[UIColor redColor];
        
    }
    cellAttachment.timeLab.hidden=YES;
    
    cellAttachment.nameLab.text=[[[[[historyModel sharedhistoryModel]homeDataDicStep2]objectForKey:@"upcoming_holiday"] objectAtIndex:indexPath.row] objectForKey:@"HOLIDAY_DATE"];
    cellAttachment.detailLab.text=[[[[[historyModel sharedhistoryModel]homeDataDicStep2]objectForKey:@"upcoming_holiday"] objectAtIndex:indexPath.row] objectForKey:@"HOLIDAY_NAME"];
    if (indexPath.row==[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"upcoming_holiday"] count]-1)
    {
    
        cellAttachment.sepraterLab.hidden=YES;
    }
    
    
    return  cellAttachment;
    
}
- (IBAction)seeAllBtn:(id)sender {
}
@end
