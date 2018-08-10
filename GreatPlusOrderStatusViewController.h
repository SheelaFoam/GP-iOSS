/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import <UIKit/UIKit.h>
#import "FCDOBDatePicker.h"
#import "CityView.h"

@interface GreatPlusOrderStatusViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, FCDOBDatePickerDelegate, CityTableDelegate, UIAlertViewDelegate> {
    FCDOBDatePicker                                 *datePicker;
    POAcvityView                                    *activityIndicator;
    CityView                                        *customPicker;
    __weak IBOutlet UIButton                        *mBtnAction;
    __weak IBOutlet UILabel                         *mLblForNav;
    __weak IBOutlet UILabel                         *mLblForNavTitle;
    __weak IBOutlet UILabel                         *mLblForDiv1;
    __weak IBOutlet UIImageView                     *mImageViewForLogo;
    __weak IBOutlet UILabel                         *mLabelForAppType;
    __weak IBOutlet UILabel                         *mLblForFrom;
    __weak IBOutlet UIView                          *mViewForFrom;
    __weak IBOutlet UITextField                     *mTextForFrom;
    __weak IBOutlet UIButton                        *mBtnForFrom;
    __weak IBOutlet UILabel                         *mLblForTo;
    __weak IBOutlet UIView                          *mViewForTo;
    __weak IBOutlet UITextField                     *mTextForTo;
    __weak IBOutlet UIButton                        *mBtnForTo;
    __weak IBOutlet UILabel                         *mLblForStatus;
    __weak IBOutlet UIView                          *mViewForStatus;
    __weak IBOutlet UITextField                     *mTextForStatus;
    __weak IBOutlet UIButton                        *mBtnForStatus;
    __weak IBOutlet UITableView                     *mTableForOrder;
    NSMutableArray                                  *mOrderStatusContainer;
    NSString                                        *statusCodeForOrder;
}

- (IBAction)mBackBtnTapped:(UIButton *)sender;
- (IBAction)mCustomBtnTapped:(UIButton *)sender;
- (IBAction)mGoBtnTapped:(UIButton *)sender;


@end
