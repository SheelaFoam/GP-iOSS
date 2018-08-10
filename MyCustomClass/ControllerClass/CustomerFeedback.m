//
//  CustomerFeedback.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 10/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "CustomerFeedback.h"

@interface CustomerFeedback() <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate> {
    NSMutableArray *pickerArray;
    NSString *selectedOption;
}

@end

@implementation CustomerFeedback

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetup];
    pickerArray = [[NSMutableArray alloc] init];
    selectedOption = [[NSString alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [_firstNameTextField resignFirstResponder];
        [_lastNameTextField resignFirstResponder];
        [_emailTextField resignFirstResponder];
        [_purposeTextField resignFirstResponder];
        [_ageTextField resignFirstResponder];
        [_mobileTextField resignFirstResponder];
        [_dobTextField resignFirstResponder];
    }
}

- (IBAction)selectEmployee:(id)sender {
}

- (IBAction)selectStore:(id)sender {
}

- (IBAction)selectGender:(id)sender {
    [self showAlert:@[@"Male", @"Female"] withTitle:@"Select Gender" andStyle:UIAlertControllerStyleAlert withButtonName:_genderButton];
}

- (IBAction)heardAboutSleepwell:(id)sender {
    [self showAlert:@[@"TV", @"Newspaper", @"Radio", @"Internet", @"Others"] withTitle:@"Where did you hear about Sleepwell ?" andStyle:UIAlertControllerStyleAlert withButtonName:_hearButton];
}

- (IBAction)everPurchasedItem:(id)sender {
    [self showAlert:@[@"Yes", @"No"] withTitle:@"Have you ever purchased any item from us ?" andStyle:UIAlertControllerStyleAlert withButtonName:_purchaseHistoryButton];
}

- (IBAction)interestedProducts:(id)sender {
}

- (IBAction)currentMattressBrand:(id)sender {
    [self showAlert:@[@"Sheela Foam", @"Sleepwell", @"Rubco", @"Tempur-Pedic", @"Dunlopillo", @"MM Foam", @"Duro Flex", @"Sleepzone", @"King Koil", @"Restonic", @"None"] withTitle:@"Current Mattress Brand*" andStyle:UIAlertControllerStyleAlert withButtonName:_currentMattressButton];
}

- (IBAction)submit:(id)sender {
}

//************ TextField Delegate methods ************

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

//************ Picker Data Source/Delegate methods ************

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    selectedOption = pickerArray[row];
}

////************ TableView Data Source/Delegate methods ************
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 7;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//************ Custom Methods ************

-(void) initialSetup {
    
    [self applyTextFieldBorder:_firstNameTextField andWidth:1.0];
    [self applyTextFieldBorder:_lastNameTextField andWidth:1.0];
    [self applyTextFieldBorder:_emailTextField andWidth:1.0];
    [self applyTextFieldBorder:_mobileTextField andWidth:1.0];
    [self applyTextFieldBorder:_ageTextField andWidth:1.0];
    [self applyTextFieldBorder:_purposeTextField andWidth:1.0];
    [self applyTextFieldBorder:_dobTextField andWidth:1.0];
    
    [self applyButtonBorder:_employeeButton andWidth:1.0];
    [self applyButtonBorder:_storeButton andWidth:1.0];
    [self applyButtonBorder:_genderButton andWidth:1.0];
    [self applyButtonBorder:_hearButton andWidth:1.0];
    [self applyButtonBorder:_purchaseHistoryButton andWidth:1.0];
    [self applyButtonBorder:_interestButton andWidth:1.0];
    [self applyButtonBorder:_currentMattressButton andWidth:1.0];
    
    UIDatePicker *dobPicker = [[UIDatePicker alloc]init];
    [dobPicker setDate:[NSDate date]];
    dobPicker.datePickerMode = UIDatePickerModeDate;
    [dobPicker addTarget:self action:@selector(dobTextField:) forControlEvents:UIControlEventValueChanged];
    [_dobTextField setInputView:dobPicker];
    
}

-(void) applyButtonBorder: (UIButton *)button andWidth: (int) width {
    
    [[button layer] setBorderColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor];
    [[button layer] setBorderWidth:width];
    [[button layer] setCornerRadius:5.0];
}

-(void) applyTextFieldBorder: (UITextField *)textfield andWidth: (int) width {
    
    [[textfield layer] setBorderColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor];
    [[textfield layer] setBorderWidth:width];
    [[textfield layer] setCornerRadius:5.0];
}

-(void) showAlert: (NSArray *)dataSourceArray withTitle: (NSString *)title andStyle: (UIAlertControllerStyle)style withButtonName: (UIButton *)button {
    
    pickerArray = [NSMutableArray arrayWithArray:dataSourceArray];
    
    UIAlertController *alert = [[UIAlertController alloc] init];
    alert = [UIAlertController alertControllerWithTitle:title message:@"\n\n\n\n\n\n\n" preferredStyle:style];
    
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(alert.view.bounds.size.width*0.025, alert.view.bounds.size.height*0.075, 250, 140)];
    
    [alert.view addSubview:picker];
    [picker setDataSource:self];
    [picker setDelegate:self];
    
    UIAlertAction *okay = [[UIAlertAction alloc] init];
    okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([selectedOption isEqualToString:@""] || [selectedOption isKindOfClass:[NSNull class]]) {
            selectedOption = pickerArray[0];
        }
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"  %@", selectedOption] forState:UIControlStateNormal];
    }];
    UIAlertAction *cancel = [[UIAlertAction alloc] init];
    cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:okay];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:true completion:nil];
}

-(void) dobTextField:(id)sender {
    
    UIDatePicker *picker = (UIDatePicker*)_dobTextField.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _dobTextField.text = [NSString stringWithFormat:@"  %@",dateString];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}
@end
