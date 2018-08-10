/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "MailClassViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <Availability.h>
#include "Reachability.h"
#import "ReachabilityCheck.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "GreatPlusSharedHeader.h"


#ifdef DEBUG
// First, check if we can use Cocoalumberjack for logging
#ifdef LOG_VERBOSE
extern int ddLogLevel;
#define ITELLLog(...)  DDLogVerbose(__VA_ARGS__)
#else
#define ITELLLog(...) ////// // // // // NSLog(@"%s(%p) %@", __PRETTY_FUNCTION__, self, [NSString stringWithFormat:__VA_ARGS__])
#endif
#else
#define ITELLLog(...) ((void)0)
#endif


static NSString *const iTellAFriendAppIdKey = @"iTellAFriendAppIdKey";
static NSString *const iTellAFriendAppKey = @"iTellAFriendAppKey";
static NSString *const iTellAFriendAppNameKey = @"iTellAFriendAppNameKey";
static NSString *const iTellAFriendAppGenreNameKey = @"iTellAFriendAppGenreNameKey";
static NSString *const iTellAFriendAppSellerNameKey = @"iTellAFriendAppSellerNameKey";
static NSString *const iTellAFriendAppStoreIconImageKey = @"iTellAFriendAppStoreIconImageKey";

static NSString *const iTellAFriendAppLookupURLFormat = @"http://itunes.apple.com/%@/lookup";
static NSString *const iTellAFriendiOSAppStoreURLFormat = @"http://itunes.apple.com/us/app/%@/id%lu?mt=8&ls=1";
static NSString *const iTellAFriendRateiOSAppStoreURLFormat = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d";
static NSString *const iTellAFriendGiftiOSiTunesURLFormat = @"https://www.google.com/";

#define REQUEST_TIMEOUT 60.0


@interface MailClassViewController () {
    
   // Pinterest*  _pinterest;
}

@end

static MailClassViewController *sharedInstance = nil;
@implementation MailClassViewController
@synthesize appStoreCountry;
@synthesize applicationName;
@synthesize applicationVersion;
@synthesize applicationGenreName;
@synthesize applicationSellerName;
@synthesize appStoreIconImage;

@synthesize applicationKey;
@synthesize messageTitle;
@synthesize message;
@synthesize appStoreID;
@synthesize appStoreURL,mCheck, mCarsDetail, mRfcDetail;
@synthesize op_territory, delearName, p_zone, p_dealer_category, p_product_name, p_product_display_name, mDelearListArray, mLocationArray, mProductListArray, mColourListArray, mOrderStatusArray, mStateArray, mCategoryArray, mProductArray, mSizeArray, mThicknessArray;

@synthesize i , mStringForText, mStringForUrl, mCutomArray, mStrForCallUS, mStrForTermsURL;

@synthesize mFilterModel;
@synthesize mFilterModelShop;
@synthesize mFilterModelBid;
@synthesize mFilterModelBidShop;
@synthesize mFilterUrlArray;
@synthesize mFilterUrlArrayShop;
@synthesize mFilterUrlArrayBid;
@synthesize mFilterUrlArrayBidShop;


+ (void)addTransitionAnimationOfType:(NSString*)animationType forLayer:(id)layer forDuration:(CFTimeInterval)duration onTarget:(id)delegate
{
	CATransition *animation = [CATransition animation];
	
	[animation setDelegate:delegate];
	[animation setType:animationType];
	[animation setDuration:duration];
	[animation setSubtype:kCATransitionFromRight];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[layer addAnimation:animation forKey:@"fadeViewAnimation"];
}


// Network Checking

+ (BOOL) isNetworkConnected
{
    BOOL status = YES;
    BOOL isWiFiConnected = [[ReachabilityCheck sharedReachability] internetConnectionStatus];
    if(!isWiFiConnected)
    {
        status = NO;
    }
    return status;
}

