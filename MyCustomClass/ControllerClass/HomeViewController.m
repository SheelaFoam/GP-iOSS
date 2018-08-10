//
//  HomeViewController.m
//  Sheela Foam
//
//  Created by Apple on 18/11/16.
//  Copyright © 2016 Supraits. All rights reserved.

#import "HomeViewController.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "myPerformenceDetail.h"
#import "OtherAppsViewController.h"
#import "ScannerViewController.h"
#import "historyModel.h"
#import "latestEvent.h"
#import "raiseaRequestVC.h"
#import "opinionDetailVC.h"
#import "UIImageView+WebCache.h"
#import "LeftMenuTableViewCell.h"
#import "profileVC.h"
#import "NewScanViewController.h"
#import "latestEventDetail.h"
#import "approveTaskVC.h"
#import "mytaskMenuVC.h"
#import "applyLeaveVC.h"
#import "holidayCalenderDetail.h"
#import "moreAppVC.h"
#import "MailClassViewController.h"
#import "GreatPlusSharedPostRequestManager.h"
#import "JsonBuilder.h"
#import "UserDefaultStorage.h"
#import "GreatPlusSharedHeader.h"
#import "LoginViewController.h"
#import "UIImageView+WebCache.h"
#import "GreatPlusMrpCalculatorViewController.h"
#import "GreatePlusCheckOutFormVC.h"
#import "GreatPlusUploadDocumentVC.h"
#import "WebViewVC.h"
#import "GuaranteeLog.h"
#import "historyModel.h"
#import "Footfall.h"
#import "CustomerFeedback.h"
#import "Complaint.h"
#import "PerformanceDashboard.h"
#import "BumperPrizeCell.h"
#import "BumperPrizeModel.h"
#import <SafariServices/SafariServices.h>

@interface HomeViewController ()<WebServiceResponseProtocal,SWRevealViewControllerDelegate>
{
    long sectionVlaue;
    MyWebServiceHelper *helper;
    NSArray*info;
    homeViewVC*home;
    UIView*raiseView;
    BOOL isShown;
    mailVW*mailVc;
    myTaskVC*taskVc;
    MyAppoinmentVC*appoinmentVc;
    myPerformenceVC*myPerformence;
    PerformingVC*Performing;
    OpinionVC*Opinion;
    holidaysVC*holidays;
    storiesVC*stories;
    latestEvent*latestVC;
    UIButton *button;
    CGRect tablefream;
    CGRect opinionfream;
    CGSize labelHeight;
    CGSize performenceTableHight;
    int lableWidth;
    CGRect contentViewfream;
   CGRect mailVcfream;
   CGRect taskVcfream;
   CGRect appoinmentVcfream;
   CGRect myPerformencefream;
   CGRect Performingfream;
   CGRect Opinionfreamhight;
   CGRect holidaysfream;
   CGRect storiesfream;
   CGRect latestVCfream;
    NSString*scrollHomeSlider;
    NSInteger SliderCount;
    float slider;
    float inbox;
    float task;
    float appointment;
    float performence;
    float companyPerformence;
    float opinion;
    float holiday;
    float story;
    float event;
    bool check;
    LeftMenuTableViewCell*cellAttachment;
    NSArray*imagwArray;
    NSDictionary*dataDic;
    NSMutableArray *businessAppsList;
    NSString *getImgUrl;
    UIButton *sankalpBtn;
    //UIButton *mailBtn;
    UIButton *latestEventBtn;
    CGRect businessAppFrame;
    
    NSMutableArray *folderArray;
    CGRect frame;
    CGPoint center;
    
    NSString *message;
    NSString *newVersion;
    
}
@end

@implementation HomeViewController
- (IBAction)logout:(id)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString * build = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    [_versionLabel setText:[NSString stringWithFormat:@"Version: %@", version]];
    
    
    
    [self checkVersion:version andBuild:build completionHandler:^(BOOL updateStatus) {
//        [self showUpdateAlert:updateStatus andVersion:version withMessage:[NSString stringWithFormat:@"\n%@", message]];
    }];
    
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height /2;
    self.profileImg.layer.masksToBounds = YES;
    self.profileImg.layer.borderWidth = 0;
    
    getImgUrl = [[NSUserDefaults standardUserDefaults]
                 stringForKey:@"preferenceName"];
    [self.profileImg setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    
    self.landingScrollView.contentSize = CGSizeMake(0,5500);
    
    self.navigationController.navigationBarHidden=YES;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    SliderCount=1;
    check=NO;
     slider=20;
     inbox=20;
     task=20;
     appointment=20;
     performence=20;
     companyPerformence=20;
     opinion=20;
     holiday=20;
     story=20;
     event=20;
    businessAppFrame = CGRectZero;
    
        mailVc=[[mailVW alloc]init];
        taskVc=[[myTaskVC alloc]init];
        appoinmentVc=[[MyAppoinmentVC alloc]init];
        myPerformence=[[myPerformenceVC alloc]init];
        Performing=[[PerformingVC alloc]init];
        Opinion=[[OpinionVC alloc]init];
        holidays=[[holidaysVC alloc]init];
        stories=[[storiesVC alloc]init];
        latestVC=[[latestEvent alloc]init];
    
    [self.landingScrollView addSubview:mailVc];
    [self.landingScrollView addSubview:taskVc];
    [self.landingScrollView addSubview:appoinmentVc];
    [self.landingScrollView addSubview:myPerformence];
    [self.landingScrollView addSubview:Performing];
    [self.landingScrollView addSubview:Opinion];
    [self.landingScrollView addSubview:holidays];
    [self.landingScrollView addSubview:stories];
    [self.landingScrollView addSubview:latestVC];
    
    self.riseTable.hidden=YES;
    mailVc.hidden=YES;
    taskVc.hidden=YES;
    appoinmentVc.hidden=YES;
    myPerformence.hidden=YES;
    Performing.hidden=YES;
    Opinion.hidden=YES;
    holidays.hidden=YES;
    stories.hidden=YES;
    latestVC.hidden=YES;
    self.leftMenuBtn.userInteractionEnabled=NO;
   self.expandView.frame=CGRectMake(0,self.headerView.frame.size.height-30-self.expandView.frame.size.height,[UIScreen mainScreen].bounds.size.width,self.expandView.frame.size.height);
   NSLog(@"fream3---->%f",self.expandView.frame.origin.y);
    
   [self.landingScrollView addSubview:self.expandView];

    self.riseTable.delegate=self;
    self.riseTable.dataSource=self;
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
//    if ([self.menuString isEqualToString:@"Left"])
//    {
//        [revealController revealToggle:self];
//    }
    [self.leftMenuBtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [taskVc.approveRequest addTarget: self
                                action: @selector(approveTaskDetail)
                      forControlEvents: UIControlEventTouchUpInside];
    
    [taskVc.seeAll addTarget: self
                              action: @selector(seeAll)
                    forControlEvents: UIControlEventTouchUpInside];
    [self firstApi];
    [self getProfileData];
    self.expandView.hidden = YES;
    
   [self.businessAppCollectionView registerNib:[UINib nibWithNibName:@"BusinessAppCell" bundle:nil] forCellWithReuseIdentifier:@"businessAppId"];
//    self.businessAppCollectionView.backgroundColor=[UIColor redColor];
    [_businessAppCollectionView layoutIfNeeded];
    
    [_prizeCollectionView registerNib:[UINib nibWithNibName:@"BumperPrizeCell" bundle:nil] forCellWithReuseIdentifier:@"BumperPrizeCell"];
    
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    } else {
        // Fallback on earlier versions
    }
    self.nameLabel.text=[historyModel sharedhistoryModel].displayname;
    [_folder setAlpha:0.0];
    
    _bumperPrizeView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    _closeButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([[historyModel sharedhistoryModel].opUserType isEqualToString:@"DEALER"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self setupBumperPrizeView];
        });
    }
}

-(void) showUpdateAlert:(BOOL)update andVersion: (NSString *)version withMessage: (NSString *)message {
    
    if (update) {
    
        UIAlertController *alert = [[UIAlertController alloc] init];
        alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"New version available - V(%@)", newVersion] message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *download = [UIAlertAction actionWithTitle:@"Download" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/in/app/greatplus/id1325457129?mt=8"]];
        }];
        [alert addAction:download];
    
        [self presentViewController:alert animated:true completion:nil];
    }
}

-(void) checkVersion:(NSString *)version andBuild: (NSString *)build completionHandler: (void (^)(BOOL updateStatus)) completion {
    
    NSDictionary *headers = @{ @"content-type": @"application/json",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"ee673415-edf2-dc3c-373e-cce8dc1a0d38" };
    NSDictionary *parameters = @{ @"os_type": @"I",
                                  @"version_code": build,
                                  @"version_name": version};
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://greatplus.com/warranty_log_api/app_update_alert.php"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"update_status"]);
                                                        message = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"ver_update"];
                                                        newVersion = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"version_name"];
                                                        if ([[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"update_status"] isEqualToString:@"true"]) {
                                                            completion(true);
                                                        } else {
                                                            completion(false);
                                                        }
                                                    }
                                                }];
    [dataTask resume];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    if (touch.view.tag != 99) {
        [self closeFolder];
    }
}

