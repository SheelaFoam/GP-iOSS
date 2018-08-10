//
//  ConsumerOrderModel.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 30/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsumerOrderModel : NSObject

+(ConsumerOrderModel*)sharedInstance;

@property (strong, nonatomic) NSMutableArray *productsArray;

@end
