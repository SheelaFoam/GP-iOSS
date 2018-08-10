//
//  PerformanceWebview.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 30/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface PerformanceWebview : UIViewController

@property (strong, nonatomic) NSString *imageStr;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end
