/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "GreatPlusSharedGetRequestManager.h"
#import "GreatPlusSharedHeader.h"
#import "GreatPlusGetSharedEngine.h"
#import "UserDefaultStorage.h"
#import "Utility.h"

static GreatPlusSharedGetRequestManager *sharedInstance = nil;

@implementation GreatPlusSharedGetRequestManager

@synthesize completionHanders;

#pragma Mark Action for Initiating the Shared Instance that is Globally Available for All over Project

/**
 *  Log a Start Initiating the Shared Instance that is Globally Available for All over Project
 *  users are doing this and how much they're intracting to Shared Instance related to other important
 *  USER LIST-related metrics.
 */

+ (GreatPlusSharedGetRequestManager *)sharedInstance {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (instancetype) init {
    self = [super init];
    completionHanders = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    return self;
}

#pragma MARK for Handling Request Data

- (NSObject *) executeRequest:(int)cmdType withUrl :(NSString *)url andTagName :(NSString *)tagName andCompletionHandler:(void(^)(id result, int statusCode, NSString *message))completionHandler {
    
    [completionHanders setObject:completionHandler forKey:tagName];
    
    switch (cmdType) {
        case CMD_GET_STATE_DATA_INIT: {
            [self fetchStateListFromServer:tagName];
        }
            break;
        case CMD_GET_PROD_CAT_DATA_INIT: {
            [self fetchProdCategoryListFromServer:tagName];
        }
            break;
        case CMD_GET_SATHI_POINTS: {
            [self fetchSathiPointsFromServer:tagName withURL:url];
        }
            break;
        case CMD_GET_PROD_DATA_INIT: {
            [self fetchProdListFromServer:tagName];
        }
            break;
        case CMD_GET_STAND_SIZE_DATA_INIT: {
            [self fetchStandardSizeFromServer:tagName andType:url];
        }
            break;
        case CMD_GET_THICKNESS_DATA_INIT: {
            [self fetchThicknessFromServer:tagName andType:url];
        }
            break;
        case CMD_GET_ACTUAL_MRP_DATA_INIT: {
            [self fetchActualMRPFromServer:tagName andType:url];
        }
            break;

        default:
            break;
    }
    return nil;
}

#pragma MARK for Sending Data to Server

/**
 *  Log a Start Fetching Creative Data on Server event to see users moving through the Data on server in real-time, understand how many
 *  users are doing this and how much they're spending per Signed UP process, and see how it related to other important
 *  user-related metrics.
 *
 *  @param tagName Name               The URL of server.
 */

-(void)fetchStateListFromServer : (NSString *) tagName {
    GreatPlusGetSharedEngine *greatPlusGetSharedEngineObj  = [[GreatPlusGetSharedEngine alloc] init];
    greatPlusGetSharedEngineObj.delegate   = (id)self;
    greatPlusGetSharedEngineObj.tagName    = tagName;
    [greatPlusGetSharedEngineObj passUrl:[NSString stringWithFormat:@"%@/%@%@",[Utility getURLString],KAPIGetStateList,[UserDefaultStorage getUserDealerID]]];
    NSLog(@"URL = %@",[NSString stringWithFormat:@"%@/%@%@",[Utility getURLString],KAPIGetStateList,[UserDefaultStorage getUserDealerID]]);
}
 -(void)fetchSathiPointsFromServer : (NSString *) tagName withURL:(NSString *)url {
    GreatPlusGetSharedEngine *greatPlusGetSharedEngineObj  = [[GreatPlusGetSharedEngine alloc] init];
    greatPlusGetSharedEngineObj.delegate   = (id)self;
    greatPlusGetSharedEngineObj.tagName    = tagName;
    [greatPlusGetSharedEngineObj passUrl:url];
//    NSLog(@"URL = %@",[NSString stringWithFormat:@"%@/%@%@",[Utility getURLString],KAPIGetStateList,[UserDefaultStorage getUserDealerID]]);
}

-(void)fetchProdCategoryListFromServer : (NSString *) tagName {
    GreatPlusGetSharedEngine *greatPlusGetSharedEngineObj  = [[GreatPlusGetSharedEngine alloc] init];
    greatPlusGetSharedEngineObj.delegate   = (id)self;
    greatPlusGetSharedEngineObj.tagName    = tagName;
    [greatPlusGetSharedEngineObj passUrl:[NSString stringWithFormat:@"%@/%@MOBILE=%@&ZONE=%@",[Utility getURLString],KAPIGetCatList,[UserDefaultStorage getUserDealerID],[UserDefaultStorage getZone]]];
    NSLog(@"URL = %@",[[NSString stringWithFormat:@"%@/%@MOBILE=%@&ZONE=%@",[Utility getURLString],KAPIGetCatList,[UserDefaultStorage getUserDealerID],[UserDefaultStorage getZone]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
}

-(void)fetchProdListFromServer : (NSString *) tagName {
    GreatPlusGetSharedEngine *greatPlusGetSharedEngineObj  = [[GreatPlusGetSharedEngine alloc] init];
    greatPlusGetSharedEngineObj.delegate   = (id)self;
    greatPlusGetSharedEngineObj.tagName    = tagName;
    [greatPlusGetSharedEngineObj passUrl:[[NSString stringWithFormat:@"%@/%@MOBILE=%@&ZONE=%@&PRODUCT_CATEGORY=%@",[Utility getURLString],KAPIProductList,[UserDefaultStorage getUserDealerID],[UserDefaultStorage getZone],([[UserDefaultStorage getPRODUCT_CATEGORY] isEqualToString:@"ALL"]) ? @"": [UserDefaultStorage getPRODUCT_CATEGORY]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    NSLog(@"URL = %@",[[NSString stringWithFormat:@"%@/%@MOBILE=%@&ZONE=%@&PRODUCT_CATEGORY=%@",[Utility getURLString],KAPIProductList,[UserDefaultStorage getUserDealerID],[UserDefaultStorage getZone],([[UserDefaultStorage getPRODUCT_CATEGORY] isEqualToString:@"ALL"]) ? @"": [UserDefaultStorage getPRODUCT_CATEGORY]] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
}

-(void)fetchStandardSizeFromServer : (NSString *) tagName andType :(NSString *)type {
    GreatPlusGetSharedEngine *greatPlusGetSharedEngineObj  = [[GreatPlusGetSharedEngine alloc] init];
    greatPlusGetSharedEngineObj.delegate   = (id)self;
    greatPlusGetSharedEngineObj.tagName    = tagName;
    [greatPlusGetSharedEngineObj passUrl:[[NSString stringWithFormat:@"%@/%@MOBILE=%@&product_name=%@&length_type=%@",[Utility getURLString],KAPIGetStandardSize,[UserDefaultStorage getUserDealerID],[UserDefaultStorage getPRODUCT_NAME],type] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    NSLog(@"URL = %@",[[NSString stringWithFormat:@"%@/%@MOBILE=%@&product_name=%@&length_type=%@",[Utility getURLString],KAPIGetStandardSize,[UserDefaultStorage getUserDealerID],[UserDefaultStorage getPRODUCT_NAME],type] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
}

-(void)fetchThicknessFromServer : (NSString *) tagName andType :(NSString *)type {
    GreatPlusGetSharedEngine *greatPlusGetSharedEngineObj  = [[GreatPlusGetSharedEngine alloc] init];
    greatPlusGetSharedEngineObj.delegate   = (id)self;
    greatPlusGetSharedEngineObj.tagName    = tagName;
    [greatPlusGetSharedEngineObj passUrl:[[NSString stringWithFormat:@"%@/%@MOBILE=%@&product_name=%@&length_type=%@",[Utility getURLString],KAPIGetThickness,[UserDefaultStorage getUserDealerID],[UserDefaultStorage getPRODUCT_NAME],type] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    NSLog(@"URL = %@",[[NSString stringWithFormat:@"%@/%@MOBILE=%@&product_name=%@&length_type=%@",[Utility getURLString],KAPIGetThickness,[UserDefaultStorage getUserDealerID],[UserDefaultStorage getPRODUCT_NAME],type] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
}


-(void)fetchActualMRPFromServer : (NSString *) tagName andType :(NSString *)type {
    GreatPlusGetSharedEngine *greatPlusGetSharedEngineObj  = [[GreatPlusGetSharedEngine alloc] init];
    greatPlusGetSharedEngineObj.delegate   = (id)self;
    greatPlusGetSharedEngineObj.tagName    = tagName;
        
    [greatPlusGetSharedEngineObj passUrl:[[NSString stringWithFormat:@"%@/%@MOBILE=%@&p_product_name=%@&p_state=%@&p_length=%@&p_bredth=%@&p_thick=%@&p_color=%@",[Utility getURLString],KAPIGetActualMRP,[UserDefaultStorage getUserDealerID],[UserDefaultStorage getPRODUCT_NAME],[UserDefaultStorage getDealerState],[UserDefaultStorage getLength],[UserDefaultStorage getWidth],[UserDefaultStorage getThickness],@""] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    NSLog(@"URL = %@",[[NSString stringWithFormat:@"%@/%@MOBILE=%@&p_product_name=%@&p_state=%@&p_length=%@&p_bredth=%@&p_thick=%@&p_color=%@",[Utility getURLString],KAPIGetActualMRP,[UserDefaultStorage getUserDealerID],[UserDefaultStorage getPRODUCT_NAME],[UserDefaultStorage getDealerState],[UserDefaultStorage getLength],[UserDefaultStorage getWidth],[UserDefaultStorage getThickness],@""] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]);
}


/**
 *  Log a Getting Data from Server event allows you to see Creative List saving information to Local server
 *  exactly what they're Diong for.
 *
 */

-(void)finishParshingData:(NSData *)userData withTagName :(NSString *)tagName andTime :(int) time {
    
    __block id data = nil;
    NSMutableArray *modelArray  = [[NSMutableArray alloc] init];
    @try {
        _handlerBlock = completionHanders[tagName];
        
        if (_handlerBlock) {
                NSMutableDictionary *allDataDictionary  = [NSJSONSerialization JSONObjectWithData:userData options:0 error:nil];

                if ([Utility validateJsonData:userData]) {
//                    if ([Utility getStatusCode:userData] == StatusCode) {
                        if ([tagName isEqualToString:GetStateListTag]) {
                            _handlerBlock = completionHanders[tagName];
                            _handlerBlock ([allDataDictionary objectForKey:@"state"], [Utility getStatusCode:userData],[allDataDictionary objectForKey:titleKey]);
                            [completionHanders removeObjectForKey:tagName];
                            
                        } else if ([tagName isEqualToString:GetCatListTag]) {
                            _handlerBlock = completionHanders[tagName];
                            _handlerBlock ([allDataDictionary objectForKey:@"All_Product"], [Utility getStatusCode:userData],[allDataDictionary objectForKey:titleKey]);
                            [completionHanders removeObjectForKey:tagName];
                        } else if ([tagName isEqualToString:GetProdListTag]) {
                            _handlerBlock = completionHanders[tagName];
                            _handlerBlock ([allDataDictionary objectForKey:@"All_Product"], [Utility getStatusCode:userData],[allDataDictionary objectForKey:titleKey]);
                            [completionHanders removeObjectForKey:tagName];
                        } else if ([tagName isEqualToString:GetStandSizeTag]) {
                            _handlerBlock = completionHanders[tagName];
                            _handlerBlock ([allDataDictionary objectForKey:@"length_bredth"], [Utility getStatusCode:userData],[allDataDictionary objectForKey:titleKey]);
                            [completionHanders removeObjectForKey:tagName];
                        } else if ([tagName isEqualToString:GetThicknessTag]) {
                            _handlerBlock = completionHanders[tagName];
                            _handlerBlock ([allDataDictionary objectForKey:@"thick"], [Utility getStatusCode:userData],[allDataDictionary objectForKey:titleKey]);
                            [completionHanders removeObjectForKey:tagName];
                        } else if ([tagName isEqualToString:GetActualMRPTag]) {
                            _handlerBlock = completionHanders[tagName];
                            _handlerBlock (allDataDictionary, [Utility getStatusCode:userData],[allDataDictionary objectForKey:titleKey]);
                            [completionHanders removeObjectForKey:tagName];
                        }else if ([tagName isEqualToString:GetSathiPoints]) {
                            _handlerBlock = completionHanders[tagName];
                            _handlerBlock (allDataDictionary, [Utility getStatusCode:userData],[allDataDictionary objectForKey:titleKey]);
                            [completionHanders removeObjectForKey:tagName];
                        }
//                        }
                    } else {
                        data = [modelArray mutableCopy];
                        _handlerBlock = completionHanders[tagName];
                        _handlerBlock (data, [Utility getStatusCode:userData], [NSString stringWithFormat:@"%@",[allDataDictionary objectForKey:titleKey]]);
                        [completionHanders removeObjectForKey:tagName];
                    }

            } else {
                /** Call back handler if Data will not get in 15 seconds */
                _handlerBlock = nil;
                _handlerBlock = completionHanders[tagName];
//                _handlerBlock (data, TimeoutTag, 0, 0, 0, 1, TimeHandlerTitle);
                [completionHanders removeObjectForKey:tagName];
            }
        }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}


@end
