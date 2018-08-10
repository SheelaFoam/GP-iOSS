/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "GreatPlusPlaceOrderViewController.h"
#import "GreatPlusSharedHeader.h"
#import "MailClassViewController.h"
#import "GreatPlusSharedPostRequestManager.h"
#import "JsonBuilder.h"
#import "UserDefaultStorage.h"
#import "HomeViewController.h"

@interface GreatPlusPlaceOrderViewController ()

@end

@implementation GreatPlusPlaceOrderViewController
// Distrubutor Name  === Delear name and Distributor name === location for sending
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self resetDataInSingelton];
    mLabelForAppType.text                                     = [NSString stringWithFormat:@"%@ app",[[UserDefaultStorage getUserDealerType] lowercaseString]];
    NSMutableArray *tempArray                                 = [[NSMutableArray alloc] init];
    [MailClassViewController sharedInstance].mDelearListArray = tempArray;
    mTextForDistributorName.text                              = EmptyString;
    [self resetData];
    mTypeOfPeice                                              = PcsTitle;
    mScrollName.contentSize                                  = ([self isRetina4]) ? CGSizeMake(0,700.0f) : CGSizeMake(0,700.0f);
    [self loadCornerRadious];
    mTextForDate.text                                         = [self findCurrentDate];
    if ([[UserDefaultStorage getUserDealerType] isEqualToString:DEALERTitle]) {
        mTextForDistributorName.text                               = [UserDefaultStorage getTitleDelearName];
        [MailClassViewController sharedInstance].delearName        = [UserDefaultStorage getTitleDelearName];
        [MailClassViewController sharedInstance].p_dealer_category = [UserDefaultStorage getDelearCategory];
        [self getDelearList];
    } else {
        NSLog(@"Empty String Data no a Dealer");
    }
}

- (void)resetDataInSingelton {
    [MailClassViewController sharedInstance].delearName        = EmptyString;
    [MailClassViewController sharedInstance].p_zone            = EmptyString;
    [MailClassViewController sharedInstance].p_dealer_category = EmptyString;
    [MailClassViewController sharedInstance].p_product_name    = EmptyString;
}

- (NSString *)findCurrentDate {
    NSDate *todayDate = [NSDate date]; // get today date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"]; //Here we can set the format which we need
    return [dateFormatter stringFromDate:todayDate];// here convert date in
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)mPcsBtnTapped:(UIButton *)sender {
    [self goDownKeyboard];
    if (sender.selected) {
        mTypeOfPeice    = BdlTitle;
        [mPcsBtn setSelected:NO];
        [mBdlBtn setSelected:YES];
    } else {
        mTypeOfPeice    = PcsTitle;
        [mPcsBtn setSelected:YES];
        [mBdlBtn setSelected:NO];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    
    if (textField == mTextForMobileNumber) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:EmptyString];
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int length = (int)[currentString length];
        
        if (length > 10) {
            
            return NO;
        }
        return [string isEqualToString:filtered];
    } else if (textField == mTextForQuantity) {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:EmptyString];
        return [string isEqualToString:filtered];
    } else if (textField == mTextForT) {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERSLength] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:EmptyString];
        return [string isEqualToString:filtered];
    } else if (textField == mTextForW) {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERSLength] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:EmptyString];
        return [string isEqualToString:filtered];
    } else if (textField == mTextForL) {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERSLength] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:EmptyString];
        return [string isEqualToString:filtered];
    } else if (textField == mTextForCustomerName) {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERSABC] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:EmptyString];
        return [string isEqualToString:filtered];
    }
    return YES;
}


- (IBAction)mBdlBtnTapped:(UIButton *)sender {
    [self goDownKeyboard];
    if (sender.selected) {
        [mBdlBtn setSelected:NO];
        mTypeOfPeice    = PcsTitle;
        [mPcsBtn setSelected:YES];
    } else {
        [mBdlBtn setSelected:YES];
        mTypeOfPeice    = BdlTitle;
        [mPcsBtn setSelected:NO];
    }
}

