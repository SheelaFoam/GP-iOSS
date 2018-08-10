/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#ifndef GreatPlusSharedHeader_h
#define GreatPlusSharedHeader_h


#endif /* GreatPlusSharedHeader_h */


#define RETINA_SCALE    2.0F
#define RETINA_4_HEIGHT 568.0F
#define RETINA_4_IMG_FORMAT @"-568h@2x"
#define ACCEPTABLE_CHARECTERS @"0123456789"
#define ACCEPTABLE_CHARECTERSLength @"0123456789."
#define ACCEPTABLE_CHARECTERSABC @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "

#define NSSTRING_HAS_DATA(_x) ( ((_x) != nil) && !( [(_x) isKindOfClass:[NSNull class]]) &&( [(_x) length] > 0 ) )


/******************** TODO Charle Prabhat Key LIST ***********************/
/****************************************************************/

#define  errorAlert                                    @"Looks like something went wrong. But don't panic, we're already working on it!"

#define  RobotoRegular                                 @"Roboto-Regular"

#define  RobotoMedium                                  @"Roboto-Medium"

#define  RobotoBold                                    @"Roboto-Bold"

#define GreatPlusAuthenticationViewControllerCtrl      @"GreatPlusAuthenticationViewController"
#define TransparentImage   [UIImage imageNamed:@"bg_place_bid@x.png"]

#define VERSION_CODE                          @"18"
#define SaathiPontTag                         @"SaathiPoint"
#define LogoutAlert                           @"Are u sure you want logout?"
#define LogoutAlertTag                        10
#define NetworkAlertTag                       101010
#define GreatPlusTitle                        @"GreatPlus"
#define LoginServiceTag                       @"loginService"
#define AuthServiceTag                        @"Authenticate"
#define ListServiceTag                        @"MenuList"
#define ExInfoServiceTag                      @"ExchangeInfo"
#define ExInfoSumitServiceTag                 @"ExchangeInfoSubMit"
#define SerialNumberFromBundle                @"SerialNumberFromBundle"
#define UnregisterGCard                       @"UnregisterGCard"
#define DelearListServiceTag                  @"DelearList"
#define PointsListTag                         @"getPoints"
#define ProfileServiceTag                     @"ProfileData"
#define LocationServiceTag                    @"LocationData"
#define ProductServiceTag                     @"ProductData"
#define ColourServiceTag                      @"ColourListData"
#define SizeServiceTag                        @"SizeData"
#define DateServiceTag                        @"DateData"
#define OrderPlaceServiceTag                  @"OrderData"
#define OrderViewStatusServiceTag             @"OrderViewData"
#define VersionDataServiceTag                 @"VersionViewData"
#define OrderApprovalServiceTag               @"OrderApprovalData"
#define VersionHistoryTag                     @"VersionHistoryData"
//updated by Amarjeet@SupraITS
#define DocumentListTag                       @"DocListData"
#define BannerListTag                         @"BannerListData"

#define OhnoAlert                             @"No Internet found. Check your connection or try again."
#define DateTitleAlert                        @"Please select current date for placing order"
#define OflineAlert                           @"Sending data through offline mode."
#define SelectOrderTitle                      @"Select Order Status"

#define  CarFilterAlert                       @"Please try to refine your filter settings to find cars offers."

#define  NoRecordAlert                        @"Looks like there are no orders available."

#define  NoRecordAlertFor                     @"Looks like there are no record's available."
#define  SelectDelearTitle                    @"Select Delear"
#define  SelectDelearLocationTitle            @"Select Location"
#define  SelectProductListTitle               @"Select Product List"
#define  SelectColourListTitle                @"Select Colour List"
#define  ApprovedTitle                        @"Approved"
#define  RejectedTitle                        @"Rejected"
#define  DispatchedTitle                      @"Dispatched"
#define  AllOrderTitle                        @"All Order"
#define  ChoseStateTitle                      @"Select State"
#define  ChoseProdCatTitle                    @"Select Category"
#define  ChoseProductTitle                    @"Select Product"
#define  ChoseSizeTitle                       @"Select Product Size"
#define  ChoseThicknessTitle                  @"Select Thickness"

