//
//  PassbookModel.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 27/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "PassbookModel.h"

@implementation PassbookModel

static PassbookModel* _sharedInstance = nil;

+(PassbookModel*)sharedInstance
{
    @synchronized([PassbookModel class])
    {
        if (!_sharedInstance)
            _sharedInstance = [[self alloc] init];
        
        return _sharedInstance;
    }
    
    return nil;
}

-(id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if(self){
        
        _detail = [decoder decodeObjectForKey:@"detail"];
        _summary = [decoder decodeObjectForKey:@"summary"];
        
//        _opening = [decoder decodeObjectForKey:@"opening"];
//        _closing = [decoder decodeObjectForKey:@"closing"];
//        _cr = [decoder decodeObjectForKey:@"cr"];
//        _dr = [decoder decodeObjectForKey:@"dr"];
//
//        _transDate = [decoder decodeObjectForKey:@"transDate"];
//        _transDesc = [decoder decodeObjectForKey:@"tranDesc"];
//        _debit = [decoder decodeObjectForKey:@"debit"];
//        _credit = [decoder decodeObjectForKey:@"credit"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:_detail forKey:@"detail"];
    [encoder encodeObject:_summary forKey:@"summary"];
    
//    [encoder encodeObject:_opening forKey:@"opening"];
//    [encoder encodeObject:_closing forKey:@"closing"];
//    [encoder encodeObject:_cr forKey:@"cr"];
//    [encoder encodeObject:_dr forKey:@"dr"];
//    
//    [encoder encodeObject:_transDate forKey:@"transDate"];
//    [encoder encodeObject:_transDesc forKey:@"transDesc"];
//    [encoder encodeObject:_credit forKey:@"credit"];
//    [encoder encodeObject:_debit forKey:@"debit"];
}

@end
