//
//  ComplaintInfoModel.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 21/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "ComplaintDetail+CoreDataClass.h"
#import "ComplaintDetail+CoreDataProperties.h"

@interface ComplaintInfoModel : NSObject

- (NSManagedObjectContext *) managedObjectContext;

@property (strong, nonatomic) NSMutableArray *complaintData;
@property (strong, nonatomic) NSManagedObjectContext *context;

+(ComplaintInfoModel *)saveData: (NSArray *)photosArray withdocs: (NSArray *)docsArray andRemarks: (NSString *)remarks withType: (NSString *)type;
@end
