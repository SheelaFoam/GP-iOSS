//
//  ConsumerOrderModel.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 30/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "ConsumerOrderModel.h"

@implementation ConsumerOrderModel

static ConsumerOrderModel* _sharedInstance = nil;

+(ConsumerOrderModel*)sharedInstance
{
    @synchronized([ConsumerOrderModel class])
    {
        if (!_sharedInstance)
            _sharedInstance = [[self alloc] init];
        
        return _sharedInstance;
    }
    
    return nil;
}


- (instancetype)initWithCoder:(NSCoder *)decoder {
    
    self = [super init];
    if (self) {
        
        _productsArray = [decoder decodeObjectForKey:@"productsArray"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:_productsArray forKey:@"productsArray"];
    
}


@end
