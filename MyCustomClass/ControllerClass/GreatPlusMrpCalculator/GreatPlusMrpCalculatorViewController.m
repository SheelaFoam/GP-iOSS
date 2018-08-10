/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "GreatPlusMrpCalculatorViewController.h"
#import "UserDefaultStorage.h"
#import "GreatPlusSharedHeader.h"
#import "MailClassViewController.h"
#import "GreatPlusSharedGetRequestManager.h"
#import "Utility.h"
#import "HomeViewController.h"

@interface GreatPlusMrpCalculatorViewController ()

@end

@implementation GreatPlusMrpCalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getStateListItem];
    sizeType = @"INCH";
    atStart  = @"INIT";
    atState  = @"INIT";
    self.navigationController.navigationBarHidden = YES;
    mLabelForAppType.text = [NSString stringWithFormat:@"%@ app",[[UserDefaultStorage getUserDealerType] lowercaseString]];
    if ([[UserDefaultStorage getUserDealerType] isEqualToString:DEALERTitle]) {
         mTextForState.text = [NSString stringWithFormat:@"%@",[UserDefaultStorage getDeafaultState]];
    }
   
    [self loadCornerRadious];
    mTextForCategory.text = @"ALL";
    [UserDefaultStorage setPRODUCT_CATEGORY:@"ALL"];
//    mScrollView.contentSize                                  = CGSizeMake(0,600.0f);
    [self initilizeUserDefaultData];
    [mBtnForThickness removeFromSuperview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mBtnForProductNameClicked:(UIButton *)sender {
    atState  = @"";
    mTextForLength.text = EmptyString;
    mLabelForMrpInfo.text = EmptyString;
    mLabelForWarrentyInfo.text = EmptyString;
    mTextForBreadth.text = EmptyString;
    mTextForThickness.text = EmptyString;
    mTextForThickness.placeholder=@"--";
    [MailClassViewController sharedInstance].mSizeArray = [[NSMutableArray alloc] init];
    [MailClassViewController sharedInstance].mThicknessArray = [[NSMutableArray alloc] init];
    [UserDefaultStorage setPRODUCT_NAME:@""];
    atStart = @"INIT";
    if ([[MailClassViewController sharedInstance].mProductArray count] > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:ChoseProductTitle forKey:titleKey];
        [self customPopUPInMRPCalc];
    } else {
        [self getProductListItem];
    }
}

- (IBAction)mButtonShowClicked:(UIButton *)sender {
    [self downScroll];
    if ([[self validateSignUpForm] isEqualToString:GoodTitle]) {
        [self showActualMRP];
    } else {
        [MailClassViewController toastWithMessage:[self validateSignUpForm] AndObj:self.view];
    }
}
#pragma mark - TextField Resign Responder
//
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [mTextForBreadth resignFirstResponder];
    [mTextForLength resignFirstResponder];
     [self downScroll];
}


#pragma Mark for Checking The All Input data is filled

- (NSString *)validateSignUpForm {
    NSString *errorMessage = GoodTitle;
    if (!(mTextForState.text.length >= 1)){
        errorMessage = @"State name field can not be empty.";
    } else if (!(mTextForCategory.text.length >= 1)) {
        errorMessage = @"Product category field can not be empty.";
    } else if (!(mTextForProductname.text.length >= 1)) {
        errorMessage = @"Product name field can not be empty.";
    } else if (!(mLabelForLength.text.length >= 1)) {
        errorMessage = @"Length field can not be empty.";
    } else if (!(mTextForBreadth.text.length >= 1)) {
        errorMessage = @"Bredth field can not be empty.";
    } else if (!(mTextForThickness.text.length >= 1)) {
        errorMessage = @"Thickness field can not be empty.";
    }
    return errorMessage;
}
#pragma mark - TEXTFIELD DELEGATE

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [customPicker removeFromSuperview];
    customPicker = nil;
    if (textField == mTextForLength) {
        [mTextForBreadth becomeFirstResponder];
    } else if (textField == mTextForBreadth) {
        [mTextForThickness becomeFirstResponder];
    }else if (textField == mTextForThickness) {
        [mTextForThickness resignFirstResponder];
        [self downScroll];
    }
    return YES;
}


