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

@interface GreatPlusExchangeOfferViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate> {
    
    POAcvityView                 *activityIndicator;
    __weak IBOutlet UIScrollView *mScrollView;
    __weak IBOutlet UIButton *mBtnAction;
    __weak IBOutlet UIButton *mBtnSend;
    __weak IBOutlet UIButton *btnUnregister;
    __weak IBOutlet UILabel *mLblForNav;
    __weak IBOutlet UILabel *mLblForNavTitle;
    __weak IBOutlet UILabel *mLblForSerialNo1;
    __weak IBOutlet UITextField *mTextForSerialNo1;
    __weak IBOutlet UILabel *mLblForSerialNo2;
    __weak IBOutlet UITextField *mTextForSerialNo2;
    __weak IBOutlet UIButton *mNoExchngBtn;
    __weak IBOutlet UILabel *mLblForNoExchngOffer;
    __weak IBOutlet UILabel *mLblForCunsumerNo;
    __weak IBOutlet UITextField *mTextForConsumerNo;
    __weak IBOutlet UIButton *mTermsBtn;
    __weak IBOutlet UILabel *mLblForTerms;
    __weak IBOutlet UIView *mViewForInfo;
    __weak IBOutlet UILabel *mLblForEOCB;
    __weak IBOutlet UILabel *mLblForEOCBInfo;
    __weak IBOutlet UILabel *mLblForSmile;
    __weak IBOutlet UILabel *mLblForSmileInfo;
    __weak IBOutlet UILabel *mLblFormattressPoints;
    __weak IBOutlet UILabel *mLblFormattressPointsInfo;
    __weak IBOutlet UILabel *mDiv1;
    __weak IBOutlet UILabel *mDiv2;
    __weak IBOutlet UIView  *mView1;
    __weak IBOutlet UIView *mView2;
    __weak IBOutlet UIView *mView3;
    __weak IBOutlet UILabel                        *mLabelForSplAllowence;
    __weak IBOutlet UITextField *bundleNumberField;
    __weak IBOutlet UITextField *customerNameField;
    __weak IBOutlet UITextField *customerEmailField;

    __weak IBOutlet UITextField *txtFieldInvoiceDate;
    __weak IBOutlet UITextField *txtFieldInvoiceNumber;
    __weak IBOutlet UITextField *salesRepTxtField;
    BOOL                                            checkValue;
    BOOL                                            checkBoxSelected;
    CGPoint                                             offSet;
    UITextField                                         *selectedField;

}

@property (nonatomic, copy) NSString *strtitle;
- (IBAction)mBackBtnTapped:(UIButton *)sender;
- (IBAction)mCheckBtnTapped:(UIButton *)sender;
- (IBAction)mTermsBtnTapped:(UIButton *)sender;
- (IBAction)mSendBtnTapped:(UIButton *)sender;
- (IBAction)mScan1BtnTapped:(UIButton *)sender;
- (IBAction)mScan2BtnTapped:(UIButton *)sender;
- (IBAction)unregisterTapped:(id)sender;



@property (weak, nonatomic) IBOutlet UILabel *shadowLbl;
@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (weak, nonatomic) IBOutlet UITableView *serialNosTable;
@property (weak, nonatomic) IBOutlet UITableView *suggestionsTable;

@end