+ (BOOL) isiPad
{
    return UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone;
}

+(CGRect)setUImainScreen {
    
    CGRect rect;
    if( [UIScreen mainScreen].bounds.size.height == 568)
    {
        
        rect.origin.x = 0.0; rect.origin.y = 0.0;
        rect.size.width = 320.0; rect.size.height = 548.0;
        // [self.view setFrame:CGRectMake(0, 0, 320, 548)];
    }else{
        
        
        rect.origin.x = 0.0; rect.origin.y = 0.0;
        rect.size.width = 320.0; rect.size.height = 460.0;
        // [self.view setFrame:CGRectMake(0, 0, 320, 460)];
    }
    return rect;
    
}

// Calling Type  self.view.frame = [MailClassViewController setUImainScreen];

+(CGRect)layoutSubviews:(CGRect)viewBound {
    
    CGRect viewBounds = viewBound;
    CGFloat heightOffset = 20.0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        heightOffset = 0.0;
    }
    //CGFloat topBarOffset = self.topLayoutGuide.length;
    
    CGFloat topBarOffset = heightOffset;
    
    viewBounds.origin.y = -topBarOffset;
    return viewBounds;
    // self.view.bounds = viewBounds;
    
}

// Calling Type  self.view.bounds = [FCCommon layoutSubviews:self.bounds];
- (void)viewDidLoad {
    
   [super viewDidLoad];
}

+ (void)load
{
    [self performSelectorOnMainThread:@selector(sharedInstance) withObject:nil waitUntilDone:NO];
}

- (BOOL)showPicker
{
    if ([MFMailComposeViewController canSendMail]) {
        return true;
    }
    
    return false;
    
}

- (BOOL)showSMSPicker
{
    if ([MFMessageComposeViewController canSendText]) {
        return true;
    }
    
    [MailClassViewController showAlertViewWithTitle:@"SMS" message:@"Simulator does not support SMS.!" delegate:nil tag:0];
    return false;
    
}

-(UINavigationController *)showSMSComposerSheet {
    
    smsComposer = [[MFMessageComposeViewController alloc] init];
    smsComposer.messageComposeDelegate = self;
    smsComposer.body = mStringForText;
    NSLog(@"%@",mStringForText);
    smsComposer.recipients = [NSArray arrayWithObjects:@"9212273322",@"9900112266", nil];
    return smsComposer;
    
}


//MFMessageComposeViewController *controller =
//[[[MFMessageComposeViewController alloc] init] autorelease];
//
//if([MFMessageComposeViewController canSendText])
//{
//    NSString *str= @"Hello";
//    controller.body = str;
//    controller.recipients = [NSArray arrayWithObjects:
//                             @"", nil];
//    controller.delegate = self;
//    [self presentModalViewController:controller animated:YES];
//}
+ (MailClassViewController *)sharedInstance
{
	@synchronized(self) {
		if (sharedInstance == nil) {
			sharedInstance = [[self alloc] init];
		}
	}
	return sharedInstance;
}