#define MessageOtp1                           @"OTP BASED#MENU"
#define MessageOtp2                           @"OTP BASED"//@"OTPBAED"
#define MainKey                               @"Main"
#define DEALERTitle                           @"DEALER"
#define GoodTitle                             @"GOOD"
#define EmptyOTPAlertMsg                      @"Please enter valid OTP."
#define EmptyOTPTxtFldMsg                     @"OTP field can not be empty."
#define EmptyTxtFldMsg                        @"Username field can not be empty."
#define EmptyPassTxtFldMsg                    @"Password field can not be empty."
#define EmptySerNo1                           @"Serial No 1 field can not be empty."
#define EmptySerNo2                           @"Serial No 2 field can not be empty."
#define DiffPass                              @"Serial No 1 & Serial No 2 field can not be same."
#define EmptyConsumer                         @"Consumer no field can not be empty."
#define MobileNumberLength                    @"Mobile number can't less than 10 digit"
#define SerialNoSelection                     @"Please select atleast one serial no 1 or serial no 2"

#define EmptyDateTxtFldMsg                    @"Date of order field can not be empty."
#define EmptyDistributorTxtFldMsg             @"Delear name field can not be empty."
#define EmptyDelearTxtFldMsg                  @"Location can not be empty."
#define EmptyProductTxtFldMsg                 @"Product name field can not be empty."
#define EmptyColourTxtFldMsg                  @"Colour field can not be empty."
#define EmptyLTxtFldMsg                       @"Length field can not be empty."
#define EmptyWTxtFldMsg                       @"Width field can not be empty."
#define EmptyTTxtFldMsg                       @"Thickness field can not be empty."
#define EmptyQuantityTxtFldMsg                @"Quantity field can not be empty."
#define EmptyCustomerNameTxtFldMsg            @"Customer name field can not be empty."
#define EmptyMobileNumberTxtFldMsg            @"Mobile number field can not be empty."
#define EmptyRemarkTxtFldMsg                  @"Remark field can not be empty."

#define ButtonColour                          [UIColor colorWithRed:32/255.0f green:161/255.0f blue:79/255.0f alpha:1.0f]

#define BlueColour                            [UIColor colorWithRed:46/255.0f green:34/255.0f blue:168/255.0f alpha:1.0f]

#define GBlueColour                           [UIColor colorWithRed:36/255.0f green:89/255.0f blue:131/255.0f alpha:1.0f]

#define Devider_COLOR                         [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1.0f]

#define GreatPlusHomeViewControllerCtrl          @"GreatPlusHomeViewController"
#define GreatPlusLoginViewControllerCtrl         @"GreatPlusLoginViewController"
#define GreatPlusHomeViewControllerCtrl          @"GreatPlusHomeViewController"
#define GreatPlusExchangeOfferViewControllerCtrl @"GreatPlusExchangeOfferViewController"
#define GreatPlusSpecificUIViewControllerCtrl    @"GreatPlusSpecificUIViewController"
#define GreatPlusPlaceOrderViewControllerCtrl    @"GreatPlusPlaceOrderViewController"
#define GreatPlusOrderStatusViewControllerCtrl   @"GreatPlusOrderStatusViewController"
#define GreatPlusOTPValidatorViewControllerCtrl  @"GreatPlusOTPValidatorViewController"
#define GreatPlusOrderApprovelViewControllerCtrl @"GreatPlusOrderApprovelViewController"
#define GreatPlusMrpCalculatorViewControllerCtrl @"GreatPlusMrpCalculatorViewController"
#define CityViewCtrl                             @"CityView"
#define OptionCustomCellCtrl                     @"OptionCustomCell"
#define FCDOBDatePickerCtrl                      @"FCDOBDatePicker"
#define someThingSelectedInDetailDOBTitle        @"someThingSelectedInDetailDOB"