- (IBAction)mBackBtnTapped:(UIButton *)sender {
    
//    HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
//    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
//
//    HomeViewControllerVC.menuString=@"Left";

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma Mark for Checking The All Input data is filled

- (NSString *)validateSignUpForm {
    NSString *errorMessage = GoodTitle;
    if (!(mTextForDate.text.length >= 1)){
        errorMessage = EmptyDateTxtFldMsg;
    } else if (!(mTextForDistributorName.text.length >= 1)) {
        errorMessage = EmptyDistributorTxtFldMsg;
    } else if (!(mTextForDelearName.text.length >= 1)) {
        errorMessage = EmptyDelearTxtFldMsg;
    } else if (!(mTextForProductName.text.length >= 1)) {
        errorMessage = EmptyProductTxtFldMsg;
    } else if (!(mTextForL.text.length >= 1)) {
        errorMessage = EmptyLTxtFldMsg;
    } else if (!(mTextForW.text.length >= 1)) {
        errorMessage = EmptyWTxtFldMsg;
    } else if (!(mTextForQuantity.text.length >= 1)) {
        errorMessage = EmptyQuantityTxtFldMsg;
    }
    
    return errorMessage;
}

- (IBAction)mSendBtnTapped:(UIButton *)sender {
    [self goDownKeyboard];
    [self removePicker];
    [self downScroll];
    if ([[self validateSignUpForm] isEqualToString:GoodTitle]) {
//        if ([mTextForT.text length] > 0 || isAutoFill == YES) {
//
//        } else {
//            [MailClassViewController toastWithMessage:EmptyTTxtFldMsg AndObj:self.view];
//        }
        if ([mTextForMobileNumber.text length] == 0 || [mTextForMobileNumber.text length] == 10) {
            tabName = SAVETitle;
            [self getCurrentTime];
        } else {
            [MailClassViewController toastWithMessage:MobileNumberLength AndObj:self.view];
        }
    } else {
        [MailClassViewController toastWithMessage:[self validateSignUpForm] AndObj:self.view];
    }
}

#pragma Mark for Saving And New Data

- (IBAction)mSaveAndNewBtnTapped:(UIButton *)sender {
    [self goDownKeyboard];
    [self removePicker];
    [self downScroll];
    if ([[self validateSignUpForm] isEqualToString:GoodTitle]) {
        if ([mTextForT.text length] > 0 || isAutoFill == YES) {
            if ([mTextForMobileNumber.text length] == 0 || [mTextForMobileNumber.text length] == 10) {
                tabName = SAVEANDNEWTitle;
                [self getCurrentTime];
            } else {
                [MailClassViewController toastWithMessage:MobileNumberLength AndObj:self.view];
            }
        } else {
            [MailClassViewController toastWithMessage:EmptyTTxtFldMsg AndObj:self.view];
        }
    } else {
        [MailClassViewController toastWithMessage:[self validateSignUpForm] AndObj:self.view];
    }
}

- (void)resetData {
    [self setFrameView:280.0f andBtnY:334.0f];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [MailClassViewController sharedInstance].mLocationArray = tempArray;
    mTextForDelearName.text   = EmptyString;
    [MailClassViewController sharedInstance].mProductListArray = tempArray;
    mTextForProductName.text  = EmptyString;
    [MailClassViewController sharedInstance].mColourListArray = tempArray;
    mTextForColourName.text   = EmptyString;
    mTextForL.text            = EmptyString;
    mTextForW.text            = EmptyString;
    mTextForT.text            = EmptyString;
    mLocationCode             = EmptyString;
    mChannel_partner_group    = EmptyString;
    mViewForColourName.hidden = NO;
}

- (IBAction)mCustomBtnTapped:(UIButton *)sender {
    [self sizeTextEnable:YES];
    [customPicker removeFromSuperview];
    customPicker = nil;
    [self goDownKeyboard];
    switch (sender.tag) {
        case 0: {
            [self resetData];
            NSLog(@"%@", [UserDefaultStorage getUserDealerType]);
            if ([[UserDefaultStorage getUserDealerType] isEqualToString:DEALERTitle]) {
                mTextForDistributorName.text = [UserDefaultStorage getTitleDelearName];
            } else {
                if ([[MailClassViewController sharedInstance].mDelearListArray count] > 0) {
                    [[NSUserDefaults standardUserDefaults] setObject:SelectDelearTitle forKey:titleKey];
                    [self customPopUP];
                } else {
                    [self getDelearList];
                }
            }
        }
            break;
        case 1: {
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            [MailClassViewController sharedInstance].mProductListArray = tempArray;
            mTextForProductName.text  = EmptyString;
            [MailClassViewController sharedInstance].mColourListArray = tempArray;
            mTextForColourName.text   = EmptyString;
            mTextForL.text            = EmptyString;
            mTextForW.text            = EmptyString;
            mTextForT.text            = EmptyString;
            mViewForColourName.hidden = NO;
            [self setFrameView:280.0f andBtnY:334.0f];
            if ([[MailClassViewController sharedInstance].mLocationArray count] > 0) {
                [[NSUserDefaults standardUserDefaults] setObject:SelectDelearLocationTitle forKey:titleKey];
                [self customPopUP];
            } else {
                mLocationCode  = EmptyString;
                mChannel_partner_group = EmptyString;
                [self getLocationList];
            }
        }
            break;
        case 2: {
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            [MailClassViewController sharedInstance].mColourListArray = tempArray;
            mTextForColourName.text = EmptyString;
            mTextForL.text = EmptyString;
            mTextForW.text = EmptyString;
            mTextForT.text = EmptyString;
            mViewForColourName.hidden = NO;
            if ([[MailClassViewController sharedInstance].mProductListArray count] > 0) {
                [[NSUserDefaults standardUserDefaults] setObject:SelectProductListTitle forKey:titleKey];
                [self customPopUP];
            } else {
                [self getProductList];
            }
        }
            break;
        case 3: {
            if ([[MailClassViewController sharedInstance].mColourListArray count] > 0) {
                [[NSUserDefaults standardUserDefaults] setObject:SelectColourListTitle forKey:titleKey];
                [self customPopUP];
            } else {
                [self getColourList];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)sizeTextEnable :(BOOL)enableFlag {
    mTextForL.userInteractionEnabled = enableFlag;
    mTextForT.userInteractionEnabled = enableFlag;
    mTextForW.userInteractionEnabled = enableFlag;
}

#pragma MARK for Getting Menu Item List

- (void) getDelearList {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_DELEAR_LIST_INIT withDictionaryInfo:[JsonBuilder buildDelearListJsonObject] andTagName:DelearListServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode) {
                [[NSUserDefaults standardUserDefaults] setObject:SelectDelearTitle forKey:titleKey];
                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                for(NSDictionary *dic in result[productKey]) {
                    
                    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:dic];
                    [d setObject:NOTitle forKey:SELECTEDKey];
                    [tempArray addObject:d];
                }
                if ([tempArray count] == 0) {
                    [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:NoRecordAlertFor delegate:nil tag:0];
                } else {
                    if ([[UserDefaultStorage getUserDealerType] isEqualToString:DEALERTitle]) {
                        //                        [MailClassViewController sharedInstance].p_zone = [NSString stringWithFormat:@"%@",[[tempArray objectAtIndex:0] objectForKey:zoneKey]];
                        [MailClassViewController sharedInstance].p_zone = [NSString stringWithFormat:@"%@",[[tempArray objectAtIndex:0] objectForKey:@"DEALER_ZONE"]];
                    } else {
                        [MailClassViewController sharedInstance].mDelearListArray = tempArray;
                        [[NSUserDefaults standardUserDefaults] setObject:SelectDelearTitle forKey:titleKey];
                        [self customPopUP];
                    }
                }
                
            } else {
                [MailClassViewController toastWithMessage:message AndObj:self.view];
            }
        }];
    } else {
        [activityIndicator hideView];
        [MailClassViewController showAlertViewWithTitle:ConnectionTitle message:OhnoAlert delegate:self tag:0];
    }
}

