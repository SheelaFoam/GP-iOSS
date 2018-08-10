//
//  ConsumerOrder.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 30/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "ConsumerOrder.h"

@interface ConsumerOrder()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, CityTableDelegate> {
    
    NSString *subProduct;
    
    UITapGestureRecognizer *tap;
    NSInteger quantityCount;
    UIButton *searchButton;
    
    CityView *customPicker;
    POAcvityView *activityIndicator;
}

@end

@implementation ConsumerOrder

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [_mobileNoTextField resignFirstResponder];
        [_consumerNameTextField resignFirstResponder];
        [_productNameTextField resignFirstResponder];
        [_heightTextField resignFirstResponder];
        [_breadthTextField resignFirstResponder];
        [_breadthTextField resignFirstResponder];
        [_thickTextField resignFirstResponder];
        [_advanceTextField resignFirstResponder];
    }
}

// *************** Textfield Delegate Methods **************

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [tap setEnabled:true];
    if (textField == _advanceTextField) {
        [_scrollView setScrollEnabled:true];
        [self scrollViewAdaptToStartEditingTextField:_advanceTextField];
    }
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _heightTextField) {
        double height = [_heightTextField.text integerValue];
        height = height*25.4;
        [_heightTextField setText:[NSString stringWithFormat:@"%0.1f", round(height)]];
    } else if (textField == _breadthTextField) {
        double breadth = [_breadthTextField.text integerValue];
        breadth = breadth*25.4;
        [_breadthTextField setText:[NSString stringWithFormat:@"%0.1f", round(breadth)]];
    }
    if (textField != _mobileNoTextField) {
        [textField resignFirstResponder];
    }
    [tap setEnabled:false];
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _advanceTextField) {
        [self scrollViewEditingFinished:_advanceTextField];
    }
}

// *************** Custom Methods **************

-(void) initialSetup {
    
    [_scrollView setScrollEnabled:false];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissInputView)];
    [self.view addGestureRecognizer:tap];
    [tap setEnabled:false];
    
    quantityCount = 0;
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _mobileNoTextField.frame.size.height, _mobileNoTextField.frame.size.height)];
    [_mobileNoTextField setRightView:rightView];
    [_mobileNoTextField setRightViewMode:UITextFieldViewModeAlways];
    searchButton = [[UIButton alloc] initWithFrame:CGRectMake(rightView.frame.origin.x, rightView.frame.origin.y, rightView.frame.size.height, rightView.frame.size.height)];
    [rightView addSubview:searchButton];
    [searchButton setImage:[UIImage imageNamed:@"search-1"] forState:UIControlStateNormal];
    
    [searchButton addTarget:self action:@selector(searchContact:) forControlEvents:UIControlEventTouchUpInside];
    
    _shadowLbl.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    _submitView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [_shadowLbl.layer setShadowColor:UIColor.blackColor.CGColor];
    [_shadowLbl.layer setShadowRadius:5.0];
    [_shadowLbl.layer setShadowOpacity:1.0];
    [_shadowLbl.layer setShadowOffset:CGSizeMake(0.0, 1.0)];
    [_shadowLbl.layer setMasksToBounds:false];
    [_submitView.layer setCornerRadius:5.0];
}

-(void) dismissInputView {
    [self.view endEditing:true];
}

- (void) scrollViewEditingFinished:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, 0);
    [_scrollView setContentOffset:point animated:YES];
}

- (void) scrollViewAdaptToStartEditingTextField:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, textField.frame.origin.y -3.5*textField.frame.size.height);
    [_scrollView setContentOffset:point animated:YES];
}

- (IBAction)searchContact:(id)sender {
    NSLog(@"Button tapped");
}

- (IBAction)increaseQuantity:(id)sender {
    
    quantityCount += 1;
    [_quantityLbl setText:[NSString stringWithFormat:@"%ld", (long)quantityCount]];
}

- (IBAction)decreaseQuantity:(id)sender {
    
    if (quantityCount > 0) {
        quantityCount -= 1;
        [_quantityLbl setText:[NSString stringWithFormat:@"%ld", (long)quantityCount]];
    } else {
        NSLog(@"Quantity cannot be less than zero");
    }
}
- (IBAction)showProductList:(id)sender {
    
    if ([[MailClassViewController sharedInstance].mProductListArray count] > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:SelectProductListTitle forKey:titleKey];
        [self customPopUP];
    } else {
        [self getProductList];
    }
}

- (IBAction)redeemNow:(id)sender {
    [self openPopupPunchInView:_submitView shadowLabel:_shadowLbl];
}

- (IBAction)redeemLater:(id)sender {
    [self openPopupPunchInView:_submitView shadowLabel:_shadowLbl];
}

- (IBAction)submit:(id)sender {
    [self closePopupPunchInView:_submitView shadowLabel:_shadowLbl];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DealerStoryboard" bundle:nil];
    GCardRegistration *vc = [storyboard instantiateViewControllerWithIdentifier:@"GCardRegistration"];
    [self presentViewController:vc animated:true completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self closePopupPunchInView:_submitView shadowLabel:_shadowLbl];
}

- (void)onCityDone:(id)sender selectedClentFocus:(NSArray *)str {
    
    subProduct = [[str objectAtIndex:0] valueForKey:@"sub_product"];
    NSLog(@"%@", subProduct);
}

- (void)onCityTableCancel:(id)sender {
    [customPicker removeFromSuperview];
    customPicker = nil;
}

- (void) customPopUP {
    
    if(customPicker == nil) {
        
        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:CityViewCtrl owner:self options:nil];
        customPicker           = (CityView *) [nibViews lastObject];
        customPicker.delegate = self;
        
        [customPicker setFrame:CGRectMake(0.0f, (self.view.frame.size.height - 268.0f)/2, self.view.frame.size.width, 268.0f)];
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:nil];
    [UIView setAnimationDuration:0.50];
    [self.view addSubview:customPicker];
    [UIView commitAnimations];
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

// *************** API Methods **************

- (void) getProductList {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        NSDictionary *param =  [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                @"getProduct",requestKey,
                                [historyModel sharedhistoryModel].userName,p_dealer_nameKey,
                                @"NORTH",@"p_zone",
                                [UserDefaultStorage getDelearCategory],@"p_dealer_category",
                                nil];
        NSLog(@"%@", param);
//        [JsonBuilder buildProductListJsonObject]
        [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_PRODUCT_LIST_INIT withDictionaryInfo:param andTagName:ProductServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode) {
                [[NSUserDefaults standardUserDefaults] setObject:SelectProductListTitle forKey:titleKey];
                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                for (NSMutableDictionary *ldic in result[productKey]) {
                    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:ldic];
                    [d setObject:NOTitle forKey:SELECTEDKey];
                    [tempArray addObject:d];
                }
                if ([tempArray count] == 0) {
                    [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:NoRecordAlertFor delegate:nil tag:0];
                } else {
                    [MailClassViewController sharedInstance].mProductListArray = tempArray;
                    [self customPopUP];
                }
            } else {
                [MailClassViewController toastWithMessage:message AndObj:self.view];
            }
        }];
    } else {
        [activityIndicator hideView];
        [MailClassViewController showAlertViewWithTitle:ConnectionTitle message:OhnoAlert delegate:nil tag:NetworkAlertTag];
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
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
