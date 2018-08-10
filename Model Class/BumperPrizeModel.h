//
//  BumperPrizeModel.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 02/08/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BumperPrizeModel : NSObject

+(BumperPrizeModel*)sharedInstance;

@property (strong, nonatomic) NSMutableArray *prizeArray;

@end