- (IBAction)mBackBtnTapped:(UIButton *)sender {
//    HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
//    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
//
//    HomeViewControllerVC.menuString=@"Left";
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)mBtnForStateClicked:(UIButton *)sender {
    [self emptyData];
    if ([[MailClassViewController sharedInstance].mStateArray count] > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:ChoseStateTitle forKey:titleKey];
        [self customPopUPInMRPCalc];
    } else {
        [self getStateListItem];
    }
}

- (IBAction)mBtnForCategoryClicked:(UIButton *)sender {
    mTextForProductname.text = EmptyString;
    mTextForLength.text = EmptyString;
    mTextForBreadth.text = EmptyString;
    mTextForThickness.text = EmptyString;
     mLabelForMrpInfo.text = EmptyString;
    mLabelForWarrentyInfo.text = EmptyString;
    [MailClassViewController sharedInstance].mProductArray = [[NSMutableArray alloc] init];
    [MailClassViewController sharedInstance].mSizeArray = [[NSMutableArray alloc] init];
    [UserDefaultStorage setPRODUCT_NAME:@""];
    [UserDefaultStorage setPRODUCT_CATEGORY:@""];
    if ([[MailClassViewController sharedInstance].mCategoryArray count] > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:ChoseProdCatTitle forKey:titleKey];
        [self customPopUPInMRPCalc];
    } else {
        [self getProductCategoryListItem];
    }
}

- (IBAction)mBtnForStandardSizeClicked:(UIButton *)sender {
    if ([mTextForProductname.text length] == 0) {
         [MailClassViewController toastWithMessage:@"Product not selected" AndObj:self.view];
    } else {
        atStart = EmptyString;
        if ([[MailClassViewController sharedInstance].mSizeArray count] > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:ChoseSizeTitle forKey:titleKey];
            [self customPopUPInMRPCalc];
        } else {
            [self getStandardSize];
        }
    }
}

- (void) emptyData {
    mTextForCategory.text = EmptyString;
    mTextForProductname.text = EmptyString;
    mTextForLength.text = EmptyString;
    mTextForBreadth.text = EmptyString;
    mTextForThickness.text = EmptyString;
    [MailClassViewController sharedInstance].mCategoryArray = [[NSMutableArray alloc] init];
    [MailClassViewController sharedInstance].mProductArray = [[NSMutableArray alloc] init];
    [MailClassViewController sharedInstance].mSizeArray = [[NSMutableArray alloc] init];
    [UserDefaultStorage setPRODUCT_NAME:@""];
    [UserDefaultStorage setPRODUCT_CATEGORY:@""];
    mLabelForMrpInfo.text = EmptyString;
    mLabelForWarrentyInfo.text = EmptyString;
}

#pragma MARK for Getting State Item List