#define cellIdentifier                        @"cell"
#define CVCellCtrl                            @"CVCell"
#define cvCellIdentifiyer                     @"cvCell"
#define LoadingTitle                          @"Loading.."
#define DeleteRecord                          @"Loading."

#define ValidatingTitle                       @"Please Wait..."
#define EmptyString                           @""
#define PARENT_MENUKey                        @"PARENT_MENU"
#define PARENT_MENU_ICONKey                   @"PARENT_MENU_ICON"
#define sub_cat_iconKey                       @"sub_cat_icon"
#define sub_cat_nameKey                       @"sub_cat_name"
#define CHILD_MENUKey                         @"CHILD_MENU"
#define PcsTitle                              @"Pcs"
#define BdlTitle                              @"Bdl"
#define titleKey                              @"title"
#define op_resultKey                          @"op_result"
#define NATitle                               @"NA"
#define NameKey                               @"PayByCash"
#define PayByCashLoading                      @"Loading"
#define ContactNumberError                    @"Please provide contact number"

#define ProdCountError                        @"Please add product First"
#define PaidAmountValueError                  @"Please add amount to be paid"
#define mandatoryFieldsAlert          @"Payment can only be initiated after completing mandatory fields,highlighted in Red."


#define DefaultImage                          [UIImage imageNamed:@"abtitlelogo.png"]


#define op_authorised_ynKey                   @"op_authorised_yn"
#define op_messageKey                         @"op_message"
#define op_role_nameKey                       @"op_role_name"
#define operationKey                          @"operation"
#define tokenKey                              @"token"
#define op_otpKey                             @"op_otp"

#define channel_partner_nameKey               @"channel_partner_name"
#define dealer_categoryKey                    @"dealer_category"
#define location_nameKey                      @"location_name"
#define location_codeKey                      @"location_code"
#define product_display_nameKey               @"product_display_name"
#define color_applicable_ynKey                @"color_applicable_yn"
#define colorKey                              @"color"
#define dealer_nameKey                        @"dealer_name"
#define order_numberKey                       @"order_number"
#define order_dateKey                         @"order_date"
#define remarkKey                             @"remark"

#define msgKey                                @"msg"
#define dataKey                               @"data"
#define messageKey                            @"message"

#define ERRORMESSAGETitle                     @"ERROR MESSAGE"

#define CurrentBidKey                         @"CurrentBid"
#define registrationCityKey                   @"registrationCity"
#define odometerReadingKey                    @"odometerReading"
#define totalRfcKey                           @"totalRfc"
#define currentKey                            @"current"
#define carIdKey                              @"carId"
#define biddingStatusKey                      @"biddingStatus"
#define buyingModeKey                         @"buyingMode"
#define rankMessageKey                        @"rankMessage"
#define messageColorCodeKey                   @"messageColorCode"
#define isWinnerKey                           @"isWinner"
#define biddingDetailKey                      @"biddingDetail"
#define auctionTimeKey                        @"auctionTime"
#define canBidKey                             @"canBid"
#define isBidNowEnableKey                     @"isBidNowEnable"
#define isBuyNowEnableKey                     @"isBuyNowEnable"
#define inspectionImagesKey                   @"inspectionImages"
#define ippKey                                @"ipp"
#define valueKey                              @"value"
#define isBuyNowKey                           @"isBuyNow"
#define lastSeenKey                           @"lastSeen"
#define last_seen_messageKey                  @"last_seen_message"
#define imagesKey                             @"images"
#define hostKey                               @"host"
#define sizeKey                               @"size"
#define thumbnailKey                          @"thumbnail"
#define waterMarkFilterKey                    @"waterMarkFilter"
#define productKey                            @"product"
#define zoneKey                               @"zone"
#define ProductSizeKey                        @"ProductSize"
#define base_lengthKey                        @"base_length"
#define base_bredthKey                        @"base_bredth"
#define base_thickKey                         @"base_thick"
#define ConnectionTitle                       @"Connection.!!!"
#define FromDateTitle                         @"From Date"
#define ToDate                                @"To Date"
#define thickKey                              @"thick"
#define lengthKey                             @"length"
#define breadthKey                            @"breadth"
#define uomKey                                @"uom"
#define qtyKey                                @"qty"

