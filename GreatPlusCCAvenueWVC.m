//
//  GreatPlusCCAvenueWVC.m
//  GreatPlus
//
//  Created by Apple on 30/01/17.
//  Copyright © 2017 Charle. All rights reserved.
//

#import "GreatPlusCCAvenueWVC.h"
#import "CCTool.h"
@interface GreatPlusCCAvenueWVC ()
{
    NSString *urlAsString;
}
@end
@implementation GreatPlusCCAvenueWVC
@synthesize rsaKeyUrl;@synthesize accessCode;@synthesize merchantId;@synthesize orderId;
@synthesize amount;@synthesize currency;@synthesize redirectUrl;@synthesize cancelUrl;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewWeb.delegate = self;
    
    //Getting RSA Key
    NSString *rsaKeyDataStr = [NSString stringWithFormat:@"access_code=%@&order_id=%@",accessCode,orderId];
    NSData *requestData = [NSData dataWithBytes: [rsaKeyDataStr UTF8String] length: [rsaKeyDataStr length]];
    NSMutableURLRequest *rsaRequest = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: rsaKeyUrl]];
    [rsaRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [rsaRequest setHTTPMethod: @"POST"];
    [rsaRequest setHTTPBody: requestData];
    NSData *rsaKeyData = [NSURLConnection sendSynchronousRequest: rsaRequest returningResponse: nil error: nil];
    NSString *rsaKey = [[NSString alloc] initWithData:rsaKeyData encoding:NSASCIIStringEncoding];
    rsaKey = [rsaKey stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    rsaKey = [NSString stringWithFormat:@"-----BEGIN PUBLIC KEY-----\n%@\n-----END PUBLIC KEY-----\n",rsaKey];
    NSLog(@"%@",rsaKey);
    
    //Encrypting Card Details
    NSString *myRequestString = [NSString stringWithFormat:@"amount=%@&currency=%@",amount,currency];
    CCTool *ccTool = [[CCTool alloc] init];
    NSString *encVal = [ccTool encryptRSA:myRequestString key:rsaKey];
    encVal = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                   (CFStringRef)encVal,
                                                                                   NULL,
                                                                                   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                   kCFStringEncodingUTF8 ));
        urlAsString = _paymentURL;

    
    //Preparing for a webview call
    //https://test.ccavenue.com/transaction/transaction.do?command=initiateTransaction
    
    // NSString *urlAsString = [NSString stringWithFormat:@"https://test.ccavenue.com/transaction/transaction.do?command=initiateTransaction"];
    
//    NSString *urlAsString = [NSString stringWithFormat:@"https://secure.ccavenue.com/transaction/initTrans"];
   // NSString *encryptedStr = [NSString stringWithFormat:@"merchant_id=%@&order_id=%@&redirect_url=%@&cancel_url=%@&enc_val=%@&access_code=%@&billing_name=amarjeet",merchantId,orderId,redirectUrl,cancelUrl,encVal,accessCode];
    
    [self ResetValue];
        NSString *encryptedStr = [NSString stringWithFormat:@"merchant_id=%@&order_id=%@&redirect_url=%@&cancel_url=%@&enc_val=%@&access_code=%@&billing_name=%@&language=EN&billing_address=%@&billing_city=%@&billing_state=%@&billing_zip=%@&billing_country=%@&billing_tel=%@&billing_email=%@&merchant_param1=%@&merchant_param2=%@&merchant_param3=%@&merchant_param4=%@&sub_account_id=%@",merchantId,orderId,redirectUrl,cancelUrl,encVal,accessCode,_billing_name,self.billing_address,self.billing_city,self.billing_state,self.billing_zip,self.billing_country,self.billing_tel,self.billing_email,self.merchant_param1,self.merchant_param2,self.merchant_param3,self.merchant_param4,self.subAccountID];
    
    NSData *myRequestData = [NSData dataWithBytes: [encryptedStr UTF8String] length: [encryptedStr length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlAsString]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setValue:urlAsString forHTTPHeaderField:@"Referer"];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: myRequestData];
    [_viewWeb loadRequest:request];
    // Do any additional setup after loading the view from its nib.
}
-(void)ResetValue
{

    if (!self.billing_address) {
        self.billing_address=@"";
    }
    if (!self.billing_tel) {
        self.billing_tel=@"";
    }
    if (!self.billing_name) {
        self.billing_name=@"";
    }
    if (!self.billing_city) {
        self.billing_city=@"";
    }
    if (!self.billing_state) {
        self.billing_state=@"";
    }
    if (!self.billing_zip) {
        self.billing_zip=@"";
    }
    if (!self.billing_email) {
        self.billing_email=@"";
    }
    if (!self.merchant_param1) {
        self.merchant_param1=@"";
    }
    if (!self.merchant_param2) {
        self.merchant_param2=@"";
    }
    if (!self.merchant_param3) {
        self.merchant_param3=@"";
    }
    if (!self.merchant_param4) {
        self.merchant_param4=@"";
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *string = webView.request.URL.absoluteString;
    if ([string rangeOfString:@"/ccavResponseHandler.php"].location != NSNotFound) {
       // NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
        
        NSString *Message = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('center')[0].innerHTML;"];
        
//        NSString *transStatus = @"Not Known";
//        
//        if (([html rangeOfString:@"Aborted"].location != NSNotFound) ||
//            ([html rangeOfString:@"Cancel"].location != NSNotFound)) {
//            transStatus = @"Transaction has been declined.";
//        }else if (([html rangeOfString:@"Success"].location != NSNotFound)) {
//            transStatus = @"Transaction Successful";
//        }else if (([html rangeOfString:@"Fail"].location != NSNotFound)) {
//            transStatus = @"Transaction Failed";
//        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:Message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.delegate=self;
        [alert show];

    }
    
   
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    NSString *string = webView.request.URL.absoluteString;
    
    //[self dismissViewControllerAnimated:YES completion:nil];

//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
//    if ([string rangeOfString:@"/initTrans"].location != NSNotFound) {
//        NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
//        
//        NSString *transStatus = @"Not Known";
//        
//        if (([html rangeOfString:@"Aborted"].location != NSNotFound)) {
//            transStatus = @"Transaction Aborted";
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:transStatus delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            alert.delegate=self;
//            [alert show];
//        }else if (([html rangeOfString:@"Fail"].location != NSNotFound)) {
//            transStatus = @"Transaction Failed";
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:transStatus delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            alert.delegate=self;
//            [alert show];
//        }
//        
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
