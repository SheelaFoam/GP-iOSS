//
//  PerformanceDashboardModel.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 30/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "PerformanceDashboardModel.h"

@implementation PerformanceDashboardModel

static PerformanceDashboardModel * _sharedModel = nil;

+(PerformanceDashboardModel *)sharedModel {
    
    @synchronized([PerformanceDashboardModel class])
    {
        if (!_sharedModel)
            _sharedModel = [[self alloc] init];
        
        return _sharedModel;
    }
}

-(id)initWithCoder:(NSCoder *)decoder {
    
    self = [super init];
    if (self) {
        self.parentDataArray = [decoder decodeObjectForKey:@"parentData"];
        self.response = [decoder decodeObjectForKey:@"response"];
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)encoder{

    [encoder encodeObject:_parentDataArray forKey:@"parentData"];
    [encoder encodeObject:_response forKey:@"response"];
}

-(void)initWithObj:(NSObject *)obj{
    _sharedModel = (PerformanceDashboardModel *)obj;
}

@end
