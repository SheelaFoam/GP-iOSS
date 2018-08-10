//
//  MyWebServiceHelper.m
//  imagetest
//
//  Created by t on 11/17/14.
//  Copyright (c) 2014 Thajmeel Ahmed. All rights reserved.
//

#import "MyWebServiceHelper.h"
#import "historyModel.h"
#import "define.h"

@implementation MyWebServiceHelper
@synthesize webApiDelegate;
-(void)passwordVerification:(NSDictionary *)loginData{
    
}

-(void)editProfile:(NSDictionary *)profileData{
    
}

-(void )synchronousApiRequestByPostWithDataTypeInResponse:(NSString *)urlString postData:(NSDictionary *)dataDic
{
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDic
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //[request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"123" forHTTPHeaderField:@"admin"];
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     
     {
         if (error)
         {
             NSLog(@"error");
            [MyCustomClass SVProgressMessageDismissWithError:@"some unknown error"  timeDalay:1.50];
         }
         else
         {

             [self webapiResponseResultHandling:data];
         }
     }];
}
-(void )synchronousApiRequestByPostWithStringTypeInResponse:(NSString *)urlString postData:(NSString *)dataString
{
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSString *jsonString = [[NSString alloc] initWithString:dataString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)dataString.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
            // [webApiDelegate webApiResponseError:error];
             NSLog(@"Erorr: %@",[NSString stringWithFormat:@"Error: %@" , error]);
             [MyCustomClass SVProgressMessageDismissWithError:[NSString stringWithFormat:@"Error: %@" , error]  timeDalay:1.50];
         }
         else
         {
             [self webapiResponseResultHandling:data];
         }
     }];
}

-(void )synchronousApiRequestByGetWithDataTypeInResponse:(NSString *)urlString
{
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //[request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
             [webApiDelegate webApiResponseError:error];
         }
         else
         {
             [self webapiResponseResultHandling:data];
         }
     }];
}

-(NSString *)synchronousApiRequest:(NSString *)urlString
{
    NSURL *mainURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlString]];
    NSURLRequest *request = [NSURLRequest requestWithURL:mainURL];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    return responseString;
}

#pragma mark - Response Result Handling Method list
-(void)webapiResponseResultHandling:(NSData *)data
{
    [webApiDelegate webApiResponseData:data apiName:apiName];
}

#pragma mark - API Request Method list

-(void)baseUrlApi:(NSDictionary *)urlData
{
    apiName=@"baseUrlApi";//doctor_id
    
    
    //NSString *urlString=@"http://125.17.8.166/service/static-value.php";
    NSString *urlString=@"http://www.greatplus.com/service/static-value.php";
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:urlData];
}

-(void)loginApi:(NSDictionary *)loginData
{
        apiName=@"Login";//doctor_id
         NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/login.php"];
    
        [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:loginData];

}
-(void)homeApiStep1:(NSDictionary *)homeData
{
    apiName=@"homeApiStep1";//doctor_id
   // NSString *urlString=[NSString stringWithFormat:@"http://125.17.8.166/service/home.php"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/home.php"];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:homeData];
    
}
-(void)homeApiStep2:(NSDictionary *)homeData
{
    apiName=@"homeApiStep2";//doctor_id
   // NSString *urlString=[NSString stringWithFormat:@"http://125.17.8.166/service/home.php"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/home.php"];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:homeData];
    
}
-(void)policiesApi:(NSDictionary *)policies
{
    apiName=@"policiesApi";//doctor_id
   // NSString *urlString=[NSString stringWithFormat:@"http://125.17.8.166/service/policies-procedure.php"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/policies-procedure.php"];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:policies];
    
}

-(void)learningReferencesAPI:(NSDictionary *)learningData
{
    apiName=@"policiesApi";//doctor_id
   // NSString *urlString=[NSString stringWithFormat:@"http://125.17.8.166/service/learning-references.php"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/learning-references.php"];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:learningData];
    
}

-(void)telephonDirApi:(NSDictionary *)learningData
{
    apiName=@"telephonDir";//doctor_id
  //  NSString *urlString=[NSString stringWithFormat:@"http://125.17.8.166/service/telephone-directory.php"];
    NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/telephone-directory.php"];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:learningData];
}
-(void)telephonSearchApi:(NSDictionary *)SearchData
{
    apiName=@"telephonSearchApi";//doctor_id
   // NSString *urlString=[NSString stringWithFormat:@"http://125.17.8.166/service/telephone-directory.php"];
    NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/telephone-directory.php"];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:SearchData];
}

-(void)myTaskApi:(NSDictionary *)learningData
{
    apiName=@"myTaskApi";//doctor_id
  //  NSString *urlString=[NSString stringWithFormat:@"http://125.17.8.166/service/side-menu.php"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/side-menu.php"];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:learningData];
    
}

