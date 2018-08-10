//
//  raiseaRequestVC.m
//  Sheela Foam
//
//  Created by Apple on 24/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "raiseaRequestVC.h"

@implementation raiseaRequestVC

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
    { UIView *ViewName = [[[NSBundle mainBundle] loadNibNamed:@"raiseaRequestVC" owner:self options:nil] objectAtIndex:0];
        CGRect frame= ViewName.frame; frame.size.width=self.frame.size.width; frame.size.height=self.frame.size.height; ViewName.frame=frame; [self addSubview:ViewName];
        
    }
    
    return self;
}
@end
