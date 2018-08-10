//
//  GCardRegistration.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 03/08/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "GCardRegistration.h"

@interface GCardRegistration ()

@end

@implementation GCardRegistration

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
