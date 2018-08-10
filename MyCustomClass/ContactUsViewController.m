//
//  ContactUsViewController.m
//  Sheela Foam
//
//  Created by Kapil on 10/17/17.
//  Copyright © 2017 Supraits. All rights reserved.
//

#import "ContactUsViewController.h"
#import "HomeViewController.h"
#import "historyModel.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ContactUsViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIButton *homebtn;

@end

@implementation ContactUsViewController
- (IBAction)btnTapped:(id)sender {
    
     [self.navigationController popViewControllerAnimated:YES];
    
//    HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
//    if ([[historyModel sharedhistoryModel].checkHomeORMenu isEqualToString:@"home"])
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//        [historyModel sharedhistoryModel].checkHomeORMenu=@"";
//
//    }
//    else
//    {
//        [self.navigationController popViewControllerAnimated:YES];
////        [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
//
////        HomeViewControllerVC.menuString=@"Left";
//
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:7.0/255.0f green:59.0/255.0f blue:117.0/255.0f alpha:1.0];
    self.navigationController.navigationBarHidden=TRUE;
    
    UITapGestureRecognizer *phoneTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneTapped)];
    phoneTapGesture.delegate=self;
    [_phoneLabel addGestureRecognizer:phoneTapGesture];
    
    UITapGestureRecognizer *emailTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emailTapped)];
    emailTapGesture.delegate=self;
    [_emailLabel addGestureRecognizer:emailTapGesture];
    _phoneLabel.userInteractionEnabled=YES;
    _emailLabel.userInteractionEnabled=YES;
    _homebtn.layer.masksToBounds=YES;
    _homebtn.layer.cornerRadius=5.0;
    // Do any additional setup after loading the view.
    
    
    
    //
    
    
    
    //
}


-(void)phoneTapped{
    NSString *phNo = @"18001026664";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}

-(void)emailTapped{
    NSString *recipients = @"mailto:it.services@sheelafoam.com?subject=Support";
    NSString *body = @"";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