- (void) getStateListItem {
    if ([atStart isEqualToString:@"INIT"]) {
    } else {
        activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
        [activityIndicator showView];
    }
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedGetRequestManager sharedInstance] executeRequest:CMD_GET_STATE_DATA_INIT withUrl:@"" andTagName:GetStateListTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode || statusCode == 0) {
                [[NSUserDefaults standardUserDefaults] setObject:ChoseStateTitle forKey:titleKey];
                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                for (NSMutableDictionary *ldic in result) {
                    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:ldic];
                    [d setObject:NOTitle forKey:SELECTEDKey];

                    if ([[d objectForKey:@"STATE"] isEqualToString:[UserDefaultStorage getDeafaultState]] && [atStart isEqualToString:@"INIT"]) {
                        [UserDefaultStorage setDealerState:[NSString stringWithFormat:@"%@",[d objectForKey:@"STATE"]]];
                        [UserDefaultStorage setZone:[NSString stringWithFormat:@"%@",[d objectForKey:@"ZONE"]]];
                        [d setObject:@"YES" forKey:SELECTEDKey];
                    }
                    [tempArray addObject:d];
                }
                if ([[UserDefaultStorage getDeafaultState] isEqualToString:EmptyString]) {
                    [UserDefaultStorage setDealerState:[NSString stringWithFormat:@"%@",[[tempArray objectAtIndex:0] objectForKey:@"STATE"]]];
                    [UserDefaultStorage setZone:[NSString stringWithFormat:@"%@",[[tempArray objectAtIndex:0] objectForKey:@"ZONE"]]];
                    mTextForState.text = [NSString stringWithFormat:@"%@",[UserDefaultStorage getDealerState]];
                    [[tempArray objectAtIndex:0] setObject:@"YES" forKey:SELECTEDKey];
                }
                [MailClassViewController sharedInstance].mStateArray = tempArray;
                if ([atStart isEqualToString:@"INIT"]) {
                    
                } else {
                    [self customPopUPInMRPCalc];
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

- (void) getProductCategoryListItem {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedGetRequestManager sharedInstance] executeRequest:CMD_GET_PROD_CAT_DATA_INIT withUrl:@"" andTagName:GetCatListTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode || statusCode == 0) {
                [[NSUserDefaults standardUserDefaults] setObject:ChoseProdCatTitle forKey:titleKey];
                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                for (NSMutableDictionary *ldic in result) {
                    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:ldic];
                    [d setObject:NOTitle forKey:SELECTEDKey];
                    [tempArray addObject:d];
                }
                [tempArray insertObject:[self loadAllElement] atIndex:0];
                [MailClassViewController sharedInstance].mCategoryArray = tempArray;
                [self customPopUPInMRPCalc];
            } else {
                [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:message delegate:nil tag:0];
            }
        }];
    } else {
        [activityIndicator hideView];
        [MailClassViewController showAlertViewWithTitle:ConnectionTitle message:OhnoAlert delegate:nil tag:0];
    }
}

- (NSMutableDictionary *) loadAllElement {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            @"ALL",@"SUB_SUB_PRODUCT_SEGMENT_2016",
            @"YES",SELECTEDKey,
            nil];
    
}

- (void) getProductListItem {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedGetRequestManager sharedInstance] executeRequest:CMD_GET_PROD_DATA_INIT withUrl:@"" andTagName:GetProdListTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode || statusCode == 0) {
                [[NSUserDefaults standardUserDefaults] setObject:ChoseProductTitle forKey:titleKey];
                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                for (NSMutableDictionary *ldic in result) {
                    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:ldic];
                    [d setObject:NOTitle forKey:SELECTEDKey];
                    [tempArray addObject:d];
                }
                [MailClassViewController sharedInstance].mProductArray = tempArray;
                [self customPopUPInMRPCalc];
            } else {
                [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:message delegate:nil tag:0];
            }
        }];
    } else {
        [activityIndicator hideView];
        [MailClassViewController showAlertViewWithTitle:ConnectionTitle message:OhnoAlert delegate:nil tag:0];
    }
}

