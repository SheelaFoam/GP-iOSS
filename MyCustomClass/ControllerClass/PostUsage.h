//
//  PostUsage.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 12/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostUsage : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *snoTextField;
@property (weak, nonatomic) IBOutlet UITextField *bundleNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *invoiceNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *customerNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *customerMobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *customerEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *customerAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *lengthTextField;
@property (weak, nonatomic) IBOutlet UITextField *widthTextField;
@property (weak, nonatomic) IBOutlet UITextField *thickTextField;
@property (weak, nonatomic) IBOutlet UITextField *serialNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *purchaseDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *existingTextField;
@property (weak, nonatomic) IBOutlet UITextField *purchasedTextField;
@property (weak, nonatomic) IBOutlet UITextField *pinCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *dealerNameButton;
@property (weak, nonatomic) IBOutlet UIButton *productNameButton;
@property (weak, nonatomic) IBOutlet UIButton *stateButton;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UIButton *complaintTypeButton;
@end