-(UINavigationController *)showComposerSheet
{
    mailComposer=[[MFMailComposeViewController alloc] init];
    
    mailComposer.mailComposeDelegate=self;
    NSArray *toRecipient=[NSArray arrayWithObject:@"contactus@sheelafoam.com"];
//    NSArray *ccRecipient=[NSArray arrayWithObjects:@"export@sheelafoam.com", nil];
    
    [mailComposer setToRecipients:toRecipient];
//    [mailComposer setCcRecipients:ccRecipient];
    
    [mailComposer setSubject:@"Sheela Foam Pvt. Ltd."];
    NSString *emailBody = mStringForUrl;
    emailBody = [emailBody stringByAppendingString:@"\n"];
    emailBody = [emailBody stringByAppendingString:@"\n"];
    mStringForText = [mStringForText stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    emailBody = [emailBody stringByAppendingString:[NSString stringWithFormat:@"\"%@\"", mStringForText]];
    // [NSString stringWithFormat:@"http://www.abc.com?userID=\"%@\"", myID]];
    emailBody = [emailBody stringByAppendingString:@"\n"];
    emailBody = [emailBody stringByAppendingString:@"\n"];
    
    emailBody = [emailBody stringByAppendingString:[NSString stringWithFormat:@"@Sheela Foam Pvt. Ltd."]];
    [mailComposer setMessageBody:emailBody isHTML:NO];
    return mailComposer;
    
}

#pragma MFMessageComposeViewController Delegate
// Notifies users about errors associated with the interface

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
   [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma MFMailComposeViewController Delegate
 // Notifies users about errors associated with the interface

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
+ (BOOL)canSendMail __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)
{
    return YES;
}

- (MailClassViewController *)init
{
    if ((self = [super init]))
    {
        
        // get bundle id from plist
        self.applicationBundleID = [[NSBundle mainBundle] bundleIdentifier];
        
        // get country
        self.appStoreCountry = [(NSLocale *)[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
        
        // application version (use short version preferentially)
        self.applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        if ([applicationVersion length] == 0)
        {
            self.applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
        }
        
        
        [self performSelectorOnMainThread:@selector(applicationLaunched) withObject:nil waitUntilDone:NO];
        
    }
    return self;
}

+ (id)getRootViewController {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    
    return [[[window subviews] objectAtIndex:0] nextResponder];
}

- (void)applicationLaunched
{
    // app key used to cache the app data
    if (self.appStoreID)
    {
        self.applicationKey = [NSString stringWithFormat:@"%lu-%@", (unsigned long)self.appStoreID, self.applicationVersion];
    }
    else
    {
        self.applicationKey = [NSString stringWithFormat:@"%@-%@", self.applicationBundleID, self.applicationVersion];
    }
    
    // load the settings info from the app NSUserDefaults, to avoid  http requests
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:iTellAFriendAppKey] isEqualToString:applicationKey]) {
        self.applicationName = [defaults objectForKey:iTellAFriendAppNameKey];
        self.applicationGenreName = [defaults objectForKey:iTellAFriendAppGenreNameKey];
        self.appStoreIconImage = [defaults objectForKey:iTellAFriendAppStoreIconImageKey];
        self.applicationSellerName = [defaults objectForKey:iTellAFriendAppSellerNameKey];
        
        if (!self.appStoreID) {
            self.appStoreID = [[defaults objectForKey:iTellAFriendAppIdKey] integerValue];
        }
    }
    
    // get the application name from the bundle
    if (self.applicationName==nil) {
        self.applicationName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    }
    
    
    // check if this is a new version
    if (![[defaults objectForKey:iTellAFriendAppKey] isEqualToString:applicationKey]) {
        [self promptIfNetworkAvailable];
    }
    
}
- (void)giftThisApp
{
 
    NSString *lString = @"http://www.google.com/#q=";
  //  NSString *string = mLavelForData.text;
   // ////// // // // // NSLog(@"%@",string);

    //NSString *test = [lString stringByAppendingString:[MailClassViewController sharedInstance].mLavelForData];
        
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithString:lString]]];
    
}
- (void)userManialThisAppWithAlertView:(BOOL)alertView
{
    if (alertView==YES) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"SubCommune", @"") message:[NSString stringWithFormat:NSLocalizedString(@"You really enjoy using %@. Your family and friends will love you", @""), self.applicationName] delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:NSLocalizedString(@"Ok", @""), nil];
        alertView.tag = 1;
        [alertView show];
        
    } else {
        [self giftThisApp];
    }
}

- (NSString *)messageTitle
{
    if (messageTitle)
    {
        return messageTitle;
    }
    return [NSString stringWithFormat:@"Check out %@", applicationName];
}

- (NSString *)message
{
    if (message) {
        return message;
    }
    return @"Check out this application on the App Store:";
}

