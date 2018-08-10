//
//  Add.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 15/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "Add.h"

@interface Add()<UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, WRRequestDelegate> {
    
    NSMutableArray *photoArray;
    NSMutableArray *docArray;
    
    UIImage *clickedImage;
    UIButton *selectedButton;
    BOOL gallerySelected;
    NSString *typeSelected;
    
    ComplaintInfoModel *complaintModel;
    
    NSMutableArray *complaintData;
    
    NSMutableDictionary *parameters;
    NSString *imgPath;
    
    NSMutableArray *photoNameArray;
    NSMutableArray *docNameArray;
    
    NSMutableArray *photoPathArray;
    NSMutableArray *docPathArray;
}

@end

@implementation Add

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetup];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addImage:(id)sender {
    
    [self showUploadOptions];
    selectedButton = _addImageButton;
}

- (IBAction)addDoc:(id)sender {
    
    [self showUploadOptions];
    selectedButton = _addDocButton;
}

- (IBAction)genuine:(id)sender {
    
    typeSelected = @"genuine";
}

- (IBAction)inGenuine:(id)sender {
    
    typeSelected = @"in-genuine";
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
    if (selectedButton == _addImageButton) {
        [photoArray addObject:clickedImage];
        [photoNameArray addObject:[NSString stringWithFormat:@"IMG-%@-%@", [self getCurrentDate], [self getCurrentTime]]];
        [photoPathArray addObject:imgPath];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_photoCollectionView reloadData];
        });
    } else {
        [docArray addObject:clickedImage];
        [docNameArray addObject:[NSString stringWithFormat:@"DOC-%@-%@", [self getCurrentDate], [self getCurrentTime]]];
        [docPathArray addObject:imgPath];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_docCollectionView reloadData];
        });
    }
}

- (IBAction)save:(id)sender {
    
//    complaintModel = [ComplaintInfoModel saveData:photoArray withdocs:docArray andRemarks:_remarksTextView.text withType:typeSelected];
    
//    [self getData];
    
    [self saveData];
}

- (IBAction)attend:(id)sender {
    
    [SVProgressHUD show];
    if ([MailClassViewController isNetworkConnected]) {
        for (int i = 0; i < photoArray.count; i++) {
            
            [parameters setValue:UIImageJPEGRepresentation(photoArray[i], 0.3) forKey:@"file[]"];
            [self uploadFile:parameters withFileName:photoNameArray[i] andPath:photoPathArray[i] completionHandler:^{
            }];
        }
        
        for (int i = 0 ; i < docArray.count; i++) {
            
            [parameters setValue:UIImageJPEGRepresentation(docArray[i], 0.3) forKey:@"file[]"];
            [self uploadFile:parameters withFileName:docNameArray[i] andPath:docPathArray[i] completionHandler:^{
                if (i == docArray.count - 1) {
                    [self saveData];
                    [self sendData:[self createGETURL:[historyModel sharedhistoryModel].mobileNo withcomplaintID:_complaintID andImgStr:[self createImageString] withRemarks:[self encodeURL:_remarksTextView.text] andType:[self encodeURL:typeSelected]]];
                }
            }];
        }
    } else {
        
        [MailClassViewController showAlertForNetwork];
    }
}

//************ PickerView Delegate Methods ************

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path;
        if (selectedButton == _addImageButton) {
            path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"IMG-%@-%@", [self getCurrentDate], [self getCurrentTime]]];
        } else {
            path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"DOC-%@-%@", [self getCurrentDate], [self getCurrentTime]]];
        }
        NSData* data = UIImageJPEGRepresentation(image, 0.3);
        [data writeToFile:path atomically:YES];
        
        if (gallerySelected) {
            [picker dismissViewControllerAnimated:true completion:nil];
            
            NSURL *imagePath = [editingInfo objectForKey:@"UIImagePickerControllerReferenceURL"];
            NSString *imageName = [imagePath lastPathComponent];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *localFilePath = [documentsDirectory stringByAppendingPathComponent:imageName];

            
            if (selectedButton == _addImageButton) {
                [photoArray addObject:image];
                [photoPathArray addObject:[NSString stringWithFormat:@"%@/IMG-%@-%@", localFilePath,[self getCurrentDate], [self getCurrentTime]]];
                [photoNameArray addObject:[NSString stringWithFormat:@"IMG-%@-%@", [self getCurrentDate], [self getCurrentTime]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_photoCollectionView reloadData];
                });
            } else {
                [docArray addObject:image];
                [docPathArray addObject:[NSString stringWithFormat:@"%@/DOC-%@-%@", localFilePath,[self getCurrentDate], [self getCurrentTime]]];
                [docNameArray addObject:[NSString stringWithFormat:@"DOC-%@-%@", [self getCurrentDate], [self getCurrentTime]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_docCollectionView reloadData];
                });
            }
        } else {
            imgPath = path;
            clickedImage = image;
            [picker dismissViewControllerAnimated:true completion:nil];
            [_previewImageView setImage:image];
            [self openPopupPunchInView:self.imagePreviewView shadowLabel:self.shadowLbl];
        }
    }
}