- (void) getStandardSize {
    if ([atStart isEqualToString:@"INIT"]) {
    } else {
        activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
        [activityIndicator showView];
    }
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedGetRequestManager sharedInstance] executeRequest:CMD_GET_STAND_SIZE_DATA_INIT withUrl:sizeType andTagName:GetStandSizeTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode || statusCode == 0) {
                [[NSUserDefaults standardUserDefaults] setObject:ChoseSizeTitle forKey:titleKey];
                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                for (NSMutableDictionary *ldic in result) {
                    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:ldic];
                    [d setObject:NOTitle forKey:SELECTEDKey];
                    [tempArray addObject:d];
                }
                [MailClassViewController sharedInstance].mSizeArray = tempArray;
                if ([atStart isEqualToString:@"INIT"]) {
                    mTextForLength.text = [NSString stringWithFormat:@"%@",[[tempArray objectAtIndex:0] objectForKey:@"LENGTH"]];
                    mTextForBreadth.text = [NSString stringWithFormat:@"%@",[[tempArray objectAtIndex:0] objectForKey:@"BREDTH"]];
                    [UserDefaultStorage setLength:[NSString stringWithFormat:@"%@",[[tempArray objectAtIndex:0] objectForKey:@"LENGTH"]]];
                    [UserDefaultStorage setWidth:[NSString stringWithFormat:@"%@",[[tempArray objectAtIndex:0] objectForKey:@"BREDTH"]]];
                    [[[MailClassViewController sharedInstance].mSizeArray objectAtIndex:0] setObject:@"YES" forKey:SELECTEDKey];
                } else {
                  [self customPopUPInMRPCalc];
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
- (IBAction)mBtnForThicknessClicked:(UIButton *)sender {
    mTextForThickness.text = EmptyString;
    mBtnForThickness.titleLabel.text = @"Select";
    if ([[MailClassViewController sharedInstance].mThicknessArray count] > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:ChoseThicknessTitle forKey:titleKey];
        [self customPopUPInMRPCalc];
    } else {
        [self getThickness];
    }
}

