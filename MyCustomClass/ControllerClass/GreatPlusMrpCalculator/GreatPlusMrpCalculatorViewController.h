/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import <UIKit/UIKit.h>
#import "POAcvityView.h"
#import "CityView.h"
#import "GreatPlusPopUp.h"

@interface GreatPlusMrpCalculatorViewController : UIViewController <CityTableDelegate, GreatPlusPopUpDelegate> {
    GreatPlusPopUp                  *filterPopUp;
    CityView                                        *customPicker;
    POAcvityView                                    *activityIndicator;
    __weak IBOutlet UILabel                         *mLblForNav;
    __weak IBOutlet UILabel                         *mLblForNavTitle;
    __weak IBOutlet UILabel                         *mLblForDiv1;
    __weak IBOutlet UIImageView                     *mImageViewForLogo;
    __weak IBOutlet UILabel                         *mLabelForAppType;
    __weak IBOutlet UIScrollView                    *mScrollView;
    __weak IBOutlet UILabel *mLblForState;
    __weak IBOutlet UIView *mViewForState;
    __weak IBOutlet UITextField *mTextForState;
    __weak IBOutlet UIButton *mBtnForState;
    __weak IBOutlet UILabel *mLblForCategory;
    __weak IBOutlet UIView *mViewForCategory;
    __weak IBOutlet UITextField *mTextForCategory;
    __weak IBOutlet UIButton *mBtnForCategory;
    __weak IBOutlet UIView *mViewForProductName;
    __weak IBOutlet UILabel *mLblForProductName;
    __weak IBOutlet UITextField *mTextForProductname;
    __weak IBOutlet UIButton *mBtnForProductName;
    //__weak IBOutlet UIButton *mBtnForProductName;
    __weak IBOutlet UILabel *mLabelForMM;
    __weak IBOutlet UILabel *mLabelForInch;
    __weak IBOutlet UISwitch *mSwitchView;
    __weak IBOutlet UILabel *mLabelForLength;
    __weak IBOutlet UILabel *mLabelForThickness;
    __weak IBOutlet UILabel *mLabelForBreadth;
    __weak IBOutlet UIView *mViewForThickness;
    __weak IBOutlet UITextField *mTextForLength;
    __weak IBOutlet UITextField *mTextForBreadth;
    __weak IBOutlet UITextField *mTextForThickness;
    NSString *atStart;
    NSString *atState;
    NSString *sizeType;
    __weak IBOutlet UIButton *mBtnForThickness;
    CGPoint                                        offSet;
    UITextField                                    *selectedField;
    __weak IBOutlet UILabel  *mLabelForMrpInfo;
    __weak IBOutlet UILabel  *mLabelForWarrentyInfo;
    
}
- (IBAction)mBtnForProductNameClicked:(UIButton *)sender;
- (IBAction)mButtonShowClicked:(UIButton *)sender;

- (IBAction)mBackBtnTapped:(UIButton *)sender;
- (IBAction)mBtnForStateClicked:(UIButton *)sender;
- (IBAction)mBtnForCategoryClicked:(UIButton *)sender;
- (IBAction)mBtnForStandardSizeClicked:(UIButton *)sender;
- (IBAction)mBtnForThicknessClicked:(UIButton *)sender;
- (IBAction)changeSwitch:(id)sender;
@end
