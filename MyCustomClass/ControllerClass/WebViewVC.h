//
//  WebViewVC.h
//  Sheela Foam
//
//  Created by SumitJain on 16/08/17.
//  Copyright © 2017 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewVC : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)imageUploadButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *imageUploadBtnObj;

@property (assign) BOOL uploadFlag;
@property (assign) BOOL lowSpeed;

@property (weak, nonatomic) IBOutlet UIView *imagePreviewView;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@property (weak, nonatomic) IBOutlet UILabel *shadowLbl;
- (IBAction)takePhotoAgain:(id)sender;
- (IBAction)selectClickedPhoto:(id)sender;

@end