- (void) getProfileData {
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_PROFILE_INIT withDictionaryInfo:[JsonBuilder buildDProfileJsonObject] andTagName:ProfileServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            
            if (statusCode == StatusCode) {
                [UserDefaultStorage setDeafaultState:[NSString stringWithFormat:@"%@",([MailClassViewController checkNull:[result objectForKey:@"op_state"]]) ? [result objectForKey:@"op_state"] : EmptyString]];
                NSLog(@"%@", [result objectForKey:@"op_user_name"]);
                [UserDefaultStorage setTitleDelearName:[NSString stringWithFormat:@"%@",[result objectForKey:@"op_user_name"]]];
                [MailClassViewController sharedInstance].op_territory = [NSString stringWithFormat:@"%@",[result objectForKey:@"op_territory_allowed"]];;
            } else {
                if (![message isEqualToString:@"(null)"]) {
                    [MailClassViewController toastWithMessage:message AndObj:self.view];
                }
                
            }
        }];
    } else {
       
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _businessAppCollectionView) {
        if (businessAppsList != nil){
            if ([[historyModel sharedhistoryModel].opUserType isEqualToString: @"DEALER"]) {
                return businessAppsList.count;
            } else {
                return businessAppsList.count;
            }
        }
        return 0;
    } else {
        return [BumperPrizeModel sharedInstance].prizeArray.count;
    }
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == _businessAppCollectionView) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"businessAppId" forIndexPath:indexPath];
        
        UILabel *title = [cell viewWithTag:74837];
        UIImageView *iconimg = [cell viewWithTag:1453];
        
        NSString *menuCheck=(businessAppsList[indexPath.item])[@"CHILD_MENU"];
        
        NSLog(@"%@", businessAppsList);
        
        title.text = businessAppsList[indexPath.row][@"CHILD_MENU"];
        [iconimg setImageWithURL:[NSURL URLWithString:(businessAppsList[indexPath.row])[@"ICON"]] placeholderImage:nil];
        cell.backgroundColor=[UIColor whiteColor];
        
        if ([menuCheck isEqualToString:@"Guarantee Log"]) {
            [iconimg setImage:[UIImage imageNamed:@"guaranteeLog"]];
        }
        return cell;
    } else {
        
        BumperPrizeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BumperPrizeCell" forIndexPath:indexPath];
        
        
        [cell.prizeLbl setText:[NSString stringWithFormat:@"%@ \n has won %@", [BumperPrizeModel sharedInstance].prizeArray[indexPath.row][@"DEALER_NAME"], [BumperPrizeModel sharedInstance].prizeArray[indexPath.row][@"BUMBER_PRIZE"]]];
        
        if ([[BumperPrizeModel sharedInstance].prizeArray[indexPath.row][@"BUMPER_PRIZE"] isEqualToString:@"Honda Activa Scooter"]) {
            [cell.prizeImgView setImage:[UIImage imageNamed:@"activa-1"]];
        } else if ([[BumperPrizeModel sharedInstance].prizeArray[indexPath.row][@"BUMPER_PRIZE"] isEqualToString:@"Honda Amaze Car"]) {
            [cell.prizeImgView setImage:[UIImage imageNamed:@"amaze"]];
        } else if ([[BumperPrizeModel sharedInstance].prizeArray[indexPath.row][@"BUMPER_PRIZE"] isEqualToString:@"Comforter - Flora (all Season)"]) {
            [cell.prizeImgView setImage:[UIImage imageNamed:@"comfortert-flora"]];
        } else if ([[BumperPrizeModel sharedInstance].prizeArray[indexPath.row][@"BUMPER_PRIZE"] isEqualToString:@"Comforter - Ivory (all Season)"]) {
            [cell.prizeImgView setImage:[UIImage imageNamed:@"Comforter-Ivory"]];
        } else if ([[BumperPrizeModel sharedInstance].prizeArray[indexPath.row][@"BUMPER_PRIZE"] isEqualToString:@"Bed Sheets - Cherish"]) {
            [cell.prizeImgView setImage:[UIImage imageNamed:@"BedSheets"]];
        } else {
            [cell.prizeImgView setImage:[UIImage imageNamed:@"discount-1"]];
        }
        
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *appURL = (businessAppsList[indexPath.item])[@"LINK"];
    
    if ([(businessAppsList[indexPath.item])[@"CHILD_MENU"] isEqualToString:@"Scan"]) {
        //
//        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
//            [[NSUserDefaults standardUserDefaults] setObject:@"Scan1" forKey:@"Value"];
//            UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:MainKey bundle:nil];
//            ScannerViewController *loginViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
            UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:MainKey bundle:nil];
            NewScanViewController *scanController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"newScan"];
            [self.navigationController pushViewController:scanController animated:YES];
