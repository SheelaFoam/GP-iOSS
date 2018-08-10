//
//  CustomerFeedback.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 10/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerFeedback : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *employeeButton;
@property (weak, nonatomic) IBOutlet UIButton *storeButton;
@property (weak, nonatomic) IBOutlet UIButton *genderButton;
@property (weak, nonatomic) IBOutlet UIButton *hearButton;
@property (weak, nonatomic) IBOutlet UIButton *purchaseHistoryButton;
@property (weak, nonatomic) IBOutlet UIButton *interestButton;
@property (weak, nonatomic) IBOutlet UIButton *currentMattressButton;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *purposeTextField;
@property (weak, nonatomic) IBOutlet UITextField *dobTextField;
@end
