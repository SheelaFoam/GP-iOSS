/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol FCDOBDatePickerDelegate <NSObject>

- (void)onDOBDatePickerCancel:(id)sender;
- (void)onDOBDatePickerDone:(id)sender selectedDate:(NSString *)str;

@end
@interface FCDOBDatePicker : UIView {

    id<FCDOBDatePickerDelegate>__weak delegate;
    NSString *saveDate;
    NSDate *saveDatea;
}
- (IBAction)doneBtnTapped:(id)sender;
- (IBAction)cancelBtnTapped:(id)sender;
- (IBAction)valueChanged:(id)sender;
- (void)someThingSelectedInDetailDOB:(NSNotification *)notificationObject;

@property (nonatomic, weak) id<FCDOBDatePickerDelegate>delegate;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePick;
@property (nonatomic, strong) IBOutlet UITextField  *dateTxtFiled;
@property (nonatomic, strong) NSString *saveDate;
@end
