//
//  profileVC.m
//  Sheela Foam
//
//  Created by Apple on 11/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "profileVC.h"
#import "changePasswordVC.h"
#import "historyModel.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "UIImageView+WebCache.h"
@interface profileVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate,WebServiceResponseProtocal,UIAlertViewDelegate>
{
    UIImage*selectedImage;
    MyWebServiceHelper *helper;
    NSArray*info;
    NSDictionary*dataDic;
   const unsigned char*uuu;
    UIAlertView *alert;
    NSUserDefaults *defaults;
    NSString *getImgUrl;
    NSString*selectImageCheck;
}
@end
@implementation profileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.nameTxt.delegate=self;
    self.userNameTxt.delegate=self;
    self.emailIDTxt.delegate=self;
    self.roleNameTxt.delegate=self;
    self.mobiletxt.delegate=self;
    self.nameTxt.userInteractionEnabled=NO;
    self.userNameTxt.userInteractionEnabled=NO;
    self.emailIDTxt.userInteractionEnabled=NO;
    self.roleNameTxt.userInteractionEnabled=NO;
    self.mobiletxt.userInteractionEnabled=NO;
    
     if ([[historyModel sharedhistoryModel].area isEqualToString:@"OTP"])
    {
        self.changePassword.hidden=YES;
    }
    self.nameTxt.text=[historyModel sharedhistoryModel].displayname;
    self.userNameTxt.text=[historyModel sharedhistoryModel].uid;
    if ([[historyModel sharedhistoryModel].userEmail isEqual:[NSNull null]])
    {
        self.emailIDTxt.text=@"";

    }
    else
    {
        self.emailIDTxt.text=[historyModel sharedhistoryModel].userEmail;

    }
    self.roleNameTxt.text=[historyModel sharedhistoryModel].opRoleName;
    if ([[historyModel sharedhistoryModel].mobileNo isEqual:[NSNull null]])
    {
        self.mobiletxt.text=@"";

    }
    else
    {
        self.mobiletxt.text=[historyModel sharedhistoryModel].mobileNo;

    }

    alert.delegate=self;
    
    self.imagePic.layer.cornerRadius = self.imagePic.frame.size.height /2;
    self.imagePic.layer.masksToBounds = YES;
    self.imagePic.layer.borderWidth = 0;
    
    
    getImgUrl = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"preferenceName"];
[self.imagePic setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];


    
    
           // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)changePassword:(id)sender {
    if ([[historyModel sharedhistoryModel].area isEqualToString:@"EMAIL"])
    {
//        NSString*urlmail=[NSString stringWithFormat:@"%@%@%@",@"http://125.17.8.166/service/inbox.login.php?",[historyModel sharedhistoryModel].uid,[historyModel sharedhistoryModel].token];
//        NSURL*url=[NSURL URLWithString:urlmail];
//        
//        if ([[UIApplication sharedApplication] canOpenURL:url])
//        {
//            [[UIApplication sharedApplication] openURL:url];
//        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Kindly change your password from your email."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        

    }
    else
    {
    
    changePasswordVC*changePassword=[[changePasswordVC alloc]init];
    [self.navigationController pushViewController:changePassword animated:YES];
    }

}
- (IBAction)sumitBtn:(id)sender {
    
    if ([selectImageCheck isEqualToString:@"ok"])
    {
        [self uplodImg];

    }
    else
    {
        
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Select Image" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera",@"Photo Library", nil] show];
        [alert show];
    }
    

}

#pragma mark -
#pragma mark UITextFieldDelegate
- (void) scrollViewAdaptToStartEditingTextField:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, textField.frame.origin.y +2.5 * textField.frame.size.height);
    [self.landingScrollView setContentOffset:point animated:YES];
}