#pragma MARK for Getting Menu Item List

- (void) getLocationList {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_LOCATION_INIT withDictionaryInfo:[JsonBuilder buildDelearLocationJsonObject] andTagName:LocationServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode) {
                [[NSUserDefaults standardUserDefaults] setObject:SelectDelearLocationTitle forKey:titleKey];
                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                for (NSMutableDictionary *ldic in result[locationKey]) {
                    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:ldic];
                    [d setObject:NOTitle forKey:SELECTEDKey];
                    [tempArray addObject:d];
                }
                if ([tempArray count] == 0) {
                    [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:NoRecordAlertFor delegate:nil tag:0];
                } else {
                    [MailClassViewController sharedInstance].mLocationArray = tempArray;
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

#pragma MARK for Getting Menu Item List

- (void) getProductList {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_PRODUCT_LIST_INIT withDictionaryInfo:[JsonBuilder buildProductListJsonObject] andTagName:ProductServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
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

#pragma MARK for Getting Menu Item List

- (void) getColourList {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_COLOUR_LIST_INIT withDictionaryInfo:[JsonBuilder buildColourListJsonObject] andTagName:ColourServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            NSLog(@"%@", result);
            NSLog(@"%@", message);
            NSLog(@"%d", statusCode);
            [activityIndicator hideView];
            if (statusCode == StatusCode) {
                [[NSUserDefaults standardUserDefaults] setObject:SelectColourListTitle forKey:titleKey];
                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                for (NSMutableDictionary *ldic in result[productKey]) {
                    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:ldic];
                    [d setObject:NOTitle forKey:SELECTEDKey];
                    [tempArray addObject:d];
                }
                if ([tempArray count] == 0) {
                    [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:NoRecordAlertFor delegate:nil tag:0];
                } else {
                    [MailClassViewController sharedInstance].mColourListArray = tempArray;
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

#pragma MARK for Getting Menu Item List

- (void) getSizeList {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_SIZE_INIT withDictionaryInfo:[JsonBuilder buildSizeListJsonObject] andTagName:SizeServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode) {
                mSizeAutofill = @"1";
                isAutoFill        = YES;
                if ([[[[result objectForKey:ProductSizeKey] objectAtIndex:0] objectForKey:base_lengthKey] isEqualToString:EmptyString]) {
                    mSizeAutofill = @"0";
                    isAutoFill    = NO;
                    [self sizeTextEnable:YES];
                } else {
                    [self sizeTextEnable:NO];
                }
                mTextForT.text = [NSString stringWithFormat:@"%@",([MailClassViewController checkNull:[[[result objectForKey:ProductSizeKey] objectAtIndex:0] objectForKey:base_thickKey]]) ? [[[result objectForKey:ProductSizeKey] objectAtIndex:0] objectForKey:base_thickKey] : EmptyString];
                mTextForW.text = [NSString stringWithFormat:@"%@",([MailClassViewController checkNull:[[[result objectForKey:ProductSizeKey] objectAtIndex:0] objectForKey:base_bredthKey]]) ? [[[result objectForKey:ProductSizeKey] objectAtIndex:0] objectForKey:base_bredthKey] : EmptyString];
                mTextForL.text = [NSString stringWithFormat:@"%@",([MailClassViewController checkNull:[[[result objectForKey:ProductSizeKey] objectAtIndex:0] objectForKey:base_lengthKey]]) ? [[[result objectForKey:ProductSizeKey] objectAtIndex:0] objectForKey:base_lengthKey] : EmptyString];
            } else {
                [MailClassViewController toastWithMessage:message AndObj:self.view];
            }
        }];
    } else {
        [activityIndicator hideView];
        [MailClassViewController showAlertViewWithTitle:ConnectionTitle message:OhnoAlert delegate:nil tag:NetworkAlertTag];
    }
}