- (void) getThickness {
    if ([atStart isEqualToString:@"INIT"]) {
    } else {
        activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
        [activityIndicator showView];
    }
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedGetRequestManager sharedInstance] executeRequest:CMD_GET_THICKNESS_DATA_INIT withUrl:sizeType andTagName:GetThicknessTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode || statusCode == 0) {
                [[NSUserDefaults standardUserDefaults] setObject:ChoseThicknessTitle forKey:titleKey];
                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                for (NSMutableDictionary *ldic in result) {
                    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:ldic];
                    [d setObject:NOTitle forKey:SELECTEDKey];
                    [tempArray addObject:d];
                }
                [MailClassViewController sharedInstance].mThicknessArray = tempArray;
                if ([atStart isEqualToString:@"INIT"] || [tempArray count] > 0) {
                    
                    if ([tempArray count]) {
                        if ([[[tempArray objectAtIndex:0] objectForKey:@"THICK"] isKindOfClass:[NSNull class]]) {
                            mTextForThickness.text = @" ";
                            [UserDefaultStorage setThickness:@" "];
                        }else{
                            mTextForThickness.text = [NSString stringWithFormat:@"%@",[[tempArray objectAtIndex:0] objectForKey:@"THICK"]];
                            [UserDefaultStorage setThickness:[NSString stringWithFormat:@"%@",[[tempArray objectAtIndex:0] objectForKey:@"THICK"]]];
                        }
                    }
                   
                    mBtnForThickness.titleLabel.text = EmptyString;
                    [[[MailClassViewController sharedInstance].mThicknessArray objectAtIndex:0] setObject:@"YES" forKey:SELECTEDKey];
                } else {
                    [self customPopUPInMRPCalc];
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

- (IBAction)changeSwitch:(id)sender {
    [self downScroll];
     mLabelForMrpInfo.text = EmptyString;
    mLabelForWarrentyInfo.text = EmptyString;
    if([sender isOn]) {
        sizeType = @"MM";
        NSLog(@"Switch is ON");
    } else {
        sizeType = @"INCH";
        NSLog(@"Switch is OFF");
    }
     [self setLemgthAndWidthe:sizeType];
}

- (void) calculateSize {
    
}

- (void) setLemgthAndWidthe :(NSString *) type {
    if ([type isEqualToString:@"INCH"]) {
        int length = [mTextForLength.text intValue];
        float value = [mTextForLength.text floatValue];
        if (length != 0) {
            mTextForLength.text = [NSString stringWithFormat:@"%.1f",value / 25.4];
        } else {
            mTextForLength.text = @"";
             mTextForLength.placeholder = @"--";
        }
        int lengthw = [mTextForBreadth.text intValue];
        float valueW = [mTextForBreadth.text floatValue];
        if (lengthw != 0) {
            mTextForBreadth.text = [NSString stringWithFormat:@"%.1f",valueW / 25.4];
        } else {
            mTextForBreadth.text = @"";
             mTextForBreadth.placeholder = @"--";
        }
        
//        int lengthT = [mTextForThickness.text intValue];
//        float valueT = [mTextForThickness.text floatValue];
//        if (lengthT != 0) {
//            mTextForThickness.text = [NSString stringWithFormat:@"%.1f",valueT / 25.4];
//        } else {
//            mTextForThickness.text = @"";
//            mTextForThickness.placeholder = @"--";
//        }
        mTextForThickness.placeholder = @"--";

        
    } else {
        int length = [mTextForLength.text intValue];
        float value = [mTextForLength.text floatValue];
        if (length != 0) {
             mTextForLength.text = [NSString stringWithFormat:@"%.f",value * 25.4];
        } else {
            mTextForLength.text = @"";
            mTextForLength.placeholder = @"--";
        }
        int lengthw = [mTextForBreadth.text intValue];
        float valueW = [mTextForBreadth.text floatValue];
        if (lengthw != 0) {
           mTextForBreadth.text = [NSString stringWithFormat:@"%.f",valueW * 25.4];
        } else {
            mTextForBreadth.text = @"";
            mTextForBreadth.placeholder = @"--";
        }
        
//        int lengthT = [mTextForThickness.text intValue];
//        float valueT = [mTextForThickness.text floatValue];
//        if (lengthT != 0) {
//            mTextForThickness.text = [NSString stringWithFormat:@"%.f",valueT * 25.4];
//        } else {
//            mTextForThickness.text = @"";
//            mTextForThickness.placeholder = @"--";
//        }
        mTextForThickness.placeholder = @"--";

        
    }
  
    [UserDefaultStorage setLength:mTextForLength.text];
    [UserDefaultStorage setWidth:mTextForBreadth.text];
    [UserDefaultStorage setThickness:mTextForThickness.text];
}

//- (void) checkWidthAndLength {
//    float value = [mTextForLength.text floatValue];
//    float valueW = [mTextForBreadth.text floatValue];
//    if (valueW > value) {
//        [self downScroll];
//        [self addPopUpForWidthAndLength];
//    }
//}

-(void) addPopUpForWidthAndLength :(NSString *)title andMessage :(NSString *) message {
    [MailClassViewController addTransitionEffect:kCATransitionFade withSubType:nil forView:self.view];
    filterPopUp                    = [[GreatPlusPopUp alloc] initWithNibName:@"GreatPlusPopUp" bundle:nil];
    filterPopUp.delegate           = self;
    filterPopUp.showInfoTitle      = title;
    filterPopUp.showInfo           = message;
    // Are you sure to delete? this process cannot be undone.
    [self.view addSubview:filterPopUp.view];
}

#pragma mark -
#pragma mark - SCInboxsublistPopUp delegate methods
#pragma mark -

- (void)cancelTheSublistDeleteItem {
    [MailClassViewController addTransitionEffect:kCATransitionFade withSubType:kCATransitionFromRight forView:self.view];
    [filterPopUp.view removeFromSuperview];
}

- (void) initilizeUserDefaultData {
     mLabelForMrpInfo.text = EmptyString;
    mLabelForWarrentyInfo.text = EmptyString;
    [UserDefaultStorage setLength:EmptyString];
    [UserDefaultStorage setWidth:EmptyString];
    [UserDefaultStorage setPRODUCT_NAME:EmptyString];
    [UserDefaultStorage setPRODUCT_CATEGORY:EmptyString];
    [UserDefaultStorage setZone:EmptyString];
    [UserDefaultStorage setThickness:EmptyString];
    [UserDefaultStorage setDealerState:EmptyString];
    [MailClassViewController sharedInstance].mStateArray = [[NSMutableArray alloc] init];
     [MailClassViewController sharedInstance].mProductArray = [[NSMutableArray alloc] init];
     [MailClassViewController sharedInstance].mCategoryArray = [[NSMutableArray alloc] init];
     [MailClassViewController sharedInstance].mSizeArray = [[NSMutableArray alloc] init];
     [MailClassViewController sharedInstance].mThicknessArray = [[NSMutableArray alloc] init];
}

- (void) setLWTstyle {
    mTextForLength.text = EmptyString;
    mTextForBreadth.text = EmptyString;
    mTextForThickness.text = EmptyString;
    [UserDefaultStorage setLength:EmptyString];
    [UserDefaultStorage setWidth:EmptyString];
    [UserDefaultStorage setThickness:EmptyString];
}

#pragma MARK for Corner Radious for Button and UI TextField

-(void) loadCornerRadious {
    
    mViewForState.layer.borderWidth                  = 1.0;
    mViewForState.layer.cornerRadius                 = 2.0;
    mViewForState.layer.borderColor                  = GBlueColour.CGColor;
    mViewForState.layer.masksToBounds                = YES;
    
    mViewForCategory.layer.borderWidth       = 1.0;
    mViewForCategory.layer.cornerRadius      = 2.0;
    mViewForCategory.layer.borderColor       = GBlueColour.CGColor;
    mViewForCategory.layer.masksToBounds     = YES;
    
    mViewForProductName.layer.borderWidth           = 1.0;
    mViewForProductName.layer.cornerRadius          = 2.0;
    mViewForProductName.layer.borderColor           = GBlueColour.CGColor;
    mViewForProductName.layer.masksToBounds         = YES;
    
    mViewForThickness.layer.borderWidth           = 1.0;
    mViewForThickness.layer.cornerRadius          = 2.0;
    mViewForThickness.layer.borderColor           = GBlueColour.CGColor;
    mViewForThickness.layer.masksToBounds         = YES;
}

# pragma Category Picker Delegates

- (void) customPopUPInMRPCalc {
    [self downScroll];
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
        
        if(str.count > 0) {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:titleKey] isEqualToString:ChoseStateTitle]) {
                mTextForState.text = [NSString stringWithFormat:@"%@",[[str objectAtIndex:0] objectForKey:@"STATE"]];
                [UserDefaultStorage setDealerState:[NSString stringWithFormat:@"%@",[[str objectAtIndex:0] objectForKey:@"STATE"]]];
                [UserDefaultStorage setZone:[NSString stringWithFormat:@"%@",[[str objectAtIndex:0] objectForKey:@"ZONE"]]];
               
            } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:titleKey] isEqualToString:ChoseProdCatTitle]) {
                mTextForCategory.text = [[str objectAtIndex:0] objectForKey:@"SUB_SUB_PRODUCT_SEGMENT_2016"];
                [UserDefaultStorage setPRODUCT_CATEGORY:[NSString stringWithFormat:@"%@",[[str objectAtIndex:0] objectForKey:@"SUB_SUB_PRODUCT_SEGMENT_2016"]]];
            } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:titleKey] isEqualToString:ChoseProductTitle]) {
                mTextForProductname.text = [NSString stringWithFormat:@"%@",[[str objectAtIndex:0] objectForKey:@"PRODUCT_DISPLAY_NAME"]];
                [UserDefaultStorage setPRODUCT_NAME:[NSString stringWithFormat:@"%@",[[str objectAtIndex:0] objectForKey:@"PRODUCT_DISPLAY_NAME"]]];
                if ([atStart isEqualToString:@"INIT"]) {
                    if ([[MailClassViewController sharedInstance].mSizeArray count] > 0) {
                        mTextForLength.text = [NSString stringWithFormat:@"%@",[[[MailClassViewController sharedInstance].mSizeArray objectAtIndex:0] objectForKey:@"LENGTH"]];
                        mTextForBreadth.text = [NSString stringWithFormat:@"%@",[[[MailClassViewController sharedInstance].mSizeArray objectAtIndex:0] objectForKey:@"BREDTH"]];
                        [UserDefaultStorage setLength:[NSString stringWithFormat:@"%@",[[[MailClassViewController sharedInstance].mSizeArray objectAtIndex:0] objectForKey:@"LENGTH"]]];
                        [UserDefaultStorage setWidth:[NSString stringWithFormat:@"%@",[[[MailClassViewController sharedInstance].mSizeArray objectAtIndex:0] objectForKey:@"BREDTH"]]];
                    } else {
                        [self getStandardSize];
                    }
                    if ([[MailClassViewController sharedInstance].mThicknessArray count] > 0) {
                        mTextForThickness.text = [NSString stringWithFormat:@"%@",[[[MailClassViewController sharedInstance].mThicknessArray objectAtIndex:0] objectForKey:@"THICK"]];
                        [UserDefaultStorage setThickness:[NSString stringWithFormat:@"%@",[[[MailClassViewController sharedInstance].mThicknessArray objectAtIndex:0] objectForKey:@"THICK"]]];
                        mBtnForThickness.titleLabel.text = EmptyString;

                    } else {
                        [self getThickness];
                    }
                }
                
            } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:titleKey] isEqualToString:ChoseSizeTitle]) {
                mTextForLength.text = [NSString stringWithFormat:@"%@",[[str objectAtIndex:0] objectForKey:@"LENGTH"]];
                 mTextForBreadth.text = [NSString stringWithFormat:@"%@",[[str objectAtIndex:0] objectForKey:@"BREDTH"]];
                [UserDefaultStorage setLength:[NSString stringWithFormat:@"%@",[[str objectAtIndex:0] objectForKey:@"LENGTH"]]];
                 [UserDefaultStorage setWidth:[NSString stringWithFormat:@"%@",[[str objectAtIndex:0] objectForKey:@"BREDTH"]]];
            } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:titleKey] isEqualToString:ChoseThicknessTitle]) {
                mTextForThickness.text = [NSString stringWithFormat:@"%@",[[str objectAtIndex:0] objectForKey:@"THICK"]];
                [UserDefaultStorage setThickness:[NSString stringWithFormat:@"%@",[[str objectAtIndex:0] objectForKey:@"THICK"]]];
                mBtnForThickness.titleLabel.text = EmptyString;
            }
           
        }
    }
    [customPicker removeFromSuperview];
    customPicker = nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    
     if (textField == mTextForLength) {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERSLength] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:EmptyString];
        return [string isEqualToString:filtered];
    } else if (textField == mTextForBreadth) {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERSLength] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:EmptyString];
        return [string isEqualToString:filtered];
    } else if (textField == mTextForThickness) {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERSLength] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:EmptyString];
        return [string isEqualToString:filtered];
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [customPicker removeFromSuperview];
    customPicker = nil;
    if (textField == mTextForLength &&  [sizeType isEqualToString:@"MM"]) {
        int length = [mTextForLength.text intValue];
        float value = [mTextForLength.text floatValue];
        if (length > 0 && length < 100) {
            
            mTextForLength.text = [NSString stringWithFormat:@"%.f",value * 25.4];
        } else {
            if (length != 0) {
                mTextForLength.text = [NSString stringWithFormat:@"%.f",value * 1.0];
            } else {
                mTextForLength.text = @"";
            }
        }
        [UserDefaultStorage setLength:[NSString stringWithFormat:@"%@",mTextForLength.text]];
        
    } else if (textField == mTextForBreadth &&  [sizeType isEqualToString:@"MM"]) {
        int length = [mTextForBreadth.text intValue];
        float value = [mTextForBreadth.text floatValue];
        if (length > 0 && length < 100) {
            mTextForBreadth.text = [NSString stringWithFormat:@"%.f",value * 25.4];
        } else {
            if (length != 0) {
                mTextForBreadth.text = [NSString stringWithFormat:@"%.f",value * 1.0];
            } else {
                mTextForBreadth.text = @"";
            }
        }
         [UserDefaultStorage setWidth:[NSString stringWithFormat:@"%@",mTextForBreadth.text]];
        
    }
