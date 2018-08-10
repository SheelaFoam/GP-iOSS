//
//  PerformanceDashboardModel.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 30/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PerformanceDashboardModel : NSObject

+(PerformanceDashboardModel *)sharedModel;

@property (strong, nonatomic) NSMutableDictionary *response;

@property (strong, nonatomic) NSMutableArray *parentDataArray;
@property (strong, nonatomic) NSMutableArray *childDataArray;

@end