- (NSURL *)appStoreURL
{
    if (appStoreURL)
    {
        return appStoreURL;
    }
    
    return [NSURL URLWithString:[NSString stringWithFormat:iTellAFriendiOSAppStoreURLFormat, @"app", (unsigned long)appStoreID]];
}
- (void)checkForConnectivityInBackground
{
    @synchronized (self)
    {
        NSString *iTunesServiceURL = [NSString stringWithFormat:iTellAFriendAppLookupURLFormat, appStoreCountry];
        
        if (self.appStoreID)
        {
            iTunesServiceURL = [iTunesServiceURL stringByAppendingFormat:@"?id=%u", (unsigned int)self.appStoreID];
        }
        else
        {
            iTunesServiceURL = [iTunesServiceURL stringByAppendingFormat:@"?bundleId=%@", self.applicationBundleID];
        }
        
        ITELLLog(@"Requesting info from iTunes Service %@", iTunesServiceURL);
        
        NSError *error = nil;
        NSURLResponse *response = nil;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:iTunesServiceURL] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:REQUEST_TIMEOUT];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (data)
        {
            
            // convert to string
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (json!=nil && error==nil) {
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                NSArray* results = [json objectForKey:@"results"];
                
                if (results==nil || [results count]==0) {
                    ITELLLog(@"Unable to find apple id %@", self.applicationKey);
                    
                    return;
                }
                
                NSDictionary* result = [results objectAtIndex:0];
                
                if (result!=nil) {
                    
                    NSString *trackId = [result valueForKey:@"trackId"];
                    NSString *genreName = [result valueForKey:@"primaryGenreName"];
                    NSString *iconImage = [result valueForKey:@"artworkUrl100"];
                    NSString *appName = [result valueForKey:@"trackName"];
                    NSString *sellerName = [result valueForKey:@"sellerName"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        // get app id
                        if (!self.appStoreID) {
                            if (trackId!=nil) {
                                NSUInteger appStoreId = [trackId integerValue];
                                self.appStoreID = appStoreId;
                                [defaults setObject:[NSNumber numberWithInteger:appStoreId] forKey:iTellAFriendAppIdKey];
                            }
                        }
                        
                        // get genre
                        if (!applicationGenreName) {
                            if (genreName!=nil) {
                                self.applicationGenreName = genreName;
                                [defaults setObject:genreName forKey:iTellAFriendAppGenreNameKey];
                            }
                        }
                        
                        if (!appStoreIconImage) {
                            if (iconImage!=nil) {
                                self.appStoreIconImage = iconImage;
                                [defaults setObject:iconImage forKey:iTellAFriendAppStoreIconImageKey];
                            }
                        }
                        
                        if (!applicationName) {
                            if (appName!=nil) {
                                self.applicationName = appName;
                                [defaults setObject:appName forKey:iTellAFriendAppNameKey];
                            }
                        }
                        
                        if (!applicationSellerName) {
                            if (sellerName!=nil) {
                                self.applicationSellerName = sellerName;
                                [defaults setObject:sellerName forKey:iTellAFriendAppSellerNameKey];
                            }
                        }
                    });
                    
                    [defaults setObject:applicationKey forKey:iTellAFriendAppKey];
                    ITELLLog(@"Loaded apple id information %@", self.applicationKey);
                }
                
            } else {
                ITELLLog(@"Unable to find apple id %@", self.applicationKey);
            }
        }
    }
}


#pragma MARK Convert HTML data Conversion

+(NSString *)convertHTML:(NSString *)html {
    
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        [myScanner scanUpToString:@">" intoString:&text] ;
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return html;
}


+ (BOOL) verifyPasswordWithPassword :(NSString *)pass1 andPassword :(NSString *)pass2 {
    
    return [pass1 isEqualToString:pass2]?YES:NO;
}

