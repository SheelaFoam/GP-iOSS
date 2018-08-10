//
//  LeftMenuViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 7/29/16.
//  Copyright © 2016 Supra IT. All rights reserved.s
//

#import "LeftMenuViewController.h"
#import "historyModel.h"
#import "menuSubClass.h"
#import "telephoneDirVC.h"
#import "WebViewVC.h"
#import "TelephoneScreenViewController.h"
#import "ContactUsViewController.h"
#import "mytaskMenuVC.h"
#import "myAppoinmentDetail.h"
#import "holidayCalenderDetail.h"
#import "latestEventDetail.h"
#import "DocumentBoxVC.h"
#import "opinionDetailVC.h"
#import "comapanyPerformenceVC.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "LoginViewController.h"
#import "UIImageView+WebCache.h"
#import "GreatPlusMrpCalculatorViewController.h"
#import "GreatePlusCheckOutFormVC.h"
#import "GreatPlusUploadDocumentVC.h"
#import "UserDefaultStorage.h"
#import <SafariServices/SafariServices.h>

@interface LeftMenuViewController ()<WebServiceResponseProtocal>
{
    NSMutableArray*dataArray;
    NSMutableArray*fixeArray;
    NSArray*imageArray;
    UIView *tableFooter;
    LeftMenuTableViewCell *cell;
    NSString*menuCheck;
    MyWebServiceHelper *helper;
    NSArray*info;
    LoginViewController*loginVC;
    NSArray *arrayOriginal;
    NSMutableArray *arForTable;
    int expandCell;
    NSString*rotate;
    BOOL hideORshow;
    
}

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftMenuTable.delegate=self;
    self.leftMenuTable.dataSource=self;
    self.leftMenuTable.sectionHeaderHeight=0;
    
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    } else {
        // Fallback on earlier versions
    }

 }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (hideORshow==YES)
