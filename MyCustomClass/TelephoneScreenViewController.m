//
//  TelephoneScreenViewController.m
//  Sheela Foam
//
//  Created by Kapil on 10/27/17.
//  Copyright © 2017 Supraits. All rights reserved.
//

#import "TelephoneScreenViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import "HomeViewController.h"
#import "historyModel.h"

@interface ContactCell:UITableViewCell
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@end

@implementation ContactCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(56, 10, 200, 24)];
        self.nameLabel.textColor=[UIColor colorWithRed:7.0/255.0f green:59.0/255.0f blue:117.0/255.0f alpha:1.0];
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
        [self.contentView addSubview:self.nameLabel];
        
        self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(56, 36, 150, 22)];
        self.phoneLabel.textColor=[UIColor grayColor];
        self.phoneLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [self.contentView addSubview:self.phoneLabel];
        
        self.imgView=[[UIImageView alloc] initWithFrame:CGRectMake(8, 10, 40, 40)];
        self.imgView.layer.cornerRadius=20;
        self.imgView.contentMode=UIViewContentModeScaleAspectFill;
        [self.imgView setImage:[UIImage imageNamed:@"ic_account_circle"]];
        self.imgView.layer.masksToBounds=YES;
       // self.imgView.backgroundColor=[UIColor orangeColor];
        [self.contentView addSubview:self.imgView];
        
        
    }
    return self;
}

-(void)setPhoneData{
    [self.nameLabel sizeToFit];
    self.phoneLabel.frame = CGRectMake(56, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height +2, 200, 25);
    self.imgView.backgroundColor=[UIColor lightGrayColor];
}


@end

@interface TelephoneScreenViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *contactTable;
@property (nonatomic,strong) NSMutableArray *contacts;

@end

@implementation TelephoneScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    __block BOOL accessGranted = NO;
    
    if (&ABAddressBookRequestAccessWithCompletion != NULL) { // We are on iOS 6
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(semaphore);
        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
    
    else { // We are on iOS 5 or Older
        accessGranted = YES;
        [self getContactsWithAddressBook:addressBook];
    }
    
    if (accessGranted) {
        [self getContactsWithAddressBook:addressBook];
    }
    
    _contactTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:_contactTable];
    _contactTable.dataSource=self;
    _contactTable.delegate=self;
    [self.contactTable registerClass:[ContactCell class] forCellReuseIdentifier:@"contactCell"];
    self.navigationItem.title=@"Telephone Directory";
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backPressed)];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(-20, 0, 50, 40)];
    [leftButton setImage:[UIImage imageNamed:@"toggleBtn"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    [leftButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];

    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        // iOS 7.0 or later
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:12.0/255.0 green:76.0/255.0 blue:164.0/255.0 alpha:1.0];
        self.navigationController.navigationBar.translucent = NO;
    }else {
        // iOS 6.1 or earlier
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:12.0/255.0 green:76.0/255.0 blue:164.0/255.0 alpha:1.0];
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // Do any additional setup after loading the view.
}

-(void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
    
    HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
    if ([[historyModel sharedhistoryModel].checkHomeORMenu isEqualToString:@"home"])
    {
        [self.navigationController popViewControllerAnimated:YES];
        [historyModel sharedhistoryModel].checkHomeORMenu=@"";
        
    }
    else
    {
        
        [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
        
        HomeViewControllerVC.menuString=@"Left";
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactCell *cell = (ContactCell *)[tableView dequeueReusableCellWithIdentifier:@"contactCell"];
    cell.nameLabel.text=[[_contacts objectAtIndex:indexPath.row] valueForKey:@"name"];
    if ([[_contacts objectAtIndex:indexPath.row] valueForKey:@"phone"]) {
        cell.phoneLabel.text=[[_contacts objectAtIndex:indexPath.row] valueForKey:@"phone"];
    }
    [cell setPhoneData];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_contacts count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *phNo = [[_contacts objectAtIndex:indexPath.row] valueForKey:@"phone"];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}

// Get the contacts.
- (void)getContactsWithAddressBook:(ABAddressBookRef )addressBook {
    
    NSMutableArray *contactList = [[NSMutableArray alloc] init];
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    
    for (int i=0;i < nPeople;i++) {
        NSMutableDictionary *dOfPerson=[NSMutableDictionary dictionary];
        
        ABRecordRef ref = CFArrayGetValueAtIndex(allPeople,i);
        
        //For username and surname
        ABMultiValueRef phones =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(ref, kABPersonPhoneProperty));
        
        CFStringRef firstName, lastName;
        firstName = ABRecordCopyValue(ref, kABPersonFirstNameProperty);
        lastName  = ABRecordCopyValue(ref, kABPersonLastNameProperty);
        [dOfPerson setObject:[NSString stringWithFormat:@"%@ %@", firstName, lastName] forKey:@"name"];
        
        //For Email ids
        ABMutableMultiValueRef eMail  = ABRecordCopyValue(ref, kABPersonEmailProperty);
        if(ABMultiValueGetCount(eMail) > 0) {
            [dOfPerson setObject:(__bridge NSString *)ABMultiValueCopyValueAtIndex(eMail, 0) forKey:@"email"];
            
        }
        
        //For Phone number
        NSString* mobileLabel;
        
        for(CFIndex j = 0; j < ABMultiValueGetCount(phones); j++) {
            mobileLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phones, j);
            if([mobileLabel isEqualToString:(NSString *)kABPersonPhoneMobileLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j) forKey:@"phone"];
            }
            else if ([mobileLabel isEqualToString:(NSString*)kABPersonPhoneIPhoneLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j) forKey:@"phone"];
                break ;
            }
            
        }
        if ([dOfPerson objectForKey:@"phone"]) {
            [contactList addObject:dOfPerson];
        }
        
        
    }
    _contacts=contactList;
    [_contactTable reloadData];
    NSLog(@"Contacts = %@",contactList);
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