+(BOOL) validUsername:(NSString*)candidatename {
    
    NSString *emailRegex = @"[a-zA-Z0-9@.\\-_]{3,}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    return [emailTest evaluateWithObject:candidatename];
}

+ (BOOL)validateMobile:(NSString *)mobileNumber {
    
    NSString *mobileNumberPattern = @"[123456789][0-9]{9}";
    NSPredicate *mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];
    
    return [mobileNumberPred evaluateWithObject:mobileNumber];
//    BOOL matched = [mobileNumberPred evaluateWithObject:mobileNumber];
}

+ (BOOL)validatePassword:(NSString *)oldPassword andNewPassword:(NSString *)newPassword {
    
    return ([oldPassword isEqualToString:newPassword]) ? YES : NO;
}



+(BOOL) validateEmail:(NSString *) emailId {
    
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailId];
}

+ (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    double ratio;
    double delta;
    CGPoint offset;
    
    //make a new square size, that is the resized imaged width
    CGSize sz = CGSizeMake(newSize.width, newSize.width);
    
    //figure out if the picture is landscape or portrait, then
    //calculate scale factor and offset
    if (image.size.width > image.size.height)
    {
        ratio = newSize.width / image.size.width;
        delta = (ratio*image.size.width - ratio*image.size.height);
        offset = CGPointMake(delta/2, 0);
    }
    else
    {
        ratio = newSize.width / image.size.height;
        delta = (ratio*image.size.height - ratio*image.size.width);
        offset = CGPointMake(0, delta/2);
    }
    
    //make the final clipping rect based on the calculated values
    CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                 (ratio * image.size.width) + delta,
                                 (ratio * image.size.height) + delta);
    
    
    //start a new context, with scale factor 0.0 so retina displays get
    //high quality image
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    {
        UIGraphicsBeginImageContextWithOptions(sz, YES, 0.0);
    }
    else
    {
        UIGraphicsBeginImageContext(sz);
    }
    UIRectClip(clipRect);
    [image drawInRect:clipRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


+(void) showAlertForNetwork {
    
   NSString *title = @"Connection.!!!";
    NSString *message = @"Internet Connection is not Available";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

+ (NSData *)validateImageSize:(NSData *)data {
    
//    if(data.length/1024 > 500) {
    
        long int imageSizeInKB = data.length/1024*1024;//Size in kb
        
        long int scaleFactor = imageSizeInKB/500; //How much scling is required. If image is of 1024 kB and required in 512kb then scaling required is 512/1024=0.5.
        
        data = UIImageJPEGRepresentation([UIImage imageWithData:data], 1.0/scaleFactor);
//    }
    // NSLog(@"Image Size: %f KB",roundf(data.length/1024));
    return data;
}

+(void) showAlertViewWithTitleAndBtn:(NSString *) title message:(NSString *) message delegate:(id) delegate tag :(NSInteger) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: title message: message delegate: delegate cancelButtonTitle: @"CANCEL" otherButtonTitles: @"OK", nil];
    alertView.tag = tag;
    [alertView show];
}

+(void) showAlertViewWithTitleForReminderMe:(NSString *) title message:(NSString *) message delegate:(id) delegate tag :(NSInteger) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: title message: message delegate: delegate cancelButtonTitle: @"OK" otherButtonTitles: @"Remind me later", nil];
    alertView.tag = tag;
    [alertView show];
}

+(void) showAlertViewWithTitleAndBtn1:(NSString *) title message:(NSString *) message delegate:(id) delegate tag :(NSInteger) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: title message: message delegate: delegate cancelButtonTitle: @"Continue" otherButtonTitles: @"Update", nil];
    alertView.tag = tag;
    [alertView show];
}

+(void) showAlertViewWithDetail:(NSString *) title message:(NSString *) message delegate:(id) delegate tag :(NSInteger) tag {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: title message: message delegate: delegate cancelButtonTitle: @"Cancel" otherButtonTitles: @"DETAIL", @"DELETE", nil];
    alertView.tag = tag;
    [alertView show];
}