//        return  dataArray.count;
//    else
        return  arForTable.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"LeftMenuTableViewCell";
    cell = (LeftMenuTableViewCell *)[self.leftMenuTable dequeueReusableCellWithIdentifier:CellIdentifier];
    tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLineEtched;
    cell.separaterLab.hidden=TRUE;
    
    if (cell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"LeftMenuTableViewCell" owner:self options:nil];
        cell = [cellArray objectAtIndex:0];
        cell.titleLab.font=[UIFont systemFontOfSize:22.0];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.titleLab.textColor=[UIColor darkGrayColor];



    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];


    int fixArrayCount = (int)fixeArray.count;
    
   if (indexPath.row<=fixArrayCount-1 && [[arForTable objectAtIndex:indexPath.row] isKindOfClass:[NSString class]])
   {

       
      cell.titleLab.text=[arForTable objectAtIndex:indexPath.row];
           cell.titleLab.textColor = [UIColor colorWithRed:7.0/255.0f green:59.0/255.0f blue:117.0/255.0f alpha:1.0];

       NSString*chechStr=[arForTable objectAtIndex:indexPath.row];
       if ([chechStr isEqualToString:@"Home"])
       {
           
           cell.menuImage.frame=CGRectMake(8, 17,30, 15);
           CGRect frame = cell.titleLab.frame;
           frame.origin.x = 18;
           cell.titleLab.frame=frame;
           
           
           cell.menuImage.image = nil;
           
           
       }

       if ([chechStr isEqualToString:@"Inbox"])
       {
           
           cell.menuImage.frame=CGRectMake(13, 17, 20, 10);
           
           
           cell.menuImage.image = [UIImage imageNamed:@"menuInbox"];
           
           
       }
       else if ([chechStr isEqualToString:@"My Tasks"])
       {
           
           cell.menuImage.frame=CGRectMake(15, 10, 15, 17);
           cell.menuImage.image = [UIImage imageNamed:@"my-tasks"];
           
       }
       else if ([chechStr isEqualToString:@"My Appointment"])
       {
           
           cell.menuImage.frame=CGRectMake(15, 10, 15, 17);
           
           cell.menuImage.image = [UIImage imageNamed:@"menumy-appiontment"];
           
       }
       else if ([chechStr isEqualToString:@"My Performance"])
       {
           
           cell.menuImage.frame=CGRectMake(15, 12, 15, 10);
           
           cell.menuImage.image = [UIImage imageNamed:@"my-performance"];
           
       }
       else if ([chechStr isEqualToString:@"Company Performence"])
       {
           
           cell.menuImage.frame=CGRectMake(15, 12, 12, 10);
           
           cell.menuImage.image = [UIImage imageNamed:@"performing"];
           
       }
       else if ([chechStr isEqualToString:@"What is your Opinion"])
       {
           
           cell.menuImage.frame=CGRectMake(15, 10, 15, 17);
           
           cell.menuImage.image = [UIImage imageNamed:@"what-is-ur-opinion"];
           
       }
       else if ([chechStr isEqualToString:@"Holiday Calendar"])
       {
           
           cell.menuImage.frame=CGRectMake(15, 10, 15, 17);
           
           cell.menuImage.image = [UIImage imageNamed:@"upcoming-holidays"];
           
       }
       else if ([chechStr isEqualToString:@"Sankalp Stories"])
       {
           
           cell.menuImage.frame=CGRectMake(15, 10, 15, 17);
           
           cell.menuImage.image = [UIImage imageNamed:@"sankalp"];
           
       }
       else if ([chechStr isEqualToString:@"Latest Event"])
       {
           
           cell.menuImage.frame=CGRectMake(18, 10, 13,13);
           
           cell.menuImage.image = [UIImage imageNamed:@"menulatest-event"];
           
       }
       else if ([chechStr isEqualToString:@"Log Out"])
       {
           cell.menuImage.frame=CGRectMake(15,13,16,16);
           
           cell.menuImage.image = [UIImage imageNamed:@"logOut"];
           cell.titleLab.font=[UIFont systemFontOfSize:22.0];

           cell.contentView.backgroundColor = [UIColor whiteColor];
           cell.titleLab.textColor=[UIColor darkGrayColor];
           UIFont * font = [UIFont fontWithName:@"Helvetica-Bold"
                                           size:[UIFont systemFontSize]];
           [cell.titleLab setFont:font];
           
           
       }
       
       else if ([chechStr isEqualToString:@"Help & Support"]) {
           cell.titleLab.text=[arForTable objectAtIndex:indexPath.row];
           cell.titleLab.textColor = [UIColor colorWithRed:7.0/255.0f green:59.0/255.0f blue:117.0/255.0f alpha:1.0];
           cell.separaterLab.hidden=TRUE;
           CGRect frame = cell.titleLab.frame;
           frame.origin.x = 18;
           cell.titleLab.frame=frame;
       }
       else if ([chechStr isEqualToString:@"More Apps"])
       {
           
           if (hideORshow==NO)
           {
               cell.dropDownImg.frame=CGRectMake(cell.titleLab.frame.origin.x+cell.titleLab.frame.size.width-25,10,cell.dropDownImg.frame.size.width,cell.dropDownImg.frame.size.height);
               [cell.dropDownImg setImage:[UIImage imageNamed:@"minus"]];
           }
           
           else if (hideORshow==YES)
           {

               cell.dropDownImg.frame=CGRectMake(cell.titleLab.frame.origin.x+cell.titleLab.frame.size.width-25,10,cell.dropDownImg.frame.size.width,cell.dropDownImg.frame.size.height);
               
               [cell.dropDownImg setImage:[UIImage imageNamed:@"plus"]];
           }


           cell.titleLab.frame=CGRectMake(cell.menuImage.frame.origin.x,cell.titleLab.frame.origin.y,cell.titleLab.frame.size.width,cell.titleLab.frame.size.height);

       // cell.contentView.backgroundColor = [UIColor whiteColor];
         //  cell.titleLab.textColor=[UIColor blueColor];
           UIFont * font = [UIFont fontWithName:@"Helvetica-Bold"
                                           size:22];
           [cell.titleLab setFont:font];


           
       }


   }
    else
    {
        if ([[arForTable objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
            if ([[arForTable objectAtIndex:indexPath.row] isEqualToString:@"Help & Support"] || [[arForTable objectAtIndex:indexPath.row] isEqualToString:@"Telephone Directory"]) {
                cell.titleLab.text=[arForTable objectAtIndex:indexPath.row];
                cell.titleLab.textColor = [UIColor colorWithRed:7.0/255.0f green:59.0/255.0f blue:117.0/255.0f alpha:1.0];
                cell.separaterLab.hidden=TRUE;
                CGRect frame = cell.titleLab.frame;
                frame.origin.x = 18;
                cell.titleLab.frame=frame;
            }
            return cell;
        }
        
        int cellLevel=[[[arForTable objectAtIndex:indexPath.row] valueForKey:@"level"] intValue];

        
        CGRect imageframe=cell.menuImage.frame;
        CGRect lableframe=cell.titleLab.frame;
        switch (cellLevel) {
            case 1:
                
                imageframe.origin.x = imageframe.origin.x+10; // new x
                cell.menuImage.frame = imageframe;
                lableframe.origin.x = lableframe.origin.x+10; // new x
                cell.titleLab.frame = lableframe;
                cell.separaterLab.hidden=YES;

                break;
            case 2:
                imageframe.origin.x = imageframe.origin.x+20; // new x
                cell.menuImage.frame = imageframe;
                lableframe.origin.x = lableframe.origin.x+20; // new x
                cell.titleLab.frame = lableframe;
                cell.separaterLab.hidden=YES;

                break;
            case 3:
                imageframe.origin.x = imageframe.origin.x+30; // new x
                cell.menuImage.frame = imageframe;
                lableframe.origin.x = lableframe.origin.x+30; // new x
                cell.titleLab.frame = lableframe;
                cell.separaterLab.hidden=YES;

                break;
            case 4:
                imageframe.origin.x = imageframe.origin.x+40; // new x
                cell.menuImage.frame = imageframe;
                lableframe.origin.x = lableframe.origin.x+40; // new x
                cell.titleLab.frame = lableframe;
                cell.separaterLab.hidden=YES;

                break;
                
            default:
                break;
        }
        if ([[[arForTable objectAtIndex:indexPath.row] valueForKey:@"level"]intValue]==0)
        {

         cell.titleLab.frame=CGRectMake(cell.menuImage.frame.origin.x,cell.titleLab.frame.origin.y,cell.titleLab.frame.size.width,cell.titleLab.frame.size.height);

        }
        if (!([[[arForTable objectAtIndex:indexPath.row] valueForKey:@"SUB_MENU"] count]==0))
        {

            cell.dropDownImg.frame=CGRectMake(cell.titleLab.frame.origin.x+cell.titleLab.frame.size.width+20,18,cell.dropDownImg.frame.size.width-10,cell.dropDownImg.frame.size.height-10);
            [cell.dropDownImg setImage:[UIImage imageNamed:@"nav-arrow"]];
            
            switch (cellLevel) {
                case 1:
                    if(!([[[arForTable objectAtIndex:indexPath.row] valueForKey:@"SUB_MENU"] count]==0))
                    {
                        
                        cell.dropDownImg.frame=CGRectMake(cell.titleLab.frame.origin.x+cell.titleLab.frame.size.width-40,18,cell.dropDownImg.frame.size.width,cell.dropDownImg.frame.size.height);
                        [cell.dropDownImg setImage:[UIImage imageNamed:@"nav-arrow"]];
                    }
                                       break;
                case 2:
                    if(!([[[arForTable objectAtIndex:indexPath.row] valueForKey:@"SUB_MENU"] count]==0))
                    {
                        cell.dropDownImg.frame=CGRectMake(cell.titleLab.frame.origin.x+cell.titleLab.frame.size.width-50,18,cell.dropDownImg.frame.size.width,cell.dropDownImg.frame.size.height);
                        [cell.dropDownImg setImage:[UIImage imageNamed:@"nav-arrow"]];
                    }                    break;
                case 3:
                    if(!([[[arForTable objectAtIndex:indexPath.row] valueForKey:@"SUB_MENU"] count]==0))
                    {
                        cell.dropDownImg.frame=CGRectMake(cell.titleLab.frame.origin.x+cell.titleLab.frame.size.width-60,18,cell.dropDownImg.frame.size.width,cell.dropDownImg.frame.size.height);
                        [cell.dropDownImg setImage:[UIImage imageNamed:@"nav-arrow"]];
                    }
                    break;
                case 4:
                    if(!([[[arForTable objectAtIndex:indexPath.row] valueForKey:@"SUB_MENU"] count]==0))
                    {
                        cell.dropDownImg.frame=CGRectMake(cell.titleLab.frame.origin.x+cell.titleLab.frame.size.width-120,10,cell.dropDownImg.frame.size.width,cell.dropDownImg.frame.size.height);
            [cell.dropDownImg setImage:[UIImage imageNamed:@"nav-arrow"]];
                    }                    break;
                    
                default:
                    break;
            }
            

            
        }
       
      
        cell.titleLab.text=[[arForTable objectAtIndex:indexPath.row] valueForKey:@"CHILD_MENU"];
        NSLog(@"CHILD_MENUCOUNT>>>%u",[[[arForTable objectAtIndex:indexPath.row] valueForKey:@"SUB_MENU"] count]);

       
           cell.titleLab.font=[UIFont systemFontOfSize:22.0];

        cell.titleLab.textColor=[UIColor colorWithRed:7.0/255.0f green:59.0/255.0f blue:117.0/255.0f alpha:1.0];
        [cell setIndentationLevel:[[[arForTable objectAtIndex:indexPath.row] valueForKey:@"level"] intValue]];
        NSLog(@"%d",  [[[arForTable objectAtIndex:indexPath.row] valueForKey:@"level"] intValue]);
        [cell.menuImage setImageWithURL:[NSURL URLWithString:[[arForTable objectAtIndex:indexPath.row] valueForKey:@"ICON"]] placeholderImage:[UIImage imageNamed:@""]];
        
    }
    cell.separaterLab.hidden=YES;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int fixarrayCount = (int)fixeArray.count;
   if (indexPath.row<=fixarrayCount-1 && [[arForTable objectAtIndex:indexPath.row] isKindOfClass:[NSString class]])
   {
       NSString*menuCheck1=[arForTable objectAtIndex:indexPath.row];
       
       if ([menuCheck1 isEqualToString:@"Home"])
       {
           
           SWRevealViewController *revealController = self.revealViewController;
           HomeViewController*MenuSubCategoriesVC=[[HomeViewController alloc] init];
           UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
           [revealController pushFrontViewController:navigationController animated:YES];
          // [historyModel sharedhistoryModel].menuTitle=@"My task";
           
           
       }
       if ([menuCheck1 isEqualToString:@"Help & Support"])
       {
           
           SWRevealViewController *revealController = self.revealViewController;
           [revealController revealToggleAnimated:YES];
           ContactUsViewController*MenuSubCategoriesVC=(ContactUsViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"contactUs"];
           UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
           [navigationController pushViewController:MenuSubCategoriesVC animated:YES];
//           UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
//           [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Help & Support";
           
           
       }
       if ([menuCheck1 isEqualToString:@"Telephone Directory"])
       {
           
           SWRevealViewController *revealController = self.revealViewController;
           TelephoneScreenViewController *MenuSubCategoriesVC=(TelephoneScreenViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"telephone"];
           UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
           [revealController pushFrontViewController:navigationController animated:YES];
           [historyModel sharedhistoryModel].menuTitle=@"Telephone Directory";
           
           
       }

        if ([menuCheck1 isEqualToString:@"Inbox"])
        {
           // NSString*urlmail=[NSString stringWithFormat:@"%@%@%@",@"http://125.17.8.166/service/inbox.login.php?",[historyModel sharedhistoryModel].uid,[historyModel sharedhistoryModel].token];
            NSString*urlmail=[NSString stringWithFormat:@"%@uid=%@&token=%@",@"https://www.greatplus.com/service/inbox.login.php?",[historyModel sharedhistoryModel].uid,[historyModel sharedhistoryModel].token];

            NSURL*url=[NSURL URLWithString:urlmail];
            
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
            else
            {
                NSLog(@"not open");
            }
            
        }
    if ([menuCheck1 isEqualToString:@"My Tasks"])
    {
        
        SWRevealViewController *revealController = self.revealViewController;
        mytaskMenuVC*MenuSubCategoriesVC=[[mytaskMenuVC alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
        [revealController pushFrontViewController:navigationController animated:YES];
        [historyModel sharedhistoryModel].menuTitle=@"My task";
    }
        if ([menuCheck1 isEqualToString:@"My Appointment"])
        {
            
            NSString *backButtonHide = @"hide";
            [[NSUserDefaults standardUserDefaults] setObject:backButtonHide forKey:@"backButtonHideValue"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            SWRevealViewController *revealController = self.revealViewController;
            myAppoinmentDetail*MenuSubCategoriesVC=[[myAppoinmentDetail alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"My Appointment";

        }
    if ([menuCheck1 isEqualToString:@"My Performance"])
    {
        
               NSString *backButtonHide = @"hide";
                [[NSUserDefaults standardUserDefaults] setObject:backButtonHide forKey:@"backButtonHideValue"];
                [[NSUserDefaults standardUserDefaults] synchronize];
               SWRevealViewController *revealController = self.revealViewController;
               myPerformenceDetail*MenuSubCategoriesVC=[[myPerformenceDetail alloc] init];
               UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
               [revealController pushFrontViewController:navigationController animated:YES];
        
        [historyModel sharedhistoryModel].menuTitle=@"My Performance";

    }
        if ([menuCheck1 isEqualToString:@"Company Performence"])
        {
            
            NSString *backButtonHide = @"hide";
            [[NSUserDefaults standardUserDefaults] setObject:backButtonHide forKey:@"backButtonHideValue"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            SWRevealViewController *revealController = self.revealViewController;
            comapanyPerformenceVC*MenuSubCategoriesVC=[[comapanyPerformenceVC alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Latest Events";
            
        }
        if ([menuCheck1 isEqualToString:@"What is your Opinion"])
        {
            
            NSString *backButtonHide = @"hide";
            [[NSUserDefaults standardUserDefaults] setObject:backButtonHide forKey:@"backButtonHideValue"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            SWRevealViewController *revealController = self.revealViewController;
            opinionDetailVC*MenuSubCategoriesVC=[[opinionDetailVC alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Latest Events";
            
        }
        if ([menuCheck1 isEqualToString:@"Holiday Calendar"])
        {
            
            NSString *backButtonHide = @"hide";
            [[NSUserDefaults standardUserDefaults] setObject:backButtonHide forKey:@"backButtonHideValue"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            SWRevealViewController *revealController = self.revealViewController;
            holidayCalenderDetail*MenuSubCategoriesVC=[[holidayCalenderDetail alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Holiday Calendar";

        }
        if ([menuCheck1 isEqualToString:@"Sankalp Stories"])
        {
            
            NSString *backButtonHide = @"hide";
            [[NSUserDefaults standardUserDefaults] setObject:backButtonHide forKey:@"backButtonHideValue"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            SWRevealViewController *revealController = self.revealViewController;
            latestEventDetail*MenuSubCategoriesVC=[[latestEventDetail alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Sankalp Stories";
            
        }
        if ([menuCheck1 isEqualToString:@"Latest Event"])
        {
            
            NSString *backButtonHide = @"hide";
            [[NSUserDefaults standardUserDefaults] setObject:backButtonHide forKey:@"backButtonHideValue"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            SWRevealViewController *revealController = self.revealViewController;
            latestEventDetail*MenuSubCategoriesVC=[[latestEventDetail alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Latest Events";
            
        }
       if ([menuCheck1 isEqualToString:@"More Apps"])
       {
           if (hideORshow==NO)
           {
               hideORshow=YES;
                [self.leftMenuTable reloadData];
               

           }
           
          else if (hideORshow==YES)
          {
              hideORshow=NO;
            
              [arForTable removeAllObjects];
              
              [arForTable addObjectsFromArray:dataArray];

            [arForTable addObjectsFromArray:[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"header_menu"]];
              
              
           
           [self.leftMenuTable reloadData];
          }
           
       }
      
      
   }
    
    else
    {
        //
        if ([[arForTable objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
            if ([[arForTable objectAtIndex:indexPath.row] isEqualToString:@"Help & Support"]) {
                SWRevealViewController *revealController = self.revealViewController;
                [revealController revealToggleAnimated:YES];
                ContactUsViewController*MenuSubCategoriesVC=(ContactUsViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"contactUs"];
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
                [revealController pushFrontViewController:navigationController animated:YES];
                [historyModel sharedhistoryModel].menuTitle=@"Help & Support";
            }
            if ([[arForTable objectAtIndex:indexPath.row] isEqualToString:@"Telephone Directory"]) {
                SWRevealViewController *revealController = self.revealViewController;
                TelephoneScreenViewController*MenuSubCategoriesVC=(TelephoneScreenViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"telephone"];
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
                [revealController pushFrontViewController:navigationController animated:YES];
                [historyModel sharedhistoryModel].menuTitle=@"Telephone Directory";
            }
            return;
        }
        //
        menuCheck=[[arForTable objectAtIndex:indexPath.row] objectForKey:@"CHILD_MENU"];
        
        if ([menuCheck isEqualToString:@"Policies And Procedures"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            menuSubClass*MenuSubVC=[[menuSubClass alloc] init];
            [revealController revealToggleAnimated:YES];
            UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
            [navigationController pushViewController:MenuSubVC animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Policy & Procedure";
        }
        if ([menuCheck isEqualToString:@"Perfect Match"])
        {
            NSString *strUrl = [[arForTable objectAtIndex:indexPath.row] objectForKey:@"LINK"];
            NSLog(@"%@", strUrl);
            NSURL *url = [NSURL URLWithString:strUrl];
            SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:url];
            //svc.delegate = self;
            [self presentViewController:svc animated:YES completion:nil];
        }
        
        //
        if ([menuCheck isEqualToString:@"Meeting Management"] || [menuCheck isEqualToString:@"Task Management"] || [menuCheck isEqualToString:@"Cafeteria Management"] || [menuCheck isEqualToString:@"Attendance / Leaves"] || [menuCheck isEqualToString:@"Visitor Management"] || [menuCheck isEqualToString:@"M I S"])
        {
            
            
            NSString *appURL = [[arForTable objectAtIndex:indexPath.row] valueForKey:@"LINK"];
            if ([appURL isKindOfClass:[NSNull class]]) {
                return;
            }
            NSString *finalURL = [[NSString alloc] initWithFormat:@"%@?email=%@&token=%@", appURL,[historyModel sharedhistoryModel].userEmail, [historyModel sharedhistoryModel].token];
            
//            UIStoryboard *storyb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            WebViewVC *vc = (WebViewVC *)[storyb instantiateViewControllerWithIdentifier:@"webviewVC"];
//            
////            SWRevealViewController *revealController = self.revealViewController;
////            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
////            [revealController pushFrontViewController:navigationController animated:YES];
////            [historyModel sharedhistoryModel].menuTitle=menuCheck;
////            [vc.webview loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:finalURL]]];
//            
//            [self presentViewController:vc animated:YES completion:^{
//                [vc.webview loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:finalURL]]];
//            }];
            
            
            SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:[[NSURL alloc] initWithString:finalURL]];
            //svc.delegate = self;
            [self presentViewController:svc animated:YES completion:nil];
            
           
        }
        
        //
        
        if ([menuCheck isEqualToString:@"Learning References"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            [revealController revealToggleAnimated:YES];
            menuSubClass*MenuSubVC=[[menuSubClass alloc] init];
            UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
            [navigationController pushViewController:MenuSubVC animated:YES];
            
            
//            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubVC];
//            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Learning References";
        }
        
        if ([menuCheck isEqualToString:@"Telephone Directory"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            [revealController revealToggleAnimated:YES];
            telephoneDirVC*MenuSubVC=[[telephoneDirVC alloc] init];
            UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
            [navigationController pushViewController:MenuSubVC animated:YES];
           // [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Telephone Directory";
        }
        
        if([[menuCheck lowercaseString] isEqualToString:@"mrp calculation"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusMrpCalculatorViewController"];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Mrp Calculation";
        }
        if([[menuCheck lowercaseString] isEqualToString:@"uber"])
        {
            if ([[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"uber://"]])
            {
                
            }
            else
            {
                [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/uber/id368677368?mt=8"]];
            }
        }
        if([[menuCheck lowercaseString] isEqualToString:@"ola"])
        {
            
            if ([[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"olacabs://"]])
            {
                
            }
            else
            {

                [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/ola-cabs-book-taxi-in-india/id539179365?mt=8"]];
            }
        }
        
        if ([[menuCheck lowercaseString] isEqualToString:@"place order"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusPlaceOrderViewController"];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"place Order";

        }
        
        if ([[menuCheck lowercaseString] isEqualToString:@"order status"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusOrderStatusViewController"];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Order Status";
            
        }
        
        if ([[menuCheck lowercaseString] isEqualToString:@"guarantee registration"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusExchangeOfferViewController"];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Guarantee Registration";
            
        }
        
        if ([[menuCheck lowercaseString] isEqualToString:@"exchange offer"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusExchangeOfferViewController"];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"Guarantee Registration";
            
        }
        
        if ([[menuCheck lowercaseString] isEqualToString:@"digital payment"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            GreatePlusCheckOutFormVC *CheckOUTVC=[[GreatePlusCheckOutFormVC alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:CheckOUTVC];
            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"DigitalPayment";
            
        }
        
        if ([[menuCheck lowercaseString] isEqualToString:@"upload document"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            GreatPlusUploadDocumentVC *UploadDocVC=[[GreatPlusUploadDocumentVC alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:UploadDocVC];
            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"UploadDocuments";
            
        }
        
        if ([[menuCheck lowercaseString] isEqualToString:@"order approval"])
        {
            SWRevealViewController *revealController = self.revealViewController;
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusOrderApprovelViewController"];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            [revealController pushFrontViewController:navigationController animated:YES];
            [historyModel sharedhistoryModel].menuTitle=@"UploadDocuments";
            
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
            
        }
        if ([menuCheck isEqualToString:@"Business Intelligence"])
        {
            
            
            NSURL*url=[NSURL URLWithString:[[arForTable objectAtIndex:indexPath.row] objectForKey:@"CHILD_MENU_VALUE"]];
            
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }

        }
        if ([menuCheck isEqualToString:@"Sankalp Blogs"])
        {
            NSURL*url=[NSURL URLWithString:[[arForTable objectAtIndex:indexPath.row] objectForKey:@"CHILD_MENU_VALUE"]];
            
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
            
        }
        
        if ([menuCheck isEqualToString:@"Visitor Registration"]||[menuCheck isEqualToString:@"Link 2"]||[menuCheck isEqualToString:@"Link 3"]||[menuCheck isEqualToString:@"Link 4"]||[menuCheck isEqualToString:@"Link 5"]||[menuCheck isEqualToString:@"Link 6"]||[menuCheck isEqualToString:@"Link 7"])
        {
            if  (![[[arForTable objectAtIndex:indexPath.row] objectForKey:@"CHILD_MENU_VALUE"] isEqual:[NSNull null]])
            {
                NSURL*url=[NSURL URLWithString:[[arForTable objectAtIndex:indexPath.row] objectForKey:@"CHILD_MENU_VALUE"]];
                
                if ([[UIApplication sharedApplication] canOpenURL:url])
                {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        }
        if ([menuCheck isEqualToString:@"Mts Report"]) {
            
            SWRevealViewController *revealController = self.revealViewController;
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"MTSReport"];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            [revealController pushFrontViewController:navigationController animated:YES];
        }
        
        else
        {
           
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                NSDictionary *d=[arForTable objectAtIndex:indexPath.row];
                if([d valueForKey:@"CHILD_MENU"]) {
                    NSArray *ar=[d valueForKey:@"SUB_MENU"];
                    
                    BOOL isAlreadyInserted=NO;
                    for(NSDictionary *dInner in ar )
                    {
                        
                        NSInteger index=[arForTable indexOfObjectIdenticalTo:dInner];
                        isAlreadyInserted=(index>0 && index!=NSIntegerMax);

                        if(isAlreadyInserted) break;
                    }
                    
                    if(isAlreadyInserted)
                    {
                        [self miniMizeThisRows:ar];
                    } else {
                        NSUInteger count=indexPath.row+1;
                        NSMutableArray *arCells=[NSMutableArray array];
                        for(NSDictionary *dInner in ar ) {
                            [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                            [arForTable insertObject:dInner atIndex:count++];
                        }
                        
                        if ([[d valueForKey:@"CHILD_MENU"] isEqualToString:@"My E-Mail"]) {
                            NSString *strUrl = [NSString stringWithFormat:@"https://www.greatplus.com/service/%@?uid=%@&token=%@",[d valueForKey:@"CHILD_MENU_VALUE"],[historyModel sharedhistoryModel].uid,[historyModel sharedhistoryModel].token];
                            NSURL *url = [NSURL URLWithString:strUrl];
                            SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:url];
                            //svc.delegate = self;
                            [self presentViewController:svc animated:YES completion:nil];
                        }
                        if([[d valueForKey:@"CHILD_MENU"] isEqualToString:@"mrp calculation"])
                        {
                            SWRevealViewController *revealController = self.revealViewController;
                            
                            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            
                            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusMrpCalculatorViewController"];
                            
                            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
                            [revealController pushFrontViewController:navigationController animated:YES];
                            [historyModel sharedhistoryModel].menuTitle=@"Mrp Calculation";
                        }
                        
                        if ([[d valueForKey:@"CHILD_MENU"] isEqualToString:@"place order"])
                        {
                            SWRevealViewController *revealController = self.revealViewController;
                            
                            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            
                            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusPlaceOrderViewController"];
                            
                            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
                            [revealController pushFrontViewController:navigationController animated:YES];
                            [historyModel sharedhistoryModel].menuTitle=@"place Order";
                            
                        }
                        
                        if ([[d valueForKey:@"CHILD_MENU"] isEqualToString:@"order status"])
                        {
                            SWRevealViewController *revealController = self.revealViewController;
                            
                            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            
                            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusOrderStatusViewController"];
                            
                            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
                            [revealController pushFrontViewController:navigationController animated:YES];
                            [historyModel sharedhistoryModel].menuTitle=@"Order Status";
                            
                        }
                        
                        if ([[d valueForKey:@"CHILD_MENU"] isEqualToString:@"guarantee registration"])
                        {
                            SWRevealViewController *revealController = self.revealViewController;
                            
                            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            
                            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusExchangeOfferViewController"];
                            
                            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
                            [revealController pushFrontViewController:navigationController animated:YES];
                            [historyModel sharedhistoryModel].menuTitle=@"Guarantee Registration";
                            
                        }
                        
                        if ([[d valueForKey:@"CHILD_MENU"] isEqualToString:@"exchange offer"])
                        {
                            SWRevealViewController *revealController = self.revealViewController;
                            
                            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            
                            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusExchangeOfferViewController"];
                            
                            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
                            [revealController pushFrontViewController:navigationController animated:YES];
                            [historyModel sharedhistoryModel].menuTitle=@"Guarantee Registration";
                            
                        }
                        
                        if ([[d valueForKey:@"CHILD_MENU"] isEqualToString:@"digital payment"])
                        {
                            SWRevealViewController *revealController = self.revealViewController;
                            
                            GreatePlusCheckOutFormVC *CheckOUTVC=[[GreatePlusCheckOutFormVC alloc] init];
                            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:CheckOUTVC];
                            [revealController pushFrontViewController:navigationController animated:YES];
                            [historyModel sharedhistoryModel].menuTitle=@"DigitalPayment";
                            
                        }
                        
                        if ([[d valueForKey:@"CHILD_MENU"] isEqualToString:@"upload document"])
                        {
                            SWRevealViewController *revealController = self.revealViewController;
                            
                            GreatPlusUploadDocumentVC *UploadDocVC=[[GreatPlusUploadDocumentVC alloc] init];
                            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:UploadDocVC];
                            [revealController pushFrontViewController:navigationController animated:YES];
                            [historyModel sharedhistoryModel].menuTitle=@"UploadDocuments";
                            
                        }
                        
                        if ([[d valueForKey:@"CHILD_MENU"] isEqualToString:@"order approval"])
                        {
                            SWRevealViewController *revealController = self.revealViewController;
                            
                            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            
                            UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"GreatPlusOrderApprovelViewController"];
                            
                            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
                            [revealController pushFrontViewController:navigationController animated:YES];
                            [historyModel sharedhistoryModel].menuTitle=@"UploadDocuments";
                            
                        }
                        
                        
                        
                        if ([[d valueForKey:@"CHILD_MENU"] isEqualToString:@"Document Box"])
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
                            
                        }

                        [tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationTop];
                    }
                }
                
            }
        }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

{
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    tempView.backgroundColor = [UIColor whiteColor];
    [self.leftMenuTable setTableHeaderView:tempView];
    return tempView;
}


//-(void)logoutApi:(NSDictionary*)dataString
//{
//    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
//    
//    [helper logOutApi:dataString];
//}
-(void)viewAllBtn
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    NSDictionary*dic= @{@"uid":[historyModel sharedhistoryModel].uid,@"action":@"logout",@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    [helper logOutApi:dic];
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"logOutApi"])
    {
        info = [dataDic objectForKey:@"info"];
        NSLog(@"loginApi--->,%@",info);
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                 if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==1)
                {
                    
                    SWRevealViewController *revealController = self.revealViewController;
                    loginVC=[[LoginViewController alloc] init];
                    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
                    [revealController pushFrontViewController:navigationController animated:YES];

                    [MyCustomClass SVProgressMessageDismissWithSuccess:[[info objectAtIndex:0]objectForKey:@"msg"] timeDalay:3.0];
                    
                    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                    [UserDefaultStorage setUserToken:nil];
                }
            });
        }
        else
        {
            NSString *msg = [dataDic objectForKey:@"msg"];
            [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:3.0];
        }
    }
}

-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknow Error" timeDalay:2.0];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    dataArray=[[NSMutableArray alloc]init];
    fixeArray=[[NSMutableArray alloc]init];
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.leftMenuTable.delegate=self;
    self.leftMenuTable.dataSource=self;
    
      // hideORshow is NO more Apps is content is show.
                    // hideORshow is YES more Apps is content is hide.
    
//    tableFooter = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.leftMenuTable.frame.size.width-10, 50)];
//    UIImageView*logOutImg=[[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 20, 20)];
//    [logOutImg setImage:[UIImage imageNamed: @"logOut"]];
//    tableFooter.backgroundColor=[UIColor whiteColor];
//    UIButton *viewAll=[UIButton buttonWithType:UIButtonTypeCustom];
//    [viewAll setFrame:CGRectMake(20,0,self.leftMenuTable.frame.size.width-150, 50)];
//    [viewAll setTitle:@"LOG OUT"forState:UIControlStateNormal];
//    viewAll.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
//
//    [viewAll setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted]; // This will helps you during click time title color will be blue color
//    [viewAll setTitleColor:[UIColor colorWithRed:102.0/255.0f green:102.0/255.0f blue:102.0/255.0f alpha:1.0] forState:UIControlStateNormal];//set the color
//    [viewAll setBackgroundImage:[UIImage imageNamed:@"viewAll"] forState:UIControlStateNormal];
//    [viewAll addTarget:self action:@selector(viewAllBtn) forControlEvents:UIControlEventTouchUpInside];
//    [tableFooter addSubview:viewAll];
    
    self.leftMenuTable.tableFooterView = self.footerView;
    
    [self.logoutBtn addTarget:self action:@selector(viewAllBtn) forControlEvents:UIControlEventTouchUpInside];
    [arForTable removeAllObjects];
    [fixeArray removeAllObjects];
   
    if ([[historyModel sharedhistoryModel].opUserType.lowercaseString isEqualToString:@"employee"]) {
        
        hideORshow=YES;
        
         [dataArray addObject:@"Home"];
         [fixeArray addObject:@"Home"];
        
         if ([[historyModel sharedhistoryModel].area isEqualToString:@"EMAIL"])
         
         {
//         [dataArray addObject:@"Inbox"];
//         [fixeArray addObject:@"Inbox"];
//
//         [dataArray addObject:@"My Appointment"];
//         [fixeArray addObject:@"My Appointment"];
         
         }
         
//         [dataArray addObject:@"My Tasks"];
//         [fixeArray addObject:@"My Tasks"];
        
//         [dataArray addObject:@"My Performance"];
//         [fixeArray addObject:@"My Performance"];
//
//         [dataArray addObject:@"Company Performence"];
//         [fixeArray addObject:@"Company Performence"];
//
//         [dataArray addObject:@"What is your Opinion"];
//         [fixeArray addObject:@"What is your Opinion"];
        
//         [dataArray addObject:@"Holiday Calendar"];
//         [fixeArray addObject:@"Holiday Calendar"];
//
//         [dataArray addObject:@"Sankalp Stories"];
//         [fixeArray addObject:@"Sankalp Stories"];
//
//         [dataArray addObject:@"Latest Event"];
//         [fixeArray addObject:@"Latest Event"];
        
        
        
        
        
//        [fixeArray addObject:@"Telephone Directory"];
//        [dataArray addObject:@"Telephone Directory"];
        
//        [fixeArray addObject:@"More Apps"];
//        [dataArray addObject:@"More Apps"];
        
//        [fixeArray addObjectsFromArray:[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"header_menu"]];
//        [dataArray addObjectsFromArray:[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"header_menu"]];
        
        NSLog(@"%@", [historyModel sharedhistoryModel].homeDataDic[@"header_menu"]);
        
        for (int i=0; i<[[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"header_menu"] count]; i++) {
            NSString *checkStr = [historyModel sharedhistoryModel].homeDataDic[@"header_menu"][i][@"CHILD_MENU"];
            if (![checkStr isEqualToString:@"Other Apps"]) {
                [dataArray addObject:[historyModel sharedhistoryModel].homeDataDic[@"header_menu"][i]];
                [fixeArray addObject:[historyModel sharedhistoryModel].homeDataDic[@"header_menu"][i]];
            }
        }
        
        [fixeArray addObject:@"Help & Support"];
        [dataArray addObject:@"Help & Support"];
         
    }
    else{
        
        hideORshow=NO;
        
        [dataArray addObjectsFromArray:[[historyModel sharedhistoryModel].homeDataDic objectForKey:@"header_menu"]];
        
        NSMutableArray *dataArrayCopy = dataArray.mutableCopy;
        
        for (int i = 0; i < dataArrayCopy.count; i++)
        {
            NSDictionary *dict = dataArrayCopy[i];
            if([dict[@"CHILD_MENU"] isEqualToString:@"Business Processes"])
            {
                //int parentIndex = i;
                for (NSDictionary *lev in dict[@"SUB_MENU"])
                {
                    [dataArray insertObject:lev atIndex:++i];
                }
            }else{
                NSArray *ar=[dict valueForKey:@"SUB_MENU"];
              //  NSUInteger count=indexPath.row+1;
            //    NSMutableArray *arCells=[NSMutableArray array];
                for(NSDictionary *dInner in ar ) {
                    [dataArray addObject:dInner];
//                    [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
//                    [arForTable insertObject:dInner atIndex:count++];
                }
            }
        }
        [dataArray addObject:@"Help & Support"];
       // [dataArray addObject:@"Telephone Directory"];
    }
    
    
    NSLog(@"menu Array>>>>%@",dataArray);
    arForTable = [[NSMutableArray alloc] init];
    [arForTable addObjectsFromArray:dataArray];
    [self.leftMenuTable reloadData];
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:YES];
    self.leftMenuTable.userInteractionEnabled=YES;

}


-(void)miniMizeThisRows:(NSArray*)ar{
    
    for(NSDictionary *dInner in ar ) {
        NSUInteger indexToRemove=[arForTable indexOfObjectIdenticalTo:dInner];
        NSArray *arInner=[dInner valueForKey:@"SUB_MENU"];
        if(arInner && [arInner count]>0){
            [self miniMizeThisRows:arInner];
        }
        if([arForTable indexOfObjectIdenticalTo:dInner]!=NSNotFound) {
            [arForTable removeObjectIdenticalTo:dInner];
            [self.leftMenuTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:
                                                         [NSIndexPath indexPathForRow:indexToRemove inSection:0]
                                                         ]
                                       withRowAnimation:UITableViewRowAnimationBottom];

        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
