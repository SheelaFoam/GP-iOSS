/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "JsonBuilder.h"
#import "historyModel.h"
#import "Utility.h"
#import "UserDefaultStorage.h"
#import "GreatPlusSharedHeader.h"
#import "MailClassViewController.h"

@implementation JsonBuilder

//+ (NSDictionary *) buildLoginJsonObject:(NSString *) userName andPassword :(NSString *) password {
//    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                           @"validateMobile",requestKey,
//                            [NSString stringWithFormat:@"%@ %@",[Utility getDeviceModel],[Utility getDeviceOSVersion]],@"deviceModel",
//                           [Utility getDeviceName],@"deviceOs",
//                           @"A",@"accessType",
//                           userName,@"mobile1",
//                           password,@"mobile2",
//                           @"",@"p_device_token",
//                           nil];
//
//    return param;
//}

+ (NSDictionary *) buildLoginJsonObject:(NSString *) userName andPassword :(NSString *) password {
    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"userTypeV1",requestKey,
                            [NSString stringWithFormat:@"%@ %@",[Utility getDeviceModel],[Utility getDeviceOSVersion]],@"deviceModel",
                            [Utility getDeviceName],@"deviceOs",
                            @"A",@"accessType",
                            userName,@"mobile1",
                            password,@"mobile2",
                            @"",@"p_device_token",
                            VERSION_CODE,@"p_app_version",
                            nil];
    
    return param;
}

+ (NSDictionary *) buildAuthJsonObject:(NSString *) userName andPassword :(NSString *) password {
    
    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"userAuthenticationV1",requestKey,
                            VERSION_CODE,@"p_app_version",
                            [UserDefaultStorage getUserDealerType]?[UserDefaultStorage getUserDealerType]:@"",@"p_role_name",
                            password,@"password",
                            [UserDefaultStorage getUserDealerID]?[UserDefaultStorage getUserDealerID]:@"",@"userId",
                            
                            [NSString stringWithFormat:@"%@ %@",[Utility getDeviceModel],[Utility getDeviceOSVersion]],@"deviceModel",
                            [Utility getDeviceName],@"deviceOs",
                            @"A",@"accessType",
                            userName,@"p_mobile_no_1",
                            @"",@"p_mobile_no_2",
                            @"",@"p_device_token",
                            nil];
    
    //    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
    //                            @"login",requestKey,
    //                            [UserDefaultStorage getUserDealerID],@"userId",
    //                            password,@"password",
    //                            [NSString stringWithFormat:@"%@ %@",[Utility getDeviceModel],[Utility getDeviceOSVersion]],@"deviceModel",
    //                            [Utility getDeviceName],@"deviceOs",
    //                            @"A",@"accessType",
    //                            userName,@"mobile1",
    //                            @"",@"mobile2",
    //                            @"",@"p_device_token",
    //                            [UserDefaultStorage getUserDealerType],@"p_role_name",
    //                            nil];
    
    return param;
}

+ (NSDictionary *) buildListJsonObject:(NSString *) userName andPassword :(NSString *) password {
    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"getMenuList",requestKey,
                            /* [UserDefaultStorage getUserDealerID],@"userId",
                             password,@"password",
                             [NSString stringWithFormat:@"%@ %@",[Utility getDeviceModel],[Utility getDeviceOSVersion]],@"deviceModel",
                             [Utility getDeviceName],@"deviceOs",
                             @"A",@"accessType",
                             userName,@"mobile1",
                             @"",@"mobile2",
                             @"",@"p_device_token",
                             [UserDefaultStorage getUserDealerType],@"p_role_name",*/
                            nil];
    
    return param;
}

+ (NSDictionary *) buildExInfoJsonObject:(NSString *) userName {
    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"exchane_offer_info",requestKey,
                            userName,@"mobile1",
                            nil];
    
    return param;
}

