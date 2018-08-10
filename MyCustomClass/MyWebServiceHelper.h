//
//  MyWebServiceHelper.h
//  imagetest
//
//  Created by t on 11/17/14.
//  Copyright (c) 2014 Thajmeel Ahmed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyProtocals.h"
#import "MyCustomClass.h"


@interface MyWebServiceHelper : NSObject
{
    NSString *apiName;
}
@property (nonatomic,strong) id <WebServiceResponseProtocal> webApiDelegate;
-(void)loginApi:(NSDictionary *)loginData;
-(void)passwordVerification:(NSDictionary *)loginData;
-(void)homeApiStep1:(NSDictionary *)homeData;
-(void)homeApiStep2:(NSDictionary *)homeData;
-(void)policiesApi:(NSDictionary *)policies;
-(void)learningReferencesAPI:(NSDictionary *)policies;
-(void)telephonDirApi:(NSDictionary *)learningData;
-(void)myTaskApi:(NSDictionary *)learningData;
-(void)myAppoinmentDetail:(NSDictionary *)appoinmentData;
-(void)poolselection:(NSDictionary *)appoinmentData;
-(void)logOutApi:(NSDictionary *)loginData;
-(void)telephonSearchApi:(NSDictionary *)learningData;
-(void)changePassword:(NSDictionary *)loginData;
-(void)logApi:(NSDictionary *)logData;
-(void)editProfile:(NSDictionary *)profileData;
-(void)approveApi:(NSDictionary *)ApproveData;
-(void)leavetype:(NSDictionary *)logData;

-(void)getDocList:(NSDictionary *)input;
-(void)deleteDoc:(NSDictionary *)input;
-(void)getProduct:(NSDictionary *)input;
-(void)docStatus:(NSDictionary *)input;
-(void)deleteProduct:(NSDictionary *)input;
-(void)PayByCash:(NSDictionary *)input;
-(void)transectionInfo:(NSDictionary *)input;
-(void)getStateCity:(NSDictionary *)input;
-(void)PayLinkToCustomerCCAV:(NSDictionary *)input;
-(void)PayLinkToCustomerHDFC:(NSDictionary *)input;



















@end
