/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "UserDefaultStorage.h"
//#import "MailClassViewController.h"

@implementation UserDefaultStorage


+(void) setUserToken:(NSString*)token
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"user_token"];
    [defaults synchronize];
    
}
+(NSString*) getUserToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"user_token"];

}

+(void) setUserDealerType:(NSString*)typeUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:typeUser forKey:@"user_Type"];
    [defaults synchronize];
}
+(NSString*) getUserDealerType
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"user_Type"];
}

+(void) setUserDealerID:(NSString*)userID
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userID forKey:@"user_ID"];
    [defaults synchronize];
}
+(NSString*) getUserDealerID
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"user_ID"];
}

+(void) setTitleInPicker:(NSString*)title
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:title forKey:@"title"];
    [defaults synchronize];
}
+(NSString*) getTitleInPicker
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"title"];
}

+(void) setTitleDelearName:(NSString*)title {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:title forKey:@"Delear_title"];
    [defaults synchronize];
}

+(NSString*) getTitleDelearName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"Delear_title"];
}

+(void) setDelearCategory:(NSString*)title {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:title forKey:@"DelearCategory"];
    [defaults synchronize];
}

+(NSString*) getDelearCategory {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"DelearCategory"];
}

+(void) setLocationCode:(NSString*)title {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:title forKey:@"LocationCode"];
    [defaults synchronize];
}

+(NSString*) getLocationCode {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"LocationCode"];
}

+(void) setBarCodeData:(NSString *) barCode {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:barCode forKey:@"bar_Code"];
    [defaults synchronize];
}

+(NSString*) getBarCodeData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"bar_Code"];
}

+(void) setDeafaultState:(NSString *)stateName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:stateName forKey:@"stateName"];
    [defaults synchronize];
}

+(NSString*) getDeafaultState {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"stateName"];
}

+(void) setDealerID:(NSString *)dealerID {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dealerID forKey:@"DealerID"];
    [defaults synchronize];
}

+(NSString*) getDealerID {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"DealerID"];
}

+(void) setZone:(NSString *)zone {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:zone forKey:@"Zone"];
    [defaults synchronize];
}

+(NSString*) getZone {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"Zone"];
}

+(void) setPRODUCT_CATEGORY:(NSString *)prodcat {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:prodcat forKey:@"PRODUCT_CATEGORY"];
    [defaults synchronize];
}

+(NSString*) getPRODUCT_CATEGORY {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"PRODUCT_CATEGORY"];
}

+(void) setPRODUCT_NAME:(NSString *)prodcatName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:prodcatName forKey:@"PRODUCT_NAME"];
    [defaults synchronize];
}

+(NSString*) getPRODUCT_NAME {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"PRODUCT_NAME"];
}

+(void) setLength:(NSString *)lLength {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:lLength forKey:@"Length"];
    [defaults synchronize];
}

+(NSString*) getLength {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"Length"];
}

+(void) setWidth:(NSString *)lWidth {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:lWidth forKey:@"Width"];
    [defaults synchronize];
}

+(NSString*) getWidth {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"Width"];
}

+(void) setThickness:(NSString *)lThickness {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:lThickness forKey:@"Thickness"];
    [defaults synchronize];
}

+(NSString*) getThickness {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"Thickness"];
}

+(void) setDealerState:(NSString *)lDealerState {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:lDealerState forKey:@"DealerState"];
    [defaults synchronize];
}

+(NSString*) getDealerState {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"DealerState"];
}

+ (void)setComplaintData:(NSMutableArray *)complaintData {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:complaintData forKey:@"ComplaintData"];
}
+ (NSMutableArray *)getComplaintData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults objectForKey:@"ComplaintData"] mutableCopy];
}

+ (void)setRemainingData:(NSMutableArray *)complaintData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:complaintData forKey:@"RemainingData"];
}

+ (NSMutableArray *)getRemainingData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults objectForKey:@"RemainingData"] mutableCopy];
}

+(void)clearRemainingData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"RemainingData"];
}

