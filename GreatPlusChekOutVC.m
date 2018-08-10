//
//  GreatPlusChekOutVC.m
//  GreatPlus
//
//  Created by Apple on 11/01/17.
//  Copyright © 2017 Charle. All rights reserved.
//

#import "GreatPlusChekOutVC.h"

@interface GreatPlusChekOutVC ()

@end

@implementation GreatPlusChekOutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)BackBTNAct:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
