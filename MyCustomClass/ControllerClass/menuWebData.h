//
//  menuWebData.h
//  Sheela Foam
//
//  Created by Apple on 30/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuWebData : UIViewController
- (IBAction)backBtn:(id)sender;
@property(strong,nonatomic)NSString*idStr;
@property (weak, nonatomic) IBOutlet UIWebView *webviewData;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
- (IBAction)profileBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *landingView;

@end
