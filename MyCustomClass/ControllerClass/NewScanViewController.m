//
//  NewScanViewController.m
//  Sheela Foam
//
//  Created by Kapil on 11/21/17.
//  Copyright © 2017 Supraits. All rights reserved.
//

#import "NewScanViewController.h"
#import "POAcvityView.h"
#import "GreatPlusSharedHeader.h"
#import "MailClassViewController.h"
#import "GreatPlusSharedPostRequestManager.h"
#import "JsonBuilder.h"
#import "UserDefaultStorage.h"
#import "ScannerViewController.h"
#import "GreatPlusSharedGetRequestManager.h"
#import "Utility.h"
#import "historyModel.h"

@interface NewScanViewController ()<ScanNumberDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtFieldDealerCode;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldSerialNumber;
- (IBAction)scanPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblOpening;
@property (weak, nonatomic) IBOutlet UILabel *lblEarned;
@property (weak, nonatomic) IBOutlet UILabel *lblClosing;
- (IBAction)goPressed:(id)sender;
- (IBAction)backPressed:(id)sender;

@end

@implementation NewScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _lblEarned.text=@"";
    _lblClosing.text=@"";
    _lblOpening.text=@"";
    _lblName.text=[historyModel sharedhistoryModel].displayname;
    
    POAcvityView *activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        
        [[GreatPlusSharedGetRequestManager sharedInstance] executeRequest:CMD_GET_SATHI_POINTS withUrl:[NSString stringWithFormat:@"%@/%@MOBILE=%@",[Utility getURLString],KAPIGetPoints,[UserDefaultStorage getUserDealerID]] andTagName:GetSathiPoints andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode || statusCode == 0) {
                _lblEarned.text=[result valueForKey:@"op_earned"];
                _lblClosing.text=[result valueForKey:@"op_closing"];
                _lblOpening.text=[result valueForKey:@"op_opening"];
            } else {
                [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:message delegate:nil tag:0];
            }
        }];
        
        
    } else {
        [activityIndicator hideView];
        [MailClassViewController showAlertViewWithTitle:ConnectionTitle message:OhnoAlert delegate:self tag:0];
    }
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

- (IBAction)scanPressed:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"Scan1" forKey:@"Value"];
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:MainKey bundle:nil];
        ScannerViewController *loginViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
        loginViewController.delegate=self;
        [self.navigationController pushViewController:loginViewController animated:YES];
    } else {
        [MailClassViewController toastWithMessage:@"Your device does not have cemera." AndObj:self.view];
    }
}
- (IBAction)goPressed:(id)sender {
    
    if ([_txtFieldDealerCode.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please enter Dealer Code" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if ([_txtFieldSerialNumber.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please enter Serial Number" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    
    POAcvityView *activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
   
    
    [self.view endEditing:YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://125.19.46.252/ws/get_pointsAPI.php?saathi_user_id=%@&p_serial_number=%@&p_dealer_code=%@",[UserDefaultStorage getUserDealerID],_txtFieldSerialNumber.text,_txtFieldDealerCode.text]]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [activityIndicator hideView];
                           
                           NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                                options:kNilOptions
                                                                                  error:nil];
                           _lblEarned.text=[json valueForKey:@"op_earned"];
                           _lblClosing.text=[json valueForKey:@"op_closing"];
                           _lblOpening.text=[json valueForKey:@"op_opening"];
                       });
        
       
    }] resume];
}

-(void)sendScannedNumber:(NSString *)number{
    
    _txtFieldSerialNumber.text = number;
}

- (IBAction)backPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