+(void) showAlertViewWithTitle:(NSString *) title message:(NSString *) message delegate:(id) delegate tag :(NSInteger) tag
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:tag];
        [alert show];
    });
}

+(void) showAlertViewWithRefreshTitle:(NSString *) title message:(NSString *) message delegate:(id) delegate tag :(NSInteger) tag
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"Refresh" otherButtonTitles: nil];
    [alert setTag:tag];
    [alert show];
}

+(NSString *) mRemoveSpecialCharacter:(NSString *) string {
    
     string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
     string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    return string;
}

# pragma MARK % Conversion of Real price and Discounted Price

+(NSString *)covertPrice :(NSString *)discountPrice withRealPrice:(NSString *)realPrice {
    
    float realDisPrice = [discountPrice floatValue] *100 / [realPrice floatValue];
    
    int roundedDown = floor(realDisPrice);
    roundedDown = 100 - roundedDown;
    
    return [NSString stringWithFormat:@"%d%% off",roundedDown];
}

# pragma MARK % Conversion of Real price and Discounted Price

+(NSString *)covertPriceOFF :(NSString *)discountPrice withRealPrice:(NSString *)realPrice {
    
    float realDisPrice = [discountPrice floatValue] *100 / [realPrice floatValue];
    
    int roundedDown = floor(realDisPrice);
    roundedDown = 100 - roundedDown;
    
    return [NSString stringWithFormat:@"%d%% OFF",roundedDown];
}


+(NSString *)covertPriceOff :(NSString *)discountPrice withRealPrice:(NSString *)realPrice {
    
    float realDisPrice = [discountPrice floatValue] *100 / [realPrice floatValue];
    
    int roundedDown = floor(realDisPrice);
    roundedDown = 100 - roundedDown;
    
    return [NSString stringWithFormat:@"%d%%",roundedDown];
}


#pragma MARK Setting Color

+(NSMutableAttributedString *)strikeOut :(NSString *)strFor {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:strFor];
    // making text property to strike text- NSStrikethroughStyleAttributeName
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [attributedString length])];
    return attributedString;
}

#pragma MARK Setting Color

+(NSMutableAttributedString *)setStarColor :(NSString *)strFor {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]  initWithString:strFor];
    [attributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0,3)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f] range:NSMakeRange([strFor length] - 1,1)];
    return attributedString;
}

+(NSMutableAttributedString *)setMandColor :(NSString *)strFor {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]  initWithString:strFor];
    [attributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0,3)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f] range:NSMakeRange(0,1)];
    return attributedString;
}


+(NSMutableAttributedString *)setColor :(NSString *)strFor {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]  initWithString:strFor];
    [attributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0,3)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f] range:NSMakeRange([strFor length] - 1,1)];
    return attributedString;
}

+(NSMutableAttributedString *)setColor :(NSString *)strFor andLengthWith :(int)length andContentLenght :(int)toLength andColor :(UIColor *)txtColor {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]  initWithString:strFor];
    [attributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0,3)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:txtColor range:NSMakeRange(length,toLength)];
    return attributedString;
}

#pragma MARK for UnderLine Text

+(NSMutableAttributedString *)setUnderLineOfText :(NSString *)strFor {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:strFor];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [attributedString length])];
    return attributedString;
}

#pragma MARK for Plane Text

+(NSMutableAttributedString *)setPlaneOfText :(NSString *)strFor {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:strFor];
    return attributedString;
}


+(BOOL)checkNull:(NSString*)txt {
    
    if ([txt isEqual: [NSNull null]]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)promptIfNetworkAvailable
{
    [self performSelectorInBackground:@selector(checkForConnectivityInBackground) withObject:nil];
}

+ (void)addTransitionEffect:(NSString*)type withSubType:(NSString*)subType forView:(UIView*)theView {
    
    CATransition *animation = [CATransition animation];
    [animation setDelegate:nil];
    [animation setType:type];
    [animation setDuration:0.3];
    [animation setSubtype:subType];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[theView layer] addAnimation:animation forKey:@"fadeViewAnimation"];
}

