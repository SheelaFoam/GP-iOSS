//
//  GreatPlusCCAvenueWVC.h
//  GreatPlus
//
//  Created by Apple on 30/01/17.
//  Copyright © 2017 Charle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GreatPlusCCAvenueWVC : UIViewController<UIWebViewDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *viewWeb;
@property (strong, nonatomic) NSString *accessCode;
@property (strong, nonatomic) NSString *merchantId;
@property (strong, nonatomic) NSString *orderId;
@property (strong, nonatomic) NSString *amount;
@property (strong, nonatomic) NSString *currency;
@property (strong, nonatomic) NSString *redirectUrl;
@property (strong, nonatomic) NSString *cancelUrl;
@property (strong, nonatomic) NSString *rsaKeyUrl;
@property (strong, nonatomic) NSString *order_id;
@property (strong, nonatomic) NSString *language;
@property (strong, nonatomic) NSString *billing_name;
@property (strong, nonatomic) NSString *billing_address;
@property (strong, nonatomic) NSString *billing_city;
@property (strong, nonatomic) NSString *billing_state;
@property (strong, nonatomic) NSString *billing_zip;
@property (strong, nonatomic) NSString *billing_country;
@property (strong, nonatomic) NSString *billing_tel;
@property (strong, nonatomic) NSString *billing_email;
@property (strong, nonatomic) NSString *merchant_param1;
@property (strong, nonatomic) NSString *merchant_param2;
@property (strong, nonatomic) NSString *merchant_param3;
@property (strong, nonatomic) NSString *merchant_param4;
@property (strong, nonatomic) NSString *subAccountID;
@property (strong, nonatomic) NSString *paymentURL;













@end