//************ TableView DataSource/Delegate Methods ************

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == _photoCollectionView) {
        return photoArray.count;
    } else {
        return docArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _photoCollectionView) {
        
        PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
        
        [cell.imgView setImage:photoArray[indexPath.row]];
        
        return cell;
    } else {
        
        DocCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DocCell" forIndexPath:indexPath];
        
        [cell.imgView setImage:docArray[indexPath.row]];
        
        return cell;
    }
}

//************ Custom Methods ************

-(void) initialSetup {
    
    [_complaintIDLbl setText:[NSString stringWithFormat:@"ComplaintID: %@", _complaintID]];
    
    photoArray = [[NSMutableArray alloc] init];
    docArray = [[NSMutableArray alloc] init];
    typeSelected = [[NSString alloc] init];
    complaintData = [[NSMutableArray alloc] init];
    
    photoNameArray = [[NSMutableArray alloc] init];
    docNameArray = [[NSMutableArray alloc] init];
    
    photoPathArray = [[NSMutableArray alloc] init];
    docPathArray = [[NSMutableArray alloc] init];
    
    parameters = [[NSMutableDictionary alloc] init];
    
    [_genuineButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [_inGenuineButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    
    [[_photoView layer] setBorderColor:UIColor.orangeColor.CGColor];
    [[_photoView layer] setBorderWidth:1.0];
    [[_photoView layer] setCornerRadius:3.0];
    
    [[_docView layer] setBorderColor:UIColor.orangeColor.CGColor];
    [[_docView layer] setBorderWidth:1.0];
    [[_docView layer] setCornerRadius:3.0];
    
    [[_remarksTextView layer] setBorderColor:UIColor.orangeColor.CGColor];
    [[_remarksTextView layer] setBorderWidth:1.0];
    [[_remarksTextView layer] setCornerRadius:3.0];
    
    self.imagePreviewView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    self.shadowLbl.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [self.imagePreviewView layer].cornerRadius = 10.0;
    self.shadowLbl.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowLbl.layer.shadowRadius = 10.0;
    self.shadowLbl.layer.shadowOpacity = 1.0;
    self.shadowLbl.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.shadowLbl.layer.masksToBounds = false;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [self checkForData];
}

-(void)dismissKeyboard
{
    [_remarksTextView resignFirstResponder];
}

-(void) showUploadOptions {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select an action" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentViewController:picker animated:true completion:nil];
        gallerySelected = false;
    }];
    UIAlertAction *gallery = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.delegate = self;
        [self presentViewController:pickerController animated:true completion:nil];
        gallerySelected = true;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        gallerySelected = false;
    }];
    
    [alert addAction:camera];
    [alert addAction:gallery];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:true completion:nil];
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

-(void) getData {
    
    complaintModel.context = [complaintModel managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ComplaintDetail"];
    complaintModel.context = [[complaintModel.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSLog(@"%@", complaintModel.complaintData[0]);
}

-(void) uploadFile: (NSMutableDictionary *)parameters withFileName: (NSString *)fileName andPath:(NSString *)filePath completionHandler: (void (^)(void))completion{
    
    NSString *uploadURL = @"http://125.19.46.252/multipartForm.php";
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:uploadURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file[]" fileName:fileName mimeType:@"image/jpeg" error:nil];
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
                          NSLog(@"%@", response);
                          NSLog(@"%@", responseObject);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                      }
                      completion();
                  }];
    
    [uploadTask resume];
}

-(void) sendData: (NSString *)urlStr {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        
                                                        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [SVProgressHUD dismiss];
                                                            [MailClassViewController toastWithMessage:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] AndObj:self.view];
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}

//************ Custom Methods ************

-(NSString *)encodeToBase64String:(UIImage *)image {
    
    return [UIImageJPEGRepresentation(image, 0.3) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

-(NSString *) getCurrentDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

-(NSString *) getCurrentTime {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    return [formatter stringFromDate:now];
}

-(void) saveData {
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    NSMutableArray *tempArray;
    
    tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < photoArray.count; i++) {
        [tempArray addObject:[self encodeToBase64String:photoArray[i]]];
    }
    [temp setValue:tempArray forKey:@"photos"];
    
    tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < photoNameArray.count; i++) {
        [tempArray addObject:photoNameArray[i]];
    }
    [temp setValue:tempArray forKey:@"photoNames"];
    
    tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < photoPathArray.count; i++) {
        [tempArray addObject:photoPathArray[i]];
    }
    [temp setValue:tempArray forKey:@"photoPaths"];
    
    tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < docArray.count; i++) {
        [tempArray addObject:[self encodeToBase64String:docArray[i]]];
    }
    [temp setValue:tempArray forKey:@"docs"];
    
    tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < docNameArray.count; i++) {
        [tempArray addObject:docNameArray[i]];
    }
    [temp setValue:tempArray forKey:@"docNames"];
    
    tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < docPathArray.count; i++) {
        [tempArray addObject:docPathArray[i]];
    }
    [temp setValue:tempArray forKey:@"docPaths"];
    
    [temp setValue:_remarksTextView.text forKey:@"remarks"];
    [temp setValue:typeSelected forKey:@"type"];
    [temp setValue:_complaintID forKey:@"compID"];
    
    [complaintData removeObjectAtIndex:_index];
    [complaintData insertObject:temp atIndex:_index];
    [UserDefaultStorage setComplaintData:complaintData];
    [MailClassViewController toastWithMessage:[NSString stringWithFormat:@"Complaint with complaint ID: %@ has been saved", _complaintID] AndObj:self.view];
}