- (void) scrollVievEditingFinished:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, 0);
    [self.landingScrollView setContentOffset:point animated:YES];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    
    [self scrollViewAdaptToStartEditingTextField:textField];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self scrollVievEditingFinished:textField];
    
    return YES;
}
-(IBAction)resignKeyboard:(id)sender
{
    [self.nameTxt resignFirstResponder];
    [self.userNameTxt resignFirstResponder];
    [self.emailIDTxt resignFirstResponder];
    [self.roleNameTxt resignFirstResponder];
    [self.mobiletxt resignFirstResponder];

}


- (IBAction)pickImg:(id)sender {
    
    
    [[[UIAlertView alloc] initWithTitle:@"" message:@"Select Option" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera",@"Photo Library", nil] show];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];

   if ([title isEqualToString:@"Camera"])
   {
       NSLog(@"CAMERA");
       UIImagePickerController *picker = [[UIImagePickerController alloc] init];
       
       picker.sourceType = UIImagePickerControllerSourceTypeCamera;
       picker.delegate = self;
    //   [self presentModalViewController:picker animated:YES];
       [self presentViewController:picker animated:YES completion:nil];

   
   }
   else if ([title isEqualToString:@"Photo Library"])
    {
        NSLog(@"GALLERY");
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
 
    }
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   selectImageCheck=@"ok";
    
        UIImage *image = [MyCustomClass scaleAndRotateImage: [info objectForKey:UIImagePickerControllerOriginalImage]];
    selectedImage=image;
   
    [self dismissViewControllerAnimated:YES completion:nil];
    [self saveImage:selectedImage];
}


- (void)saveImage:(UIImage*)image {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"ss"]];
    // UIImage *image = ; // imageView is my image from camera
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:YES];
}


-(void)uplodImg
{
    [SVProgressHUD show];
    NSMutableData *imageData ;
    
    //yourImage=imageName1;
    imageData = [UIImageJPEGRepresentation(selectedImage,2.0) mutableCopy];
   // serverImageName1=[NSString stringWithFormat:@"%@.png",];
        
   // NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://125.17.8.166/service/profile-pic.php"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.greatplus.com/service/profile-pic.php"]];

    [request setHTTPMethod:@"POST"];

    NSString *boundary =[NSString stringWithFormat:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"op_greatplus_user_id\";\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",[historyModel sharedhistoryModel].opGreatplususerId] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"mode\";\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"upload_image"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"op_user_role_name\";\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",[historyModel sharedhistoryModel].opuserRoleName] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uid\";\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",[historyModel sharedhistoryModel].uid] dataUsingEncoding:NSUTF8StringEncoding]];
    
     [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"token\";\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
      [body appendData:[[NSString stringWithFormat:@"%@",[historyModel sharedhistoryModel].token] dataUsingEncoding:NSUTF8StringEncoding]];
    
         [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"auth_type\";\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",[historyModel sharedhistoryModel].authType] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
   
    NSLog(@"uid%@",[historyModel sharedhistoryModel].uid);
  
    NSLog(@"token%@",[historyModel sharedhistoryModel].token);
    NSLog(@"authType%@",[historyModel sharedhistoryModel].authType);


    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_image\"; filename=\"ipodfile.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type:image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    ////
  
    

    
    // setting the body of the post to the reqeust [request addValue:contentType forHTTPHeaderField: @"Content-Type"]; [request setHTTPBody:body];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    [request setHTTPBody:body];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error){
                               NSLog(@"Completed");
                               

NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                               
                               
                NSString *saveImgUrl =[[[jsonDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"op_user_profile_image"];
        [[NSUserDefaults standardUserDefaults] setObject:saveImgUrl forKey:@"preferenceName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
                               

    getImgUrl = [[NSUserDefaults standardUserDefaults]
                                    stringForKey:@"preferenceName"];
                               
[self.imagePic setImageWithURL:[NSURL URLWithString:getImgUrl] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
                               
    [SVProgressHUD dismiss];

                               if (error) {
                                   NSLog(@"error:%@", error.localizedDescription);
                               }
                               
                           }];
    NSLog(@"Finish");

}

-(void)viewWillAppear:(BOOL)animated
{
    NSString*pageName=@"Profile Page";
    [MyCustomClass logApi:pageName];
    
}





@end