//        } else {
//            [MailClassViewController toastWithMessage:@"Your device does not have cemera." AndObj:self.view];
//        }
        return;
    }
    
    if([appURL isKindOfClass:[NSNull class]] || appURL == nil ||(appURL != nil && [appURL isEqualToString:@""]))
    {
        NSString *menuCheck=(businessAppsList[indexPath.item])[@"CHILD_MENU"];
        
        if([[menuCheck lowercaseString] isEqualToString:@"mrp calculation"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusMrpCalculatorViewController"];
            
            UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
            [navigationController pushViewController:vc animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Mrp Calculation";
            return;
        }
        
        if([[menuCheck lowercaseString] isEqualToString:@"quick support"]) {
            
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"https://itunes.apple.com/in/app/teamviewer-quicksupport/id661649585?mt=8"]];
            return;
        }
        
        if ([[menuCheck lowercaseString] isEqualToString:@"place order"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusPlaceOrderViewController"];
            
            UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
            [navigationController pushViewController:vc animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"place Order";
            return;
        }
        
        if ([[menuCheck lowercaseString] isEqualToString:@"order status"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusOrderStatusViewController"];
            
            UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
            [navigationController pushViewController:vc animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Order Status";
            return;
        }
        
        if ([[menuCheck lowercaseString] isEqualToString:@"order report"]) {
            
//            SWRevealViewController *revealController = self.revealViewController;
//
//            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"OrderReport"];
//
//            UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
//            [navigationController pushViewController:vc animated:YES];
//            [historyModel sharedhistoryModel].menuTitle=@"Order Status";
            
            return;
        }
        
//        if ([[menuCheck lowercaseString] isEqualToString:@"guarantee registration"])
        {
//            SWRevealViewController *revealController = self.revealViewController;
//
//            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusExchangeOfferViewController"];
//
//            UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
//            [navigationController pushViewController:vc animated:YES];
//            [historyModel sharedhistoryModel].menuTitle=@"Guarantee Registration";
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DealerStoryboard" bundle:nil];
            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ConsumerOrder"];
            [self presentViewController:vc animated:true completion:nil];
            
            //
            
            
            //
            return;
            
        }
        
        if ([[menuCheck lowercaseString] isEqualToString:@"exchange offer"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusExchangeOfferViewController"];
            
            UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
            [navigationController pushViewController:vc animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Guarantee Registration";
            return;
        }
        
        if ([[menuCheck lowercaseString] isEqualToString:@"digital payment"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            GreatePlusCheckOutFormVC *CheckOUTVC=[[GreatePlusCheckOutFormVC alloc] init];
            UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
            [navigationController pushViewController:CheckOUTVC animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"DigitalPayment";
            return;
        }
        
        if ([[menuCheck lowercaseString] isEqualToString:@"upload document"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            GreatPlusUploadDocumentVC *UploadDocVC=[[GreatPlusUploadDocumentVC alloc] init];
            UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
            [navigationController pushViewController:UploadDocVC animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"UploadDocuments";
            return;
        }
        
        if ([[menuCheck lowercaseString] isEqualToString:@"order approval"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusOrderApprovelViewController"];
            
            UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
            [navigationController pushViewController:vc animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"UploadDocuments";
            return;
        }
        
        
        
        if ([menuCheck isEqualToString:@"Document Box"])
        {
            
            // NSURL*url=[NSURL URLWithString:@"http://125.17.8.166/service/document-box-login.php?uid=ROSHNI.SHRESHTHA&token=TkVXQEluZGlh"];
            // NSURL*url=[NSURL URLWithString:@"https://www.greatplus.com/service/document-box-login.php?uid=ROSHNI.SHRESHTHA&token=TkVXQEluZGlh"];
            
            
            // NSURL*url=[NSURL URLWithString:@"https://www.greatplus.com/service/document-box-login.php?uid=%@&token=%@",[historyModel sharedhistoryModel].uid,[historyModel sharedhistoryModel].token];
            
            NSString*urlStr=[NSString stringWithFormat:@"%@uid=%@&token=%@",@"https://www.greatplus.com/service/document-box-login.php?",[historyModel sharedhistoryModel].uid,[historyModel sharedhistoryModel].token];
            NSURL*url=[NSURL URLWithString:urlStr];
            
            
            
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
            return;
        }
        
        if ([menuCheck isEqualToString:@"Orders"]) {
            
            UICollectionViewLayoutAttributes *attributes = [self.businessAppCollectionView layoutAttributesForItemAtIndexPath:indexPath];
            
//            CGRect cellFrameInSuperview = [self.businessAppCollectionView convertRect:attributes.frame toView:[self.businessAppCollectionView superview]];
            frame = [self.businessAppCollectionView convertRect:attributes.frame toView:self.view];
            center = [self.businessAppCollectionView convertPoint:attributes.center toView:self.view];
            
            [_folder setAlpha:1.0];
            [_folder setBounds:frame];
            [_folder setCenter:center];
            [self showFolder];
            
            NSLog(@"Orders tapped");
            return;
        }
        
        if ([menuCheck isEqualToString:@"Guarantee Log"]) {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *controller = (GuaranteeLog *)[storyboard instantiateViewControllerWithIdentifier:@"GuaranteeLog"];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:navController animated:true completion:nil];
            return;
        }
    }
    
    NSString *menuCheck=(businessAppsList[indexPath.item])[@"CHILD_MENU"];
    
    NSLog(@"%@", menuCheck);
    
    if ([menuCheck isEqualToString:@"Performance Dashboard"]) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *controller = (PerformanceDashboard *)[storyboard instantiateViewControllerWithIdentifier:@"PerformanceDashboard"];
//        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:controller animated:true completion:nil];
        return;
    }
    
    if ([menuCheck isEqualToString:@"Other Apps"]) {
        
        OtherAppsViewController *controller = [[OtherAppsViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    if ([menuCheck isEqualToString:@"Complaint"]) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DealerStoryboard" bundle:nil];
        UIViewController *controller = (Complaint *)[storyboard instantiateViewControllerWithIdentifier:@"Complaint"];
        
        [self.navigationController pushViewController:controller animated:true];
        
        return;
    }
    
//    if ([menuCheck isEqualToString:@"Showroom Image"]) {
//        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BEStoryboard" bundle:nil];
//        UIViewController *controller = (Footfall *)[storyboard instantiateViewControllerWithIdentifier:@"Showroom"];
//        
//        [self.navigationController pushViewController:controller animated:true];
//        
//        return;
//    }
//    
//    if ([menuCheck isEqualToString:@"Footfall & Conversion"]) {
//
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BEStoryboard" bundle:nil];
//        UIViewController *controller = (Footfall *)[storyboard instantiateViewControllerWithIdentifier:@"Footfall"];
//
//        [self.navigationController pushViewController:controller animated:true];
//
//        return;
//    }
    
//    if ([menuCheck isEqualToString:@"Customer Feedback"]) {
//        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BEStoryboard" bundle:nil];
//        UIViewController *controller = (CustomerFeedback *)[storyboard instantiateViewControllerWithIdentifier:@"CustomerFeedback"];
//        
//        [self.navigationController pushViewController:controller animated:true];
//        
//        return;
//    }
    
    
    if ([appURL rangeOfString:@"SheelaFoamApp"].location == NSNotFound) {
        
        self.finalURL = [[[NSString alloc] init] stringByAppendingFormat:@"%@?email=%@&token=%@", appURL, [historyModel sharedhistoryModel].userEmail, [historyModel sharedhistoryModel].token];
        
    } else {
        
        if ([appURL rangeOfString:@"#"].location == NSNotFound) {
            
            self.finalURL = [[[NSString alloc] init] stringByAppendingFormat:@"%@?email=%@&token=%@", appURL, [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"], [historyModel sharedhistoryModel].token];
        } else {
            self.finalURL = [[[NSString alloc] init] stringByAppendingFormat:@"%@%@/%@", appURL, [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"], [historyModel sharedhistoryModel].token];
        }
    }
    
    NSLog(@"%@", self.finalURL);
    if ([menuCheck isEqualToString:@"My Idea"]) {
        SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:self.finalURL]];
        [self presentViewController:safari animated:true completion:nil];
    } else {
        UIStoryboard *storyb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WebViewVC *vc = (WebViewVC *)[storyb instantiateViewControllerWithIdentifier:@"webviewVC"];
        if ([self.finalURL rangeOfString:@"my-gallery"].location != NSNotFound) {
            vc.uploadFlag = true;
        }
        
        
        [self presentViewController:vc animated:YES completion:^{
            [vc.webview loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:self.finalURL]]];
        }];
    }
}

-(void) showFolder {
    
    [UIView animateWithDuration:0.75 animations:^{
        _folder.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.5, 2.5);
        [_folder setCenter:self.view.center];
    } completion:nil];
}

-(void) closeFolder {
    
    [UIView animateWithDuration:0.75 animations:^{
        
        _folder.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        [_folder setCenter:center];
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 animations:^{
            [_folder setAlpha:0.0];
        }];
    }];
}

-(void)openBusinessApp:(NSString *)menuCheck
{
    if([[menuCheck lowercaseString] isEqualToString:@"mrp calculation"])
    {
        SWRevealViewController *revealController = self.revealViewController;
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusMrpCalculatorViewController"];
        
        UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
        [navigationController pushViewController:vc animated:YES];
        [historyModel sharedhistoryModel].menuTitle=@"Mrp Calculation";
    }
    
    if ([[menuCheck lowercaseString] isEqualToString:@"place order"])
    {
        
        [historyModel sharedhistoryModel].menuTitle=@"place Order";
        SWRevealViewController *revealController = self.revealViewController;
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusPlaceOrderViewController"];
        
        UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
        [navigationController pushViewController:vc animated:YES];
        
    }
    
    if ([[menuCheck lowercaseString] isEqualToString:@"order status"])
    {
        SWRevealViewController *revealController = self.revealViewController;
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusOrderStatusViewController"];
        
        UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
        [navigationController pushViewController:vc animated:YES];
        [historyModel sharedhistoryModel].menuTitle=@"Order Status";
        
    }
    
    if ([[menuCheck lowercaseString] isEqualToString:@"guarantee registration"])
    {
        SWRevealViewController *revealController = self.revealViewController;
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusExchangeOfferViewController"];
        
        UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
        [navigationController pushViewController:vc animated:YES];
        [historyModel sharedhistoryModel].menuTitle=@"Guarantee Registration";
        
    }
    
    if ([[menuCheck lowercaseString] isEqualToString:@"exchange offer"])
    {
        SWRevealViewController *revealController = self.revealViewController;
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusExchangeOfferViewController"];
        
        UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
        [navigationController pushViewController:vc animated:YES];
        [historyModel sharedhistoryModel].menuTitle=@"Guarantee Registration";
        
    }
    
    if ([[menuCheck lowercaseString] isEqualToString:@"digital payment"])
    {
        SWRevealViewController *revealController = self.revealViewController;
        
        GreatePlusCheckOutFormVC *CheckOUTVC=[[GreatePlusCheckOutFormVC alloc] init];
        UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
        [navigationController pushViewController:CheckOUTVC animated:YES];
        [historyModel sharedhistoryModel].menuTitle=@"DigitalPayment";
        
    }
    
    if ([[menuCheck lowercaseString] isEqualToString:@"upload document"])
    {
        SWRevealViewController *revealController = self.revealViewController;
        
        GreatPlusUploadDocumentVC *UploadDocVC=[[GreatPlusUploadDocumentVC alloc] init];
        UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
        [navigationController pushViewController:UploadDocVC animated:YES];
        [historyModel sharedhistoryModel].menuTitle=@"UploadDocuments";
        
    }
    
    if ([[menuCheck lowercaseString] isEqualToString:@"order approval"])
    {
        SWRevealViewController *revealController = self.revealViewController;
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusOrderApprovelViewController"];
        
        UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
        [navigationController pushViewController:vc animated:YES];
        [historyModel sharedhistoryModel].menuTitle=@"UploadDocuments";
        
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _businessAppCollectionView) {
        CGFloat wid = (CGFloat)((int)((collectionView.frame.size.width)/3-8));
        return CGSizeMake(wid, wid);
    } else {
        return CGSizeMake(_prizeCollectionView.bounds.size.width, _prizeCollectionView.bounds.size.height);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (collectionView == _businessAppCollectionView) {
        return UIEdgeInsetsMake(8, 8, 8, 8);
    } else {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10.0; // This is the minimum inter item spacing, can be more
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 3.0;
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    if (collectionView == _businessAppCollectionView) {
        return 5.0;
    } else {
        return 0.0;
    }
}

-(void)firstApi
{
    NSDictionary*dataString= @{@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"mode":@"step1",@"auth_type":[historyModel sharedhistoryModel].authType,@"displayname":[historyModel sharedhistoryModel].displayname,@"op_role_name":[historyModel sharedhistoryModel].opRoleName,@"op_user_emp_group_code":[historyModel sharedhistoryModel].opUserEmpGroupCode,@"user_email":[historyModel sharedhistoryModel].userEmail,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"op_user_zone":[historyModel sharedhistoryModel].opUserzone,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName};
    
    
    NSLog(@"homeData%@",dataString);
    
    [self HomeDataStep1:dataString];
}
-(void)HomeDataStep1:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper homeApiStep1:dataString];
}
-(void)HomeDataStep2:(NSDictionary*)dataStringStep2
{
   // [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper homeApiStep2:dataStringStep2];
}
-(void)step2
{
    if (!self.uid)
    {
        self.uid=@"";
    }
    if (!self.token)
    {
        self.token=@"";
    }
    if (!self.authType)
    {
        self.authType=@"";
    }
    if (!self.displayname)
    {
        self.displayname=@"";
    }
    if (!self.opRoleName)
    {
        self.opRoleName=@"";
    }
    if (!self.opUserEmpGroupCode)
    {
        self.opUserEmpGroupCode=@"";
    } if (!self.userEmail)
    {
        self.userEmail=@"";
    }
    NSDictionary*dataString= @{@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"mode":@"step2",@"auth_type":[historyModel sharedhistoryModel].authType,@"displayname":[historyModel sharedhistoryModel].displayname,@"op_role_name":[historyModel sharedhistoryModel].opRoleName,@"op_user_emp_group_code":[historyModel sharedhistoryModel].opUserEmpGroupCode,@"user_email":[historyModel sharedhistoryModel].userEmail,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"op_user_zone":[historyModel sharedhistoryModel].opUserzone,@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName};
        NSLog(@"homeData%@",dataString);
        [self HomeDataStep2:dataString];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
   // NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"homeApiStep1"])
    {
        if (dataDic.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSMutableDictionary *prunedDictionary = [NSMutableDictionary dictionary];
                for (NSString * key in [dataDic allKeys])
                {
                    if (![[dataDic objectForKey:key] isKindOfClass:[NSNull class]])
                        [prunedDictionary setObject:[dataDic objectForKey:key] forKey:key];
                }
                dataDic=[prunedDictionary mutableCopy];
                 NSLog(@"dataDic>>>>%@",dataDic);
                [historyModel sharedhistoryModel].homeDataDic=dataDic;
                
                mailVc.hidden=NO;
                taskVc.hidden=NO;
                appoinmentVc.hidden=NO;
                
            });
            
//            for (NSDictionary *dic in dataDic[@"header_menu"])
//            {
//                if ([dic[@"CHILD_MENU"] isEqualToString:@"Business Processes"]) {
//                    businessAppsList = dic[@"SUB_MENU"];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        _businessAppCollectionView.dataSource = self;
//                        _businessAppCollectionView.delegate = self;
//
////                        [self.businessAppCollectionView reloadData];
//                    });
//                    
//                    break;
//                }
//            }
            businessAppsList = [[NSMutableArray alloc] init];
            folderArray = [[NSMutableArray alloc] init];
            if(((NSMutableArray *)dataDic[@"quick_access"]).count > 0)
            {
//                if ([[historyModel sharedhistoryModel].opUserType isEqualToString:@"DEALER"]) {
//                    for (int i =0; i < [dataDic[@"quick_access"] count]; i++) {
//                        NSString *temp = dataDic[@"quick_access"][i][@"CHILD_MENU"];
//                        temp = [temp lowercaseString];
//                        if ([temp rangeOfString:@"order"].location == NSNotFound) {
//                            [businessAppsList addObject:dataDic[@"quick_access"][i]];
//                        } else {
//                            [folderArray addObject:dataDic[@"quick_access"][i]];
//                        }
//                    }
//                    [businessAppsList insertObject:@{@"CHILD_MENU":@"Orders",@"ICON":@"https://www.greatplus.com/images/OStatus.png",@"LINK":@""} atIndex:0];
//                } else {
//                    businessAppsList = (NSMutableArray *)dataDic[@"quick_access"];
//                }
                
//                if ([[historyModel sharedhistoryModel].opUserType isEqualToString:@"BE"]) {
//
//                    for (int i =0; i < [dataDic[@"quick_access"] count]; i++) {
//                        [businessAppsList addObject:dataDic[@"quick_access"][i]];
//                    }
//                    [businessAppsList insertObject:@{@"CHILD_MENU":@"Guarantee Log",@"ICON":@"",@"LINK":@""} atIndex:[businessAppsList indexOfObject:[businessAppsList lastObject]]];
//                } else {
//                    businessAppsList = (NSMutableArray *)dataDic[@"quick_access"];
//                }
                for (int i =0; i < [dataDic[@"quick_access"] count]; i++) {
                    NSString *menuCheck=[dataDic objectForKey:@"quick_access"][i][@"CHILD_MENU"];
                    NSLog(@"%@", menuCheck);
                    if (![menuCheck isEqualToString:@"Other Apps"]) {
                        [businessAppsList addObject:dataDic[@"quick_access"][i]];
                    }
                }
//                [businessAppsList insertObject:@{@"CHILD_MENU":@"Guarantee Log",@"ICON":@"",@"LINK":@""} atIndex:[businessAppsList indexOfObject:[businessAppsList lastObject]]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    _businessAppCollectionView.dataSource = self;
                    _businessAppCollectionView.delegate = self;
                    _prizeCollectionView.dataSource = self;
                    _prizeCollectionView.delegate = self;
//                    [self.businessAppCollectionView reloadData];
                });
            }
            
            [self step2];
        }
    }
       else if([apiName isEqualToString:@"homeApiStep2"])
        {
            
            NSLog(@"step2");
            if (dataDic.count>0)
                
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    NSMutableDictionary *prunedDictionary = [NSMutableDictionary dictionary];
                    for (NSString * key in [dataDic allKeys])
                    {
                        if (![[dataDic objectForKey:key] isKindOfClass:[NSNull class]])
                            [prunedDictionary setObject:[dataDic objectForKey:key] forKey:key];
                    }
                    dataDic=[prunedDictionary mutableCopy];
                    NSLog(@"dataDic>>>>%@",dataDic);


            [historyModel sharedhistoryModel].homeDataDicStep2=dataDic;
                                     myPerformence.hidden=NO;
                    Performing.hidden=NO;
                    Opinion.hidden=NO;
                    holidays.hidden=NO;
                    stories.hidden=NO;
                    latestVC.hidden=NO;
                    NSLog(@"leave status>>>>>%lu",[[[[dataDic objectForKey:@"request_center_inner_menu"] objectAtIndex:1]objectForKey:@"Leave"] count]);
                    
                    if ([[[[dataDic objectForKey:@"request_center_inner_menu"] objectAtIndex:0]objectForKey:@"Facilities"] count]==0 &&[[[[dataDic objectForKey:@"request_center_inner_menu"] objectAtIndex:1]objectForKey:@"Leave"] count]==0 &&[[[[dataDic objectForKey:@"request_center_inner_menu"] objectAtIndex:2]objectForKey:@"other_request"] count]==0)
                    {
                        NSLog(@"request_center_inner_menu print");
                        self.raiseRequest.userInteractionEnabled=NO;
                    }
                    else
                    {
                        NSLog(@"request_center_inner_menu print else");
                    }
                    [self initField];
                    self.leftMenuBtn.userInteractionEnabled=YES;
                    [SVProgressHUD dismiss];
                    
                });
            }
        }


        else
        {
            NSString *msg = [dataDic objectForKey:@"msg"];
            [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:3.0];
        }
}
-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknow Error" timeDalay:2.0];
}
-(void)initField
{
    int rowCount = ceil((CGFloat)((double)businessAppsList.count / 3.0));
    CGFloat businessViewHeight =  rowCount * [self collectionView:self.businessAppCollectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]].height +(rowCount-1)*18;
    CGRect bvappfra = CGRectMake(self.businessAppView.frame.origin.x, self.businessAppView.frame.origin.y, self.businessAppView.frame.size.width, businessViewHeight);
    self.businessAppView.frame = bvappfra;
    self.businessAppCollectionView.scrollEnabled=NO;
    
    businessAppFrame = self.businessAppView.frame;
    [self.businessAppCollectionView setFrame:_businessAppView.bounds];
    
    
    
    if ([[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"inbox"] count]==0)
    {
        inbox=0;
        mailVc.frame=CGRectMake(13,businessAppFrame.origin.y + businessAppFrame.size.height + 10.0f, [UIScreen mainScreen].bounds.size.width-30,0);
        mailVc.hidden=YES;
        mailVcfream=mailVc.frame;
    }
    else
    {
        mailVc.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
        mailVc.layer.borderWidth = 2.0f;
        CGRect tablehight;
        
        tablehight= CGRectMake(mailVc.mailTable.frame.origin.x, mailVc.mailTable.frame.origin.y,mailVc.mailTable.frame.size.width,(75*[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"inbox"] count])+mailVc.mailTable.tableFooterView.frame.size.height+mailVc.mailTable.tableHeaderView.frame.size.height);
        [mailVc.mailDetail addTarget:self
                       action:@selector(inboxDetail)
           forControlEvents:UIControlEventTouchUpInside];
        
        if ([scrollHomeSlider isEqualToString:@"yes"])
        {
            mailVc.frame=CGRectMake(13,businessAppFrame.origin.y + businessAppFrame.size.height +20, [UIScreen mainScreen].bounds.size.width-30,mailVcfream.size.height);
        }
        else
        {
            mailVc.frame=CGRectMake(13,businessAppFrame.origin.y + businessAppFrame.size.height+20, [UIScreen mainScreen].bounds.size.width-30,tablehight.size.height);
            mailVcfream=mailVc.frame;
        }

    }
    