#pragma MARK for Getting Menu Item List

- (void) getCurrentTime {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_DATE_INIT withDictionaryInfo:[JsonBuilder buildCurrentDateJsonObject] andTagName:DateServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            NSLog(@"%@", result);
            [activityIndicator hideView];
            if (statusCode == StatusCode) {
                NSDate *serverDate  = [self convertTimeInDate:[NSString stringWithFormat:@"%@",[result objectForKey:DateKey]]];
                NSDate *currentDate = [self convertTimeInDate:mTextForDate.text];
                NSLog(@"currentDate = %@ serverDate = %@",currentDate,serverDate);
                if ([serverDate isEqualToDate:currentDate]) {
                    [self sendOrderDataToServer];
                } else {
                    [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:DateTitleAlert delegate:nil tag:0];
                }
            } else {
                [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:message delegate:nil tag:0];
            }
        }];
    } else {
        [activityIndicator hideView];
        [MailClassViewController showAlertViewWithTitle:ConnectionTitle message:OhnoAlert delegate:nil tag:0];
    }
}

- (void) clearData {
    mTextForProductName.text        = EmptyString;
    mTextForColourName.text         = EmptyString;
    mTextForL.text                  = EmptyString;
    mTextForW.text                  = EmptyString;
    mTextForT.text                  = EmptyString;
    mPcsBtn.selected                = YES;
    mBdlBtn.selected                = NO;
    mTypeOfPeice                    = PcsTitle;
    mTextForQuantity.text           = EmptyString;
    mTextForCustomerName.text       = EmptyString;
    mTextForMobileNumber.text       = EmptyString;
    mTextForRemark.text             = EmptyString;
    NSMutableArray *tempArray       = [[NSMutableArray alloc] init];
    [MailClassViewController sharedInstance].mColourListArray  = tempArray;
    [MailClassViewController sharedInstance].mProductListArray = tempArray;
    mViewForColourName.hidden       = NO;
    [self setFrameView:280.0f andBtnY:334.0f];
}

