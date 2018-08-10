//
//  WebViewVC.m
//  Sheela Foam
//
//  Created by SumitJain on 16/08/17.
//  Copyright © 2017 Supraits. All rights reserved.
//

#import "WebViewVC.h"
#import "UploadImage.h"
#import <Photos/Photos.h>
#import "SVProgressHUD.h"
#import "MailClassViewController.h"

@interface WebViewVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIWebViewDelegate> {
    
    UIImage *clickedImage;
}

@end

@implementation WebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.uploadFlag == true) {
        
        [self.imageUploadBtnObj setHidden:false];
    } else {
        [self.imageUploadBtnObj setHidden:true];
    }
    
    self.imagePreviewView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    self.shadowLbl.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [self.imagePreviewView layer].cornerRadius = 10.0;
    self.shadowLbl.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowLbl.layer.shadowRadius = 10.0;
    self.shadowLbl.layer.shadowOpacity = 1.0;
    self.shadowLbl.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.shadowLbl.layer.masksToBounds = false;
    
    [_webview setScalesPageToFit:true];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    
    if (_lowSpeed) {
        [MailClassViewController showAlertViewWithTitle:@"Great Plus" message:@"Network speed is slow, this page might take a bit more time to load." delegate:nil tag:0];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonTapped:(id)sender {
    [SVProgressHUD dismiss];
    if (_webview.canGoBack) {
        [_webview goBack];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)imageUploadButton:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:@"test.png"];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
    
    clickedImage = image;
    [picker dismissViewControllerAnimated:true completion:nil];
    [_previewImageView setImage:image];
    [self openPopupPunchInView:self.imagePreviewView shadowLabel:self.shadowLbl];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (IBAction)takePhotoAgain:(id)sender {
    
    [self closePopupPunchInView:self.imagePreviewView shadowLabel:self.shadowLbl];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:true completion:nil];
}

- (IBAction)selectClickedPhoto:(id)sender {
    
    [self closePopupPunchInView:self.imagePreviewView shadowLabel:self.shadowLbl];
    UIStoryboard *storyboarb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UploadImage *vc = (UploadImage *)[storyboarb instantiateViewControllerWithIdentifier:@"UploadImage"];
    vc.selectedImage = clickedImage;
    [self presentViewController:vc animated:true completion:nil];
}

-(void) closePopupPunchInView: (UIView *) view shadowLabel: (UILabel *) label {
    [UIView animateWithDuration:0.3/1.5 animations:^{
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
            label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        }];
    }];
}

-(void) openPopupPunchInView: (UIView *) view shadowLabel: (UILabel *) label {
    [UIView animateWithDuration:0.3/1.5 animations:^{
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                view.transform = CGAffineTransformIdentity;
                label.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

@end
