/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/


#import <Foundation/Foundation.h>

@interface JsonBuilder : NSObject

+ (NSDictionary *) buildLoginJsonObject:(NSString *) userName andPassword :(NSString *) password;
+ (NSDictionary *) buildBundleNumberJSONWith:(NSString *) bundleNumber;
+ (NSDictionary *) buildAuthJsonObject:(NSString *) userName andPassword :(NSString *) password;
+ (NSDictionary *) buildListJsonObject:(NSString *) userName andPassword :(NSString *) password;
+ (NSDictionary *) buildExInfoJsonObject:(NSString *) userName;
//+ (NSDictionary *) buildExInfoSendDataJsonObject:(NSString *) userName withSerialNo1:(NSString *)serialNo1 withSerialNo2:(NSString *)serialNo2 withEcob :(NSString *)ecob andCustomerMobileno :(NSString *)mobileNo withCustomerName:(NSString *)name withCustomerEmail:(NSString *)email;
+ (NSDictionary *) buildExInfoSendDataJsonObject:(NSString *) userName withSerialNo1:(NSString *)serialNo1 withSerialNo2:(NSString *)serialNo2 withEcob :(BOOL)ecob andCustomerMobileno :(NSString *)mobileNo withCustomerName:(NSString *)name withCustomerEmail:(NSString *)email withInvoiceNo:(NSString *)invoiceNum andInvoiceDate:(NSString *)invoiceDate withDealerMobileNo: (NSString *)dealerMobileNo anddealerUID: (NSString *)uid withSalesRepName:(NSString *)salesRepName;
+ (NSDictionary *) buildDProfileJsonObject;
+ (NSString *) getJsonString :(NSString *)userName;
+ (NSDictionary *) buildDelearListJsonObject;
+ (NSDictionary *) buildDelearLocationJsonObject;
+ (NSDictionary *) buildProductListJsonObject;
+ (NSDictionary *) buildColourListJsonObject;
+ (NSDictionary *) buildSizeListJsonObject;
+ (NSDictionary *) buildCurrentDateJsonObject;
+ (NSDictionary *) buildOrderInfoSendDataJsonObject:(int) quantity withCustomerName :(NSString *)customerName withMobileNumber :(NSString *)mobileNumber withRemark :(NSString *)remark withDelearName :(NSString *)delearName withLocationCode :(NSString *)locationCode withLocationName :(NSString *)locationName withColourAplicable :(NSString *)colourApplicable withLength :(NSString *)length withBredth :(NSString *)breadth withThick :(NSString *)thick WithColour :(NSString *)colour withPeiceOrBundle :(NSString *)pcsOrBndl withAutoSizeFill :(NSString *)autfilSize withChannel_partner_group :(NSString *)channel_partner_group andOrderDate :(NSString *)orderDate;
+ (NSDictionary *) buildOrederViewJsonObject :(NSString *)fromDate withToDate :(NSString *)toDate andStatus :(NSString *)status;
+ (NSDictionary *) buildOrederApprovalJsonObject;
+ (NSDictionary *) buildVersionCodeJsonObject;
+ (NSDictionary *) buildCheckVersionCodeJsonObject;
+ (NSDictionary *) buildSaathiPointsSendDataJsonObject :(NSString *)dealerCode andSerialNumber :(NSString *)serialNumber;
+ (NSDictionary *) buildBannerDataJsonObject;
+ (NSDictionary *) buildPointsList;

@end