- (NSDate *)convertTimeInDate : (NSString *)dateString {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    return  [dateFormatter dateFromString:dateString];
}

# pragma Category Picker Delegates

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

- (void)onCityTableCancel:(id)sender {
    [customPicker removeFromSuperview];
    customPicker = nil;
}

- (void)onCityDone:(id)sender selectedClentFocus:(NSArray *)str {
    if (str == nil || str.count == 0) {
    } else {
        
        if(str.count > 0){
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:titleKey] isEqualToString:SelectDelearTitle]) {
                
                BOOL isKeyExists      = [[str objectAtIndex:0] objectForKey:channel_partner_nameKey] != nil;
                if (isKeyExists) {
                    mTextForDistributorName.text = [[str objectAtIndex:0] objectForKey:channel_partner_nameKey];
                    [MailClassViewController sharedInstance].delearName = [[str objectAtIndex:0] objectForKey:channel_partner_nameKey];
                    [MailClassViewController sharedInstance].p_zone = [[str objectAtIndex:0] objectForKey:zoneKey];
                    [MailClassViewController sharedInstance].p_dealer_category = [[str objectAtIndex:0] objectForKey:dealer_categoryKey];
                } else {
                    mTextForDistributorName.text = [[str objectAtIndex:0] objectForKey:@"DEALER_NAME"];
                    [MailClassViewController sharedInstance].delearName = [[str objectAtIndex:0] objectForKey:@"DEALER_NAME"];
                    [MailClassViewController sharedInstance].p_zone = [[str objectAtIndex:0] objectForKey:@"DEALER_ZONE"];
                    [MailClassViewController sharedInstance].p_dealer_category = [[str objectAtIndex:0] objectForKey:@"DEALER_CATEGORY"];
                    [MailClassViewController sharedInstance].delearID = [[str objectAtIndex:0] objectForKey:@"DEALER_ID"];
                }
                
                
                
                //                    mDelearID = [[str objectAtIndex:0] objectForKey:@"DEALER_ID"];
            } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:titleKey] isEqualToString:SelectDelearLocationTitle]) {
                mTextForDelearName.text = [[str objectAtIndex:0] objectForKey:location_nameKey];
                [UserDefaultStorage setLocationCode:[[str objectAtIndex:0] objectForKey:location_codeKey]];
                mChannel_partner_group = [[str objectAtIndex:0] objectForKey:@"channel_partner_group"];
                mLocationCode = [[str objectAtIndex:0] objectForKey:location_codeKey];
            } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:titleKey] isEqualToString:SelectProductListTitle]) {
                mTextForProductName.text = [[str objectAtIndex:0] objectForKey:product_display_nameKey];
                [MailClassViewController sharedInstance].p_product_name = [[str objectAtIndex:0] objectForKey:product_display_nameKey];
                mColourApplicable = [[str objectAtIndex:0] objectForKey:color_applicable_ynKey];
                [self setFrameView:280.0f andBtnY:334.0f];
                if ([mColourApplicable isEqualToString:EmptyString]) {
                    mViewForColourName.hidden = YES;
                    mColour                   = EmptyString;
                    [self getSizeList];
                    [self setFrameView:250.0f andBtnY:320.0f];
                }
            } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:titleKey] isEqualToString:SelectColourListTitle]) {
                mTextForColourName.text = [[str objectAtIndex:0] objectForKey:colorKey];
                mColour = [[str objectAtIndex:0] objectForKey:colorKey];
                [self getSizeList];
            }
        }
    }
    [customPicker removeFromSuperview];
    customPicker = nil;
}