-(void) saveDataForFutureUpload {
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    NSMutableArray *tempArray;
    
    tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < photoArray.count; i++) {
        [tempArray addObject:[self encodeToBase64String:photoArray[i]]];
    }
    [temp setValue:tempArray forKey:@"photos"];
    
    tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < photoNameArray.count; i++) {
        [tempArray addObject:photoNameArray[i]];
    }
    [temp setValue:tempArray forKey:@"photoNames"];
    
    tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < photoPathArray.count; i++) {
        [tempArray addObject:photoPathArray[i]];
    }
    [temp setValue:tempArray forKey:@"photoPaths"];
    
    tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < docArray.count; i++) {
        [tempArray addObject:[self encodeToBase64String:docArray[i]]];
    }
    [temp setValue:tempArray forKey:@"docs"];
    
    tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < docNameArray.count; i++) {
        [tempArray addObject:docNameArray[i]];
    }
    [temp setValue:tempArray forKey:@"docNames"];
    
    tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < docPathArray.count; i++) {
        [tempArray addObject:docPathArray[i]];
    }
    [temp setValue:tempArray forKey:@"docPaths"];
    
    [temp setValue:_remarksTextView.text forKey:@"remarks"];
    [temp setValue:typeSelected forKey:@"type"];
    [temp setValue:_complaintID forKey:@"compID"];
    
    [complaintData removeObjectAtIndex:_index];
    [complaintData insertObject:temp atIndex:_index];
    [UserDefaultStorage setRemainingData:complaintData];
}

-(void) checkForData {
    
    if ([UserDefaultStorage getComplaintData].count > 0) {
        complaintData = [UserDefaultStorage getComplaintData];
        if (complaintData[_index][@"compID"] == _complaintID) {
            for (int i = 0; i < [complaintData[_index][@"photos"] count]; i++) {
                
                [photoArray addObject:[self decodeBase64ToImage:complaintData[_index][@"photos"][i]]];
            }
            for (int i = 0; i < [complaintData[_index][@"photoNames"] count]; i++) {
                [photoNameArray addObject:complaintData[_index][@"photoNames"][i]];
            }
            for (int i = 0; i < [complaintData[_index][@"photoPaths"] count]; i++) {
                [photoPathArray addObject:complaintData[_index][@"photoPaths"][i]];
            }
            [_photoCollectionView reloadData];
            
            for (int i = 0; i < [complaintData[_index][@"docs"] count]; i++) {
                [docArray addObject:[self decodeBase64ToImage:complaintData[_index][@"docs"][i]]];
            }
            for (int i = 0; i < [complaintData[_index][@"docNames"] count]; i++) {
                [docNameArray addObject:complaintData[_index][@"docNames"][i]];
            }
            for (int i = 0; i < [complaintData[_index][@"docPaths"] count]; i++) {
                [docPathArray addObject:complaintData[_index][@"docPaths"][i]];
            }
            [_docCollectionView reloadData];
            [_remarksTextView setText:complaintData[_index][@"remarks"]];
            if ([complaintData[_index][@"type"] isEqualToString:@"genuine"]) {
                [_genuineButton setSelected:true];
                typeSelected = @"genuine";
            } else {
                [_inGenuineButton setSelected:true];
                typeSelected = @"in-genuine";
            }
        } else {
            [complaintData removeObjectAtIndex:_index];
        }
    }
}

-(NSString *) encodeURL: (NSString *)str {
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF32StringEncoding];
}

-(NSString *) createImageString {
    
    NSMutableString *imgStr;
    imgStr = [[NSMutableString alloc] init];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray addObjectsFromArray:photoNameArray];
    [tempArray addObjectsFromArray:docNameArray];
    for (int i = 0; i < tempArray.count; i++) {
        if ([imgStr isKindOfClass:[NSNull class]] || [imgStr isEqualToString:@""]) {
            [imgStr appendString:[NSString stringWithFormat:@"%@", tempArray[i]]];
        } else {
            [imgStr appendString:[NSString stringWithFormat:@"***%@", tempArray[i]]];
        }
    }
    return imgStr;
}

-(NSString *) createGETURL: (NSString *)mobileNo withcomplaintID: (NSString *)compID andImgStr: (NSString *)imgStr withRemarks: (NSString *)remarks andType: (NSString *)type {
    
    return [NSString stringWithFormat:@"http://125.19.46.252/ws/ComplaintVisitReport.php?MOBILE=%@&ID=%@&IMAGE=%@&REMARK=%@&p_gen_ungen=%@", mobileNo, compID, imgStr, remarks, type];
}

//************ Back Action ************

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}


@end
