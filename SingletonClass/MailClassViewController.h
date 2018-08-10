/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface MailClassViewController : UIViewController <MFMailComposeViewControllerDelegate, UIAlertViewDelegate, MFMessageComposeViewControllerDelegate>
{

     NSInteger selectedIndex;
     UIPopoverController *listpopOver;
    
    NSInteger selectedIndexInProfile;
    
    MFMailComposeViewController *mailComposer;
    MFMessageComposeViewController *smsComposer;
    
    NSString *appStoreCountry;
    NSString *applicationName;
    NSString *applicationVersion;
    NSString *applicationGenreName;
    NSString *applicationSellerName;
    NSString *appStoreIconImage;
    
    NSString *applicationKey;
    NSString *messageTitle;
    NSString *message;
    NSUInteger appStoreID;
    NSURL *appStoreURL;
    
    NSInteger i;
    
    UILabel *mLavelForData;
    //
    NSString *mStringForText;
    NSString *mStringForUrl;
     NSString *mHeartCount;
    //
    //
    NSMutableArray *mLangugeArray;
    
    //
    NSString *_strPackageID,*_strEmailID,*_strTitle;
    NSMutableArray *schedulerArr;
   
}
+(NSMutableAttributedString *)strikeOut :(NSString *)strFor;

+(NSString *)covertPriceOFF :(NSString *)discountPrice withRealPrice:(NSString *)realPrice;
//- (void)shareOnpinIt;
- (BOOL)showSMSPicker;
-(UINavigationController *)showSMSComposerSheet;
//-(void)shareonGoogle;
//-(void)shareonTwitter;
+ (void)addTransitionAnimationOfType:(NSString*)animationType
							forLayer:(id)layer
						 forDuration:(CFTimeInterval) duration
							onTarget:(id)delegate;

+(NSString *)convertHTML:(NSString *)html;
+(CGRect)setUImainScreen;
//self.frame = [FCCommon setUImainScreen];
//self.bounds = [FCCommon layoutSubviews:self.bounds];
+(CGRect)layoutSubviews:(CGRect)viewBound;
+(NSString *) mRemoveSpecialCharacter:(NSString *) string;
+(void) showAlertViewWithTitle:(NSString *) title message:(NSString *) message delegate:(id) delegate tag :(NSInteger) tag;
//application details - these are set automatically
//

@property (nonatomic, strong)  NSMutableArray *mCutomArray;
@property (nonatomic, strong)  NSMutableArray *mDelearListArray;
@property (nonatomic, strong)  NSMutableArray *mLocationArray;
@property (nonatomic, strong)  NSMutableArray *mProductListArray;
@property (nonatomic, strong)  NSMutableArray *mColourListArray;
@property (nonatomic, strong)  NSMutableArray *mOrderStatusArray;
@property (nonatomic, strong)  NSMutableArray *mStateArray;
@property (nonatomic, strong)  NSMutableArray *mCategoryArray;
@property (nonatomic, strong)  NSMutableArray *mProductArray;
@property (nonatomic, strong)  NSMutableArray *mSizeArray;
@property (nonatomic, strong)  NSMutableArray *mThicknessArray;

@property (nonatomic, copy) NSString *mStringForText;
@property (nonatomic, copy) NSString *mStringForUrl;
@property (nonatomic, copy) NSString *op_territory;
@property (nonatomic, copy) NSString *delearName;
@property (nonatomic, copy) NSString *p_zone;
@property (nonatomic, copy) NSString *p_dealer_category;
@property (nonatomic, copy) NSString *p_product_name;
@property (nonatomic, copy) NSString *delearID;

@property (nonatomic, copy) NSString *p_product_display_name;

@property (nonatomic, copy) NSString *mStrForCallUS;
@property (nonatomic, copy) NSString *mStrForTermsURL;

//@property (nonatomic, strong)  NSMutableArray *mArraySecurityDeposite;
@property (nonatomic, strong)  NSMutableArray *mFilterModel;
@property (nonatomic, strong)  NSMutableArray *mFilterModelShop;
@property (nonatomic, strong)  NSMutableArray *mFilterModelBid;
@property (nonatomic, strong)  NSMutableArray *mFilterModelBidShop;
@property (nonatomic, strong)  NSMutableArray *mFilterUrlArray;
@property (nonatomic, strong)  NSMutableArray *mFilterUrlArrayShop;
@property (nonatomic, strong)  NSMutableArray *mFilterUrlArrayBid;
@property (nonatomic, strong)  NSMutableArray *mFilterUrlArrayBidShop;

@property (nonatomic, strong)  NSMutableArray *mCarsDetail;
@property (nonatomic, strong)  NSMutableArray *mRfcDetail;

+(void) showAlertViewWithTitleAndBtn1:(NSString *) title message:(NSString *) message delegate:(id) delegate tag :(NSInteger) tag;
//@property (nonatomic, strong) UILabel *mLavelForData;
@property (nonatomic) NSInteger i;
@property (nonatomic, copy) NSString *appStoreCountry;
@property (nonatomic, copy) NSString *applicationName;
@property (nonatomic, copy) NSString *applicationVersion;
@property (nonatomic, copy) NSString *applicationGenreName;
@property (nonatomic, copy) NSString *applicationSellerName;
@property (nonatomic, copy) NSString *applicationBundleID;
@property (nonatomic, copy) NSString *appStoreIconImage;