#pragma Methods for compressssss the image

+(UIImage*)compressImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize
{
	// Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
	
    // Tell the old image to draw in this new context, with the desired
    // new size
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	
    // End the context
    UIGraphicsEndImageContext();
	
    // Return the new image.
    return newImage;
	
}

#pragma mark- EmailValidate
+(BOOL)emailValidate:(NSString *)email
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    return [regExPredicate evaluateWithObject:email];
}


#pragma mark- Create Document Folder
+(BOOL)createDirectives:(NSString *)folderName  //Fodler name is PACKAGE ID...
{
    BOOL exist = [MailClassViewController fileExistAtPath:[MailClassViewController craeteFolderAtPath:folderName]];
    if(!exist)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:[MailClassViewController craeteFolderAtPath:folderName] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return exist;
}

#pragma mark- Delete Document Folder
+(BOOL)deleteDirectives:(NSString *)folderName  //Fodler name is PACKAGE ID
{
    BOOL exist = [MailClassViewController fileExistAtPath:[MailClassViewController craeteFolderAtPath:folderName]];
    if(exist)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:[MailClassViewController craeteFolderAtPath:folderName] error:nil];
    }
    return exist;
}

+(NSString *)craeteFolderAtPath:(NSString *)folderName   //Fodler name is PACKAGE ID
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory,NSUserDomainMask, YES);
	NSString *docs = [paths objectAtIndex:0];
    return [docs stringByAppendingFormat:@"/%@/",folderName]; //[docs stringByAppendingFormat:@"/Ins_%@/",folderName]
}

+(BOOL)fileExistAtPath:(NSString *)folderName
{
    return [[NSFileManager defaultManager] fileExistsAtPath:folderName];
}
//save package ID

-(NSString *)getConsultantID
{
    _strPackageID=[[NSUserDefaults standardUserDefaults] valueForKey:@"CID"];
    return _strPackageID;
}

-(void)setConsultantID:(NSString *)ID
{
    [[NSUserDefaults standardUserDefaults] setValue:ID forKey:@"CID"];
    _strPackageID = [[NSString alloc]initWithString:ID];
}

//save Email ID

-(NSString *)getEmailID
{
    return _strEmailID;
}

-(void)setEmailID:(NSString *)ID
{
    _strEmailID = [[NSString alloc]initWithString:ID];
}

//set shceduler array

-(void)setSchedulerArr:(NSMutableArray *)token
{
    schedulerArr = [[NSMutableArray alloc]initWithArray:token];
}

-(NSMutableArray *)getSchedulerArr
{
    return schedulerArr;
}

// save header title
-(NSString *)getHeadertitleName
{
    return _strTitle;
}
-(void)setHeadertitleName:(NSString *)ID;
{
    _strTitle = [[NSString alloc]initWithString:ID];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(NSString *)getCurrentDate :(NSString *)dateStr {
    
    NSArray *arr = [dateStr componentsSeparatedByString:@"-"];
    NSArray *array = [[NSArray alloc] initWithObjects:@"",@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
    int month = [[arr objectAtIndex:1] intValue];
    
   return [NSString stringWithFormat:@"%@ %@ %@",[arr objectAtIndex:0],[array objectAtIndex:month],[arr objectAtIndex:2]];
}

+(BOOL) canDevicePlaceAPhoneCall {
    
    BOOL canCall;
    // Check if the device can place a phone call
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]) {
        // Device supports phone calls, lets confirm it can place one right now
        CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
        CTCarrier *carrier = [netInfo subscriberCellularProvider];
        NSString *mnc = [carrier mobileNetworkCode];
        if (([mnc length] == 0) || ([mnc isEqualToString:@"65535"])) {
            // Device cannot place a call at this time.  SIM might be removed.
            canCall  =  NO;
            [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Device does not support phone calls" delegate:0 tag:0];
        } else {
            // Device can place a phone call
            canCall = YES;
        }
    } else {
        // Device does not support phone calls
        canCall =  NO;
        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Device does not support phone calls" delegate:0 tag:0];
    }
    return canCall;
}

+ (NSString *)formatTimeFromSeconds:(long  long)numberOfSeconds {
    long long  days=numberOfSeconds/(60*60*24);
    long seconds = numberOfSeconds % 60;
    long minutes = (numberOfSeconds / 60) % 60;
    long hours = (numberOfSeconds / 3600)%24;
    if(days>=1)
        return [NSString stringWithFormat:@"%02lldd %ld:%02ld:%02ld",days,hours,minutes,seconds];
    else
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hours,minutes,seconds];
}

