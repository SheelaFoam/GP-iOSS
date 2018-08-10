//
//  AppDelegate.m
//  Sheela Foam
//
//  Created by Apple on 17/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//
#import "AppDelegate.h"
#import "historyModel.h"
#import "SVProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#import "PasswordLogin.h"
#import "UserDefaultStorage.h"
#import "GreatPlusSharedHeader.h"
#import "WebViewVC.h"


@interface AppDelegate ()<CLLocationManagerDelegate>

@end

@implementation AppDelegate

{
    CLLocationManager *locationManager;

}
+(AppDelegate *)appDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
    LoginViewController*LoginVC = [[LoginViewController alloc] init];
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:LoginVC];
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_login_12"];
    if (data) {
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (dict && [dict valueForKey:@"username"] && [dict valueForKey:@"password"]) {
            NSString *clientUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"ClientURL"];
            if (clientUrl) {
                [historyModel sharedhistoryModel].clientUrl=clientUrl;
            
                NSData *dataOld = [[NSUserDefaults standardUserDefaults] objectForKey:@"oldAppLoginResponse"];
                NSDictionary *dataDicOld = [NSKeyedUnarchiver unarchiveObjectWithData:dataOld];
                NSLog(@"%@", dataDicOld);
            
                [UserDefaultStorage setUserDealerID:[[NSUserDefaults standardUserDefaults] valueForKey:@"username"]];
            
                [UserDefaultStorage setUserDealerType:[NSString stringWithFormat:@"%@",[dataDicOld objectForKey:op_role_nameKey]]];
                NSData *dataNew = [[NSUserDefaults standardUserDefaults] objectForKey:@"webApiLoginResponse"];
                NSDictionary *dataDic = [NSKeyedUnarchiver unarchiveObjectWithData:dataNew];
                PasswordLogin*passWordVc=[[PasswordLogin alloc]init];
                passWordVc.passWordORopt=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"area"];
                passWordVc.userName=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"email_login"];
                passWordVc.userNameText=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"email_login"];
                passWordVc.area=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"area"];
                [historyModel sharedhistoryModel].area=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"area"];
                passWordVc.oprolename=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"op_role_name"];
                passWordVc.autoLogin=TRUE;
                frontNavigationController = [[UINavigationController alloc] initWithRootViewController:passWordVc];
            }else{
                [self fetchGreeting];
            }
        }
    }else{
        [self fetchGreeting];
    }
    
    
   // HomeViewController *frontViewController = [[HomeViewController alloc] init];
    LeftMenuViewController *rearViewController = [[LeftMenuViewController alloc] init];
    
    
    
    
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]
                                                    initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    
    mainRevealController.delegate = self;
    
    self.viewController = mainRevealController;
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
  //  [self fetchGreeting];
    
    [self networkSpeedTest:@"http://www.androidguys.com/wp-content/uploads/2016/05/UAqpqU0.png" completionHandler:^(BOOL check) {
        
        WebViewVC *webview = [[WebViewVC alloc] init];
        webview.lowSpeed = check;
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [self saveContext];
}

-(void) networkSpeedTest:(NSString *)fileURL completionHandler: (void (^)(BOOL check))completion {
    
    NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    NSData *imgData = [[NSData alloc] initWithData:UIImageJPEGRepresentation((result), 0.5)];
    NSUInteger imageSize   = imgData.length;
    double imgSize = imageSize/1024.0;
    double speed = imgSize/([NSDate timeIntervalSinceReferenceDate] - startTime);
    
    if (speed < 75) {
        completion(false);
    } else {
        completion(true);
    }
}

- (void)fetchGreeting;
{
    [SVProgressHUD show];
    
    NSURL *url = [NSURL URLWithString:@"http://www.greatplus.com/service/static-value.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *staticUrl = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
           
             [historyModel sharedhistoryModel].clientUrl=[[staticUrl objectForKey:@"info"] objectForKey:@"ClientURL"];
             [[NSUserDefaults standardUserDefaults] setObject:[historyModel sharedhistoryModel].clientUrl forKey:@"ClientURL"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             NSLog(@"static VAlu%@",[historyModel sharedhistoryModel].clientUrl);
             [SVProgressHUD dismiss];
         }
     }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
//    UIAlertView *errorAlert = [[UIAlertView alloc]
//                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[errorAlert show];
    [manager stopMonitoringSignificantLocationChanges];
    [manager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        [historyModel sharedhistoryModel].latitudeStr = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        [historyModel sharedhistoryModel].longitudeStr = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
      //  NSLog(@"latitudeStr%@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
       // NSLog(@"longitudeStr%@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
    }
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"ComplaintDetail"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
