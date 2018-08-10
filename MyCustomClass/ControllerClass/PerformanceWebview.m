//
//  PerformanceWebview.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 30/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "PerformanceWebview.h"

@interface PerformanceWebview() <UIWebViewDelegate>

@end

@implementation PerformanceWebview

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_webview setScalesPageToFit:true];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_imageStr]];
    [_webview loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
