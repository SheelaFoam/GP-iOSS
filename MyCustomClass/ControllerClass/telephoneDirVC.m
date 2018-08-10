//
//  telephoneDirVC.m
//  Sheela Foam
//
//  Created by Apple on 30/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "telephoneDirVC.h"
#import "telephoneDirCell.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "historyModel.h"
#import "UIImageView+WebCache.h"
#import "profileVC.h"



@interface telephoneDirVC ()<WebServiceResponseProtocal,UITextFieldDelegate>
{
    telephoneDirCell*cellAttachment;
    NSDictionary*dataDic;
    MyWebServiceHelper *helper;
    NSArray*info;
    NSArray*searchInfo;
    int str;
    NSString*search;
    
}

@end

@implementation telephoneDirVC

- (IBAction)logout:(id)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height /2;
    self.profileImg.layer.masksToBounds = YES;
    self.profileImg.layer.borderWidth =0;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    str=1;
    self.telephonDirTable.delegate=self;
    self.telephonDirTable.dataSource=self;
    self.searchTxtField.delegate=self;
    NSLog(@"mail13");

    [self callApi];
    
    self.telephonDirTable.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
 }
-(void)getLatestLoans
{

    int counter=str;
    str = counter + 1;
    [self callApi];
}

- (IBAction)searchBtn:(id)sender
{
    [SVProgressHUD show];
    search=@"searchLoad";
    
    if(self.searchTxtField.text==nil || [self.searchTxtField.text length]<=0)
    {
        [self.searchTxtField resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter text" timeDalay:1.0f];
    }
    else
    {
    NSString*count=[NSString stringWithFormat:@"%d",str];
    NSDictionary*dataString= @{@"uid":[historyModel sharedhistoryModel].uid,@"mode":@"search",@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"page":count,@"keyword":[self.searchTxtField.text uppercaseString],@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
        
//        {"uid":"ROSHNI.SHRESHTHA","token":"TkVXQEluZGlh","auth_type":"EMAIL","mode":"search","page":"1","keyword":"rosh","op_user_role_name":"WEB ADMIN","op_greatplus_user_id":"ROSHNIS"}

        
    NSLog(@"homeData%@",dataString);
    [helper telephonSearchApi:dataString];
    }

}

-(void)callApi
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];

    NSString*count=[NSString stringWithFormat:@"%d",str];
    NSDictionary*dataString= @{@"uid":[historyModel sharedhistoryModel].uid,@"mode":@"list",@"op_user_role_name":[historyModel sharedhistoryModel].opuserRoleName,@"op_greatplus_user_id":[historyModel sharedhistoryModel].opGreatplususerId,@"page":count,@"uid":[historyModel sharedhistoryModel].uid,@"token":[historyModel sharedhistoryModel].token,@"auth_type":[historyModel sharedhistoryModel].authType};
    NSLog(@"homeData%@",dataString);
    
    [self policieApi:dataString];
    

}
-(void)policieApi:(NSDictionary*)dataString
{
   [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper telephonDirApi:dataString];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"telephonDir"])
    {
        if (dataDic.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                ;
               
                    info=[dataDic objectForKey:@"info"];
                [self.telephonDirTable reloadData];
    [MyCustomClass SVProgressMessageDismissWithSuccess:@"" timeDalay:3.0];


                
            });
        }
    }
    if([apiName isEqualToString:@"telephonSearchApi"])
    {
        if (dataDic.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                searchInfo= [dataDic objectForKey:@"info"];
                if (searchInfo.count==0)
                {
                    [self.telephonDirTable reloadData];

                    [MyCustomClass SVProgressMessageDismissWithError:@"No Data Found" timeDalay:3.0];

                }
                else
                {
                    searchInfo=[dataDic objectForKey:@"info"];
                    [self.telephonDirTable reloadData];
                    [MyCustomClass SVProgressMessageDismissWithSuccess:@"" timeDalay:3.0];

                }
                


                
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if ([search isEqualToString:@"searchLoad"])
    {
        return searchInfo.count;
    }
    else
    {
    return info.count;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"telephoneDirCell";
    cellAttachment = (telephoneDirCell *)[self.telephonDirTable dequeueReusableCellWithIdentifier:CellIdentifier];
  
    
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"telephoneDirCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        cellAttachment.selectionStyle=NO;
        
       
    }
    
    if ([search isEqualToString:@"searchLoad"])
    {
        
        if([[[searchInfo objectAtIndex:indexPath.row] objectForKey:@"DESIGNATION"] isEqualToString:@""])
        {
         cellAttachment.nameLab.text=[NSString stringWithFormat:@"%@ %@",[[searchInfo objectAtIndex:indexPath.row] objectForKey:@"USER_NAME"],[[searchInfo objectAtIndex:indexPath.row] objectForKey:@"DESIGNATION"]];
        }
        else
        {
         cellAttachment.nameLab.text=[NSString stringWithFormat:@"%@ (%@)",[[searchInfo objectAtIndex:indexPath.row] objectForKey:@"USER_NAME"],[[searchInfo objectAtIndex:indexPath.row] objectForKey:@"DESIGNATION"]];
        }
       
        cellAttachment.departmentLab.text=[[searchInfo objectAtIndex:indexPath.row] objectForKey:@"DEPARTEMENT"];
        cellAttachment.mobNo.text=[[searchInfo objectAtIndex:indexPath.row] objectForKey:@"MOBILE_NO_1"];
        cellAttachment.emaiLab.text=[[searchInfo objectAtIndex:indexPath.row] objectForKey:@"EMAIL_ID"];
        
        NSString*imgUrl=[[searchInfo objectAtIndex:indexPath.row] valueForKey:@"image"];
        imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

          [cellAttachment.Image setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
        }
    else
    {
        
        
        if([[[info objectAtIndex:indexPath.row] objectForKey:@"DESIGNATION"] isEqualToString:@""])
        {
            cellAttachment.nameLab.text=[NSString stringWithFormat:@"%@ %@",[[info objectAtIndex:indexPath.row] objectForKey:@"USER_NAME"],[[info objectAtIndex:indexPath.row] objectForKey:@"DESIGNATION"]];
        }
        else
        {
              cellAttachment.nameLab.text=[NSString stringWithFormat:@"%@ (%@)",[[info objectAtIndex:indexPath.row] objectForKey:@"USER_NAME"],[[info objectAtIndex:indexPath.row] objectForKey:@"DESIGNATION"]];
        }
       
        cellAttachment.departmentLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"DEPARTEMENT"];
        cellAttachment.mobNo.text=[[info objectAtIndex:indexPath.row] objectForKey:@"MOBILE_NO_1"];
        cellAttachment.emaiLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"EMAIL_ID"];
        NSString*imgUrl=[[info objectAtIndex:indexPath.row] valueForKey:@"image"];
        imgUrl = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [cellAttachment.Image setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
          // [cellAttachment.Image setImageWithURL:[NSURL URLWithString:[[info objectAtIndex:indexPath.row] valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    }
    
    
    return  cellAttachment;
    
      
}



- (IBAction)backBtn:(id)sender {
//    HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
//    
//    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
//    
//    HomeViewControllerVC.menuString=@"Left";
    
//    SWRevealViewController *rev = self.view.window.rootViewController;
//    UINavigationController *nav = rev.rearViewController;
//    [self.navigationController popToViewController:nav.topViewController animated:YES];
  //  [nav popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView
                  willDecelerate:(BOOL)decelerate{

    
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 50;
    if(y > h + reload_distance) {
        NSLog(@"load more data");
        [self getLatestLoans];
       // [spinner startAnimating];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (range.location==0)
    {
        search=@"";
        [self.telephonDirTable reloadData];

    NSLog(@"shouldChangeCharactersInRange");
        

    return YES;
    }
    else
    {
        return YES;

    }

}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [self.searchTxtField resignFirstResponder];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString*getImgUrl = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"preferenceName"];
    [self.profileImg setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    NSString*pageName=@"Telephone Directory Page";
    [MyCustomClass logApi:pageName];
    
   }

- (IBAction)profileBtn:(id)sender
{
    profileVC*profile=[[profileVC alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *phNo;
    if ([search isEqualToString:@"searchLoad"])
    {
        phNo = [[searchInfo objectAtIndex:indexPath.row] valueForKey:@"MOBILE_NO_1"];
        //return searchInfo.count;
    }
    else
    {
        phNo = [[info objectAtIndex:indexPath.row] valueForKey:@"MOBILE_NO_1"];
        
    }
    
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}
@end