//+(void) setNewUserFlag:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"NewUser_Flag"];
//    [defaults synchronize];
//}
//
//+(BOOL) getNewUserFlag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"NewUser_Flag"];
//}
//
//+(void) setTandCFlag:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"TandC_Flag"];
//    [defaults synchronize];
//}
//
//+(BOOL) getTandCFlag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"TandC_Flag"];
//}
//
//+(void) setPopUpFlag:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"PopUp_Flag"];
//    [defaults synchronize];
//}
//
//+(BOOL) getPopUpFlag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"PopUp_Flag"];
//}
//
//+(void) setRememberFlag:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"Remember_Flag"];
//    [defaults synchronize];
//}
//
//+(BOOL) getRememberFlag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"Remember_Flag"];
//}
//
//+(void) setFilterFlag:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"Filter_Flag"];
//    [defaults synchronize];
//}
//
//+(BOOL) getFilterFlag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"Filter_Flag"];
//}
//
//+(void) setFilterFlagShop:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"Filter_FlagShop"];
//    [defaults synchronize];
//}
//
//+(BOOL) getFilterFlagShop
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"Filter_FlagShop"];
//}
//
//
//+(void) setFilterFlagBid:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"Filter_FlagBid"];
//    [defaults synchronize];
//}
//
//+(BOOL) getFilterFlagBid
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"Filter_FlagBid"];
//}
//
//+(void) setFilterFlagBidShop:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"Filter_FlagBidShop"];
//    [defaults synchronize];
//}
//
//+(BOOL) getFilterFlagBidShop
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"Filter_FlagBidShop"];
//}
//
//+(void) setFilterString:(NSString *)urlString {
////    [MailClassViewController sharedInstance].mFilterModel = [[NSMutableArray alloc] init];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:urlString forKey:@"Filter_String"];
//    [defaults synchronize];
//}
//
//+(NSString *) getFilterString {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults valueForKey:@"Filter_String"];
//}
//
//+(void) setUDIDFlag:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"UDUD_String"];
//    [defaults synchronize];
//}
//
//+(BOOL) getUDIDFlag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"UDUD_String"];
//}
//
//+(void) setFilterStringShop:(NSString *)urlString {
//    //    [MailClassViewController sharedInstance].mFilterModel = [[NSMutableArray alloc] init];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:urlString forKey:@"Filter_StringShop"];
//    [defaults synchronize];
//}
//
//+(NSString *) getFilterStringShop {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults valueForKey:@"Filter_StringShop"];
//}
//
//+(void) setFilterStringBid:(NSString *)urlString {
//    //    [MailClassViewController sharedInstance].mFilterModel = [[NSMutableArray alloc] init];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:urlString forKey:@"Filter_StringBid"];
//    [defaults synchronize];
//}
//
//+(NSString *) getFilterStringBid {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults valueForKey:@"Filter_StringBid"];
//}
//
//+(void) setFilterStringBidShop:(NSString *)urlString {
//    //    [MailClassViewController sharedInstance].mFilterModel = [[NSMutableArray alloc] init];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:urlString forKey:@"Filter_StringBidShop"];
//    [defaults synchronize];
//}
//
//+(NSString *) getFilterStringBidShop {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults valueForKey:@"Filter_StringBidShop"];
//}
//
//+(void) setFilterArray:(NSMutableArray*)filterArray
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:filterArray] forKey:@"filter_Array"];
//    [defaults synchronize];
//    
//}
//
//+(void) setOrderArray:(NSMutableArray*)orderArray
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:orderArray] forKey:@"order_Array"];
//    [defaults synchronize];
//    
//}
//+(NSMutableArray*) getOrderArray
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"order_Array"]];
//}
//
//+(NSMutableArray*) getFilterArray
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"filter_Array"]];
//}
//
//+(void) setShopFilterArray:(NSMutableArray*)shopfilterArray
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:shopfilterArray] forKey:@"Shopfilter_Array"];
//    [defaults synchronize];
//    
//}
//
//+(NSMutableArray*) getShopFilterArray
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"Shopfilter_Array"]];
//}
//
//+(void) setButtonArray:(NSMutableArray *)filterArray
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:filterArray] forKey:@"button_Array"];
//    [defaults synchronize];
//    
//}
//
//+(NSMutableArray*) getButtonArray
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"button_Array"]];
//}
//
//+(void) setDeviceToken:(NSString *)deviceToken
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:deviceToken forKey:@"deviceToken"];
//    [defaults synchronize];
//}
//+(NSString *) getDeviceToken
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults objectForKey:@"deviceToken"];
//}
//
//+(void) setTabString:(NSString *)urlString {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:urlString forKey:@"Tab_String"];
//    [defaults synchronize];
//}
//
//+(NSString *) getTAbString {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults valueForKey:@"Tab_String"];
//}
//
////+(void) setBadgeCount:(NSInteger)countNumber{
////    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////    [defaults setInteger:countNumber forKey:@"Badge_Number"];
////    [defaults synchronize];
////}
////
////+(NSInteger) getBadgeCount {
////    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////    return [defaults integerForKey:@"Badge_Number"];
////}
//
////+(void) setBadgeCarIdArray:(NSMutableArray *)filterArray
////{
////    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:filterArray] forKey:@"badgeCaridArr"];
////    [defaults synchronize];
////    
////}
////
////+(NSMutableArray*) getBadgeCarIdArray
////{
////    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////    return [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"badgeCaridArr"]];
////}
//
//
//+(void) setStateArray:(NSMutableArray *)stateArray {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:stateArray] forKey:@"state_Array"];
//    [defaults synchronize];
//    
//}
//
//+(NSMutableArray*) getStateArray {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"state_Array"]];
//}
//
//+(void) setStateSecArray:(NSMutableArray *)stateArray {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:stateArray] forKey:@"state_Sec_Array"];
//    [defaults synchronize];
//    
//}
//
//+(NSMutableArray*) getStateSecArray {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"state_Sec_Array"]];
//}
//
//+(void) setCityArray:(NSMutableArray *)cityArray {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:cityArray] forKey:@"City_Array"];
//    [defaults synchronize];
//    
//}
//
//+(NSMutableArray*) getCityArray {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"City_Array"]];
//}
//
//+(void) setNotifyFlag:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"Notify_Flag"];
//    [defaults synchronize];
//}
//
//+(BOOL) getNotifyFlag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"Notify_Flag"];
//}
//
//+(BOOL) getBGNotify
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"notify"];
//}
//
//
//+(void) setBGNotify:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"notify"];
//    [defaults synchronize];
//}
//
//
//+(void) setCarCodeString:(NSString *)urlString {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:urlString forKey:@"CarCode_String"];
//    [defaults synchronize];
//}
//
//+(NSString *) getCarCodeString {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults valueForKey:@"CarCode_String"];
//}
//
//
////+(void) setTimeeOffFlag:(BOOL)flag {
////    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////    [defaults setBool:flag forKey:@"Timer_Flag"];
////    [defaults synchronize];
////}
////
////+(BOOL) getTimerOffFlag {
////    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////    return [defaults boolForKey:@"Timer_Flag"];
////}
//
//
//+(void) setCarCode:(NSString *)urlString {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:urlString forKey:@"Car_Code"];
//    [defaults synchronize];
//}
//
//+(NSString *) getCarCode {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults valueForKey:@"Car_Code"];
//}
//
//
//+(void) setSearchString:(NSString *)urlString {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:urlString forKey:@"Search_String"];
//    [defaults synchronize];
//}
//
//+(NSString *) getSearchString {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults valueForKey:@"Search_String"];
//}
//
//
//+(void) setSearchFlag:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"Search_Flag"];
//    [defaults synchronize];
//}
//
//+(BOOL) getSearchFlag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"Search_Flag"];
//}
//
//+(void) setCarID:(NSString *)urlString {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:urlString forKey:@"Car_ID"];
//    [defaults synchronize];
//}
//
//+(NSString *) getCarID {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults valueForKey:@"Car_ID"];
//}
//
//+(void) setPauseFlag:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"Pause_Flag"];
//    [defaults synchronize];
//}
//
//+(BOOL) getPauseFlag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"Pause_Flag"];
//}
//
//
//+(void) setFilterCount:(NSMutableArray *)filterArray {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:filterArray] forKey:@"Filter_Count"];
//    [defaults synchronize];
//    
//}
//
//+(NSMutableArray*) getFilterCount {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"Filter_Count"]];
//}
//
//+(void) setEmptyFlag:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"Empty_Flag"];
//    [defaults synchronize];
//}
//
//+(BOOL) getEmptyFlag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"Empty_Flag"];
//}
//
//+(void) setDealFlag:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"Deal_Flag"];
//    [defaults synchronize];
//}
//
//+(BOOL) getDealFlag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"Deal_Flag"];
//}
//
//+(void) setDealLostFlag:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"DealLost_Flag"];
//    [defaults synchronize];
//}
//
//+(BOOL) getDealLostFlag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"DealLost_Flag"];
//}
//
//+(void) setTimerCount:(NSInteger)count {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setInteger:count forKey:@"Timer_Count"];
//    [defaults synchronize];
//    
//}
//
//+(NSInteger) getTimerCount {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults integerForKey:@"Timer_Count"];
//}
//
//+(void) setBaseUrlString:(NSString *)urlString {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:urlString forKey:@"baseUrl_String"];
//    [defaults synchronize];
//}
//
//+(NSString *) getBaseUrlString {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults valueForKey:@"baseUrl_String"];
//}
//
//+(void) setFBCount:(NSInteger)count {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setInteger:count forKey:@"FB_Count"];
//    [defaults synchronize];
//    
//}
//
//+(NSInteger) getFBCount {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults integerForKey:@"FB_Count"];
//}
//
//
//+(void) setRejetcNotif:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"Notif_Flag"];
//    [defaults synchronize];
//}
//
//+(BOOL) getRejetcNotif
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"Notif_Flag"];
//}
//
//
//+(void) setDetailNotificationFlag:(BOOL)flag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:flag forKey:@"Notification_Flag"];
//    [defaults synchronize];
//}
//
//+(BOOL) getDetailNotificationFlag
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"Notification_Flag"];
//}
//

@end
