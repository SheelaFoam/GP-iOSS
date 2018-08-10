//
//  OtherAppsViewController.m
//  Sheela Foam
//
//  Created by Kapil on 1/30/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "OtherAppsViewController.h"

@interface OtherAppsCell : UITableViewCell
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *nameLabel;
@end

@implementation OtherAppsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, self.contentView.frame.size.width-80, 30)];
        self.nameLabel.textColor=[UIColor colorWithRed:80.0/255.0 green:111.0/255.0 blue:138.0/255.0 alpha:1.0];
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
        [self.contentView addSubview:self.nameLabel];
        
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 15, 30)];
        [self.icon setImage:[UIImage imageNamed:@"shape"]];
        self.icon.clipsToBounds=YES;
        self.icon.contentMode=UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.icon];
        
    }
    return self;
}

@end

@interface OtherAppsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *myTableView;

@end

@implementation OtherAppsViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=FALSE;
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=TRUE;
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:47.0/255.0 green:12.0/255.0 blue:165.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:19.0/255.0 green:79.0/255.0 blue:161.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:_myTableView];
    _myTableView.dataSource=self;
    _myTableView.delegate=self;
    [_myTableView registerClass:[OtherAppsCell class] forCellReuseIdentifier:@"otherCell"];
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OtherAppsCell *cell = (OtherAppsCell *)[tableView dequeueReusableCellWithIdentifier:@"otherCell"];
    if (indexPath.row==0) {
        cell.nameLabel.text=@"Uber";
        cell.icon.image = [UIImage imageNamed:@"App Icon"];
    }else{
        cell.nameLabel.text=@"Ola";
        cell.icon.image=[UIImage imageNamed:@"logomark"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        if ([[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"uber://"]])
        {
            
        }
        else
        {
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/uber/id368677368?mt=8"]];
        }
    }else{
        if ([[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"olacabs://"]])
        {
            
        }
        else
        {
            
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/ola-cabs-book-taxi-in-india/id539179365?mt=8"]];
        }
    }
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

@end
