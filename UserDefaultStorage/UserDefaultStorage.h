/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import <Foundation/Foundation.h>

@interface UserDefaultStorage : NSObject

//+(void) setRememberFlag:(BOOL)flag;
//+(BOOL ) getRememberFlag;

+(void) setUserToken:(NSString*)token;
+(NSString*) getUserToken;

+(void) setUserDealerType:(NSString*)typeUser;
+(NSString*) getUserDealerType;
+(void) setUserDealerID:(NSString*)userID;
+(NSString*) getUserDealerID;
+(void) setTitleInPicker:(NSString*)title;
+(NSString*) getTitleInPicker;
+(void) setTitleDelearName:(NSString*)title;
+(NSString*) getTitleDelearName;
+(void) setDelearCategory:(NSString*)title;
+(NSString*) getDelearCategory;

+(void) setLocationCode:(NSString*)title;
+(NSString*) getLocationCode;

+(void) setBarCodeData:(NSString *) barCode;
+(NSString*) getBarCodeData;

+(void) setDeafaultState:(NSString *)stateName;
+(NSString*) getDeafaultState;

+(void) setDealerID:(NSString *)dealerID;
+(NSString*) getDealerID;

+(void) setZone:(NSString *)zone;
+(NSString*) getZone;

+(void) setPRODUCT_CATEGORY:(NSString *)prodcat;
+(NSString*) getPRODUCT_CATEGORY;

+(void) setPRODUCT_NAME:(NSString *)prodcatName;
+(NSString*) getPRODUCT_NAME;

+(void) setLength:(NSString *)lLength;
+(NSString*) getLength;

+(void) setWidth:(NSString *)lWidth;
+(NSString*) getWidth;

+(void) setThickness:(NSString *)lThickness;
+(NSString*) getThickness;

+(void) setDealerState:(NSString *)lDealerState;
+(NSString*) getDealerState;

+(void) setComplaintData: (NSMutableArray *)complaintData;
+(NSMutableArray *) getComplaintData;

+(void) setRemainingData: (NSMutableArray *)complaintData;
+(NSMutableArray *) getRemainingData;
+(void) clearRemainingData;

//+(void) setFilterArray:(NSMutableArray*)filterArray;
//+(NSMutableArray*) getFilterArray;
//+(void) setDeviceToken:(NSString *)deviceToken;
//+(NSString *) getDeviceToken;
//
//+(void) setButtonArray:(NSMutableArray*)filterArray;
//+(NSMutableArray*) getButtonArray;
//
//+(void) setShopFilterArray:(NSMutableArray*)shopfilterArray;
//+(NSMutableArray*) getShopFilterArray;
//
//+(void) setGuaranteeMoney:(NSString*)money;
//+(NSString*) getGuaranteeMoney;
//
//+(void) setOrderArray:(NSMutableArray*)orderArray;
//+(NSMutableArray*) getOrderArray;
//
//+(void) setUserTutorialFlag:(BOOL)flag;
//+(BOOL) getTutorialFlag;
//
//+(void) setPopUpFlag:(BOOL)flag;
//+(BOOL) getPopUpFlag;
//
//+(void) setNewUserFlag:(BOOL)flag;
//+(BOOL) getNewUserFlag;
//
//+(void) setTabString:(NSString *)urlString;
//+(NSString *) getTAbString;
//
//+(void) setFilterFlag:(BOOL)flag;
//+(BOOL) getFilterFlag;
//+(void) setFilterFlagShop:(BOOL)flag;
//+(BOOL) getFilterFlagShop;
//
//+(void) setFilterString:(NSString *)urlString;
//+(NSString *) getFilterString;
//+(void) setFilterStringShop:(NSString *)urlString;
//+(NSString *) getFilterStringShop;
//
//
//+(void) setFilterFlagBid:(BOOL)flag;
//+(BOOL) getFilterFlagBid;
//+(void) setFilterFlagBidShop:(BOOL)flag;
//+(BOOL) getFilterFlagBidShop;
//
//+(void) setFilterStringBid:(NSString *)urlString;
//+(NSString *) getFilterStringBid;
//+(void) setFilterStringBidShop:(NSString *)urlString;
//+(NSString *) getFilterStringBidShop;
//
////+(void) setBadgeCount:(NSInteger)countNumber;
////+(NSInteger) getBadgeCount;
//
////+(void) setBadgeCarIdArray:(NSMutableArray *)filterArray;
////+(NSMutableArray*) getBadgeCarIdArray;
//
//+(void) setTandCFlag:(BOOL)flag;
//+(BOOL) getTandCFlag;
//
//+(void) setUDIDFlag:(BOOL)flag;
//+(BOOL) getUDIDFlag;
//
//+(void) setStateArray:(NSMutableArray *)stateArray;
//+(NSMutableArray*) getStateArray;
//+(void) setCityArray:(NSMutableArray *)cityArray;
//+(NSMutableArray*) getCityArray;
//
//+(void) setNotifyFlag:(BOOL)flag;
//+(BOOL) getNotifyFlag;
//
//+(BOOL) getBGNotify;
//+(void) setBGNotify:(BOOL)flag;
//
//+(void) setCarCodeString:(NSString *)urlString;
//+(NSString *) getCarCodeString;
//
//+(void) setCarCode:(NSString *)urlString;
//+(NSString *) getCarCode;
//
//+(void) setStateSecArray:(NSMutableArray *)stateArray;
//+(NSMutableArray*) getStateSecArray;
//
//+(void) setSearchString:(NSString *)urlString;
//+(NSString *) getSearchString;
//
//+(void) setSearchFlag:(BOOL)flag;
//+(BOOL) getSearchFlag;
//
//+(void) setCarID:(NSString *)urlString;
//+(NSString *) getCarID;
//+(void) setPauseFlag:(BOOL)flag;
//+(BOOL) getPauseFlag;
//
//
//+(void) setFilterCount:(NSMutableArray *)filterArray;
//+(NSMutableArray*) getFilterCount;
//
//
//+(void) setEmptyFlag:(BOOL)flag;
//+(BOOL) getEmptyFlag;
//
//+(void) setDealFlag:(BOOL)flag;
//+(BOOL) getDealFlag;
//
//+(void) setDealLostFlag:(BOOL)flag;
//+(BOOL) getDealLostFlag;
//
//+(void) setTimerCount:(NSInteger)count;
//+(NSInteger) getTimerCount;
//
//+(void) setBaseUrlString:(NSString *)urlString;
//+(NSString *) getBaseUrlString;
//
//+(void) setFBCount:(NSInteger)count;
//+(NSInteger) getFBCount;
//
//+(void) setRejetcNotif:(BOOL)flag;
//+(BOOL) getRejetcNotif;
////+(void) setTimeeOffFlag:(BOOL)flag;
////+(BOOL) getTimerOffFlag;
//
//+(void) setDetailNotificationFlag:(BOOL)flag;
//+(BOOL) getDetailNotificationFlag;

@end
