//
//  applyLeaveVC.m
//  Sheela Foam
//
//  Created by Apple on 15/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "applyLeaveVC.h"
#import "historyModel.h"
#import "AppDelegate.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "historyModel.h"
#import "UIImageView+WebCache.h"
#import "profileVC.h"
@interface applyLeaveVC ()<UIPickerViewDelegate,UIPickerViewDataSource,WebServiceResponseProtocal,UIScrollViewDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIPickerView*pickerView;
    UIView*timeBackgroundView;
    NSString*pickercheck;
    NSDictionary*dataDic;
    MyWebServiceHelper *helper;
    NSArray*info;
    NSArray*leaveTypearray;
    NSUInteger pickerRow;
    NSString*leaveTypeStr;
    UIDatePicker*datePicker;
    NSString *leaveToDateStr;
    NSString *leaveFromDateStr;
    NSDate *startDate;
    NSDate *endDate;
    NSString*leaveOption;
    NSString*leavefrom;
    NSString*to;
    NSString*totaLeave;
    NSString*apiCheck;
    NSString*api;
}
@end
@implementation applyLeaveVC

- (IBAction)logout:(id)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.landingScrollView.delegate=self;
    self.reasonTextView.delegate=self;
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height /2;
    self.profileImg.layer.masksToBounds = YES;
    self.profileImg.layer.borderWidth = 0;
    self.nameLab.text=[NSString stringWithFormat:@"%@",[historyModel sharedhistoryModel].displayname];
    self.titleLab.text=[NSString stringWithFormat:@" %@",@"Fill the following information to apply for leave"];
    self.numberOfLeave.clipsToBounds=YES;
    self.numberOfLeave.layer.cornerRadius=7.0;
    self.leavefrom.layer.cornerRadius=7.0;
    self.leaveTo.layer.cornerRadius=7.0;
    self.reasonTextView.layer.cornerRadius=7.0;
    self.submitBtn.layer.cornerRadius=7.0;
    self.leaveType.layer.cornerRadius=7.0;
    _reasonTextView.delegate=self;
    [_reasonTextView setText:@"Reason"];
    [_reasonTextView setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [_reasonTextView setTextColor:[UIColor lightGrayColor]];
    [self bothLeaveOptionViewLoad];
    leavefrom=[NSString stringWithFormat:@"  Leave From"];
    [self.leavefrom setTitle:leavefrom forState:UIControlStateNormal];
    to=[NSString stringWithFormat:@"   Leave TO"];
    [self.leaveTo setTitle:to forState:UIControlStateNormal];
    self.leaveStatus.frame=CGRectMake(5,self.noteLab.frame.origin.y+self.noteLab.frame.size.height+10,self.view.frame.size.width-10,self.leaveStatus.frame.size.height);
    self.leaveStatus.layer.borderWidth = 1;
    self.leaveStatus.layer.borderColor = [UIColor darkGrayColor].CGColor;
    [self.landingScrollView addSubview:self.leaveStatus];
    pickerRow=0;
    pickercheck=@"leaveType";
    NSDictionary*dataString= @{@"mode":@"leave_list",@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"uid":[historyModel sharedhistoryModel].uid,@"op_user_emp_group_code":[historyModel sharedhistoryModel].opUserEmpGroupCode,@"user_email":[historyModel sharedhistoryModel].userEmail,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    [self leave:dataString];
 }
-(void)leave:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper leavetype:dataString];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    info=[dataDic objectForKey:@"info"];
    if([apiName isEqualToString:@"leavetype"])
    {
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([api isEqualToString:@"submit"])
                {
                    if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==1)
                    {
                        [self refreshController];
                        [MyCustomClass SVProgressMessageDismissWithSuccess:[[info objectAtIndex:0]objectForKey:@"msg"] timeDalay:3.0];
                    }
                }
                else
                {
                    NSLog(@"%u",[[dataDic objectForKey:@"leave_detail"] count]);
                    if (!([[dataDic objectForKey:@"leave_detail"] count]==0))
                    {
                        [self DetailleaveStatus];
                    }
                    leaveTypearray=[[[dataDic objectForKey:@"info"] objectAtIndex:0]objectForKey:@"leave_type1"];
                    [leaveTypearray mutableCopy];
                    [SVProgressHUD dismiss];
                }
            });
        }
    }
    
    else
    {
        NSString *msg = [dataDic objectForKey:@"msg"];
        [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:3.0];
    }
}
-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknow Error" timeDalay:2.0];
}
-(void)DetailleaveStatus
{
    self.clOpening.text= self.clOpening.text=[[[dataDic objectForKey:@"leave_detail"] objectAtIndex:0]objectForKey:@"op_open_cl"];;
    self.clEncash.text=[[[dataDic objectForKey:@"leave_detail"] objectAtIndex:0]objectForKey:@"op_receive_cl"];
    self.clTaken.text=[[[dataDic objectForKey:@"leave_detail"] objectAtIndex:0]objectForKey:@"op_issue_cl"];
    self.clBalance.text=[[[dataDic objectForKey:@"leave_detail"] objectAtIndex:0]objectForKey:@"op_bal_cl"];
    self.elOpening.text=[[[dataDic objectForKey:@"leave_detail"] objectAtIndex:0]objectForKey:@"op_open_el"];
    self.elEncash.text=[[[dataDic objectForKey:@"leave_detail"] objectAtIndex:0]objectForKey:@"op_receive_el"];
    self.elTaken.text=[[[dataDic objectForKey:@"leave_detail"] objectAtIndex:0]objectForKey:@"op_issue_el"];
    self.elBalance.text=[[[dataDic objectForKey:@"leave_detail"] objectAtIndex:0]objectForKey:@"op_bal_el"];
    self.Opening.text=[[[dataDic objectForKey:@"leave_detail"] objectAtIndex:0]objectForKey:@"op_open_co"];
    self.coEncash.text=[[[dataDic objectForKey:@"leave_detail"] objectAtIndex:0]objectForKey:@"op_receive_co"];
    self.coTaken.text=[[[dataDic objectForKey:@"leave_detail"] objectAtIndex:0]objectForKey:@"op_issue_co"];
    self.coBalance.text=[[[dataDic objectForKey:@"leave_detail"] objectAtIndex:0]objectForKey:@"op_bal_co"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)leaveType:(id)sender {
     self.leaveType.userInteractionEnabled=NO;
    pickercheck=@"leaveType";
    self.leavefrom.userInteractionEnabled=YES;
    self.leaveTo.userInteractionEnabled=YES;
    [self CreatePicker];
    [pickerView reloadAllComponents];
}
- (IBAction)leavefrom:(id)sender {
    CGPoint point = CGPointMake(0, self.leavefrom.frame.origin.y-1.0 * self.leavefrom.frame.size.height);
    [self.landingScrollView setContentOffset:point animated:YES];
    pickercheck=@"leaveFrom";
    self.leavefrom.userInteractionEnabled=NO;
    self.leaveType.userInteractionEnabled=YES;
    self.leaveTo.userInteractionEnabled=YES;
    [self datePicker];
}
- (IBAction)leaveTo:(id)sender
{
    CGPoint point = CGPointMake(0, self.leaveTo.frame.origin.y-1.0 * self.leaveTo.frame.size.height);
    [self.landingScrollView setContentOffset:point animated:YES];
    pickercheck=@"leaveTo";
    self.leaveTo.userInteractionEnabled=NO;
    self.leaveType.userInteractionEnabled=YES;
    self.leavefrom.userInteractionEnabled=YES;
    [self datePicker];
}
- (IBAction)first:(id)sender
{
    [SVProgressHUD dismiss];
    [self.numberOfLeave setTitle:@".5" forState:UIControlStateNormal];
    totaLeave=@".5";
    [self.leaveTo setTitle:leaveFromDateStr forState:UIControlStateNormal];
    [self.imageFirst setImage:[UIImage imageNamed: @"radioSelect"]];
    [self.imageSecond setImage:[UIImage imageNamed: @"radioUnselect"]];
    [self.imageThird setImage:[UIImage imageNamed: @"radioUnselect"]];
    leaveOption=@"F";
}
- (IBAction)second:(id)sender
{
    [self.numberOfLeave setTitle:@".5" forState:UIControlStateNormal];
    totaLeave=@".5";
    [self.leaveTo setTitle:leaveFromDateStr forState:UIControlStateNormal];
    [self.imageSecond setImage:[UIImage imageNamed: @"radioSelect"]];
    [self.imageThird setImage:[UIImage imageNamed: @"radioUnselect"]];
    [self.imageFirst setImage:[UIImage imageNamed: @"radioUnselect"]];
    leaveOption=@"S";
}
- (IBAction)third:(id)sender
{
    [self bothLeaveOption];
}
-(void)bothLeaveOptionViewLoad
{
    [self.numberOfLeave setTitle:@"" forState:UIControlStateNormal];
    totaLeave=@"";
    [self.imageThird setImage:[UIImage imageNamed: @"radioSelect"]];
    [self.imageSecond setImage:[UIImage imageNamed: @"radioUnselect"]];
    [self.imageFirst setImage:[UIImage imageNamed: @"radioUnselect"]];
    leaveOption=@"B";
}
-(void)bothLeaveOption
{
    [self.numberOfLeave setTitle:@"1" forState:UIControlStateNormal];
    totaLeave=@"1";
    [self.imageThird setImage:[UIImage imageNamed: @"radioSelect"]];
    [self.imageSecond setImage:[UIImage imageNamed: @"radioUnselect"]];
    [self.imageFirst setImage:[UIImage imageNamed: @"radioUnselect"]];
    leaveOption=@"B";
}

-(void)datePicker
{
    timeBackgroundView.hidden=YES;
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width,180)];
    NSDate *date = [NSDate date];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.hidden = NO;
    datePicker.date = date;
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, Window_Width, 64)];
    pickerToolbar.tintColor = [UIColor whiteColor];
    [pickerToolbar sizeToFit];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(clickOnCancelButtonOnActionSheet:)];
    
    [cancelBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                       NSForegroundColorAttributeName,
                                       nil] forState:UIControlStateNormal];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *titleButton;
    //float pickerMarginHeight = 168;
    titleButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target: nil action: nil];
    [titleButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                         NSForegroundColorAttributeName,
                                         nil] forState:UIControlStateNormal];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(clickOnDoneButtonOnActionSheet1:)];
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                     NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];
    NSArray *itemArray = [[NSArray alloc] initWithObjects:cancelBtn, flexSpace, titleButton, flexSpace, doneBtn, nil];
    timeBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,Window_Height-240, Window_Width, 246)];
    [timeBackgroundView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    [timeBackgroundView addSubview:pickerToolbar];
    [timeBackgroundView addSubview:datePicker];
    [[AppDelegate appDelegate].window addSubview:timeBackgroundView];
    [pickerToolbar setItems:itemArray animated:YES];
}
-(void)CreatePicker
{
    timeBackgroundView.hidden=YES;
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 100)];
    pickerView.delegate=self;
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    pickerToolbar.tintColor = [UIColor whiteColor];
    [pickerToolbar sizeToFit];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(clickOnCancelButtonOnActionSheet:)];
    [cancelBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                       NSForegroundColorAttributeName,
                                       nil] forState:UIControlStateNormal];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *titleButton;
    //float pickerMarginHeight = 168;
    titleButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target: nil action: nil];
    [titleButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                         NSForegroundColorAttributeName,
                                         nil] forState:UIControlStateNormal];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(clickOnDoneButtonOnActionSheet1:)];
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                     NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];
    NSArray *itemArray = [[NSArray alloc] initWithObjects:cancelBtn, flexSpace, titleButton, flexSpace, doneBtn, nil];
    timeBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,Window_Height-160, Window_Width, 170)];
    [timeBackgroundView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    [timeBackgroundView addSubview:pickerToolbar];
    [timeBackgroundView addSubview:pickerView];
    [[AppDelegate appDelegate].window addSubview:timeBackgroundView];
    [pickerToolbar setItems:itemArray animated:YES];
}
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
            return [leaveTypearray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
       return [leaveTypearray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    pickerRow=row;
    NSLog(@"pickerRow....>%ld",(long)pickerRow);
}
-(void)clickOnDoneButtonOnActionSheet1:(id)sender
{
    if ([pickercheck isEqualToString:@"leaveType"])
    {
        leaveTypeStr=[leaveTypearray objectAtIndex:pickerRow];
        [self.leaveType setTitle:leaveTypeStr forState:UIControlStateNormal];
        timeBackgroundView.hidden=YES;
        self.leaveType.userInteractionEnabled=YES;
    }
    else if([pickercheck isEqualToString:@"leaveFrom"])
    {
        leaveTypeStr=[leaveTypearray objectAtIndex:pickerRow];
        timeBackgroundView.hidden=YES;
        self.leavefrom.userInteractionEnabled=YES;
        NSDate*date=datePicker.date;
        NSLog(@"%@",date);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        leaveFromDateStr= [formatter stringFromDate:date];
        NSLog(@"%@",leaveFromDateStr);
        [self.leavefrom setTitle:leaveFromDateStr forState:UIControlStateNormal];
        [self calculateDay];
    }
    else if([pickercheck isEqualToString:@"leaveTo"])
    {
        leaveTypeStr=[leaveTypearray objectAtIndex:pickerRow];
        timeBackgroundView.hidden=YES;
        self.leaveTo.userInteractionEnabled=YES;
        NSDate*date=datePicker.date;
        NSLog(@"%@",date);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        leaveToDateStr = [formatter stringFromDate:date];
        NSLog(@"%@",leaveToDateStr);
        [self.leaveTo setTitle:leaveToDateStr forState:UIControlStateNormal];
        [self calculateDay];
    }
    CGPoint point = CGPointMake(0, 0);
    [self.landingScrollView setContentOffset:point animated:YES];

}
-(void)clickOnCancelButtonOnActionSheet:(id)sender
{
    if ([pickercheck isEqualToString:@"leaveType"])
    {
        timeBackgroundView.hidden=YES;
        self.leaveType.userInteractionEnabled=YES;
    }
    else if([pickercheck isEqualToString:@"leaveFrom"])
    {
        timeBackgroundView.hidden=YES;
        self.leavefrom.userInteractionEnabled=YES;
    }
    else if([pickercheck isEqualToString:@"leaveTo"])
    {
        timeBackgroundView.hidden=YES;
        self.leaveTo.userInteractionEnabled=YES;
    }
    CGPoint point = CGPointMake(0, 0);
    [self.landingScrollView setContentOffset:point animated:YES];
}
-(void)compareDate
{
    [SVProgressHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"If you choose First, Second or Both options than Leave From & Leave To date must be same"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
}
-(void)calculateDay
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd/MM/yyyy"];
    startDate = [f dateFromString:leaveFromDateStr];
    endDate = [f dateFromString:leaveToDateStr];
    if (!leaveToDateStr)
    {
    
    }
   else if (startDate <=endDate)
    {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
        NSLog(@"%ld", (long)[components day]);
        totaLeave=(NSString*)[NSString stringWithFormat:@"%d", [components day]+1];
    [self.imageThird setImage:[UIImage imageNamed: @"radioSelect"]];
    [self.imageSecond setImage:[UIImage imageNamed: @"radioUnselect"]];
    [self.imageFirst setImage:[UIImage imageNamed: @"radioUnselect"]];
    leaveOption=@"B";
    [self.numberOfLeave setTitle:totaLeave forState:UIControlStateNormal];
    }
    else
    {
        totaLeave=@"";
        [self.numberOfLeave setTitle:totaLeave forState:UIControlStateNormal];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"You must provide Leave To date greater than Leave From"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)submitBtn:(id)sender {
    [SVProgressHUD show];
    
     if([self.leaveType.titleLabel.text isEqualToString:@"Please select the leave type"])
    {
        [MyCustomClass SVProgressMessageDismissWithError:@"select leave type" timeDalay:3.0];
        
    }
   else if([self.leavefrom.titleLabel.text isEqualToString:leavefrom])
    {
        [MyCustomClass SVProgressMessageDismissWithError:@"select from date" timeDalay:2.0];
    }
    else if([self.leaveTo.titleLabel.text isEqualToString:to])
    {
        [MyCustomClass SVProgressMessageDismissWithError:@"select TO date" timeDalay:2.0];
        
    }

   else if([self.leavefrom.titleLabel.text isEqualToString:leavefrom])
    {
        [MyCustomClass SVProgressMessageDismissWithError:@"select from date" timeDalay:2.0];
    }
    else if([self.leaveTo.titleLabel.text isEqualToString:to])
    {
        [MyCustomClass SVProgressMessageDismissWithError:@"select TO date" timeDalay:2.0];
        
    }
   else if([self.leavefrom.titleLabel.text isEqualToString:leavefrom])
    {
        [MyCustomClass SVProgressMessageDismissWithError:@"select from date" timeDalay:2.0];
    }
    else if([self.leaveTo.titleLabel.text isEqualToString:to])
    {
        [MyCustomClass SVProgressMessageDismissWithError:@"select TO date" timeDalay:2.0];
        
    }
    else if([self.numberOfLeave.titleLabel.text isEqualToString:@"Number of leave"])
    {
          [MyCustomClass SVProgressMessageDismissWithError:@"select date" timeDalay:3.0];
    }
    else if([self.numberOfLeave.titleLabel.text isEqualToString:@"0"])
    {
        [MyCustomClass SVProgressMessageDismissWithError:@"select date" timeDalay:3.0];
    }
    else if([self.reasonTextView.text isEqualToString:@"Reason"]||[self.reasonTextView.text isEqualToString:@""])
    {
        [MyCustomClass SVProgressMessageDismissWithError:@"type reason" timeDalay:3.0];
    }
   else if ([leaveOption isEqualToString:@"First"]||[leaveOption isEqualToString:@"Second"]||[leaveOption isEqualToString:@"Third"])
    {
        if (!(startDate==endDate))
        {
            [self compareDate];
        }
        else
        {
            [self submitLeave];
        }
    }
    else
    {
        [self submitLeave];
    }

}
-(void)submitLeave
{
    api=@"submit";
    if (!leaveOption)
    {
        leaveOption=@"";
    }
    NSDictionary*dataString=@{@"p_leave_type":leaveTypeStr,@"p_leave_date_from":leaveFromDateStr, @"p_leave_date_to":leaveFromDateStr, @"p_leave_nos":totaLeave,@"p_remark":self.reasonTextView.text,@"op_user_name":[historyModel sharedhistoryModel].displayname,@"p_half_day_leave_dt":@"",@"p_which_half_leave":leaveOption,@"user_email":[historyModel sharedhistoryModel].userEmail,@"uid":[historyModel sharedhistoryModel].uid,@"mode":@"apply_leave",@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"op_user_emp_group_code":[historyModel sharedhistoryModel].opUserEmpGroupCode,@"token":[historyModel sharedhistoryModel].token};
    [helper leavetype:dataString];
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    CGPoint point = CGPointMake(0, self.numberOfLeave.frame.origin.y-1.0 * self.reasonTextView.frame.size.height);
    [self.landingScrollView setContentOffset:point animated:YES];
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (_reasonTextView.textColor == [UIColor lightGrayColor])
    {
        _reasonTextView.text = @"";
        _reasonTextView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(_reasonTextView.text.length == 0){
        _reasonTextView.textColor = [UIColor lightGrayColor];
        _reasonTextView.text = @"Reason";
        [_reasonTextView resignFirstResponder];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(_reasonTextView.text.length == 0){
            _reasonTextView.textColor = [UIColor lightGrayColor];
            _reasonTextView.text = @"Reason";
            [_reasonTextView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString*getImgUrl = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceName"];
    [self.profileImg setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    
    [super viewWillAppear:animated];
    NSString*pageName=@"Apply Leave Page";
    [MyCustomClass logApi:pageName];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            // iPhone 4s
            self.landingScrollView.contentSize= CGSizeMake(0,550);        }
        if(result.height == 568)
        {
            // iPhone 5s
            self.landingScrollView.contentSize= CGSizeMake(0,1050);        }
        if(result.height == 667)
            
        {
            // iPhone 6
            self.landingScrollView.contentSize= CGSizeMake(0,1050);
        }
        if(result.height == 736 )
        {
            
            // iPhone 6 Plus$6splus
            
            self.landingScrollView.contentSize= CGSizeMake(0,1650);
        }
    }

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    timeBackgroundView.hidden=YES;
    
    }

-(void)refreshController
{
    [self.leaveType setTitle:@"Please select the leave type" forState:UIControlStateNormal];
    [self.leavefrom setTitle:@"  Leave From" forState:UIControlStateNormal];
    [self.leaveTo setTitle:@"   Leave TO" forState:UIControlStateNormal];
    [self.numberOfLeave setTitle:@"" forState:UIControlStateNormal];
    [_reasonTextView setTextColor:[UIColor lightGrayColor]];
    _reasonTextView.text = @"Reason";
}

- (IBAction)profileBtn:(id)sender
{
    profileVC*profile=[[profileVC alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
}




@end
