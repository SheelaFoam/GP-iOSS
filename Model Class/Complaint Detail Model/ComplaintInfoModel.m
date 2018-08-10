//
//  ComplaintInfoModel.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 21/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "ComplaintInfoModel.h"

@implementation ComplaintInfoModel {
    
    AppDelegate *delegate;
}

@synthesize context, complaintData;

+(ComplaintInfoModel *) sharedInstance {
    
    static ComplaintInfoModel *_sharedInstance = nil;
    static dispatch_once_t onePredicate;
    
    dispatch_once(&onePredicate , ^{
        _sharedInstance = [[ComplaintInfoModel alloc]init];
    });
    
    return _sharedInstance;
}

-(NSManagedObjectContext *)managedObjectContext{
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = [[delegate persistentContainer] viewContext];
    
    return context;
}

+ (ComplaintInfoModel *)saveData:(NSArray *)photosArray withdocs:(NSArray *)docsArray andRemarks:(NSString *)remarks withType:(NSString *)type {
    
    ComplaintInfoModel *saveData = [[ComplaintInfoModel alloc] init];
    saveData.context = [saveData managedObjectContext];
    saveData.complaintData = [[NSMutableArray alloc] init];
    NSManagedObject *task = [[ComplaintDetail alloc] initWithContext:saveData.context];
    
    
    if (photosArray.count < 1) {
        NSLog(@"No photos");
    } else if (docsArray.count < 1) {
        NSLog(@"No documents");
    } else if (remarks.length < 1) {
        NSLog(@"No remarks");
    } else {
        
        [task setValue:remarks forKey:@"remarks"];
        [task setValue:type forKey:@"type"];
        
        NSMutableArray *tempArray;
        tempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < photosArray.count; i++) {
            [tempArray addObject:[self encodeToBase64String:photosArray[i]]];
        }
        [task setValue:tempArray forKey:@"photos"];
        
        tempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < docsArray.count; i++) {
            [tempArray addObject:[self encodeToBase64String:docsArray[i]]];
        }
        [task setValue:tempArray forKey:@"docs"];
        
        [saveData.complaintData addObject:task];
    }
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [appDelegate saveContext];
    
    return saveData;
}

+(NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end
