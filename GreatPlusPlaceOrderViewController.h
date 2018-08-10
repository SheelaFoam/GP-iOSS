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

@interface GreatPlusPlaceOrderViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate, CityTableDelegate, UIAlertViewDelegate> {
    CityView                                       *customPicker;
    POAcvityView                                  *activityIndicator;
    __weak IBOutlet UIButton                       *mBtnAction;
    __weak IBOutlet UILabel                        *mLblForNav;
    __weak IBOutlet UILabel                        *mLblForNavTitle;
    
    __weak IBOutlet UILabel                        *mLblForDiv1;
    __weak IBOutlet UIImageView                    *mImageViewForLogo;
    __weak IBOutlet UILabel                        *mLabelForAppType;
    __weak IBOutlet UIScrollView                   *mScrollName;
    
    __weak IBOutlet UIView                         *mViewForDate;
    __weak IBOutlet UITextField                    *mTextForDate;
    
    __weak IBOutlet UIView                         *mViewForDistributorName;
    __weak IBOutlet UITextField                    *mTextForDistributorName;
    
    __weak IBOutlet UIView                         *mViewForDelearName;
    __weak IBOutlet UITextField                    *mTextForDelearName;
    
    __weak IBOutlet UIView                         *mViewForProductName;
    __weak IBOutlet UITextField                    *mTextForProductName;
    
    __weak IBOutlet UIView                         *mViewForColourName;
    __weak IBOutlet UITextField                    *mTextForColourName;
    
    __weak IBOutlet UIView                         *mViewForL;
    __weak IBOutlet UITextField                    *mTextForL;
    
    __weak IBOutlet UIView                         *mViewForW;
    __weak IBOutlet UITextField                    *mTextForW;
    
    __weak IBOutlet UIView                         *mViewForT;
    __weak IBOutlet UITextField                    *mTextForT;
    
    __weak IBOutlet UIButton                       *mPcsBtn;
    __weak IBOutlet UILabel                        *mPcsLabel;
    
    __weak IBOutlet UIButton                       *mBdlBtn;
    __weak IBOutlet UILabel                        *mBdlLabel;
    
    __weak IBOutlet UIView                         *mViewForQuantity;
    __weak IBOutlet UITextField                    *mTextForQuantity;
    
    __weak IBOutlet UIView                         *mViewForCustomerName;
    __weak IBOutlet UITextField                    *mTextForCustomerName;
    
    __weak IBOutlet UIView                         *mViewForMobileNumber;
    __weak IBOutlet UITextField                    *mTextForMobileNumber;
    
    __weak IBOutlet UIView                         *mViewForRemark;
    __weak IBOutlet UITextField                    *mTextForRemark;
    
    __weak IBOutlet UIButton                       *mSendBtn;
    __weak IBOutlet UIButton                       *mSaveAndNewBtn;
    CGPoint                                        offSet;
    UITextField                                    *selectedField;
    NSString                                       *mLocationCode;
    NSString                                       *mTypeOfPeice;
    NSString                                       *mColourApplicable;
    NSString                                       *mColour;
    NSString                                       *mSizeAutofill;
    BOOL                                           isAutoFill;
    NSString                                       *mCodeForLocation;
    NSString                                       *tabName;
    NSString                                       *mChannel_partner_group;
}
- (IBAction)mPcsBtnTapped:(UIButton *)sender;
- (IBAction)mBdlBtnTapped:(UIButton *)sender;
- (IBAction)mBackBtnTapped:(UIButton *)sender;
- (IBAction)mSendBtnTapped:(UIButton *)sender;
- (IBAction)mSaveAndNewBtnTapped:(UIButton *)sender;
- (IBAction)mCustomBtnTapped:(UIButton *)sender;


@end
