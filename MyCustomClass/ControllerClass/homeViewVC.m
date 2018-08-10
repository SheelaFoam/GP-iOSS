//
//  homeViewVC.m
//  Sheela Foam
//
//  Created by Apple on 22/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "homeViewVC.h"
#import "HomeViewController.h"
#import "historyModel.h"

@implementation homeViewVC
-(id)initWithFrame:(CGRect)frame
{ self = [super initWithFrame:frame];
    
    if (self)
    {
        UIView *ViewName = [[[NSBundle mainBundle] loadNibNamed:@"homeViewVC" owner:self options:nil] objectAtIndex:0];
        CGRect frame= ViewName.frame; frame.size.width=self.frame.size.width; frame.size.height=self.frame.size.height; ViewName.frame=frame; [self addSubview:ViewName];
        // [self.NextcontentLab setAutoresizesSubviews:YES];
        NSString *ImageURL = [[[historyModel sharedhistoryModel].homeArray objectAtIndex:1]objectForKey:@"slider_image"];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
        self.nextHomeImage.image = [UIImage imageWithData:imageData];
        self.NexttitleLab.text=[[[historyModel sharedhistoryModel].homeArray objectAtIndex:1]objectForKey:@"name"];
        self.NextdetailLab.text=[[[historyModel sharedhistoryModel].homeArray objectAtIndex:1]objectForKey:@"message"];
        
       
        //[ViewName addSubview:self.mailTable];
//        HomeViewController*home=[[HomeViewController alloc]init];
//        home.contentLab.frame=CGRectMake(13,self.contentLab.frame.origin.y+self.contentLab.frame.size.height+100, self.contentLab.frame.size.width+10,300);
//        [home.view addSubview:ViewName];
        
    }
    return self;
}


@end
