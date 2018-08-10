//
//  UploadImage.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 12/04/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "UploadImage.h"
#import "historyModel.h"
#import "SVProgressHUD.h"
#import "MyCustomClass.h"
#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface UploadImage() <NSURLSessionDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    
    NSDictionary *responseDictionary;
    NSDictionary *photoResponse;
    NSMutableArray *empArray;
    NSMutableArray *storeArray;
    
    NSMutableArray *pickerDataSource;
    
    NSString *selectedEmp;
    NSString *selectedStore;
    
    bool empSelection;
    bool storeSelection;
    
    NSInteger storeIndex;
    
    NSMutableDictionary* parameters;
    
    NSString* path;
}

@end

@implementation UploadImage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self setupReasonPicker];
    
    [_imgView setImage:_selectedImage];
    
    empArray = [[NSMutableArray alloc] init];
    storeArray = [[NSMutableArray alloc] init];
    
    parameters = [[NSMutableDictionary alloc] init];
    
    NSData *imgData = UIImageJPEGRepresentation(_selectedImage, 0.5);
    
    [parameters setValue:imgData forKey:@"file"];
    [parameters setValue:[historyModel sharedhistoryModel].uid forKey:@"employeeId"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    path = [documentsDirectory stringByAppendingPathComponent:
                      @"test.png" ];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_empNameBtn setUserInteractionEnabled:false];
            [_storeBtn setUserInteractionEnabled:false];
            [_uploadImgBtn setUserInteractionEnabled:false];
        });
        
        [self getEmployeeAndStoreDetails:^{
            for (int i = 0; i <= [responseDictionary[@"data"] count]-1; i++) {
                NSString *tempStr = [responseDictionary[@"data"][i] valueForKey:@"eMP_NAME"];
                [empArray addObject:tempStr];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_empNameBtn setUserInteractionEnabled:true];
                [_storeBtn setUserInteractionEnabled:true];
                [_uploadImgBtn setUserInteractionEnabled:true];
                [SVProgressHUD dismiss];
            });
        }];
    });
}

-(void)setupReasonPicker {
    
    [_pickerView setAlpha:0.0];
    [_shadowLbl setAlpha:0.0];
    
    [_pickerView layer].cornerRadius = 5.0;
    
    [_shadowLbl layer].shadowColor = UIColor.blackColor.CGColor;
    [_shadowLbl layer].shadowOpacity = 1.0;
    [_shadowLbl layer].shadowRadius = 5.0;
    [_shadowLbl layer].masksToBounds = false;
    [_shadowLbl layer].shadowOffset = CGSizeMake(0.0, 1.0);
}

-(void)setupView {
    
    [self.empNameBtn layer].borderWidth = 1.0;
    [self.empNameBtn layer].borderColor = UIColor.blueColor.CGColor;
    [self.empNameBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    
    [self.storeBtn layer].borderWidth = 1.0;
    [self.storeBtn layer].borderColor = UIColor.blueColor.CGColor;
    [self.storeBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    
    [self.uploadImgBtn layer].borderWidth = 3.0;
    [self.uploadImgBtn layer].borderColor = UIColor.whiteColor.CGColor;
    [self.uploadImgBtn layer].cornerRadius = 5.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerDataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return pickerDataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (empSelection == true) {
        
        selectedEmp = empArray[row];
        storeIndex = row;
    } else {
        selectedStore = storeArray[row];
    }
}

- (IBAction)selectEmpName:(id)sender {
    
    pickerDataSource = empArray;
    [_picker reloadAllComponents];
    empSelection = true;
    self.empSelected = true;
    [UIView animateWithDuration:0.25 animations:^{
        [_pickerView setAlpha:1.0];
        [_shadowLbl setAlpha:1.0];
    }];
}

- (IBAction)selectStore:(id)sender {
    
    if (self.empSelected == true) {
        storeSelection = true;
        for (int i = 0; i <= [responseDictionary[@"data"][storeIndex][@"storeList"] count]-1; i++) {
            NSString *tempStr = [responseDictionary[@"data"][storeIndex][@"storeList"][i] valueForKey:@"pARENT_CHANNEL_PARTNER_NAME"];
            [storeArray addObject:tempStr];
        }
        pickerDataSource = storeArray;
        [_picker reloadAllComponents];
        [UIView animateWithDuration:0.25 animations:^{
            [_pickerView setAlpha:1.0];
            [_shadowLbl setAlpha:1.0];
        }];
    } else {
        
    }
}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)selectionDone:(id)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        [_pickerView setAlpha:0.0];
        [_shadowLbl setAlpha:0.0];
    }];
    if (empSelection == true) {
        empSelection = false;
        if (!selectedEmp.length) {
            selectedEmp = [empArray firstObject];
        }
        [_empNameBtn setTitle:[NSString stringWithFormat:@" %@", selectedEmp] forState:UIControlStateNormal];
    } else {
        storeSelection = false;
        if (!selectedStore.length) {
            selectedStore = [storeArray firstObject];
        }
        [_storeBtn setTitle:[NSString stringWithFormat:@" %@", selectedStore] forState:UIControlStateNormal];
    }
}

- (IBAction)uploadImage:(id)sender {
    
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_empNameBtn setUserInteractionEnabled:false];
        [_storeBtn setUserInteractionEnabled:false];
        [_uploadImgBtn setUserInteractionEnabled:false];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [self imgUpload:@"tempImg" completionHandler:^{
            
            bool success = photoResponse[@"success"];
            if (success == true) {

                NSString *message = photoResponse[@"message"];
                UIAlertController *alert = [[UIAlertController alloc] init];
                alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:true completion:nil];
                }]];
                [self presentViewController:alert animated:true completion:nil];

                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [_empNameBtn setUserInteractionEnabled:true];
                    [_storeBtn setUserInteractionEnabled:true];
                    [_uploadImgBtn setUserInteractionEnabled:true];
                });
            } else {

                UIAlertController *alert = [[UIAlertController alloc] init];
                alert = [UIAlertController alertControllerWithTitle:nil message:@"Bad Request, please try again." preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:true completion:nil];
            }
        }];

    });
}

// **************** HTTP Methods ****************

-(void) getEmployeeAndStoreDetails: (void (^)(void))completion {
    
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://be.greatplus.com/sheelafoam/rest/employees/details/%@/%@",[historyModel sharedhistoryModel].uid, [historyModel sharedhistoryModel].token]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSURLSession *session = [[NSURLSession alloc] init];
    session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration delegate:self delegateQueue:nil];
    
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200) {
            NSError *parseError = nil;
            responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            completion();
        } else {
            UIAlertController *alert = [[UIAlertController alloc] init];
            alert = [UIAlertController alertControllerWithTitle:nil message:@"Bad Request" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:true completion:nil];
        }
    }];
    [task resume];
}

-(void) imgUpload: (NSString *)imageName completionHandler: (void (^)(void))completion {
    
    NSString *baseURL = @"http://be.greatplus.com/sheelafoam/rest/";
    NSString *imageUpload = [NSString stringWithFormat:@"%@file/upload/%@/%@/%@", baseURL, [historyModel sharedhistoryModel].uid, [historyModel sharedhistoryModel].token, selectedStore];
    imageUpload = [imageUpload stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:imageUpload parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:path] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                          photoResponse = responseObject;
                          completion();
                      }
                  }];
    
    [uploadTask resume];
}

- (NSString *)generateBoundaryString {
    return [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];
}

@end
