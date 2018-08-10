//
//  AppDelegate.h
//  Sheela Foam
//
//  Created by Apple on 17/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "LeftMenuViewController.h"
#import <CoreData/CoreData.h>

//#import "MyAccountMenuController.h"
#define Window_Height [AppDelegate appDelegate].window.frame.size.height
#define Window_Width [AppDelegate appDelegate].window.frame.size.width
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SWRevealViewController *viewController;
+(AppDelegate *)appDelegate;
@property (weak, nonatomic)  NSString *latitudeLabel;
@property (weak, nonatomic)  NSString *longitudeLabel;
- (void)fetchGreeting;


@property (readonly, strong) NSPersistentContainer *persistentContainer;
- (void)saveContext;

@end

