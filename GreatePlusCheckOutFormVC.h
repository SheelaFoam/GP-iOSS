//
//  GreatePlusCheckOutFormVC.h
//  GreatPlus
//
//  Created by Apple on 11/01/17.
//  Copyright © 2017 Charle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWebServiceHelper.h"


@interface GreatePlusCheckOutFormVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,WebServiceResponseProtocal>
@property (weak, nonatomic) IBOutlet UIScrollView *CheckoutFormSV;
@property (weak, nonatomic) IBOutlet UIView *CustomerVW;
@property (weak, nonatomic) IBOutlet UITextField *CustNameTXT;
@property (weak, nonatomic) IBOutlet UITextField *CustEmailTXT;
@property (weak, nonatomic) IBOutlet UITextField *CustContactTXT;
@property (weak, nonatomic) IBOutlet UITextField *CustStateTXT;
@property (weak, nonatomic) IBOutlet UITextField *CustPincodeTXT;
@property (weak, nonatomic) IBOutlet UITextField *CustCityTXT;
@property (weak, nonatomic) IBOutlet UITextView *CustAddressTXTW;

@property (strong, nonatomic) IBOutlet UIView *ProductHeaderVW;
@property (weak, nonatomic) IBOutlet UIView *ProductVW;
@property (weak, nonatomic) IBOutlet UITableView *ProductTV;
@property (weak, nonatomic) IBOutlet UIView *InvoiceVW;
@property (weak, nonatomic) IBOutlet UITextField *serialNumTxt;
@property (weak, nonatomic) IBOutlet UITableView *InvoiceTV;
@property (strong, nonatomic) IBOutlet UIView *InvoiceHW;
@property (strong, nonatomic) IBOutlet UIView *InvoiceFW;
@property (strong, nonatomic) IBOutlet UIView *payView;
@property (weak, nonatomic) IBOutlet UITextField *paymentPayTxt;

- (IBAction)addProductBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *inviceIDLab;

@property (weak, nonatomic) IBOutlet UILabel *noItemLAB;

- (IBAction)payByCard:(id)sender;
- (IBAction)CityPickerBTN:(id)sender;
- (IBAction)StatePickerBTN:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *CityPickerBTN;
@property (weak, nonatomic) IBOutlet UIButton *StatePickerBTN;
@property (weak, nonatomic) IBOutlet UILabel *AddressLAB;
@property (weak, nonatomic) IBOutlet UIButton *PayLinkToCustomerAction;
- (IBAction)PayLinkToCustomerAction:(id)sender;

@end