-(BOOL) isRetina4 {
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    return ([UIScreen mainScreen].scale == RETINA_SCALE && screenHeight == RETINA_4_HEIGHT);
}

-(void)scrollToPositionUP:(BOOL)isUP withTxtField:(UITextField *)textField {
    
    if ([self isRetina4]) {
        isUP ? ({
            
            CGPoint point;
            CGRect rect = [textField bounds];
            rect        = [textField convertRect:rect toView:mScrollName];
            point       = rect.origin;
            if (point.y > 200) {
                point.x = 0;
                point.y -=100;
                [mScrollName setContentOffset:point animated:YES];
            }}) : [mScrollName setContentOffset:offSet animated:YES];
    } else {
        isUP ? ({
            
            CGPoint point;
            CGRect rect = [textField bounds];
            rect        = [textField convertRect:rect toView:mScrollName];
            point       = rect.origin;
            // // // // // NSLog(@"positon %f",point.y);
            if (point.y > 160) {
                point.x = 0;
                point.y -=100;
                
                [mScrollName setContentOffset:point animated:YES];
            }}) : [mScrollName setContentOffset:offSet animated:YES];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self removePicker];
    mScrollName.contentSize = ([self isRetina4]) ? CGSizeMake(0,700.0f) : CGSizeMake(0,600.0f);
    selectedField = textField;
    
    if (textField == mTextForL) {
        [self scrollToPositionUP:YES withTxtField:selectedField];
    } else if (textField == mTextForW) {
        [self scrollToPositionUP:YES withTxtField:selectedField];
    } else if (textField == mTextForT) {
        [self scrollToPositionUP:YES withTxtField:selectedField];
    } else if (textField == mTextForQuantity) {
        [self scrollToPositionUP:YES withTxtField:selectedField];
    } else if (textField == mTextForCustomerName) {
        [self scrollToPositionUP:YES withTxtField:selectedField];
    } else if (textField == mTextForMobileNumber) {
        [self scrollToPositionUP:YES withTxtField:selectedField];
    } else if (textField == mTextForRemark) {
        [self scrollToPositionUP:YES withTxtField:selectedField];
    }
    return YES;
}

#pragma mark - TEXTFIELD DELEGATE

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self removePicker];
    if (textField == mTextForL) {
        [mTextForW becomeFirstResponder];
    } else if (textField == mTextForW) {
        [mTextForT becomeFirstResponder];
    } else if (textField == mTextForT) {
        [mTextForQuantity becomeFirstResponder];
    } else if (textField == mTextForQuantity) {
        [mTextForCustomerName becomeFirstResponder];
    } else if (textField == mTextForCustomerName) {
        [mTextForMobileNumber becomeFirstResponder];
    } else if (textField == mTextForMobileNumber) {
        [mTextForRemark becomeFirstResponder];
    } else if (textField == mTextForRemark) {
        [self downScroll];
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == mTextForL) {
        int length = [mTextForL.text intValue];
        float value = [mTextForL.text floatValue];
        if (length > 0 && length < 100) {
            
            mTextForL.text = [NSString stringWithFormat:@"%.f",value * 25.4];
        } else {
            if (length != 0) {
                mTextForL.text = [NSString stringWithFormat:@"%.f",value * 1.0];
            } else {
                mTextForL.text = @"";
            }
        }
        
    } else if (textField == mTextForW) {
        int length = [mTextForW.text intValue];
        float value = [mTextForW.text floatValue];
        if (length > 0 && length < 100) {
            mTextForW.text = [NSString stringWithFormat:@"%.f",value * 25.4];
        } else {
            if (length != 0) {
                mTextForW.text = [NSString stringWithFormat:@"%.f",value * 1.0];
            } else {
                mTextForW.text = @"";
            }
        }
        
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void) goDownKeyboard {
    [mTextForL resignFirstResponder];
    [mTextForW resignFirstResponder];
    [mTextForT resignFirstResponder];
    [mTextForQuantity resignFirstResponder];
    [mTextForCustomerName resignFirstResponder];
    [mTextForMobileNumber resignFirstResponder];
    [mTextForRemark resignFirstResponder];
}