/******************** END ***********************/
/****************************************************************/

/******************** TODO Charle Prabhat Key LIST ***********************/
/****************************************************************/

#define HackTitle                            @"Hack"
#define keyCheckTitle                        @"keyCheck"
#define callUsKey                            @"callUs"
#define termAndConditionKey                  @"termAndCondition"
#define mandatoryKey                         @"mandatory"
#define versionCodeKey                       @"versionCode"

#define baseUrlsKey                          @"baseUrls"
#define baseUrlKey                           @"baseUrl"

#define outbidKey                            @"outbid"
#define suspendedKey                         @"suspended"
#define pausedKey                            @"paused"
#define deal_lostKey                         @"deal_lost"
#define alertKey                             @"alert"
#define typeKey                              @"type"
#define colorCodeKey                         @"colorCode"

#define locationKey                          @"location"


/******************** Login Info ***********************/
/****************************************************************/
#define csrf_tokenKey                        @"csrf_token"
#define user_tokenKey                        @"user_token"
#define dealer_infoKey                       @"dealer_info"
#define emailKey                             @"email"
#define tncValidateKey                       @"tncValidate"
#define guaranteeMoneyKey                    @"guaranteeMoney"
#define preferedStateSavedKey                @"preferedStateSaved"
#define detailKey                            @"detail"
#define car_detailKey                        @"car_detail"
#define statusKey                            @"status"

#define SubscryptKey                         @"Subscrypt"
#define CFBundleShortVersionStringKey        @"CFBundleShortVersionString"
#define LoginViewTitle                       @"Login View"
#define CarsViewTitle                        @"My Cars View"
#define AnswerEvent                          @"CustomEvent"
#define FiltersTitle                         @"FILTERS"
#define CallUsTilte                          @"Call us"
#define ForgotUsTilte                        @"I forgot my Password"
#define GoodTitle                            @"GOOD"
#define SAVEANDNEWTitle                      @"SAVEANDNEW"
#define SAVETitle                            @"SAVE"


/******************** TODO Charle Prabhat Filters Model Key Tag LIST ***********************/
/****************************************************************/

#define SELECTEDKey                          @"SELECTED"
#define keyKey                               @"key"
#define filterKey                            @"filter"
#define labelKey                             @"label"
#define singlePageKey                        @"singlePage"
#define searchableKey                        @"searchable"
#define valueKey                             @"value"
#define isSelectedKey                        @"isSelected"
#define fromKey                              @"from"
#define key_requestKey                       @"key_request"
#define sendKeyKey                           @"sendKey"
#define op_eocbKey                           @"op_eocb"
#define op_smileKey                          @"op_smile"
#define op_returned_mattressKey              @"op_returned_mattress"
#define statusCodeKey                        @"statusCode"

/******************** END ***********************/
/****************************************************************/
#define AppStoreID                           @"1129401659"
#define StatusBarNotificationObserver        @"touchStatusBarClick"
#define RemovePlaceBidNotificationObserver   @"RemovePicker"
#define DeleteDataNotificationObserver       @"DeleteData"
#define UpdateDataNotificationObserver       @"UpdateData"


/******************** TODO Charle Prabhat Tag LIST ***********************/
/****************************************************************/



#define ErrorMessageNoRecordFound       @"No Record Found"

#define GetActualMRPTag                 @"GetActualMRP"
#define GetThicknessTag                 @"GetThickness"
#define GetVersionHistoryTag            @"VersionHistory"
#define GetConfigUrlTag                 @"ConfigUrl"
#define GetStateListTag                 @"StateList"
#define GetCatListTag                   @"CategoryList"
#define GetSathiPoints                  @"SathiPoints"
#define GetProdListTag                  @"ProductList"
#define GetStandSizeTag                 @"GetStandSize"
#define APNSTag                         @"APNSService"
#define NoRecordsFoundTitle             @"No Record Found"
#define NOTitle                         @"NO"

