//
//  HomeViewController.h
//  Sheela Foam
//
//  Created by Apple on 18/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mailVW.h"
#import "myTaskVC.h"
#import "MyAppoinmentVC.h"
#import "myPerformenceVC.h"
#import "PerformingVC.h"
#import "OpinionVC.h"
#import "holidaysVC.h"
#import "storiesVC.h"
#import "storiesVC.h"
#import "homeViewVC.h"

@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITableView *riseTable;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIScrollView *landingScrollView;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl * pageControl;
@property (weak, nonatomic) IBOutlet UIImageView *homeImage;
@property(strong,nonatomic)NSString*checkHomeORMenu;
@property(strong,nonatomic)NSString*menuString;
- (IBAction)nextBtn:(id)sender;
- (IBAction)previousBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *previousBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIButton *raiseRequest;
@property (weak, nonatomic) IBOutlet UIButton *leftMenuBtn;
@property (strong, nonatomic) IBOutlet UIView *expandView;

@property (strong, nonatomic) IBOutlet UIView *businessAppView;
@property (strong, nonatomic) IBOutlet UICollectionView *businessAppCollectionView;

- (IBAction)profileBtn:(id)sender;

- (IBAction)raiseRequest:(id)sender;

- (IBAction)moreApp:(id)sender;
@property(strong,nonatomic)NSString*uid;
@property(strong,nonatomic)NSString*token;
@property(strong,nonatomic)NSString*authType;
@property(strong,nonatomic)NSString*displayname;
@property(strong,nonatomic)NSString*opRoleName;
@property(strong,nonatomic)NSString*opUserEmpGroupCode;
@property(strong,nonatomic)NSString*userEmail;
@property(strong,nonatomic)NSString*opGreatplususerId;
@property(strong, nonatomic)NSString*finalURL;

- (IBAction)logout:(id)sender;

-(void)firstApi;

@property (weak, nonatomic) IBOutlet UIView *folder;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@property (weak, nonatomic) IBOutlet UIView *bumperPrizeView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UICollectionView *prizeCollectionView;


@end
