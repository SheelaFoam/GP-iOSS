/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "FCDOBDatePicker.h"
#import "MailClassViewController.h"
#import "GreatPlusSharedHeader.h"


@implementation FCDOBDatePicker
@synthesize delegate;
@synthesize datePick;
@synthesize dateTxtFiled;
@synthesize saveDate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(someThingSelectedInDetailDOB:) name:@"someThingSelectedInDetailDOB" object:nil];
}

- (void)someThingSelectedInDetailDOB:(NSNotification*)notificationObject {
    NSString *dob = notificationObject.object;
    // NSLog(@"Chef Name from notification: %@",chefName);
    [self.dateTxtFiled setText:dob];
    NSLog(@" someThingSelectedInDetail  %@",notificationObject.object);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dob];
    [self.datePick setDate:dateFromString animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)doneBtnTapped:(id)sender {
    
    if ([delegate respondsToSelector:@selector(onDOBDatePickerDone:selectedDate:)]) {
        
        if (saveDate.length > 0) {
            [delegate onDOBDatePickerDone:sender selectedDate:saveDate];
            
        } else {
            [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Select date" delegate:nil tag:0];
        }
        
    }
}
- (IBAction)cancelBtnTapped:(id)sender{
    
    if ([delegate respondsToSelector:@selector(onDOBDatePickerCancel:)]) {
        [delegate onDOBDatePickerCancel:sender];
    }
}

-(void)dateChanged :(NSNotification *)object {
    
}

- (IBAction)valueChanged:(id)sender{
    
    NSString *selectedDate = [NSString stringWithFormat:@"%@",self.datePick.date];
    NSLog(@"selectedDate  %@",selectedDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyy-MM-dd HH:mm:ss Z"];
    NSDate *date = [dateFormatter dateFromString:selectedDate];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    NSString *dateWithNewFormat = [dateFormatter stringFromDate:date];
    NSLog(@"dateWithNewFormat: %@", dateWithNewFormat);
    saveDate = dateWithNewFormat;
    NSLog(@"saveDate  %@",saveDate);
    self.dateTxtFiled.text = saveDate;
  
    NSLog(@"Time:----------- %lli", [@(floor([date timeIntervalSince1970] * 1000)) longLongValue]);
    NSLog(@"Time: %lli", [@(floor([date timeIntervalSince1970])) longLongValue]);
    
}

@end