-(void)myAppoinmentDetail:(NSDictionary *)appoinmentData
{
    apiName=@"myAppoinmentDetail";//doctor_id
  //  NSString *urlString=[NSString stringWithFormat:@"http://125.17.8.166/service/side-menu.php"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/side-menu.php"];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:appoinmentData];
    
}
-(void)poolselection:(NSDictionary *)appoinmentData
{
    apiName=@"poolselection";//doctor_id
   // NSString *urlString=[NSString stringWithFormat:@"http://125.17.8.166/service/polls.php"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/polls.php"];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:appoinmentData];
    
}
-(void)logOutApi:(NSDictionary *)loginData
{
    apiName=@"logOutApi";//doctor_id
    //NSString *urlString=[NSString stringWithFormat:@"http://125.17.8.166/service/logout.php"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/logout.php"];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:loginData];
    
}
-(void)changePassword:(NSDictionary *)changePasswordData
{
    apiName=@"changePassword";//doctor_id
   // NSString *urlString=[NSString stringWithFormat:@"http://125.17.8.166/service/change-password.php"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/change-password.php"];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:changePasswordData];
    
}

-(void)approveApi:(NSDictionary *)ApproveData
{
    apiName=@"approveApi";//doctor_id
   // NSString *urlString=[NSString stringWithFormat:@"http://125.17.8.166/service/approve-disapprove.php"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/approve-disapprove.php"];
    

    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:ApproveData];
    
}
-(void)logApi:(NSDictionary *)logData
{
    apiName=@"logApi";//doctor_id
   // NSString *urlString=[NSString stringWithFormat:@"http://125.17.8.166/service/mobile-user-log.php"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/mobile-user-log.php"];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:logData];
    
}
-(void)leavetype:(NSDictionary *)leaveDate
{
    apiName=@"leavetype";//doctor_id
    

    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",[historyModel sharedhistoryModel].clientUrl,@"service/apply-leave.php"];
    
    
   // NSString *urlString=[NSString stringWithFormat:@"http://125.17.8.166/service/apply-leave.php"];
    

    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:leaveDate];
    
}

#pragma mark - API Request Method list

-(void)getDocList:(NSDictionary *)Input
{
    apiName=@"UploadedDocList";
    NSString *urlString=[NSString stringWithFormat:@"%@get_dealer_document.php",BASE_URL];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:Input];
    
}
-(void)deleteDoc:(NSDictionary *)input
{
    apiName=@"deleteDoc";
    NSString *urlString=[NSString stringWithFormat:@"%@delete_dealer_document.php",BASE_URL];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:input];
    
}
-(void)getProduct:(NSDictionary *)input
{
    apiName=@"getProduct";
    NSString *urlString=[NSString stringWithFormat:@"%@prc_get_product_gcard.php",BASE_URL];
    // http://125.19.46.252/ws/prc_get_product_gcard.php
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:input];
    
}
-(void)docStatus:(NSDictionary *)input
{
    apiName=@"docStatus";
    NSString *urlString=[NSString stringWithFormat:@"%@prc_update_document_status.php",BASE_URL];
    // http://125.19.46.252/ws/prc_get_product_gcard.php
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:input];
    
}
-(void)deleteProduct:(NSDictionary *)input
{
    apiName=@"deleteProduct";
    NSString *urlString=[NSString stringWithFormat:@"%@prc_del_product_gcard.php",BASE_URL];
    //http://125.19.46.252/ws/prc_del_product_gcard.php
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:input];
    
}
-(void)PayByCash:(NSDictionary *)input
{
    apiName=@"PayByCash";
    NSString *urlString=[NSString stringWithFormat:@"%@prc_get_payment_gcard.php",BASE_URL];
    //http://125.19.46.252/ws/prc_del_product_gcard.php
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:input];
}
-(void)transectionInfo:(NSDictionary *)input
{  //http://125.19.46.252/ws/get_transaction.php
    
    apiName=@"transectionInfo";
    NSString *urlString=[NSString stringWithFormat:@"%@get_transaction.php",BASE_URL];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:input];
}
-(void)getStateCity:(NSDictionary *)input
{
    //http://sleepwellproducts.com/cms/get_state_city
    
    apiName=@"getStateCity";
    NSString *urlString=[NSString stringWithFormat:@"http://sleepwellproducts.com/service/get_state_city.php"];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:input];
}

-(void)PayLinkToCustomerCCAV:(NSDictionary *)input
{
    
    apiName=@"PayLink";
    NSString *urlString=[NSString stringWithFormat:@"%@pay_link_to_customer.php",LINKTOPAY_URLCCAV];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:input];
}
-(void)PayLinkToCustomerHDFC:(NSDictionary *)input
{
    
    apiName=@"PayLink";
    NSString *urlString=[NSString stringWithFormat:@"%@pay_link_to_customer.php",LINKTOPAY_URLHDFC];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:input];
}

@end