if ([[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"task"] count]==0)
    {

        taskVc.approveRequest.hidden=YES;
        taskVc.seeAll.hidden=YES;
        taskVc.approveRequestLab.hidden=YES;
        taskVc.mytaskTable.hidden=YES;

        task=0;
        taskVc.frame=CGRectMake(13,mailVc.frame.origin.y+mailVc.frame.size.height+task, [UIScreen mainScreen].bounds.size.width-30,0);
        
        taskVcfream=taskVc.frame;
        taskVc.hidden=YES;

    }
    else
    {
        
        //NSLog(@"TASK>>>>%lu",[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"task"] count]);
        taskVc.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
        taskVc.layer.borderWidth = 2.0f;
        [taskVc.mytaskTable reloadData];
        CGRect tablehight;

        tablehight= CGRectMake(taskVc.mytaskTable.frame.origin.x, taskVc.mytaskTable.frame.origin.y,taskVc.mytaskTable.frame.size.width,(73*([[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"task"] count]))+taskVc.mytaskTable.tableFooterView.frame.size.height+taskVc.mytaskTable.tableHeaderView.frame.size.height);
        if ([scrollHomeSlider isEqualToString:@"yes"])
        {
            
             taskVc.frame=CGRectMake(13,mailVc.frame.origin.y+mailVc.frame.size.height+task, [UIScreen mainScreen].bounds.size.width-30,taskVcfream.size.height);
        }
        else
        {
            taskVc.frame=CGRectMake(13,mailVc.frame.origin.y+mailVc.frame.size.height+task, [UIScreen mainScreen].bounds.size.width-30,tablehight.size.height);
            taskVcfream=taskVc.frame;
        }

        
    }
    
    if ([[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"appointment"] count]==0)
    {

        appointment=0;
        
        appoinmentVc.frame=CGRectMake(13,taskVc.frame.origin.y+taskVc.frame.size.height+appointment, [UIScreen mainScreen].bounds.size.width-30,0);
        appoinmentVc.hidden=YES;
        
        appoinmentVcfream=appoinmentVc.frame;
    }
    else
    {
        
        appoinmentVc.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
        appoinmentVc.layer.borderWidth = 2.0f;
        
        CGRect tablehight;
        
        tablehight= CGRectMake(appoinmentVc.myAppoinmentTable.frame.origin.x, appoinmentVc.myAppoinmentTable.frame.origin.y,appoinmentVc.myAppoinmentTable.frame.size.width,(84*([[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"appointment"] count]))+appoinmentVc.myAppoinmentTable.tableHeaderView.frame.size.height);
        
        
        
        if ([scrollHomeSlider isEqualToString:@"yes"])
        {
            
appoinmentVc.frame=CGRectMake(13,taskVc.frame.origin.y+taskVc.frame.size.height+20, [UIScreen mainScreen].bounds.size.width-30,appoinmentVcfream.size.height);
        }
        else
        {
            appoinmentVc.frame=CGRectMake(13,taskVc.frame.origin.y+taskVc.frame.size.height+20, [UIScreen mainScreen].bounds.size.width-30,tablehight.size.height);
            appoinmentVcfream=appoinmentVc.frame;

        }
    }
    
    
    
    if ([[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance"] count]==0)
    {
        companyPerformence=0;

        Performing.frame=CGRectMake(13,appoinmentVc.frame.origin.y+appoinmentVc.frame.size.height+companyPerformence, [UIScreen mainScreen].bounds.size.width-30,0);
        
        Performing.hidden=YES;
        
        Performingfream=Performing.frame;
        

    }
    else
    {
        Performing.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
        Performing.layer.borderWidth = 2.0f;
        Performing.tpHeading.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance_heading"] objectAtIndex:0] objectForKey:@"TP"];
        Performing.rcvHeading.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance_heading"] objectAtIndex:0] objectForKey:@"RCV"];
        Performing.tpAchiveLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance"] objectAtIndex:0] objectForKey:@"TP_YTD_ACH"];
        Performing.tpTargetLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance"] objectAtIndex:0] objectForKey:@"TP_YTD_TARGET"];
        Performing.rcvAchiveLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance"] objectAtIndex:0] objectForKey:@"RCV_YTD_ACH"];
        Performing.rcvTargetLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance"] objectAtIndex:0] objectForKey:@"RCV_YTD_TARGET"];
        if ([scrollHomeSlider isEqualToString:@"yes"])
        {
            
           Performing.frame=CGRectMake(13,appoinmentVc.frame.origin.y+appoinmentVc.frame.size.height+20, [UIScreen mainScreen].bounds.size.width-30,Performingfream.size.height);
        }
        else
        {
            Performing.frame=CGRectMake(13,appoinmentVc.frame.origin.y+appoinmentVc.frame.size.height+20, [UIScreen mainScreen].bounds.size.width-30,470);
            
            Performingfream=Performing.frame;
        }
    }
    
    if ([[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] count]==0)
    {
        
        performence=0;
        myPerformence.frame=CGRectMake(13,Performing.frame.origin.y+Performing.frame.size.height+performence,[UIScreen mainScreen].bounds.size.width-30,0);
        myPerformence.hidden=YES;
        
        myPerformencefream=myPerformence.frame;
        
        
        
    }
    else
    {
        
        myPerformence.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
        myPerformence.layer.borderWidth = 2.0f;
        [myPerformence.myPerformenceTable reloadData];
        
        
        
        
        
        if ([scrollHomeSlider isEqualToString:@"yes"])
        {
            
            myPerformence.frame=CGRectMake(13,Performing.frame.origin.y+Performing.frame.size.height+20,[UIScreen mainScreen].bounds.size.width-30,myPerformencefream.size.height);
        }
        else
        {
            CGRect tablehight;
            
            lableWidth=225;
            
            int i;float a; performenceTableHight.height=0;tablehight.size.height=0;
            for (i = 0; i < [[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] count]; i++)
            {
                
                performenceTableHight=[self heigtForCellwithString:[NSString stringWithFormat:@"%@ %@/NOS",[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:i]objectForKey:@"KPI"],[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:i]objectForKey:@"WEIGHTAGE"]] withFont:[UIFont systemFontOfSize:14]];
                
                //NSLog([myArrayOfStrings objectAtIndex:i]);
                
                
                a=performenceTableHight.height+tablehight.size.height+30;
                tablehight= CGRectMake(myPerformence.myPerformenceTable.frame.origin.x, myPerformence.myPerformenceTable.frame.origin.y, myPerformence.myPerformenceTable.frame.size.width,a+myPerformence.myPerformenceTable.tableHeaderView.frame.size.height);
            }
            myPerformence.frame=CGRectMake(13,Performing.frame.origin.y+Performing.frame.size.height+20,[UIScreen mainScreen].bounds.size.width-30,tablehight.size.height);
            myPerformencefream=myPerformence.frame;
            
        }
        
    }
    
    if ([[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] count]==0 || ![[historyModel sharedhistoryModel].opUserType.lowercaseString isEqualToString:@"employee"])
    {
        opinion =0;
        Opinion.frame=CGRectMake(13,myPerformence.frame.origin.y+myPerformence.frame.size.height+5+opinion, [UIScreen mainScreen].bounds.size.width-30,0);
        Opinion.hidden=YES;
        opinionfream=Opinion.frame;
    }
    else
    {
        Opinion.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
        Opinion.layer.borderWidth = 2.0f;
        
        
opinionfream= CGRectMake(Opinion.pooleTable.frame.origin.x, Opinion.pooleTable.frame.origin.y, Opinion.pooleTable.frame.size.width,(100*([[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0]objectForKey:@"polls_option"]count])));
        
        if  ([[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"id_poll_options"]isEqualToString:@""])
        {
            [historyModel sharedhistoryModel].poolstr=@"homepool"; //isEqualToString:@"homepool"]
        }
        [Opinion.pooleTable reloadData];
         Opinion.titleLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"polls"] objectAtIndex:0] objectForKey:@"name"];

        
        if ([scrollHomeSlider isEqualToString:@"yes"])
        {
            
            Opinion.frame=CGRectMake(13,myPerformence.frame.origin.y+myPerformence.frame.size.height+20, [UIScreen mainScreen].bounds.size.width-30,Opinionfreamhight.size.height);
        }
        else
        {
            
            Opinion.frame=CGRectMake(13,myPerformence.frame.origin.y+myPerformence.frame.size.height+20, [UIScreen mainScreen].bounds.size.width-30,opinionfream.size.height+50);
            
            Opinionfreamhight=Opinion.frame;
        }
    }
    
    if ([[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"upcoming_holiday"] count]==0)
    {
        holiday=0;
        
        holidays.frame=CGRectMake(13,Opinion.frame.origin.y+Opinion.frame.size.height+holiday, [UIScreen mainScreen].bounds.size.width-30,0);
        
        holidays.hidden=YES;
        
        holidaysfream=holidays.frame;
       
        
    }
    else
    {
        holidays.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
        holidays.layer.borderWidth = 2.0f;
        [holidays.holidaysTable reloadData];
        
        [holidays.seeAllBtn addTarget:self
                                    action:@selector(holidaylist)
                          forControlEvents:UIControlEventTouchUpInside];
        CGRect tablehight;
         tablehight= CGRectMake(holidays.holidaysTable.frame.origin.x, holidays.holidaysTable.frame.origin.y, holidays.holidaysTable.frame.size.width,(80*([[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"upcoming_holiday"] count]))+holidays.holidaysTable.tableHeaderView.frame.size.height+holidays.holidaysTable.tableFooterView.frame.size.height);
        if ([scrollHomeSlider isEqualToString:@"yes"])
        {
            
            
            holidays.frame=CGRectMake(13,Opinion.frame.origin.y+Opinion.frame.size.height+20, [UIScreen mainScreen].bounds.size.width-30,holidaysfream.size.height);
        }
        else
        {
            
            holidays.frame=CGRectMake(13,Opinion.frame.origin.y+Opinion.frame.size.height+20, [UIScreen mainScreen].bounds.size.width-30,tablehight.size.height);
            holidaysfream=holidays.frame;
        }

        
        
    }
    
    if ([[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"sankalp_story"] count]==0)
    {
        story=0;
        
        stories.frame=CGRectMake(13,holidays.frame.origin.y+holidays.frame.size.height+story, [UIScreen mainScreen].bounds.size.width-30,0);
        stories.hidden=YES;
        
        storiesfream=stories.frame;
    }
    else
    {
        [stories.sankalpStoriesTable reloadData];
        
        CGRect tablehight;
        tablehight= CGRectMake(stories.sankalpStoriesTable.frame.origin.x, stories.sankalpStoriesTable.frame.origin.y,stories.sankalpStoriesTable.frame.size.width,(290*([[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"sankalp_story"] count]))+stories.sankalpStoriesTable.tableHeaderView.frame.size.height+stories.sankalpStoriesTable.tableFooterView.frame.size.height);
       
                [stories.sankalpBtn addTarget:self
                           action:@selector(ViewAllStories)
                 forControlEvents:UIControlEventTouchUpInside];
        if ([scrollHomeSlider isEqualToString:@"yes"])
        {
             stories.frame=CGRectMake(13,holidays.frame.origin.y+holidays.frame.size.height+20, [UIScreen mainScreen].bounds.size.width-30,storiesfream.size.height);
        }
        else
        {
            
             stories.frame=CGRectMake(13,holidays.frame.origin.y+holidays.frame.size.height+20, [UIScreen mainScreen].bounds.size.width-30,tablehight.size.height);
            storiesfream=stories.frame;
        }
    }
    
    if ([[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"event_list"] count]==0)
    {
        event=0;
        
        latestVC.frame=CGRectMake(13,stories.frame.origin.y+stories.frame.size.height+event, [UIScreen mainScreen].bounds.size.width-30,0);
        latestVC.hidden=YES;
        
        latestVCfream=latestVC.frame;

    }
    else
    {
        [latestVC.latestEventVCTable reloadData];
        
        CGRect tablehight;
        NSLog(@"%d",[historyModel sharedhistoryModel].hight);
        NSLog(@"%f",latestVC.latestEventVCTable.tableHeaderView.frame.size.height);
        NSLog(@"%f",latestVC.latestEventVCTable.tableFooterView.frame.size.height);

        tablehight= CGRectMake(latestVC.latestEventVCTable.frame.origin.x, latestVC.latestEventVCTable.frame.origin.y,latestVC.latestEventVCTable.frame.size.width,[historyModel sharedhistoryModel].hight+latestVC.latestEventVCTable.tableHeaderView.frame.size.height+latestVC.latestEventVCTable.tableFooterView.frame.size.height);
        

      
        [latestVC.latestEventBtn addTarget:self
                                   action:@selector(latestevent)
                         forControlEvents:UIControlEventTouchUpInside];
        
        if ([scrollHomeSlider isEqualToString:@"yes"])
        {
            
              latestVC.frame=CGRectMake(13,stories.frame.origin.y+stories.frame.size.height+20, [UIScreen mainScreen].bounds.size.width-30,latestVCfream.size.height);
        }
        else
        {
            
              latestVC.frame=CGRectMake(13,stories.frame.origin.y+stories.frame.size.height+20, [UIScreen mainScreen].bounds.size.width-30,tablehight.size.height);
            latestVCfream=latestVC.frame;
        }
    }
    
    //===Youtube embed
    
    UIWebView * youTubeWebView=[[UIWebView alloc]initWithFrame:CGRectMake(13,latestVC.frame.origin.y + latestVC.frame.size.height + 10.0f, [UIScreen mainScreen].bounds.size.width-30,240)];
    youTubeWebView.allowsInlineMediaPlayback=YES;
    youTubeWebView.mediaPlaybackRequiresUserAction=NO;
    youTubeWebView.mediaPlaybackAllowsAirPlay=YES;
    youTubeWebView.delegate=self;
    youTubeWebView.scrollView.bounces=NO;
    
    NSString *linkObj=@"https://youtu.be/N9vfsHq1ZdU";//@"http://www.youtube.com/v/6MaSTM769Gk";
    NSLog(@"linkObj1_________________%@",linkObj);
    NSString *embedHTML =[NSString stringWithFormat:@"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
                          background-color: transparent;color: white;}\\</style>\\</head><body style=\"margin:20\">\\<embed webkit-playsinline id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \\width=\"100%%\" height=\"180\"></embed>\\</body></html>",linkObj];
    
    
    NSString *html = [NSString stringWithFormat:embedHTML, linkObj];
    [youTubeWebView loadHTMLString:html baseURL:nil];
    