#pragma MARK for Showing Toast as Alert Type

+ (UILabel *) toastWithMessage:(NSString *)message AndObj :(id)obj {
    UILabel *title;
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        title = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 382.0f, 300, 44.0f)];
    } else {
        title = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 470.0f, 300, 44.0f)];
    }
    [title setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_place_bid.png"]]];
    [title setTextColor:[UIColor whiteColor]];
    [title setNumberOfLines:2];
    [title setAlpha:0.8f];
    title.layer.borderWidth         = 0.8;
    title.layer.cornerRadius        = 4.0;
    title.layer.masksToBounds       = YES;
    title.layer.borderColor         = Devider_COLOR.CGColor;
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setText:message];
    [title setFont:[UIFont fontWithName:RobotoRegular size:13.0f]];
    [obj addSubview:title];
    int duration = 2; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            title.alpha = 0.0;
            [title removeFromSuperview];
//            [title setHidden:YES];
        }];
    });
    return title;
}

// Assumes input like "#00FF00" (#RRGGBB).
+ (UIColor *)colorFromHexString:(NSString *)hexString {
    if ([hexString length] > 0) {
        unsigned rgbValue = 0;
        NSScanner *scanner = [NSScanner scannerWithString:hexString];
        [scanner setScanLocation:1]; // bypass '#' character
        [scanner scanHexInt:&rgbValue];
        return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:.9f];
    } else {
        return [UIColor clearColor];
    }
}

+(void)openStackFlowUrl :(NSString *)query {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"http://itunes.apple.com/",[query stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]]];
}

+(void)openAppStoreUrl :(NSString *)appStoreId {
        NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@",@"1129401659"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"http://itunes.apple.com/",appStoreId]]];
}

#pragma MARK for Showing Toast as Alert Type

+ (UILabel *) toastWithMessageForServerError:(NSString *)message AndObj :(id)obj andTimeDuration :(int)duration {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 470.0f, 300, 44.0f)];
    [title setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_place_bid.png"]]];
    [title setTextColor:[UIColor whiteColor]];
    [title setNumberOfLines:2];
    [title setAlpha:0.8f];
    title.layer.borderWidth         = 0.8;
    title.layer.cornerRadius        = 4.0;
    title.layer.masksToBounds       = YES;
//    title.layer.borderColor         = Devider_COLOR.CGColor;
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setText:message];
//    [title setFont:[UIFont fontWithName:RobotoRegular size:13.0f]];
    [obj addSubview:title];
//    int duration = 3; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2 animations:^{
            title.alpha = 0.0;
            [title removeFromSuperview];
            //            [title setHidden:YES];
        }];
    });
    return title;
}

+(NSString *)checkStringEmptyForApplicable :(NSString *)str {
    return  (([str length] == 0) || ([str isEqualToString:@"<null>"]) || ([str isEqualToString:@"(null)"])) ? @"NA": [NSString stringWithFormat:@"%@",str];
}



@end
