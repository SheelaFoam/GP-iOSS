//
//  storiesVC.m
//  Sheela Foam
//
//  Created by Apple on 22/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "storiesVC.h"
#import "historyModel.h"
#import "latestEventDetail.h"
#import "latestEventCell.h"
#import "UIImageView+WebCache.h"

@implementation storiesVC
{
    CGSize labelHeightDesc;
    CGSize labelHeightTitle;
    latestEventCell*cellAttachment;

}


-(id)initWithFrame:(CGRect)frame
{ self = [super initWithFrame:frame];
    
    if (self)
    { UIView *ViewName = [[[NSBundle mainBundle] loadNibNamed:@"storiesVC" owner:self options:nil] objectAtIndex:0];
        CGRect frame= ViewName.frame; frame.size.width=self.frame.size.width; frame.size.height=self.frame.size.height; ViewName.frame=frame; [self addSubview:ViewName];
        
        self.sankalpStoriesTable.dataSource=self;
        self.sankalpStoriesTable.delegate=self;
        UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(13,self.headerView.frame.size.height-5,[UIScreen mainScreen].bounds.size.width-60,1)];
        fromLabel.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:76.0/255.0f blue:164.0/255.0f alpha:1.0];
        [self.headerView addSubview:fromLabel];

        
        self.sankalpStoriesTable.tableHeaderView=self.headerView;
        self.sankalpStoriesTable.tableFooterView=self.footerView;

        NSLog(@"mail8");


    
    }
    
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableString *detailLab;
    NSString*titleStr;
    
    
    detailLab =[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"sankalp_story"] objectAtIndex:0] objectForKey:@"desc"];
    titleStr= [[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"sankalp_story"] objectAtIndex:0] objectForKey:@"title"];
    
    
    
    labelHeightTitle=[self heigtForCellwithString:titleStr withFont:[UIFont systemFontOfSize:17]];
    labelHeightDesc = [self heigtForCellwithString:detailLab withFont:[UIFont systemFontOfSize:14]];
    
    
    return labelHeightTitle.height+labelHeightDesc.height+cellAttachment.imageLab.frame.size.height+cellAttachment.dateLab.frame.size.height+60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"sankalp_story"] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"latestEventCell";
    cellAttachment = (latestEventCell *)[self.sankalpStoriesTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"latestEventCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        self.sankalpStoriesTable.allowsSelection = NO;
        
    }
    cellAttachment.sapraterLab.hidden=YES;

    NSString *ImageURL;
    if ([[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"sankalp_story"] objectAtIndex:0] objectForKey:@"image"] isEqual:[NSNull null]])
    {
        ImageURL=@"";
        
    }
    else
    {
        ImageURL = [[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"sankalp_story"] objectAtIndex:0] objectForKey:@"image"];
        
    }
    
    
    [cellAttachment.imageLab setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"sankalpImg"]];
    
    cellAttachment.titleLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"sankalp_story"] objectAtIndex:0] objectForKey:@"title"];
    
    cellAttachment.dateLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"sankalp_story"] objectAtIndex:0] objectForKey:@"date"];
    
    
    cellAttachment.detailLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"sankalp_story"] objectAtIndex:0] objectForKey:@"desc"];
    
    
    cellAttachment.titleLab.frame=CGRectMake(15,cellAttachment.imageLab.frame.origin.y+cellAttachment.imageLab.frame.size.height+5,[UIScreen mainScreen].bounds.size.width-60,cellAttachment.titleLab.frame.size.height);
    [cellAttachment.titleLab sizeToFit];
    
    cellAttachment.dateLab.frame=CGRectMake(15,cellAttachment.titleLab.frame.origin.y+cellAttachment.titleLab.frame.size.height+15,cellAttachment.dateLab.frame.size.width,cellAttachment.dateLab.frame.size.height);
    
    
    // [cellAttachment.dateLab sizeToFit];
    
    cellAttachment.detailLab.frame=CGRectMake(15,cellAttachment.dateLab.frame.origin.y+cellAttachment.dateLab.frame.size.height+15,[UIScreen mainScreen].bounds.size.width-60,cellAttachment.detailLab.frame.size.height);
    [cellAttachment.detailLab sizeToFit];
    
    
    cellAttachment.sapraterLab.frame=CGRectMake(15,cellAttachment.frame.size.height-10,cellAttachment.sapraterLab.frame.size.width-10,cellAttachment.sapraterLab.frame.size.height);
    return  cellAttachment;
    
}

-(CGSize)heigtForCellwithString:(NSString *)stringValue withFont:(UIFont*)font{
    CGSize constraint = CGSizeMake(310,2000); // Replace 300 with your label width
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [stringValue boundingRectWithSize:constraint
                                            options:         (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil];
    return rect.size;
    
}


@end
