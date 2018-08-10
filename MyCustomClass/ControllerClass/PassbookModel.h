//
//  PassbookModel.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 27/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PassbookModel : NSObject

+(PassbookModel*)sharedInstance;


@property (strong, nonatomic) NSMutableDictionary *summary;
@property (strong, nonatomic) NSMutableDictionary *detail;

//@property (strong, nonatomic) NSString *opening;
//@property (strong, nonatomic) NSString *closing;
//@property (strong, nonatomic) NSString *cr;
//@property (strong, nonatomic) NSString *dr;

//@property (strong, nonatomic) NSString *transDate;
//@property (strong, nonatomic) NSString *transDesc;
//@property (strong, nonatomic) NSString *debit;
//@property (strong, nonatomic) NSString *credit;

@end
