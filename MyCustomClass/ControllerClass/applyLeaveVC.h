//
//  applyLeaveVC.h
//  Sheela Foam
//
//  Created by Apple on 15/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface applyLeaveVC : UIViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leaveTable;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
- (IBAction)leaveType:(id)sender;
- (IBAction)leavefrom:(id)sender;
- (IBAction)leaveTo:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *numberOfLeave;
@property (weak, nonatomic) IBOutlet UIButton *leaveType;
@property (weak, nonatomic) IBOutlet UIScrollView *landingScrollView;


@property (weak, nonatomic) IBOutlet UIButton *leavefrom;
@property (weak, nonatomic) IBOutlet UIButton *leaveTo;
@property (weak, nonatomic) IBOutlet UIView *landingView;
@property (strong, nonatomic) IBOutlet UIView *leaveStatus;

- (IBAction)first:(id)sender;
- (IBAction)second:(id)sender;
- (IBAction)third:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *reasonTextView;
- (IBAction)submitBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageFirst;
@property (weak, nonatomic) IBOutlet UIImageView *imageSecond;
@property (weak, nonatomic) IBOutlet UIImageView *imageThird;
// leaveStatus

@property (weak, nonatomic) IBOutlet UILabel *clOpening;

@property (weak, nonatomic) IBOutlet UILabel *clEncash;
@property (weak, nonatomic) IBOutlet UILabel *clTaken;
@property (weak, nonatomic) IBOutlet UILabel *clBalance;


@property (weak, nonatomic) IBOutlet UILabel *elOpening;

@property (weak, nonatomic) IBOutlet UILabel *elEncash;
@property (weak, nonatomic) IBOutlet UILabel *elTaken;
@property (weak, nonatomic) IBOutlet UILabel *elBalance;

@property (weak, nonatomic) IBOutlet UILabel *Opening;

@property (weak, nonatomic) IBOutlet UILabel *coEncash;
@property (weak, nonatomic) IBOutlet UILabel *coTaken;
@property (weak, nonatomic) IBOutlet UILabel *coBalance;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
- (IBAction)logout:(id)sender;
- (IBAction)profileBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *noteLab;
@property (weak, nonatomic) IBOutlet UILabel *reasonLab;

@end
