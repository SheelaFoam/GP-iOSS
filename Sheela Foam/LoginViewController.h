//
//  LoginViewController.h
//  Sheela Foam
//
//  Created by Apple on 17/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *landingScroll;
@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
- (IBAction)loginBtn:(id)sender;

@end
