//
//  DocumentBoxVC.m
//  Sheela Foam
//
//  Created by Apple on 01/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "DocumentBoxVC.h"
#import "HomeViewController.h"
#import "historyModel.h"


@interface DocumentBoxVC ()<UIWebViewDelegate>
{
}

@end

@implementation DocumentBoxVC

- (IBAction)profileBtn:(id)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text=[historyModel sharedhistoryModel].menuTitle;
    self.navigationController.navigationBarHidden=YES;

{
    if ([[historyModel sharedhistoryModel].menuTitle isEqualToString:@"Document Box"])
    {

    NSString*url= [historyModel sharedhistoryModel].menuLink;
    NSString *embedHTML =[NSString stringWithFormat:@"%@", url];
        [self.webUrl loadHTMLString:embedHTML baseURL:nil];

    }
    if ([[historyModel sharedhistoryModel].menuTitle isEqualToString:@"INBOX"])
    {
        
//        NSString*url= [historyModel sharedhistoryModel].menuLink;
//        NSString *embedHTML =[NSString stringWithFormat:@"%@", url];
//        [self.webUrl loadHTMLString:embedHTML baseURL:nil];
        
       
      //  [[UIApplication sharedApplication] openURL:[NSURL
                                                  //  URLWithString:[historyModel sharedhistoryModel].menuTitle]];
        
        
    }
    else
    {
        NSString*url= [historyModel sharedhistoryModel].menuLink;
        NSString *embedHTML =[NSString stringWithFormat:@"%@", url];
        [self.webUrl loadHTMLString:embedHTML baseURL:nil];
    
    }
}
   
    self.webUrl.delegate=self;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    
    return YES;
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

- (IBAction)backBtn:(id)sender {
    HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
    
    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
    
    HomeViewControllerVC.menuString=@"Left";
    

}
@end