+ (NSDictionary *) buildExInfoSendDataJsonObject:(NSString *) userName withSerialNo1:(NSString *)serialNo1 withSerialNo2:(NSString *)serialNo2 withEcob :(BOOL)ecob andCustomerMobileno :(NSString *)mobileNo withCustomerName:(NSString *)name withCustomerEmail:(NSString *)email withInvoiceNo:(NSString *)invoiceNum andInvoiceDate:(NSString *)invoiceDate withDealerMobileNo: (NSString *)dealerMobileNo anddealerUID: (NSString *)uid withSalesRepName:(NSString *)salesRepName{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"exchane_offer_submit" forKey:requestKey];
    [params setValue:userName forKey:@"mobile1"];
    [params setValue:serialNo1 forKey:@"p_serial_no1"];
    [params setValue:serialNo2 forKey:@"p_serial_no2"];
    [params setValue:mobileNo forKey:@"p_customer_mobile"];
    [params setValue:name forKey:@"p_customer_name"];
    [params setValue:email forKey:@"p_customer_email"];
    [params setValue:invoiceNum forKey:@"p_invoice_number"];
    [params setValue:invoiceDate forKey:@"p_invoice_date"];
    [params setValue:dealerMobileNo forKey:@"p_dealer_mobile"];
    [params setValue:uid forKey:@"p_user_id"];
    [params setValue:salesRepName forKey:@"p_sales_rep_name"];
    [params setObject:[NSNumber numberWithBool:ecob] forKey:@"p_non_eo"];
    
    NSLog(@"%@", params);
    
    return params;
}

+ (NSDictionary *) buildBundleNumberJSONWith:(NSString *) bundleNumber {
    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"exchane_offer_info_bundle",requestKey,
                            bundleNumber,@"p_bundle_number",
                            nil];
    
    return param;
}

+ (NSString *) getJsonString :(NSString *)userName {
    NSString *urlString = [[NSString alloc] init];
    urlString = [urlString stringByAppendingFormat:@"request=%@&deviceModel=%@&deviceOs=%@&accessType=%@&mobile1=%@&mobile2=%@&p_device_token=%@",@"validateMobile", @"iPhone 5C",[Utility getDeviceName],@"A",userName,@"",@""];
    return urlString;
}

+ (NSDictionary *) buildDelearListJsonObject {
    
    if ([[historyModel sharedhistoryModel].opUserType isEqualToString:@"EMPLOYEE"] ) {
        return [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"1",@"old",
                [historyModel sharedhistoryModel].opGreatplususerId,@"op_greatplus_user_id",
                [historyModel sharedhistoryModel].opuserRoleName,@"op_user_role_name",
                nil];
    }
    
    if ([[UserDefaultStorage getDealerID] isEqualToString:EmptyString] || ([UserDefaultStorage getDealerID] == nil)) {
        return [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"getProductDealers_V1",requestKey,
                [MailClassViewController sharedInstance].op_territory,@"p_territory",
                nil];
    } else {
        return [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"getProductDealers_V1",requestKey,
                [UserDefaultStorage getDealerID],@"p_dealer_id",
                [UserDefaultStorage getUserDealerType],@"p_role_name",
                nil];
    }
    
    //    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
    //                            @"getProductDealers",requestKey,
    //                            [MailClassViewController sharedInstance].op_territory,@"p_territory",
    //                            nil];
    
    //    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
    //                            @"getProductDealers_V1",requestKey,
    //                            [UserDefaultStorage getDealerID],@"p_dealer_id",
    //                            [UserDefaultStorage getUserDealerType],@"p_role_name",
    //                            nil];
    //
    //    return param;
}

+ (NSDictionary *) buildPointsList {

        return [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                [historyModel sharedhistoryModel].opGreatplususerId,@"saathi_user_id",
                [UserDefaultStorage getDealerID],@"p_serial_number",
                [UserDefaultStorage getUserDealerType],@"p_dealer_code",
                nil];
}

+ (NSDictionary *) buildDelearLocationJsonObject {
    //    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
    //                            @"getLocationDataV1",requestKey,
    //                            [UserDefaultStorage getDealerID],@"p_dealer_id",
    //                            nil];
    if ([[UserDefaultStorage getDealerID] isEqualToString:EmptyString] || [UserDefaultStorage getDealerID] == nil) {
        return [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"getLocationDataV1",requestKey,
                [MailClassViewController sharedInstance].delearID,@"p_dealer_id",
                [MailClassViewController sharedInstance].delearName,p_dealer_nameKey,
                [MailClassViewController sharedInstance].op_territory,@"p_territory",
                nil];
    } else {
        return [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"getLocationDataV1",requestKey,
                [UserDefaultStorage getDealerID],@"p_dealer_id",
                nil];
    }
    //    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
    //                            @"getLocationData",requestKey,
    //                            [MailClassViewController sharedInstance].op_territory,@"p_territory",
    //                            [MailClassViewController sharedInstance].delearName,p_dealer_nameKey,
    //                            nil];
    
    //    return param;
}