@property (nonatomic, copy) NSString *applicationKey;
@property (nonatomic, copy) NSString *messageTitle;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSUInteger appStoreID;
@property (nonatomic, copy) NSURL *appStoreURL;
+ (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+(NSString *)covertPriceOff :(NSString *)discountPrice withRealPrice:(NSString *)realPrice;
+ (BOOL) isiPad;
-(BOOL)showPicker;
-(UINavigationController *)showComposerSheet;
//-(void)launchMailAppOnDevice;
+ (MailClassViewController *)sharedInstance;

/**
 * Lanuches the gift app itunes screen
 */
- (void)giftThisApp;
//- (void)publishButtonPressed;
/**
 * Lanuches the gift app itunes screen, with optional informational alert view
 * @param alertView optional informational alert view
 */
- (void)userManialThisAppWithAlertView:(BOOL)alertView;
//+(void) showAlertFoeDelete:(NSString *) title message:(NSString *) message delegate:(id) delegate:(NSInteger) tag;
/**
 * Lanuches the app store rate this app screen
 */
//- (void)rateThisApp;
+ (BOOL) verifyPasswordWithPassword :(NSString *)pass1 andPassword :(NSString *)pass2;
+(BOOL) validUsername:(NSString*)candidatename;
+(BOOL) validateEmail:(NSString *) emailId;
+ (void)addTransitionEffect:(NSString*)type withSubType:(NSString*)subType forView:(UIView*)theView;
+(void) showAlertViewWithTitleAndBtn:(NSString *) title message:(NSString *) message delegate:(id) delegate tag :(NSInteger) tag;

+(void) showAlertViewWithDetail:(NSString *) title message:(NSString *) message delegate:(id) delegate tag :(NSInteger) tag;
/**
 * Lanuches the app store rate this app screen, with optional informational alert view
 * @param alertView optional informational alert view
 */
//- (void)rateThisAppWithAlertView:(BOOL)alertView;
@property (nonatomic, copy) NSString *mCheck;
+ (BOOL) isNetworkConnected;
+(void) showAlertForNetwork;
+(NSMutableAttributedString *)setColor :(NSString *)strFor andLengthWith :(int)length andContentLenght :(int)toLength andColor :(UIColor *)txtColor;

+(UIImage*)compressImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize;
+(NSString *)covertPrice :(NSString *)discountPrice withRealPrice:(NSString *)realPrice;
+(NSMutableAttributedString *)setColor :(NSString *)strFor;

#pragma mark- EmailValidate
+(BOOL)emailValidate:(NSString *)email;

#pragma mark- Create Document Folder
+(BOOL)createDirectives:(NSString *)folderName;

#pragma mark- Delete Document Folder
+(BOOL)deleteDirectives:(NSString *)folderName;

+(BOOL)fileExistAtPath:(NSString *)folderName;
//setPackageId
-(NSString *)getConsultantID;
-(void)setConsultantID:(NSString *)ID;

//setEmailId
-(NSString *)getEmailID;
-(void)setEmailID:(NSString *)ID;

//setTitlename
-(NSString *)getHeadertitleName;
-(void)setHeadertitleName:(NSString *)ID;

+ (BOOL)validateMobile:(NSString *)mobileNumber;
//setarray
-(void)setSchedulerArr:(NSMutableArray *)token;
-(NSMutableArray *)getSchedulerArr;
// Check Null Status
+(BOOL)checkNull:(NSString*)txt;

// Compress image
+ (NSData *)validateImageSize:(NSData *)data;
+(NSString *)getCurrentDate :(NSString *)dateStr;
//+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
//+(NSString *) updateCountdown :(NSDate *)dateString;
+(NSMutableAttributedString *)setUnderLineOfText :(NSString *)strFor;
+(NSMutableAttributedString *)setPlaneOfText :(NSString *)strFor;
+ (BOOL)validatePassword:(NSString *)oldPassword andNewPassword:(NSString *)newPassword;

+(BOOL) canDevicePlaceAPhoneCall;
+ (NSString *)formatTimeFromSeconds:(long  long)numberOfSeconds;
+ (UILabel *) toastWithMessage:(NSString *)message AndObj :(id)obj;
+ (UIColor *)colorFromHexString:(NSString *)hexString;

+(void)openStackFlowUrl :(NSString *)query;
+(void)openAppStoreUrl :(NSString *)appStoreId;
+(NSMutableAttributedString *)setStarColor :(NSString *)strFor;
+(NSMutableAttributedString *)setMandColor :(NSString *)strFor;
+(NSString *)checkStringEmptyForApplicable :(NSString *)str;
+(void) showAlertViewWithRefreshTitle:(NSString *) title message:(NSString *) message delegate:(id) delegate tag :(NSInteger) tag;

+(void) showAlertViewWithTitleForReminderMe:(NSString *) title message:(NSString *) message delegate:(id) delegate tag :(NSInteger) tag;
+ (UILabel *) toastWithMessageForServerError:(NSString *)message AndObj :(id)obj andTimeDuration :(int)duration;
@end