//    NSURL *url = [NSURL URLWithString:@"http://www.youtube.com/watch?v=N9vfsHq1ZdU"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [youTubeWebView loadRequest:request];
    
    BOOL youTubePresent = FALSE;
     if (![[historyModel sharedhistoryModel].opUserType.lowercaseString isEqualToString:@"employee"]) {
         [self.landingScrollView addSubview:youTubeWebView];
         youTubePresent=true;
     }
    
    
    
    
    
    //
    
    if ([[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"slider"] count]==0)
    {
        slider=0;
        self.contentLab.frame=CGRectMake(13,latestVC.frame.origin.y + latestVC.frame.size.height + 10.0f+(youTubePresent?250:0), [UIScreen mainScreen].bounds.size.width-30,0);
        
        contentViewfream=self.contentLab.frame;
        
        
    }
    else
    {
        self.contentLab.layer.borderColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:222/255.0 alpha:1.0].CGColor;
        self.contentLab.layer.borderWidth = 2.0f;
        NSArray*sliderArray=[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"slider"];
        [historyModel sharedhistoryModel].homeArray=sliderArray;
        NSString *ImageURL = [[sliderArray objectAtIndex:0]objectForKey:@"slider_image"];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
        lableWidth=325;
        self.homeImage.image = [UIImage imageWithData:imageData];
        self.titleLab.text=[[sliderArray objectAtIndex:0]objectForKey:@"name"];
        labelHeight = [self heigtForCellwithString:[[sliderArray objectAtIndex:0]objectForKey:@"message"] withFont:[UIFont systemFontOfSize:17]];
        self.detailLab.text=[[sliderArray objectAtIndex:0]objectForKey:@"message"];
        
        [self.detailLab sizeToFit];
        if ([scrollHomeSlider isEqualToString:@"yes"])
        {
            self.contentLab.frame=CGRectMake(13,latestVC.frame.origin.y + latestVC.frame.size.height + 10.0f+(youTubePresent?250:0), [UIScreen mainScreen].bounds.size.width-30,contentViewfream.size.height);
        }
        else
        {
            self.contentLab.frame=CGRectMake(13,latestVC.frame.origin.y + latestVC.frame.size.height + 10.0f+(youTubePresent?250:0), [UIScreen mainScreen].bounds.size.width-30,self.homeImage.frame.size.height+labelHeight.height+self.titleLab.frame.size.height+70);
            contentViewfream=self.contentLab.frame;
        }
    }
    
    self.landingScrollView.contentSize=CGSizeMake(self.view.frame.size.width, (youTubePresent?250:0)+mailVc.frame.size.height+ taskVc.frame.size.height+ appoinmentVc.frame.size.height+ myPerformence.frame.size.height+ Performing.frame.size.height+ Opinion.frame.size.height+ holidays.frame.size.height+stories.frame.size.height+latestVC.frame.size.height+self.contentLab.frame.size.height+slider+inbox+task+appointment+performence+companyPerformence+opinion+holiday+story+event+50+businessAppFrame.size.height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextBtn:(id)sender {
    NSLog(@"n");
    if (SliderCount==[[historyModel sharedhistoryModel].homeArray count]-1) {
        
        self.nextBtn.userInteractionEnabled=NO;
    }
   else if ([[historyModel sharedhistoryModel].homeArray count]==1)
    {
        
        self.nextBtn.userInteractionEnabled=NO;
    }

    else
    {
        self.previousBtn.userInteractionEnabled=YES;

        NSLog(@"Slider Array Value>>%@",[historyModel sharedhistoryModel].homeArray);
        home=[[homeViewVC alloc]init];
        home.frame=CGRectMake(self.contentLab.frame.origin.x,self.contentLab.frame.origin.y,self.contentLab.frame.size.width
                              ,self.contentLab.frame.size.height);
        
        CGRect basketTopFrame = self.contentLab.frame;
        [self.landingScrollView addSubview:home];
        home.hidden=YES;
        
        basketTopFrame.origin.x = self.contentLab.frame.size.width+50;
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.contentLab.frame = basketTopFrame;
            
            
        }
                         completion:^(BOOL finished)
         {
             scrollHomeSlider=@"yes";
            
             NSString *ImageURL = [[[historyModel sharedhistoryModel].homeArray objectAtIndex:SliderCount]objectForKey:@"slider_image"];
            [self.homeImage   setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
             
             self.titleLab.text=[[[historyModel sharedhistoryModel].homeArray objectAtIndex:SliderCount]objectForKey:@"name"];
             self.detailLab.text=[[[historyModel sharedhistoryModel].homeArray objectAtIndex:SliderCount]objectForKey:@"message"];
             [self.detailLab sizeToFit];
             self.contentLab.frame=home.frame;
             lableWidth=325;
             
             labelHeight = [self heigtForCellwithString:[[[historyModel sharedhistoryModel].homeArray objectAtIndex:SliderCount]objectForKey:@"message"] withFont:[UIFont systemFontOfSize:17]];
           //  self.detailLab.text=[[sliderArray objectAtIndex:0]objectForKey:@"message"];
             [self.detailLab sizeToFit];
             [self initField];
         
         
         }];
        
        SliderCount=SliderCount+1;
        
    }
}