+ (NSDictionary *) buildDProfileJsonObject {
    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"getProfile",requestKey,
                            nil];
    
    return param;
}

+ (NSDictionary *) buildVersionCodeJsonObject {
    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"checkAppVersion",requestKey,
                            VERSION_CODE,@"p_app_version",
                            [UserDefaultStorage getUserDealerID],@"userId",
                            [NSString stringWithFormat:@"%@ %@",[Utility getDeviceModel],[Utility getDeviceOSVersion]],@"deviceModel",
                            [Utility getDeviceName],@"deviceOs",
                            @"A",@"accessType",
                            "",@"mobile1",
                            @"",@"mobile2",
                            @"",@"p_device_token",
                            nil];
    
    return param;
}

+ (NSDictionary *) buildCheckVersionCodeJsonObject {
    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"checkAppVersion",requestKey,
                            VERSION_CODE,@"p_app_version",
                            nil];
    
    return param;
}

+ (NSDictionary *) buildProductListJsonObject {
    
    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"getProduct",requestKey,
                            [MailClassViewController sharedInstance].delearName,p_dealer_nameKey,
                            [MailClassViewController sharedInstance].p_zone,@"p_zone",
                            [UserDefaultStorage getDelearCategory],@"p_dealer_category",
                            nil];
    NSLog(@"%@", param);
    return param;
}

+ (NSDictionary *) buildColourListJsonObject {
    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"getProductColor",requestKey,
                            [MailClassViewController sharedInstance].p_product_name,@"p_product_name",
                            [MailClassViewController sharedInstance].p_zone,@"p_zone",
                            nil];
    
    return param;
}

+ (NSDictionary *) buildSizeListJsonObject {
    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"getProductSize",requestKey,
                            [MailClassViewController sharedInstance].delearName,p_dealer_nameKey,
                            [MailClassViewController sharedInstance].p_zone,@"p_zone",
                            [MailClassViewController sharedInstance].p_product_name,@"p_product_display_name",
                            nil];
    
    return param;
}

+ (NSDictionary *) buildCurrentDateJsonObject {
    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"getCurrentTime",requestKey,
                            nil];
    
    return param;
}

