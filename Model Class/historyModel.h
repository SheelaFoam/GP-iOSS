//
//  historyModel.h
//  Patient
//
//  Created by Alok Singh on 5/20/16.
//  Copyright © 2016 mithun ravi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface historyModel : NSObject
//add all other model data
+(historyModel*)sharedhistoryModel;
@property(strong,nonatomic)NSString*clientUrl;


@property(strong,nonatomic)NSArray*homeArray;
@property(strong,nonatomic)NSDictionary*homeDataDic;
@property(strong,nonatomic)NSDictionary*homeDataDicStep2;
@property(strong,nonatomic)NSString*webStr;
@property(strong,nonatomic)NSString*userEmail;
@property(strong,nonatomic)NSString*uID;
@property(strong,nonatomic)NSString*menuTitle;


@property(strong,nonatomic)NSString*uid;
@property(strong,nonatomic)NSString*token;
@property(strong,nonatomic)NSString*authType;
@property(strong,nonatomic)NSString*displayname;
@property(strong,nonatomic)NSString*opRoleName;
@property(strong, nonatomic)NSString*opUserType;
@property(strong,nonatomic)NSString*opUserEmpGroupCode;
@property(strong,nonatomic)NSString*opGreatplususerId;
@property(strong,nonatomic)NSString*opUserzone;
@property(strong,nonatomic)NSString*menuLink;
@property(strong,nonatomic)NSString*poolTable;
@property(strong,nonatomic)NSString*poolstr;
@property(strong,nonatomic)NSString*opuserRoleName;
@property(strong,nonatomic)NSString*area;
@property(nonatomic)int hight;

//for profile

@property(strong,nonatomic)NSString*userName;
@property(strong,nonatomic)NSString*opuseremailid;
@property(strong,nonatomic)NSString*mobileNo;
@property(strong,nonatomic)NSURL*imageUrl;
@property(strong,nonatomic)NSString*checkHomeORMenu;
@property (strong, nonatomic)  NSString *latitudeStr;
@property (strong, nonatomic)  NSString *longitudeStr;

@property (strong, nonatomic)  NSString *deviceOS;
@property (strong, nonatomic)  NSString *deviceID;
@property (strong, nonatomic)  NSString *deviceName;

@property(strong,nonatomic)NSMutableArray*stateAndCityArray;




-(void)initWithObj:(NSObject *)obj;










//@property(strong,nonatomic)NSString*userEmail;opGreatplususerId


































@end
