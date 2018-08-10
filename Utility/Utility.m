/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "Utility.h"
#import "NSString+Extension.h"
#include <ifaddrs.h>
#include <arpa/inet.h>


@implementation Utility

NSString *const KAPIVersionLogin    =   @"sheelafoams/api_v1.php";
//NSString *const KAPIVersionLogin    =   @"sheelafoams/apis.php";
//NSString *const KAPIVersionOrder    =   @"sheelafoams/orders.php";
NSString *const KAPIVersionOrder    =   @"sheelafoams/orders_v1.php";

NSString *const KAPIGetStateList    =   @"ws/get_all_state.php?MOBILE=";
NSString *const KAPIGetCatList      =   @"ws/get_product_category_v1.php?";
NSString *const KAPIProductList     =   @"ws/get_product_v1.php?";
NSString *const KAPIGetStandardSize =   @"ws/get_product_l_b.php?";
NSString *const KAPIGetThickness    =   @"ws/get_product_thick.php?";
NSString *const KAPIGetActualMRP    =   @"ws/get_product_mrp.php?";
NSString *const KAPIGetPoints      =   @"ws/get_pointsAPI.php?";

+ (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
} 



#pragma MARK for Getting Config Url

+(NSString *) getConfigURLString {
    
    NSLog(@"Base Url = %@",[NSString stringWithFormat:@"%@://%@",[[NSBundle mainBundle] infoDictionary][@"Protocol"],[[NSBundle mainBundle] infoDictionary][@"Cofig_URL"]]);
    return [NSString stringWithFormat:@"%@://%@",[[NSBundle mainBundle] infoDictionary][@"Protocol"],[[NSBundle mainBundle] infoDictionary][@"Cofig_URL"]];
}

+(NSString *)getURLString {
    return @"http://125.19.46.252";
}


#pragma MARK for Checking Subscrypt


+ (BOOL) getConfigSubscrypt {
    
    if ([[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] infoDictionary][@"Subscrypt"]] isEqualToString:@"_QA"] || [[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] infoDictionary][@"Subscrypt"]] isEqualToString:@"_Dev"] || [[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] infoDictionary][@"Subscrypt"]] isEqualToString:@"_UAT"] || [[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] infoDictionary][@"Subscrypt"]] isEqualToString:@"_QA4"] || [[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] infoDictionary][@"Subscrypt"]] isEqualToString:@"_QA5"]) {
        
        return YES;
    } else {
        return NO;
    }
}

#pragma MARK for Validate Json

+ (BOOL)validateJsonData :(NSData *)jsonData {
   return  [NSJSONSerialization isValidJSONObject:[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil]];
}

#pragma MARK for Getting Status Code

+ (int) getStatusCode :(NSData *)jsonData {
    return  [[[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil] objectForKey:@"status"] intValue];
}


+(NSString *)getCurrentAppVersion
{
    // NSString * appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    // NSLog(@"appBuildString  %@",appBuildString);
    
    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    // NSLog(@"appVersionString  %@",appVersionString);
    return appVersionString;
}

+(NSString *)getAppBundleName
{
    return [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"];
}


+(NSString*)uniqueIDForDevice
{
    NSString* uniqueIdentifier = nil;
    if( [UIDevice instancesRespondToSelector:@selector(identifierForVendor)] ) { // >=iOS 7
        uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    } else { ///<iOS6, Use UDID of Device
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        //uniqueIdentifier = ( NSString*)CFUUIDCreateString(NULL, uuid);- for non- ARC
        uniqueIdentifier = ( NSString*)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));// for ARC
        CFRelease(uuid);
    }
    
    return uniqueIdentifier;
}

#pragma MARK for Getting Device Name

+(NSString*)getDeviceName {
    return [[UIDevice currentDevice] systemName];
    
}

+(NSString *)getLocalizedModel {
    
    return [UIDevice currentDevice].localizedModel;
}

+(NSString *)getDeviceModel {
    
    return [UIDevice currentDevice].model;
}

+(NSString *)getDeviceOSVersion {
    
    return [UIDevice currentDevice].systemVersion;
}

+(NSString *)getDeviceSystemName {
    
    return [UIDevice currentDevice].systemName;
}

+(NSString *)getUDIDofDevice {
    
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString*) getFormatedAmount: (NSString *) string
{
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [currencyFormatter setCurrencySymbol:@""];
    [currencyFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_IN"]];
    [currencyFormatter setMaximumFractionDigits:0];
    NSNumber *currency = [currencyFormatter numberFromString:string];
    return [currencyFormatter stringFromNumber:currency];
}

//income with comma seperated format
+(NSString *) getFormatedIncome:(NSString *)income
{
    return [Utility getFormatedAmount:[Utility getIncomeByRemovingSpecialChar:income]];
}

//it resturns string by triming spaces and trimming comma
+(NSString *) getIncomeByRemovingSpecialChar:(NSString *)str {
    str = [str stringByReplacingOccurrencesOfString:@"Rs. " withString:@""];
    NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@","];
    str=[[str componentsSeparatedByCharactersInSet: trim] componentsJoinedByString: @""];
    str=[str stringByTrimmingLeadingAndTrailingWhiteSpace];
    return str;
}

@end
