//
//  GreatPlusViewUplodImg.h
//  GreatPlus
//
//  Created by Apple on 06/02/17.
//  Copyright © 2017 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GreatPlusViewUplodImg : UIViewController
- (IBAction)backBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(strong,nonatomic)NSString*url;


@end
