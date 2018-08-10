//
//  UnregisterGCardViewController.m
//  Sheela Foam
//
//  Created by Kapil on 1/31/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "UnregisterGCardViewController.h"
#import "GreatPlusSharedPostRequestManager.h"
#import "JsonBuilder.h"
#import "GreatPlusSharedHeader.h"
#import "POAcvityView.h"
#import "MailClassViewController.h"
#import "historyModel.h"

@interface UnregisterGCardViewController () <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    NSArray *reasonArray;
    NSString *selectedReason;
}

@property (weak, nonatomic) IBOutlet UITextField *txtFieldBundleNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldSerialNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldMobileNumber;

@end

@implementation UnregisterGCardViewController

- (void)viewDidLoad {
    
    reasonArray = [NSArray arrayWithObjects:@"Size Mismatch", @"Comfort Issue", @"Incorrect Dispatch", @"Short Payment", nil];
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:12.0/255.0 green:76.0/255.0 blue:164.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    _txtFieldSerialNumber.layer.borderColor=[UIColor colorWithRed:12.0/255.0 green:76.0/255.0 blue:164.0/255.0 alpha:1.0].CGColor;
    _txtFieldMobileNumber.layer.borderColor=[UIColor colorWithRed:12.0/255.0 green:76.0/255.0 blue:164.0/255.0 alpha:1.0].CGColor;
    _txtFieldBundleNumber.layer.borderColor=[UIColor colorWithRed:12.0/255.0 green:76.0/255.0 blue:164.0/255.0 alpha:1.0].CGColor;
    _reasonBtn.layer.borderColor=[UIColor colorWithRed:12.0/255.0 green:76.0/255.0 blue:164.0/255.0 alpha:1.0].CGColor;
    _txtFieldSerialNumber.layer.masksToBounds=YES;
    _txtFieldMobileNumber.layer.masksToBounds=YES;
    _txtFieldBundleNumber.layer.masksToBounds=YES;
    _reasonBtn.layer.masksToBounds=YES;
    _txtFieldSerialNumber.layer.borderWidth=1.0;
    _txtFieldMobileNumber.layer.borderWidth=1.0;
    _txtFieldBundleNumber.layer.borderWidth=1.0;
    _reasonBtn.layer.borderWidth=1.0;
    
    [self setupReasonPicker];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

-(void)dismissKeyboard {
    [_txtFieldMobileNumber resignFirstResponder];
}

-(void)setupReasonPicker {
    
    [_reasonPickerView setAlpha:0.0];
    [_shadowLbl setAlpha:0.0];
    
    [_reasonPickerView layer].cornerRadius = 5.0;
    
    [_shadowLbl layer].shadowColor = UIColor.blackColor.CGColor;
    [_shadowLbl layer].shadowOpacity = 1.0;
    [_shadowLbl layer].shadowRadius = 5.0;
    [_shadowLbl layer].masksToBounds = false;
    [_shadowLbl layer].shadowOffset = CGSizeMake(0.0, 1.0);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return reasonArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return reasonArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    selectedReason = [reasonArray objectAtIndex:row];
}

- (IBAction)getBundleDetails:(id)sender {
    [self getBundleDetails];
}

- (IBAction)reasonDropDownAction:(id)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        [_reasonPickerView setAlpha:1.0];
        [_shadowLbl setAlpha:1.0];
    }];
}

- (IBAction)selectionDone:(id)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        [_reasonPickerView setAlpha:0.0];
        [_shadowLbl setAlpha:0.0];
    }];
    if (!selectedReason.length) {
        selectedReason = [reasonArray objectAtIndex:0];
    }
    [_reasonBtn setTitle:[NSString stringWithFormat:@" %@", selectedReason] forState:UIControlStateNormal];
}

- (IBAction)unregisterTapped:(id)sender {
    
    if (!selectedReason.length) {
        
        UIAlertController *alert = [[UIAlertController alloc] init];
        alert = [UIAlertController alertControllerWithTitle:nil message:@"Please select a reason" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:true completion:nil];
        
    } else {
        
        NSDictionary *params = @{    @"request":@"unregister_guarantee",
                                     @"p_user_id":[historyModel sharedhistoryModel].opGreatplususerId,
                                     @"p_serial_no1":_txtFieldSerialNumber.text,
                                     @"p_serial_no2":@"",
                                     @"p_dealer_mobile":[historyModel sharedhistoryModel].mobileNo,
                                     @"p_customer_mobile":_txtFieldMobileNumber.text,
                                     @"p_customer_email":@"",
                                     @"p_customer_name":@"",
                                     @"p_non_eo":@"",
                                     @"p_invoice_number":@"",
                                     @"p_invoice_date":@"",
                                     @"p_reason_unregister":selectedReason
                                     };
        NSLog(@"%@", params);
        
        POAcvityView *activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
        [activityIndicator showView];
        [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_UNREGISTER_G_CARD withDictionaryInfo:params andTagName:UnregisterGCard andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode) {
                
                NSLog(@"%@",[result objectForKey:@"op_message"]);
                if(([result objectForKey:@"op_message"] == [NSNull null]))
                {
                    [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:[NSString stringWithFormat:@"%@",[result objectForKey:op_messageKey]] delegate:nil tag:0];
                }
                else
                {
                    [MailClassViewController toastWithMessage:message AndObj:self.view];
                }
                
                
            } else {
                [MailClassViewController toastWithMessage:message AndObj:self.view];
            }
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=FALSE;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=TRUE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getBundleDetails{
    POAcvityView *activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_GET_SERIAL_NUMBERS_FROM_BUNDLE withDictionaryInfo:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                                                                                                  @"gcard_detail",requestKey,
                                                                                                                                  _txtFieldBundleNumber.text,@"p_bundle_number",
                                                                                                                                  [historyModel sharedhistoryModel].opGreatplususerId,@"p_user_id",
                                                                                                                                  nil] andTagName:SerialNumberFromBundle andCompletionHandler:^(id result, int statusCode, NSString *message) {
        [activityIndicator hideView];
        if (statusCode == StatusCode) {
            
            NSLog(@"%@",[result objectForKey:@"op_message"]);
            
            if(([result objectForKey:@"op_serial_no1"] == [NSNull null]) || ([result objectForKey:@"op_serial2"] == [NSNull null]))
            {
                [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Sorry! serial number is not linked with bundle number" delegate:nil tag:0];
            }
            else
            {
//                mTextForSerialNo1.text = [NSString stringWithFormat:@"%@", [result objectForKey:@"op_serial1"]];
//                mTextForSerialNo2.text = [NSString stringWithFormat:@"%@", [result objectForKey:@"op_serial2"]];
                NSLog(@"HEllo success");
                _txtFieldMobileNumber.text=[result objectForKey:@"op_customer_mobile"];
                _txtFieldSerialNumber.text=[result objectForKey:@"op_serial_no1"];
            }
            
            
        } else {
            [MailClassViewController toastWithMessage:message AndObj:self.view];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