#define NoNetWorkAlertTag               505050
#define UnderGoingUpgaredAlertTag       11111
#define UpgradeAlertTag                 101010
#define RemindMeAlertTag                1010
#define StatusCode                      200
#define StatusCodeLogout                401
#define NoRecordsTag                    2020
#define UpdateUsTag                     1212
#define DateKey                         @"Date"
#define typeZero                        @"0"
#define typeOne                         @"1"
#define typeTwo                         @"2"
#define typeThree                       @"3"
#define typeFour                        @"4"
#define typeFive                        @"5"
#define typeSix                         @"6"
#define typeSeven                       @"7"
#define GreenColourCode                 @"CC1a5a8a"


#define requestKey                      @"request"
#define p_from_dateKey                  @"p_from_date"
#define p_to_dateKey                    @"p_to_date"
#define p_dealer_nameKey                @"p_dealer_name"
#define p_statusKey                     @"p_status"
/******************** TODO Charle Prabhat CMD Type ***********************/
/****************************************************************/


#define CMD_LOGIN_INIT               1
#define CMD_AUTH_INIT                2
#define CMD_LIST_INIT                3
#define CMD_EX_INFO_INIT             4
#define CMD_EX_INFO_SBMT_INIT        5
#define CMD_DELEAR_LIST_INIT         6
#define CMD_PROFILE_INIT             7
#define CMD_LOCATION_INIT            8
#define CMD_PRODUCT_LIST_INIT        9
#define CMD_COLOUR_LIST_INIT         10
#define CMD_SIZE_INIT                11
#define CMD_DATE_INIT                12
#define CMD_PLACE_ORDER_DATA_INIT      13
#define CMD_ORDER_STATUS_INIT          14
#define CMD_VERSION_DATA_INIT          15
#define CMD_ORDER_STATUS_APPROVAL_INIT 16
#define CMD_CHECK_VERSION_DATA_INIT    17

#define CMD_GET_STATE_DATA_INIT        18
#define CMD_GET_PROD_CAT_DATA_INIT     19
#define CMD_GET_PROD_DATA_INIT         20
#define CMD_GET_STAND_SIZE_DATA_INIT   21
#define CMD_GET_THICKNESS_DATA_INIT    22
#define CMD_GET_ACTUAL_MRP_DATA_INIT   23
#define CMD_GET_SAATHI_POINT_DATA_INIT 24
#define CMD_GET_DOC_LIST_DATA_INIT     25
#define CMD_GET_BANNER_LIST_DATA_INIT  26
#define CMD_GET_SERIAL_NUMBERS_FROM_BUNDLE 27
#define CMD_UNREGISTER_G_CARD 28
#define CMD_GET_SATHI_POINTS 29

// CCAvenue Values


#define CCAV_MerchantID                 @"119962"
#define CCAV_Merch_AccesCode            @"AVYD68EA58AD56DYDA"
#define CCAV_RSAKey_URL                 @"http://sleepwellproducts.com/ccav/GetRSA.php"
#define CCAV_Redirect_URL               @"http://sleepwellproducts.com/ccav/ccavResponseHandler.php"
#define CCAV_Cancel_URL                 @"http://sleepwellproducts.com/ccav/ccavResponseHandler.php"
#define CCAV_Currency                   @"INR"

// HDFC Values
#define HDFC_MerchantID                 @"122737"
#define HDFC_Merch_AccesCode            @"AVNC68EA99CL70CNLC"
#define HDFC_RSAKey_URL                 @"http://54.254.131.151/hdfc/GetRSA.php"
#define HDFC_Redirect_URL               @"http://sleepwellproducts.com/hdfc/ccavResponseHandler.php"
#define HDFC_Cancel_URL                 @"http://sleepwellproducts.com/hdfc/ccavResponseHandler.php"
#define HDFC_Currency                   @"INR"




