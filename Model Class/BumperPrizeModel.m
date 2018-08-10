//
//  BumperPrizeModel.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 02/08/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "BumperPrizeModel.h"

@implementation BumperPrizeModel

static BumperPrizeModel * _sharedInstance = nil;

+(BumperPrizeModel *)sharedInstance {
    
    @synchronized([BumperPrizeModel class])
    {
        if (!_sharedInstance)
            _sharedInstance = [[self alloc] init];
        
        return _sharedInstance;
    }
}

-(id)initWithCoder:(NSCoder *)decoder {
    
    self = [super init];
    if (self) {
        _prizeArray = [decoder decodeObjectForKey:@"prizeList"];
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:_prizeArray forKey:@"prizeArray"];
}

-(void)initWithObj:(NSObject *)obj{
    _sharedInstance = (BumperPrizeModel *)obj;
}

@end
