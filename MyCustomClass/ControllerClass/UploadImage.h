//
//  UploadImage.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 12/04/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadImage : UIViewController

@property (strong, nonatomic) UIImage *selectedImage;
@property (assign) BOOL empSelected;

@property (weak, nonatomic) IBOutlet UIButton *empNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *storeBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadImgBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

- (IBAction)selectEmpName:(id)sender;
- (IBAction)selectStore:(id)sender;
- (IBAction)uploadImage:(id)sender;
- (IBAction)back:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *shadowLbl;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
- (IBAction)selectionDone:(id)sender;

@end
