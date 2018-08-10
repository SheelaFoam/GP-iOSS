//
//  DocumentBoxVC.h
//  Sheela Foam
//
//  Created by Apple on 01/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocumentBoxVC : UIViewController
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIWebView *webUrl;
- (IBAction)profileBtn:(id)sender;

@end
