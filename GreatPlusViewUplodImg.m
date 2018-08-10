//
//  GreatPlusViewUplodImg.m
//  GreatPlus
//
//  Created by Apple on 06/02/17.
//  Copyright © 2017 SupraITS. All rights reserved.
//

#import "GreatPlusViewUplodImg.h"
#import "POAcvityView.h"


@interface GreatPlusViewUplodImg ()
{
    POAcvityView *activityIndicator;

}

@end

@implementation GreatPlusViewUplodImg

- (void)viewDidLoad {
    [super viewDidLoad];
   activityIndicator = [[POAcvityView alloc] initWithTitle:@"" message:@"Loading.."];
    
    [activityIndicator showView]; NSURL *imageURL = [NSURL URLWithString:self.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:imageURL];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
        if ( !error )
        {
            self.imageView.image= [UIImage imageWithData:data];
        }
        [activityIndicator hideView];
   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
