//
//  GreatPlusUploadDovumentVC.h
//  GreatPlus
//
//  Created by Apple on 08/02/17.
//  Copyright © 2017 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWebServiceHelper.h"


@interface GreatPlusUploadDocumentVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,WebServiceResponseProtocal, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (IBAction)backBtnAct:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageseting;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Activity;

@property (weak, nonatomic) IBOutlet UITableView *uploadDocTAB;
@property (strong, nonatomic) IBOutlet UIView *tableHV;
- (IBAction)uploadNewDocBTN:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *uploadNewDocBTN;
@property (weak, nonatomic) IBOutlet UILabel *totalDocLAB;
- (IBAction)submitDocBTN:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitDocBTN;
- (IBAction)NavigationBTNAct:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *contectPersonTXT;
@property (weak, nonatomic) IBOutlet UIImageView *uploadDocImg;
@property (weak, nonatomic) IBOutlet UITextField *_CustContactTXT;
@property (weak, nonatomic) IBOutlet UITextField *emailTXT;
@property (weak, nonatomic) IBOutlet UITextField *panNoTXT;

@end
