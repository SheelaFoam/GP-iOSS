//
//  Add.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 15/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"
#import "PhotoCell.h"
#import "DocCell.h"
#import "JVFloatLabeledTextView.h"
#import <CFNetwork/CFNetwork.h>
#import "WhiteRaccoon.h"
#import "ComplaintInfoModel.h"
#import "UserDefaultStorage.h"
#import "MailClassViewController.h"
#import "AFNetworking.h"
#import "historyModel.h"

@interface Add : UIViewController

@property (strong, nonatomic) NSString *complaintID;
@property NSInteger index;


@property (weak, nonatomic) IBOutlet UILabel *complaintIDLbl;
@property (weak, nonatomic) IBOutlet UILabel *shadowLbl;

@property (weak, nonatomic) IBOutlet RadioButton *genuineButton;
@property (weak, nonatomic) IBOutlet RadioButton *inGenuineButton;

@property (weak, nonatomic) IBOutlet UIButton *addImageButton;
@property (weak, nonatomic) IBOutlet UIButton *addDocButton;

@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIView *docView;
@property (weak, nonatomic) IBOutlet UIView *imagePreviewView;

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *docCollectionView;

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextView *remarksTextView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@end