-(void)downScroll {
    mScrollName.contentSize = ([self isRetina4]) ? CGSizeMake(0,700.0f) : CGSizeMake(0,700.0f);
    [mScrollName setContentOffset:CGPointMake(0, 0) animated:YES];
    [mScrollName setScrollEnabled:YES];
    [mTextForRemark resignFirstResponder];
}

#pragma MARK for Corner Radious for Button and UI TextField

-(void) loadCornerRadious {
    
    mViewForDate.layer.borderWidth                  = 1.0;
    mViewForDate.layer.cornerRadius                 = 2.0;
    mViewForDate.layer.borderColor                  = GBlueColour.CGColor;
    mViewForDate.layer.masksToBounds                = YES;
    
    mViewForDistributorName.layer.borderWidth       = 1.0;
    mViewForDistributorName.layer.cornerRadius      = 2.0;
    mViewForDistributorName.layer.borderColor       = GBlueColour.CGColor;
    mViewForDistributorName.layer.masksToBounds     = YES;
    
    mViewForProductName.layer.borderWidth           = 1.0;
    mViewForProductName.layer.cornerRadius          = 2.0;
    mViewForProductName.layer.borderColor           = GBlueColour.CGColor;
    mViewForProductName.layer.masksToBounds         = YES;
    
    mViewForDelearName.layer.borderWidth            = 1.0;
    mViewForDelearName.layer.cornerRadius           = 2.0;
    mViewForDelearName.layer.borderColor            = GBlueColour.CGColor;
    mViewForDelearName.layer.masksToBounds          = YES;
    
    mViewForColourName.layer.borderWidth            = 1.0;
    mViewForColourName.layer.cornerRadius           = 2.0;
    mViewForColourName.layer.borderColor            = GBlueColour.CGColor;
    mViewForColourName.layer.masksToBounds          = YES;
    
    mViewForL.layer.borderWidth                     = 1.0;
    mViewForL.layer.cornerRadius                    = 2.0;
    mViewForL.layer.borderColor                     = GBlueColour.CGColor;
    mViewForL.layer.masksToBounds                   = YES;
    
    mViewForW.layer.borderWidth                     = 1.0;
    mViewForW.layer.cornerRadius                    = 2.0;
    mViewForW.layer.borderColor                     = GBlueColour.CGColor;
    mViewForW.layer.masksToBounds                   = YES;
    
    mViewForT.layer.borderWidth                     = 1.0;
    mViewForT.layer.cornerRadius                    = 2.0;
    mViewForT.layer.borderColor                     = GBlueColour.CGColor;
    mViewForT.layer.masksToBounds                   = YES;
    
    mViewForQuantity.layer.borderWidth              = 1.0;
    mViewForQuantity.layer.cornerRadius             = 2.0;
    mViewForQuantity.layer.borderColor              = GBlueColour.CGColor;
    mViewForQuantity.layer.masksToBounds            = YES;
    
    mViewForCustomerName.layer.borderWidth          = 1.0;
    mViewForCustomerName.layer.cornerRadius         = 2.0;
    mViewForCustomerName.layer.borderColor          = GBlueColour.CGColor;
    mViewForCustomerName.layer.masksToBounds        = YES;
    
    mViewForMobileNumber.layer.borderWidth          = 1.0;
    mViewForMobileNumber.layer.cornerRadius         = 2.0;
    mViewForMobileNumber.layer.borderColor          = GBlueColour.CGColor;
    mViewForMobileNumber.layer.masksToBounds        = YES;
    
    mViewForRemark.layer.borderWidth                = 1.0;
    mViewForRemark.layer.cornerRadius               = 2.0;
    mViewForRemark.layer.borderColor                = GBlueColour.CGColor;
    mViewForRemark.layer.masksToBounds              = YES;
}