- (IBAction)previousBtn:(id)sender {
    NSLog(@"p");
    
    
    if(SliderCount==1)
    {
        self.previousBtn.userInteractionEnabled=NO;
       // self.nextBtn.userInteractionEnabled=YES;
    }
    else
    {
        self.nextBtn.userInteractionEnabled=YES;

        home=[[homeViewVC alloc]init];
        home.frame=CGRectMake(self.contentLab.frame.origin.x,self.contentLab.frame.origin.y,self.contentLab.frame.size.width
                              ,self.contentLab.frame.size.height);
        
        CGRect basketTopFrame = self.contentLab.frame;
        
        basketTopFrame.origin.x=basketTopFrame.origin.x-400;
        [self.landingScrollView addSubview:home];
        home.hidden=YES;
        
        // basketTopFrame.origin.x = self.contentLab.frame.size.width+50;
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            self.contentLab.frame = basketTopFrame;
            
        }
                         completion:^(BOOL finished)
         {
             
             scrollHomeSlider=@"yes";

             NSString *ImageURL = [[[historyModel sharedhistoryModel].homeArray objectAtIndex:SliderCount]objectForKey:@"slider_image"];
             [self.homeImage   setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
             
             self.titleLab.text=[[[historyModel sharedhistoryModel].homeArray objectAtIndex:SliderCount]objectForKey:@"name"];
             self.detailLab.text=[[[historyModel sharedhistoryModel].homeArray objectAtIndex:SliderCount]objectForKey:@"message"];
             self.contentLab.frame=home.frame;
             lableWidth=325;

             labelHeight = [self heigtForCellwithString:[[[historyModel sharedhistoryModel].homeArray objectAtIndex:SliderCount]objectForKey:@"message"] withFont:[UIFont systemFontOfSize:17]];
             //  self.detailLab.text=[[sliderArray objectAtIndex:0]objectForKey:@"message"];
             [self.detailLab sizeToFit];
             [self initField];
         }];
        SliderCount=SliderCount-1;
    }
    
}
- (IBAction)raiseRequest:(id)sender {
    NSLog(@"yes");

    if (check==NO)
    {
        [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        
        check=YES;
            if (!([[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"]objectAtIndex:1] objectForKey:@"Leave"]==0))
            {
                self.expandView.frame = CGRectMake(0,0,self.view.frame.size.width,[UIScreen mainScreen].bounds.size.height-360);
                self.raiseRequest.frame = CGRectMake(0,self.expandView.frame.size.height-40, self.raiseRequest.frame.size.width,50);
                
                NSLog(@"expandView---->%f",self.expandView.frame.size.height);
            }
            else
            {
        
                self.expandView.frame = CGRectMake(0,0,self.view.frame.size.width,[UIScreen mainScreen].bounds.size.height-100);
                self.raiseRequest.frame = CGRectMake(0,self.expandView.frame.size.height-40, self.raiseRequest.frame.size.width,50);
                
                NSLog(@"expandView---->%f",self.expandView.frame.size.height);
        
            }
    }
                     completion:^(BOOL finished)
     {
            self.riseTable.hidden=NO;
            [self.riseTable reloadData];


     }];
    }
        else
    {
    
            [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
            
            check=NO;

            self.expandView.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,40);
            self.raiseRequest.frame = CGRectMake(0,self.expandView.frame.size.height-40, self.raiseRequest.frame.size.width,50);
        }
                         completion:^(BOOL finished)
         {
             self.riseTable.hidden=YES;
         }];
        
    }

    }

- (IBAction)moreApp:(id)sender
{
    moreAppVC*MAVC=[[moreAppVC alloc]init];
    [self.navigationController pushViewController:MAVC animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"count>>>%luu",[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"] count]);
        return [[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"] count];
   // return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
        return 100;

    }
    else
    {
        return 40;

    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {

    return [[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"]objectAtIndex:section] objectForKey:@"Facilities"] count];
    }
   else if (section==1)
    {
        NSLog(@"count>>>%luu",[[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"]objectAtIndex:section] objectForKey:@"Leave"] count]);
        
        return [[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"]objectAtIndex:section] objectForKey:@"Leave"] count];
    }
    else //if (section==2)
    {
        NSLog(@"other_request>>>>%@",[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"]objectAtIndex:section] objectForKey:@"other_request"]);
    return [[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"]objectAtIndex:section] objectForKey:@"other_request"] count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"LeftMenuTableViewCell";
    cellAttachment = (LeftMenuTableViewCell *)[self.riseTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"LeftMenuTableViewCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        cellAttachment.titleLab.font=[UIFont systemFontOfSize:15.0];
         cellAttachment.titleLab.textColor = [UIColor colorWithRed:30.0/255.0f green:175.0/255.0f blue:180.0/255.0f alpha:1.0];
        cellAttachment.selectionStyle=NO;
        cellAttachment.separaterLab.hidden=YES;
    }
    
    cellAttachment.titleLab.frame=CGRectMake(cellAttachment.menuImage.frame.origin.y+cellAttachment.menuImage.frame.size.width+20,cellAttachment.titleLab.frame.origin.y,cellAttachment.titleLab.frame.size.width,cellAttachment.titleLab.frame.size.height);
    
    if (indexPath.section==0)
    {
        cellAttachment.menuImage.frame=CGRectMake(15, 14, 17,17);

        NSString*urlStr=[[[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"]objectAtIndex:indexPath.section] objectForKey:@"Facilities"] objectAtIndex:indexPath.row] objectForKey:@"ICON"];
        
        [cellAttachment.menuImage setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"common-bullet"]];
        
cellAttachment.titleLab.text=[[[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"]objectAtIndex:indexPath.section] objectForKey:@"Facilities"] objectAtIndex:indexPath.row] objectForKey:@"CHILD_MENU"];
        
        }
    if (indexPath.section==1)
    {
       UILabel*leaveLab = [[UILabel alloc] initWithFrame:CGRectMake(cellAttachment.frame.origin.x+20,15,cellAttachment.frame.size.width-50, 30)];
        
        UISlider*leaveLabStatus = [[UISlider alloc] initWithFrame:CGRectMake(cellAttachment.frame.origin.x+20,60,cellAttachment.frame.size.width-50,2)];
        [leaveLabStatus setThumbImage:[UIImage new] forState:UIControlStateNormal];
        leaveLabStatus.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 2.0);

         UILabel*line = [[UILabel alloc] initWithFrame:CGRectMake(cellAttachment.frame.origin.x+20,cellAttachment.frame.size.height+cellAttachment.frame.origin.y+40,cellAttachment.frame.size.width,2)];
        
        
        NSString*leavebal=[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"leave_status"] objectAtIndex:0] objectForKey:@"op_leave_bal"];
        NSString*opleaverec=[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"leave_status"] objectAtIndex:0] objectForKey:@"op_leave_rec"];
        
        
        leaveLab.text=[NSString stringWithFormat:@"%@/%@ %@",leavebal,opleaverec,@"Leaves Remaining"];
        leaveLab.font=[UIFont systemFontOfSize:16.0];

        float intleaveLabStatus = [leavebal intValue];
        float intopleaverec = [opleaverec intValue];
        line.backgroundColor=[UIColor colorWithRed:231.0/255.0f green:232.0/255.0f blue:236.0/255.0f alpha:1.0];
        [cellAttachment addSubview:leaveLab];
        [cellAttachment addSubview:leaveLabStatus];
        [cellAttachment addSubview:line];
        leaveLabStatus.maximumTrackTintColor=[UIColor lightGrayColor];
        leaveLabStatus.minimumTrackTintColor=[UIColor lightGrayColor];
        leaveLabStatus.value=0;
        leaveLabStatus.maximumValue=0;
        leaveLabStatus.maximumValue=100;
        float percent=intleaveLabStatus*100/intopleaverec;
        if (percent<=25)
        {
            leaveLabStatus.value=percent;
            leaveLabStatus.minimumTrackTintColor=[UIColor redColor];

        }
       else if (percent<=50)
        {
            leaveLabStatus.value=percent;
            leaveLabStatus.minimumTrackTintColor=[UIColor yellowColor];

        }
       else if (percent<=100)
        {
            leaveLabStatus.value=percent;
            leaveLabStatus.minimumTrackTintColor=[UIColor greenColor];

        }
    }
     if (indexPath.section==2)
    {        cellAttachment.menuImage.frame=CGRectMake(15, 14, 17,17);

        NSString*urlStr=[[[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"]objectAtIndex:indexPath.section] objectForKey:@"other_request"] objectAtIndex:indexPath.row] objectForKey:@"ICON"];
        
        [cellAttachment.menuImage setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"common-bullet"]];
        cellAttachment.titleLab.text=[[[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"]objectAtIndex:indexPath.section] objectForKey:@"other_request"] objectAtIndex:indexPath.row] objectForKey:@"CHILD_MENU"];
    }
    return  cellAttachment;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString*headerStr;
    if(section == 0)
    {
        headerStr=@"FACILITIES";
    }
    else if(section == 2)
    {
        headerStr=@"OTHER REQUESTS";
    }
    return headerStr;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   if (section==0)
   {
   if ([[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"]objectAtIndex:section] objectForKey:@"Facilities"] count]==0)
       
       return 0;
       else
           return 25;
   }
    if (section==2)
    {
        if ([[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"]objectAtIndex:section] objectForKey:@"other_request"] count]==0)
            
            return 0;
        else
            return 25;
    }
    else
    {
    
    }
    return 25;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString*webStr;
    if (![[[[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"]objectAtIndex:indexPath.section] objectForKey:@"Facilities"] objectAtIndex:indexPath.row] objectForKey:@"LINK"] isEqual:[NSNull null]])
    {
     webStr=[[[[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"request_center_inner_menu"]objectAtIndex:indexPath.section] objectForKey:@"Facilities"] objectAtIndex:indexPath.row] objectForKey:@"LINK"];
    }
    if (indexPath.section==0)
    {
        NSURL*url=[NSURL URLWithString:webStr];
        
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    if (indexPath.section==1)
    {
        NSURL*url=[NSURL URLWithString:webStr];
        
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view;
    
    if (section==1)
    {
    view = [[UIView alloc] initWithFrame:CGRectMake(50,0, self.riseTable.frame.size.width,50)];
        
        UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.riseTable.frame.size.width, 2)];
         UILabel*title=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, self.riseTable.frame.size.width-200, 40)];
         UIButton*applyLeave=[[UIButton alloc]initWithFrame:CGRectMake(self.riseTable.frame.size.width-100, 5,90, 30)];
        [applyLeave setTitle:@"Apply" forState:UIControlStateNormal];
        [applyLeave setTitleColor:[UIColor colorWithRed:30.0/255.0f green:175.0/255.0f blue:180.0/255.0f alpha:1.0] forState:UIControlStateNormal];
        applyLeave.titleLabel.font = [UIFont systemFontOfSize:12];
        [applyLeave addTarget:self action:@selector(applyLeaveAction) forControlEvents:UIControlEventTouchUpInside];
        lab.backgroundColor=[UIColor colorWithRed:231.0/255.0f green:232.0/255.0f blue:236.0/255.0f alpha:1.0];
        title.text=@"LEAVES";
        title.font=[title.font fontWithSize:12];
       // view.backgroundColor=[UIColor redColor];
        [view addSubview:lab];
        [view addSubview:title];
        [view addSubview:applyLeave];
        [self.riseTable.tableHeaderView addSubview:view];
    }
    return view;
}
-(void)applyLeaveAction
{
    NSLog(@"applyLeaveAction");
    applyLeaveVC*applLeave=[[applyLeaveVC alloc]init];
    [self.navigationController pushViewController:applLeave animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = TRUE;
    getImgUrl = [[NSUserDefaults standardUserDefaults]
                 stringForKey:@"preferenceName"];
    [self.profileImg setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    [self logApi];
}
-(void)logApi
{
    NSString*pageName=@"Home Page";
    [MyCustomClass logApi:pageName];
}
- (IBAction)profileBtn:(id)sender
{
    profileVC*profile=[[profileVC alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
}
-(void)ViewAllStories
{
    latestEventDetail*profile=[[latestEventDetail alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
    [historyModel sharedhistoryModel].menuTitle=@"Sankalp Stories";
    [historyModel sharedhistoryModel].checkHomeORMenu=@"home";
}
-(void)latestevent
{
    latestEventDetail*profile=[[latestEventDetail alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
    [historyModel sharedhistoryModel].menuTitle=@"Latest Events";
    [historyModel sharedhistoryModel].checkHomeORMenu=@"home";
}
-(void)approveTaskDetail
{
    approveTaskVC*approve=[[approveTaskVC alloc]init];
    [self.navigationController pushViewController:approve animated:YES];
}
-(void)holidaylist
{
    holidayCalenderDetail*approve=[[holidayCalenderDetail alloc]init];
    [self.navigationController pushViewController:approve animated:YES];
    [historyModel sharedhistoryModel].checkHomeORMenu=@"home";
}
-(void)seeAll
{
    mytaskMenuVC*seeAll=[[mytaskMenuVC  alloc]init];
    [self.navigationController pushViewController:seeAll animated:YES];
    [historyModel sharedhistoryModel].checkHomeORMenu=@"home";
}

-(void)inboxDetail
{
    NSString*urlmail=[NSString stringWithFormat:@"%@uid=%@&token=%@",@"https://www.greatplus.com/service/inbox.login.php?",[historyModel sharedhistoryModel].uid,[historyModel sharedhistoryModel].token];
    NSURL*url=[NSURL URLWithString:urlmail];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}
-(CGSize)heigtForCellwithString:(NSString *)stringValue withFont:(UIFont*)font
{
    CGSize constraint = CGSizeMake(lableWidth,2000); // Replace 300 with your label width
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [stringValue boundingRectWithSize:constraint
                                            options:         (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil];
    return rect.size;
}

-(void) getBumperPrizeData: (NSString *)fromDate andToDate: (NSString *)toDate withUserID: (NSString *)uid andDealerID: (NSString *)dealerID  withCompletionHandler: (void (^)(void))completionHandler {
    
    NSDictionary *headers = @{ @"content-type": @"application/json"};
    
    NSDictionary *parameters = @{@"p_user_id":uid, @"p_dealer_id":dealerID, @"p_from":fromDate, @"p_to":toDate};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://greatplus.com/api_services/bumper_prize_api.php"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *realResponse = (NSHTTPURLResponse *)response;
        
        if (realResponse.statusCode == 200) {
            NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            [BumperPrizeModel sharedInstance].prizeArray = [[NSMutableArray alloc] init];
            
            [[BumperPrizeModel sharedInstance].prizeArray addObjectsFromArray:json[@"bumper_prize"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_prizeCollectionView reloadData];
                completionHandler();
            });
        } else {
            NSLog(@"%@", error);
        }
    }];
    [task resume];
}

-(void) setupBumperPrizeView {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSString *currentDateString = [formatter stringFromDate:now];
    
    [self getBumperPrizeData:@"01-08-2018" andToDate:currentDateString withUserID:@"8800525300" andDealerID:@"S1DLH1276081" withCompletionHandler:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self openPopup:_bumperPrizeView closeButton:_closeButton];
        });
    }];
}

-(void) openPopup: (UIView *)view closeButton:(UIButton *)button {
    [UIView animateWithDuration:0.3/1.5 animations:^{
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                view.transform = CGAffineTransformIdentity;
                button.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

-(void) closePopup: (UIView *)view closeButton:(UIButton *)button {
    [UIView animateWithDuration:0.3/1.5 animations:^{
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
            button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        }];
    }];
}

- (IBAction)closeBumperPrizeView:(id)sender {
    [self closePopup:_bumperPrizeView closeButton:_closeButton];
}

@end