+ (NSDictionary *) buildOrderInfoSendDataJsonObject:(int) quantity withCustomerName :(NSString *)customerName withMobileNumber :(NSString *)mobileNumber withRemark :(NSString *)remark withDelearName :(NSString *)delearName withLocationCode :(NSString *)locationCode withLocationName :(NSString *)locationName withColourAplicable :(NSString *)colourApplicable withLength :(NSString *)length withBredth :(NSString *)breadth withThick :(NSString *)thick WithColour :(NSString *)colour withPeiceOrBundle :(NSString *)pcsOrBndl withAutoSizeFill :(NSString *)autfilSize withChannel_partner_group :(NSString *)channel_partner_group andOrderDate :(NSString *)orderDate {
    
    if ([[UserDefaultStorage getDealerID] isEqualToString:EmptyString] || [UserDefaultStorage getDealerID] == nil) {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        
        [params setValue:@"setSaveOrder_v1" forKey:requestKey];
        [params setValue:channel_partner_group forKey:@"p_channel_partner_group"];
        [params setValue:[MailClassViewController sharedInstance].delearID forKey:@"p_dealer_id"];
        [params setValue:delearName forKey:p_dealer_nameKey];
        [params setValue:[MailClassViewController sharedInstance].p_dealer_category forKey:@"p_dealer_category"];
        [params setValue:locationCode forKey:@"p_location_code"];
        [params setValue:locationName forKey:@"p_location_name"];
        [params setValue:[MailClassViewController sharedInstance].p_product_name forKey:@"p_product_display_name"];
        [params setValue:colourApplicable forKey:@"p_color_applicable_yn"];
        [params setValue:length forKey:@"p_length"];
        [params setValue:breadth forKey:@"p_breadth"];
        [params setValue:thick forKey:@"p_thick"];
        [params setValue:colour forKey:@"p_colour"];
        [params setValue:pcsOrBndl forKey:@"p_uom"];
        [params setValue:autfilSize forKey:@"p_auto_size_flag"];
        [params setValue:[NSNumber numberWithInt:quantity] forKey:@"p_qty"];
        [params setValue:remark forKey:@"p_remark"];
        [params setValue:customerName forKey:@"p_customer_name"];
        [params setValue:mobileNumber forKey:@"p_customer_mobile"];
        [params setValue:@"" forKey:@"p_delivery_date"];
        [params setValue:@"" forKey:@"p_captured_image"];
        [params setValue:@"" forKey:@"p_captured_length"];
        [params setValue:@"" forKey:@"p_captured_bredth"];
        [params setValue:orderDate forKey:@"p_order_date"];
        [params setValue:@"" forKey:@"p_captured_image_binary"];
        
        
        NSLog(@"%@", params);
//        return [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                @"setSaveOrder_v1",requestKey,
//                channel_partner_group,@"p_channel_partner_group",
//                [MailClassViewController sharedInstance].delearID,@"p_dealer_id",
//                delearName,p_dealer_nameKey,
//                [MailClassViewController sharedInstance].p_dealer_category,@"p_dealer_category",
//                locationCode,@"p_location_code",
//                locationName,@"p_location_name",
//                [MailClassViewController sharedInstance].p_product_name,@"p_product_display_name",
//                colourApplicable,@"p_color_applicable_yn",
//                length,@"p_length",
//                breadth,@"p_breadth",
//                thick,@"p_thick",
//                colour,@"p_colour",
//                pcsOrBndl,@"p_uom",
//                autfilSize,@"p_auto_size_flag",
//                quantity,@"p_qty",
//                remark,@"p_remark",
//                customerName,@"p_customer_name",
//                mobileNumber,@"p_customer_mobile",
//                @"",@"p_delivery_date",
//                @"",@"p_captured_image",
//                @"",@"p_captured_length",
//                @"",@"p_captured_bredth",
//                orderDate,@"p_order_date",
//                @"",@"p_captured_image_binary",
//                nil];
        
        return params;
    } else {
        
//        return [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                @"setSaveOrder_v1",requestKey,
//                channel_partner_group,@"p_channel_partner_group",
//                [UserDefaultStorage getDealerID],@"p_dealer_id",
//                delearName,p_dealer_nameKey,
//                [MailClassViewController sharedInstance].p_dealer_category,@"p_dealer_category",
//                locationCode,@"p_location_code",
//                locationName,@"p_location_name",
//                [MailClassViewController sharedInstance].p_product_name,@"p_product_display_name",
//                colourApplicable,@"p_color_applicable_yn",
//                length,@"p_length",
//                breadth,@"p_breadth",
//                thick,@"p_thick",
//                colour,@"p_colour",
//                pcsOrBndl,@"p_uom",
//                autfilSize,@"p_auto_size_flag",
//                quantity,@"p_qty",
//                remark,@"p_remark",
//                customerName,@"p_customer_name",
//                mobileNumber,@"p_customer_mobile",
//                @"",@"p_delivery_date",
//                @"",@"p_captured_image",
//                @"",@"p_captured_length",
//                @"",@"p_captured_bredth",
//                orderDate,@"p_order_date",
//                @"",@"p_captured_image_binary",
//                nil];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        
        [parameters setValue:@"setSaveOrder_v1" forKey:requestKey];
        [parameters setValue:channel_partner_group forKey:@"p_channel_partner_group"];
        [parameters setValue:[UserDefaultStorage getDealerID] forKey:@"p_dealer_id"];
        [parameters setValue:delearName forKey:p_dealer_nameKey];
        [parameters setValue:[MailClassViewController sharedInstance].p_dealer_category forKey:@"p_dealer_category"];
        [parameters setValue:locationCode forKey:@"p_location_code"];
        [parameters setValue:locationName forKey:@"p_location_name"];
        [parameters setValue:[MailClassViewController sharedInstance].p_product_name forKey:@"p_product_display_name"];
        [parameters setValue:colourApplicable forKey:@"p_color_applicable_yn"];
        [parameters setValue:length forKey:@"p_length"];
        [parameters setValue:breadth forKey:@"p_breadth"];
        [parameters setValue:thick forKey:@"p_thick"];
        [parameters setValue:colour forKey:@"p_colour"];
        [parameters setValue:pcsOrBndl forKey:@"p_uom"];
        [parameters setValue:autfilSize forKey:@"p_auto_size_flag"];
        [parameters setValue:[NSNumber numberWithInt:quantity] forKey:@"p_qty"];
        [parameters setValue:remark forKey:@"p_remark"];
        [parameters setValue:customerName forKey:@"p_customer_name"];
        [parameters setValue:mobileNumber forKey:@"p_customer_mobile"];
        [parameters setValue:@"" forKey:@"p_delivery_date"];
        [parameters setValue:@"" forKey:@"p_captured_image"];
        [parameters setValue:@"" forKey:@"p_captured_length"];
        [parameters setValue:@"" forKey:@"p_captured_bredth"];
        [parameters setValue:orderDate forKey:@"p_order_date"];
        [parameters setValue:@"" forKey:@"p_captured_image_binary"];
        
        NSLog(@"%@", parameters);
        
        return parameters;
    }
    //    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
    //                            @"setSaveOrder_v1",requestKey,
    //                            channel_partner_group,@"p_channel_partner_group",
    //                            [UserDefaultStorage getDealerID],@"p_dealer_id",
    //                            delearName,p_dealer_nameKey,
    //                            [MailClassViewController sharedInstance].p_dealer_category,@"p_dealer_category",
    //                            locationCode,@"p_location_code",
    //                            locationName,@"p_location_name",
    //                            [MailClassViewController sharedInstance].p_product_name,@"p_product_display_name",
    //                            colourApplicable,@"p_color_applicable_yn",
    //                            length,@"p_length",
    //                            breadth,@"p_breadth",
    //                            thick,@"p_thick",
    //                            colour,@"p_colour",
    //                            pcsOrBndl,@"p_uom",
    //                            autfilSize,@"p_auto_size_flag",
    //                            quantity,@"p_qty",
    //                            remark,@"p_remark",
    //                            customerName,@"p_customer_name",
    //                            mobileNumber,@"p_customer_mobile",
    //                            @"",@"p_delivery_date",
    //                            @"",@"p_captured_image",
    //                            @"",@"p_captured_length",
    //                            @"",@"p_captured_bredth",
    //                            orderDate,@"p_order_date",
    //                            @"",@"p_captured_image_binary",
    //                            nil];
    //
    //    return param;
    
//    NSLog(@"%@", );
}

+ (NSDictionary *) buildOrederViewJsonObject :(NSString *)fromDate withToDate :(NSString *)toDate andStatus :(NSString *)status {
    NSDictionary *param  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"getAllOrder",requestKey,
                            fromDate,p_from_dateKey,
                            toDate,p_to_dateKey,
                            @"",p_dealer_nameKey,
                            status,p_statusKey,
                            nil];
    return param;
}

+ (NSDictionary *) buildOrederApprovalJsonObject {
    NSDictionary *param  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"getAllOrder",requestKey,
                            @"",p_from_dateKey,
                            @"",p_to_dateKey,
                            nil];
    return param;
}

+ (NSDictionary *) buildSaathiPointsSendDataJsonObject :(NSString *)dealerCode andSerialNumber :(NSString *)serialNumber {
    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"getSaathiPoints",requestKey,
                            [UserDefaultStorage getUserDealerID],@"saathi_user_id",
                            serialNumber,@"p_serial_number",
                            dealerCode,@"p_dealer_code",
                            nil];
    
    return param;
}

+ (NSDictionary *) buildBannerDataJsonObject {
    NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"get_ca_order_status",requestKey,
                            [UserDefaultStorage getDealerID],@"p_dealer_id",
                            nil];
    
    return param;
}

@end