- (void) removePicker {
    [self onCityTableCancel:nil];
}

#pragma MARK for Sending Order Data To Server

#pragma MARK for Getting Menu Item List

- (void) sendOrderDataToServer {
    
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_PLACE_ORDER_DATA_INIT withDictionaryInfo:[JsonBuilder buildOrderInfoSendDataJsonObject:[mTextForQuantity.text intValue] withCustomerName:mTextForCustomerName.text withMobileNumber:mTextForMobileNumber.text withRemark:mTextForRemark.text withDelearName:mTextForDistributorName.text withLocationCode:mLocationCode withLocationName:mTextForDelearName.text withColourAplicable:mColourApplicable withLength:mTextForL.text withBredth:mTextForW.text withThick:mTextForT.text WithColour:mColour withPeiceOrBundle:mTypeOfPeice withAutoSizeFill:mSizeAutofill withChannel_partner_group :mChannel_partner_group andOrderDate:mTextForDate.text] andTagName:OrderPlaceServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode) {
                if ([[NSString stringWithFormat:@"%@",[result objectForKey:op_resultKey]] intValue] == 0) {
                    [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:[NSString stringWithFormat:@"%@",[result objectForKey:op_messageKey]] delegate:nil tag:0];
                } else {
                    if ([tabName isEqualToString:SAVEANDNEWTitle]) {
                        [self clearData];
                        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:[NSString stringWithFormat:@"%@",[result objectForKey:op_messageKey]] delegate:nil tag:0];
                    } else {
                        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:[NSString stringWithFormat:@"%@",[result objectForKey:op_messageKey]] delegate:self tag:10];
                    }
                }
            } else {
                [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:message delegate:nil tag:0];
            }
        }];
    } else {
        [activityIndicator hideView];
        [MailClassViewController showAlertViewWithTitle:ConnectionTitle message:OhnoAlert delegate:nil tag:NetworkAlertTag];
    }
}

- (void)setFrameView :(CGFloat)txtViewY andBtnY :(CGFloat)btnY   {
    mViewForT.frame = CGRectMake(mViewForT.frame.origin.x, txtViewY, mViewForT.frame.size.width, mViewForT.frame.size.height);
    mViewForW.frame = CGRectMake(mViewForW.frame.origin.x, txtViewY, mViewForW.frame.size.width, mViewForW.frame.size.height);
    mViewForL.frame = CGRectMake(mViewForL.frame.origin.x, txtViewY, mViewForL.frame.size.width, mViewForL.frame.size.height);
    
    mPcsBtn.frame = CGRectMake(mPcsBtn.frame.origin.x, btnY, mPcsBtn.frame.size.width, mPcsBtn.frame.size.height);
    mPcsLabel.frame = CGRectMake(mPcsLabel.frame.origin.x, btnY, mPcsLabel.frame.size.width, mPcsLabel.frame.size.height);
    
    mBdlBtn.frame = CGRectMake(mBdlBtn.frame.origin.x, btnY, mBdlBtn.frame.size.width, mBdlBtn.frame.size.height);
    mBdlLabel.frame = CGRectMake(mBdlLabel.frame.origin.x, btnY, mBdlLabel.frame.size.width, mBdlLabel.frame.size.height);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10) {
        [self moveToOrderStatusPage];
    } else {
        [self getDelearList];
    }
}

- (void)moveToOrderStatusPage {
    [[NSUserDefaults standardUserDefaults] setValue:keyCheckTitle forKey:HackTitle];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
