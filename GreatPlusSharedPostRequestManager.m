/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "GreatPlusSharedPostRequestManager.h"
#import "GreatPlusSharedHeader.h"
#import "GreatPlusPostSharedEngine.h"
#import "Utility.h"
#import "historyModel.h"


static GreatPlusSharedPostRequestManager *sharedInstance = nil;

@implementation GreatPlusSharedPostRequestManager

@synthesize completionHanders;

#pragma Mark Action for Initiating the Shared Instance that is Globally Available for All over Project

/**
 *  Log a Start Initiating the Shared Instance that is Globally Available for All over Project
 *  users are doing this and how much they're intracting to Shared Instance related to other important
 *  USER LIST-related metrics.
 */

+ (GreatPlusSharedPostRequestManager *)sharedInstance {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

#pragma MARK for Handling Request Data

- (NSObject *) executePostRequest:(int)cmdType withDictionaryInfo :(NSDictionary *)dict andTagName :(NSString *)tagName andCompletionHandler:(void(^)(id result, int statusCode, NSString *message))completionHandler {
    
    [completionHanders setObject:completionHandler forKey:tagName];
    
    switch (cmdType) {
        case CMD_LOGIN_INIT: {
            [self sendLoginDataToServerWithDic:dict andTagName:tagName];
        }
            break;
        case CMD_AUTH_INIT: {
            [self sendAuthDataToServerWithDic:dict andTagName:tagName];
        }
            break;
        case CMD_LIST_INIT: {
            [self sendListDataToServerWithDic:dict andTagName:tagName];
        }
            break;
        case CMD_EX_INFO_INIT: {
            [self sendListDataToServerWithDic:dict andTagName:tagName];
        }
            break;
        case CMD_EX_INFO_SBMT_INIT: {
            [self sendListDataToServerWithDic:dict andTagName:tagName];
        }
            break;
        case CMD_DELEAR_LIST_INIT: {
            [self sendListDataToServerWithDic:dict andTagName:tagName];
        }
            break;
        case CMD_PROFILE_INIT: {
            [self sendListDataToServerWithDic:dict andTagName:tagName];
        }
            break;
        case CMD_LOCATION_INIT: {
            [self sendListDataToServerWithDic:dict andTagName:tagName];
        }
            break;
        case CMD_PRODUCT_LIST_INIT: {
            [self sendListDataToServerWithDic:dict andTagName:tagName];
        }
            break;
        case CMD_COLOUR_LIST_INIT: {
            [self sendListDataToServerWithDic:dict andTagName:tagName];
        }
            break;
        case CMD_SIZE_INIT: {
            [self sendListDataToServerWithDic:dict andTagName:tagName];
        }
            break;
        case CMD_DATE_INIT: {
            [self sendListDataToServerWithDic:dict andTagName:tagName];
        }
            break;
        case CMD_PLACE_ORDER_DATA_INIT: {
            [self sendListDataToServerWithDicInOrder:dict andTagName:tagName];
        }
            break;
        case CMD_ORDER_STATUS_INIT: {
            [self sendListDataToServerWithDicInOrder:dict andTagName:tagName];
        }
            break;
        case CMD_VERSION_DATA_INIT: {
            [self sendListDataToServerWithDic:dict andTagName:tagName];
        }
            break;
        case CMD_ORDER_STATUS_APPROVAL_INIT: {
            [self sendListDataToServerWithDicInOrder:dict andTagName:tagName];
        }
            break;
        case CMD_CHECK_VERSION_DATA_INIT: {
            [self sendListDataToServerWithDic:dict andTagName:tagName];
        }
            break;
        case CMD_GET_SAATHI_POINT_DATA_INIT: {
            [self getSaathiPointDataToServer:dict andTagName:tagName];
        }
            break;
        case CMD_GET_BANNER_LIST_DATA_INIT: {
            [self getBannerListDataToServer:dict andTagName:tagName];
        }
            break;
        case CMD_GET_SERIAL_NUMBERS_FROM_BUNDLE:{
            [self getSerialNumbersFromBundle:dict andTagName:tagName];
        }
            break;
        case CMD_UNREGISTER_G_CARD:{
            [self unRegisterGCardWithParams:dict andTagName:tagName];
        }
            break;
        default:
            break;
    }
    return nil;
}

#pragma MARK for Sending Login Data To Server

- (void) sendLoginDataToServerWithDic :(NSDictionary *)loginDict andTagName :(NSString *)tagName {
    GreatPlusPostSharedEngine *cars24PostSharedEngine     = [[GreatPlusPostSharedEngine alloc] init];
    cars24PostSharedEngine.delegate                       = (id)self;
    [cars24PostSharedEngine setTagName:tagName];
    [cars24PostSharedEngine postDataUrl:[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin] :loginDict];
    NSLog(@"URL = %@",[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin]);
}


#pragma MARK for Sending Login Data To Server

- (void) sendAuthDataToServerWithDic :(NSDictionary *)loginDict andTagName :(NSString *)tagName {
    GreatPlusPostSharedEngine *cars24PostSharedEngine     = [[GreatPlusPostSharedEngine alloc] init];
    cars24PostSharedEngine.delegate                       = (id)self;
    [cars24PostSharedEngine setTagName:tagName];
    [cars24PostSharedEngine postDataUrl:[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin] :loginDict];
    NSLog(@"URL = %@",[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin]);
}


#pragma MARK for Sending List Data To Server

- (void) sendListDataToServerWithDicInOrder :(NSDictionary *)loginDict andTagName :(NSString *)tagName {
    GreatPlusPostSharedEngine *cars24PostSharedEngine     = [[GreatPlusPostSharedEngine alloc] init];
    cars24PostSharedEngine.delegate                       = (id)self;
    [cars24PostSharedEngine setTagName:tagName];
    [cars24PostSharedEngine postDataUrl:[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionOrder] :loginDict];
    NSLog(@"URL = %@",[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionOrder]);
}

#pragma MARK for Sending List Data To Server

- (void) sendListDataToServerWithDic :(NSDictionary *)loginDict andTagName :(NSString *)tagName {
    GreatPlusPostSharedEngine *cars24PostSharedEngine     = [[GreatPlusPostSharedEngine alloc] init];
    cars24PostSharedEngine.delegate  = (id)self;
    [cars24PostSharedEngine setTagName:tagName];
    
    if ([tagName isEqualToString:@"DelearList"]) {
        [cars24PostSharedEngine postDataUrl:@"http://125.19.46.252/sheelafoams/api_v1.php" :loginDict];
        
    }else if ([tagName isEqualToString:@"getPoints"]){
        [cars24PostSharedEngine postDataUrl:[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIGetPoints] :loginDict];
    }
    else{
        [cars24PostSharedEngine postDataUrl:[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin] :loginDict];
    }
    NSLog(@"URL = %@",[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin]);
}

#pragma MARK for Getting Delear List Data To Server

- (void) getDelearListDataToServer :(NSDictionary *)loginDict andTagName :(NSString *)tagName {
    GreatPlusPostSharedEngine *cars24PostSharedEngine     = [[GreatPlusPostSharedEngine alloc] init];
    cars24PostSharedEngine.delegate                       = (id)self;
    [cars24PostSharedEngine setTagName:tagName];
    [cars24PostSharedEngine postDataUrl:[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin] :loginDict];
    NSLog(@"URL = %@",[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin]);
}

#pragma MARK for Getting Saathi Point Data To Server

- (void) getSaathiPointDataToServer :(NSDictionary *)loginDict andTagName :(NSString *)tagName {
    GreatPlusPostSharedEngine *cars24PostSharedEngine     = [[GreatPlusPostSharedEngine alloc] init];
    cars24PostSharedEngine.delegate                       = (id)self;
    [cars24PostSharedEngine setTagName:tagName];
    [cars24PostSharedEngine postDataUrl:[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin] :loginDict];
    NSLog(@"URL = %@",[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin]);
}

#pragma MARK for Getting Banner Data To Server

- (void) getBannerListDataToServer :(NSDictionary *)loginDict andTagName :(NSString *)tagName {
    GreatPlusPostSharedEngine *cars24PostSharedEngine     = [[GreatPlusPostSharedEngine alloc] init];
    cars24PostSharedEngine.delegate                       = (id)self;
    [cars24PostSharedEngine setTagName:tagName];
    [cars24PostSharedEngine postDataUrl:[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin] :loginDict];
    NSLog(@"URL = %@",[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin]);
}

#pragma MARK for Getting SerialNUmber from Bundle Number

- (void) getSerialNumbersFromBundle :(NSDictionary *)loginDict andTagName :(NSString *)tagName {
    GreatPlusPostSharedEngine *cars24PostSharedEngine     = [[GreatPlusPostSharedEngine alloc] init];
    cars24PostSharedEngine.delegate                       = (id)self;
    [cars24PostSharedEngine setTagName:tagName];
    [cars24PostSharedEngine postDataUrl:[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin] :loginDict];
    NSLog(@"URL = %@",[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin]);
}
- (void) unRegisterGCardWithParams :(NSDictionary *)loginDict andTagName :(NSString *)tagName {
    GreatPlusPostSharedEngine *cars24PostSharedEngine     = [[GreatPlusPostSharedEngine alloc] init];
    cars24PostSharedEngine.delegate                       = (id)self;
    [cars24PostSharedEngine setTagName:tagName];
    [cars24PostSharedEngine postDataUrl:[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin] :loginDict];
    NSLog(@"URL = %@",[NSString stringWithFormat:@"%@/%@",[Utility getURLString],KAPIVersionLogin]);
}

- (void) gettingData:(NSData *)data WithTagName:(NSString *)tagName {
    __block id dataContainer = nil;
    
    @try {
         NSMutableDictionary *allDataDictionary  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([Utility validateJsonData:data]) {
            if ([Utility getStatusCode:data] == 200) {
                if ([tagName isEqualToString:LoginServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:AuthServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:ListServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:ExInfoServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:ExInfoSumitServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:DelearListServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:ProfileServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:LocationServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:ProductServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:ColourServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:SizeServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:DateServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:OrderPlaceServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:OrderViewStatusServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:VersionDataServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:VersionHistoryTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:OrderApprovalServiceTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:SaathiPontTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:BannerListTag]) {
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                }
                else if([tagName isEqualToString:SerialNumberFromBundle]){
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                }
                else if([tagName isEqualToString:UnregisterGCard]){
                    dataContainer = [[allDataDictionary objectForKey:dataKey] mutableCopy];
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], ERRORMESSAGETitle);
                    [completionHanders removeObjectForKey:tagName];
                }


            } else {
                if ([tagName isEqualToString:OrderPlaceServiceTag]) {
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], [NSString stringWithFormat:@"%@",[allDataDictionary objectForKey:msgKey]]);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:OrderViewStatusServiceTag]) {
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], [NSString stringWithFormat:@"%@",[allDataDictionary objectForKey:msgKey]]);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:VersionDataServiceTag]) {
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], [NSString stringWithFormat:@"%@",[allDataDictionary objectForKey:msgKey]]);
                    [completionHanders removeObjectForKey:tagName];
                } else if ([tagName isEqualToString:VersionHistoryTag]) {
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], [NSString stringWithFormat:@"%@",[allDataDictionary objectForKey:msgKey]]);
                    [completionHanders removeObjectForKey:tagName];
                } else {
                    _handlerBlock = completionHanders[tagName];
                    _handlerBlock(dataContainer, [Utility getStatusCode:data], [NSString stringWithFormat:@"%@",[[allDataDictionary objectForKey:dataKey] objectForKey:messageKey]]);
                    [completionHanders removeObjectForKey:tagName];
                }
                 // Show Error Message
            }
        } else {
             // Show Error Message
            _handlerBlock = completionHanders[tagName];
            _handlerBlock(dataContainer, [Utility getStatusCode:data], errorAlert);
            [completionHanders removeObjectForKey:tagName];
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
}

- (instancetype) init {
    self = [super init];
    completionHanders = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    return self;
}

- (void) errorInConnection {
    
}

//#pragma MARK for Connection Time Out Handling
//
//-(void) timeErrorHandlingInSharedEngine:(int)time {
////    [self callBackHandler];
//}


@end