//    [self checkWidthAndLength];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void) showActualMRP {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        float length = [mTextForLength.text floatValue];
        float width  = [mTextForBreadth.text floatValue];
        float thick  = [mTextForThickness.text floatValue];
        if ([sizeType isEqualToString:@"INCH"]) {
            [UserDefaultStorage setLength:[NSString stringWithFormat:@"%.f",length * 25.4]];
            [UserDefaultStorage setWidth:[NSString stringWithFormat:@"%.f",width * 25.4]];
            
        }
        [UserDefaultStorage setThickness:[NSString stringWithFormat:@"%.f",thick]];
        [[GreatPlusSharedGetRequestManager sharedInstance] executeRequest:CMD_GET_ACTUAL_MRP_DATA_INIT withUrl:sizeType andTagName:GetActualMRPTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode || statusCode == 0) {
                mLabelForMrpInfo.text = EmptyString;
                mLabelForWarrentyInfo.text = EmptyString;
                if ([[NSString stringWithFormat:@"%@",[result objectForKey:@"op_mrp"]] isEqualToString:@""]) {
//                    [self addPopUpForWidthAndLength:@"Message" andMessage:[NSString stringWithFormat:@"%@",[result objectForKey:@"op_message"]]];
                    [MailClassViewController showAlertViewWithTitle:@"Message" message:[NSString stringWithFormat:@"%@",[result objectForKey:@"op_message"]] delegate:nil tag:0];
                } else {
                    
                    mLabelForMrpInfo.text = [NSString stringWithFormat:@"₹%@",[Utility getFormatedAmount:[NSString stringWithFormat:@"%@",[result objectForKey:@"op_mrp"]]]];
                    mLabelForWarrentyInfo.text = [NSString stringWithFormat:@"%@", [result objectForKey:@"op_mrp_gurranty"]];
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

-(BOOL) isRetina4 {
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    return ([UIScreen mainScreen].scale == RETINA_SCALE && screenHeight == RETINA_4_HEIGHT);
}

-(void)scrollToPositionUP:(BOOL)isUP withTxtField:(UITextField *)textField {
    
    if ([self isRetina4]) {
        isUP ? ({
            
            CGPoint point;
            CGRect rect = [textField bounds];
            rect        = [textField convertRect:rect toView:mScrollView];
            point       = rect.origin;
            if (point.y > 200) {
                point.x = 0;
                point.y -=100;
                [mScrollView setContentOffset:point animated:YES];
            }}) : [mScrollView setContentOffset:offSet animated:YES];
    } else {
        isUP ? ({
            
            CGPoint point;
            CGRect rect = [textField bounds];
            rect        = [textField convertRect:rect toView:mScrollView];
            point       = rect.origin;
            // // // // // NSLog(@"positon %f",point.y);
            if (point.y > 160) {
                point.x = 0;
                point.y -=100;
                
                [mScrollView setContentOffset:point animated:YES];
            }}) : [mScrollView setContentOffset:offSet animated:YES];
    }
}

-(void)downScroll {
    mScrollView.contentSize = ([self isRetina4]) ? CGSizeMake(0,700.0f) : CGSizeMake(0,600.0f);
    [mScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [mScrollView setScrollEnabled:NO];
    [mTextForBreadth resignFirstResponder];
    [mTextForLength resignFirstResponder];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [customPicker removeFromSuperview];
    customPicker = nil;
    mScrollView.contentSize = ([self isRetina4]) ? CGSizeMake(0,700.0f) : CGSizeMake(0,600.0f);
    selectedField = textField;
    
    if (textField == mTextForLength) {
        [self scrollToPositionUP:YES withTxtField:selectedField];
    } else if (textField == mTextForBreadth) {
        [self scrollToPositionUP:YES withTxtField:selectedField];
    } 
    return YES;
}

@end
