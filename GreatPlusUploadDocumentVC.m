//
//  GreatPlusUploadDovumentVC.m
//  GreatPlus
//
//  Created by Apple on 08/02/17.
//  Copyright © 2017 SupraITS. All rights reserved.
//

#import "GreatPlusUploadDocumentVC.h"
#import "UploadDocCell.h"
#import "UserDefaultStorage.h"
#import "MailClassViewController.h"
#import "GreatPlusSharedHeader.h"
#import "POAcvityView.h"
#import "GreatePlusCheckOutFormVC.h"
#import "GreatPlusViewUplodImg.h"
#import "HomeViewController.h"

@interface GreatPlusUploadDocumentVC ()
@end
@implementation GreatPlusUploadDocumentVC
{
    
    UploadDocCell*cellAttachment;
    MyWebServiceHelper *helper;
    NSArray*docArray;
    UIAlertView*alert;
    UIAlertView*addDocAlert;
    UIImage *Image;
    NSPredicate *emailTest;
    POAcvityView *activityIndicator;
    NSDictionary*dataDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    _uploadDocTAB.delegate=self;
    _uploadDocTAB.dataSource=self;
    [self freamingText];
    _contectPersonTXT.delegate=self;
    __CustContactTXT.delegate=self;
    _emailTXT.delegate=self;
    _panNoTXT.delegate=self;
    helper =[[MyWebServiceHelper alloc] init];
    helper.webApiDelegate=self;
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    __CustContactTXT.inputAccessoryView = keyboardDoneButtonView;
    
 
    // Sumit: Uncomment after new API
    /*
    NSDictionary *SearchDict;
    SearchDict=  @{@"p_greatplus_user_id":[UserDefaultStorage getUserDealerID],@"p_dealer_id":[UserDefaultStorage getDealerID],};
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    [helper getDocList:SearchDict];
    */
}
- (IBAction)doneClicked:(id)sender
{
    [__CustContactTXT resignFirstResponder];
}
- (IBAction)NavigationBTNAct:(id)sender {
    
    GreatePlusCheckOutFormVC *CheckOutFormVC=[[GreatePlusCheckOutFormVC alloc] init];
    [self.navigationController pushViewController:CheckOutFormVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"UploadedDocList"])
    {
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                docArray=[dataDic objectForKey:@"data"];
                [self docCount];
                [_uploadDocTAB reloadData];
                [self tableHight];
                [activityIndicator hideView];

                NSMutableArray*statusArray=[[NSMutableArray alloc]init];
                
                int i ;
                
                for (i=0; i < [docArray count]; i++)
                {
                    NSString* status=[[docArray objectAtIndex:i] objectForKey:@"STATUS"];
                    if ([status isEqualToString:@"1"])
                    {
                        [statusArray addObject:@1];
                        
                    }
                    
                }
                
                if (statusArray.count==docArray.count)
                {
                    [self disableField];

                }
                else
                {
                    [self enableField];

                }
                NSLog(@"statusArray>>>%@",statusArray);
                
            });
        }
        else
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self docCount];
               // [self enableField];
                [activityIndicator hideView];

            });
        }
    }
    else if([apiName isEqualToString:@"deleteDoc"])
    {
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                    docArray=[dataDic objectForKey:@"data"];
                    [self docCount];
                    [_uploadDocTAB reloadData];
                    [self tableHight];
                    [activityIndicator hideView];
            [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:[dataDic valueForKey:@"msg"] delegate:nil tag:0];
                
                
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [activityIndicator hideView];
            });
        }
    }
    else if([apiName isEqualToString:@"docStatus"])
    {
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [activityIndicator hideView];
                docArray=[dataDic valueForKey:@"data"];
                [_uploadDocTAB reloadData];
                [self tableHight];
                [activityIndicator hideView];
                [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:[dataDic valueForKey:@"msg"] delegate:nil tag:0];
                [self disableField];
                
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [activityIndicator hideView];
            });        }
    }
}
-(void)tableHight
{
    
    if ([docArray count]<=2)
    {
        CGRect TableFrame=_uploadDocTAB.frame;
        TableFrame.size.height=67*[docArray count];
        _uploadDocTAB.frame=TableFrame;
    }
    else
    {
        CGRect TableFrame=_uploadDocTAB.frame;
        TableFrame.size.height=[UIScreen mainScreen].bounds.size.height-430;

        _uploadDocTAB.frame=TableFrame;

    }

    

}
-(void)docCount
{
    NSInteger total=[docArray count];

    NSString *totalStrValue = [NSString stringWithFormat:@"%ld", (long)total];
    
    _totalDocLAB.text=totalStrValue;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [docArray count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"UploadDocCell";
    cellAttachment = (UploadDocCell *)[self.uploadDocTAB dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cellAttachment == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"UploadDocCell" owner:self options:nil];
        cellAttachment = [cellArray objectAtIndex:0];
        cellAttachment.selectionStyle=NO;
        [tableView setShowsVerticalScrollIndicator:NO];

    }
    [cellAttachment.delateDocBTN addTarget:self
                                    action:@selector(deleateDocAction:)
                          forControlEvents:UIControlEventTouchUpInside];
    [cellAttachment.docNameBTN addTarget:self
                                    action:@selector(viewUplodDoc:)
                          forControlEvents:UIControlEventTouchUpInside];
    cellAttachment.docNameBTN.tag=indexPath.row;
    cellAttachment.delateDocBTN.tag=indexPath.row;
    cellAttachment.serialNumberLAB.text = [NSString stringWithFormat:@"%li.", indexPath.row+1];


    
    [cellAttachment.docNameBTN setTitle:[[docArray objectAtIndex:indexPath.row] objectForKey:@"DOCUMENT_NAME"] forState: UIControlStateNormal];
    if ([[[docArray objectAtIndex:indexPath.row] objectForKey:@"STATUS"] isEqualToString:@"1"])
    {
        [cellAttachment.delateIMGView setImage:[UIImage imageNamed:@"deleteG"]];
        cellAttachment.delateDocBTN.userInteractionEnabled=NO;

    }
    else
    {
        cellAttachment.delateDocBTN.userInteractionEnabled=YES;

    }

     return  cellAttachment;
    
}
-(void)viewUplodDoc:(id)sender
{
    GreatPlusViewUplodImg*ViewUploadVC=[[GreatPlusViewUplodImg alloc]init];
        [self.navigationController pushViewController:ViewUploadVC animated:YES];
    NSLog(@"DOCUMENT_URL>>>%@",[[docArray objectAtIndex:[sender tag]] objectForKey:@"DOCUMENT_URL"]);
        ViewUploadVC.url=[NSString stringWithFormat:@"%@",[[docArray objectAtIndex:[sender tag]] objectForKey:@"DOCUMENT_URL"]];
}

- (IBAction)uploadNewDocBTN:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"" message:@"Select Option" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera",@"Photo Library", nil] show];
    [addDocAlert show];
}
-(void)deleateDocAction:(id)sender
{
    NSLog(@"tag>>>>%ld",(long)[sender tag]);
    NSDictionary *InputDict;
    InputDict=  @{@"p_greatplus_user_id":[UserDefaultStorage getUserDealerID],@"p_document_id":[[docArray objectAtIndex:[sender tag]] valueForKey:@"DOCUMENT_ID" ],@"mode":@"delete_document",};
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:DeleteRecord];
    [activityIndicator showView];
    [helper deleteDoc:InputDict];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"Camera"])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else if ([title isEqualToString:@"Photo Library"])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    //    // get the ref url
    //    NSURL *refURL = [editingInfo valueForKey:UIImagePickerControllerReferenceURL];
    //      // define the block to call when we get the asset based on the url (below)
    //    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    //    {
    //        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
    //        // NSLog(@"[imageRep filename] : %@", [imageRep filename]);
    //        ImageName = [imageRep filename];
    //        NSLog(@"image name>>>%@",ImageName);
    //
    //
    //    };
    //
    //    // get the asset library and fetch the asset based on the ref url (pass in block above)
    //    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    //    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    if ([MailClassViewController isNetworkConnected])
    {
        [self setImage:image];
        self.imageseting.image=image;
        

    }
    else
    {
        [MailClassViewController showAlertViewWithTitle:@"Connection.!!!" message:OhnoAlert delegate:self tag:NetworkAlertTag];
    }
}

-(void)setImage:(UIImage *)FetchedImage
{
    Image=FetchedImage;

    [self uploadImage];
}
-(void)uploadImage
{
    [activityIndicator showView];
    NSData *iMagaedata = UIImageJPEGRepresentation(Image, 0.7);
    NSString *strPostUrl =@"http://125.19.46.252/ws/insert_dealer_document.php";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strPostUrl]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithFormat:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_greatplus_user_id\";\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",[UserDefaultStorage getUserDealerID]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"mode\";\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",@"upload_document"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_document_name\"; filename=\"ipodfile.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type:image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:iMagaedata]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // setting the body of the post to the reqeust
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    [request setHTTPBody:body];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSError *jsonError;
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingMutableContainers
                                                                error:&jsonError];
         NSLog(@"result from json %@",json);
         if([[json valueForKey:@"status"] integerValue]==1){
             docArray=[json valueForKey:@"data"];
             [self docCount];

             [_uploadDocTAB reloadData];
             [self tableHight];
             [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:[json valueForKey:@"msg"] delegate:nil tag:0];

             [activityIndicator hideView];
         }
     }];
    
}

- (IBAction)submitDocBTN:(id)sender {
    
//    if ([docArray count]>=1)
//    {
//        [self submitDocument];
//    }
//    else
//    {
//        alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"You can not submit document, please upload at least one document." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
    
          [self submitDocument];

}
-(void)submitDocument
{
    if(_contectPersonTXT.text==nil|| [_contectPersonTXT.text length]<=0)
    {
        
        alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"please enter contact person name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [_contectPersonTXT becomeFirstResponder];
        
    }
    else if(__CustContactTXT.text==nil||[__CustContactTXT.text length]<=0)
        
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"please enter mobile number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [__CustContactTXT becomeFirstResponder];
        
        
    }
    else if (!([__CustContactTXT.text length]==10))
    {
        [__CustContactTXT becomeFirstResponder];
        
        alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Please enter 10 digit contact number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    else if(_emailTXT.text==nil|| [_emailTXT.text length]<=0)
        
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"please enter email ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [_emailTXT becomeFirstResponder];
        
    }

    else if(_panNoTXT.text==nil|| [_panNoTXT.text length]<=0)
        
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"please enter PAN number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [_panNoTXT becomeFirstResponder];
        
        
    }
    
    else if(!([_panNoTXT.text length]==10))
        
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Please enter 10 digit PAN number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [_panNoTXT becomeFirstResponder];
        
    }

    
    else
    {
        [self NSStringIsValidEmail:_emailTXT.text];
        
        if ([emailTest evaluateWithObject:_emailTXT.text] == NO)
        {
            
            [_emailTXT becomeFirstResponder];
            
            alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@" Please enter correct email id." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            
        }
        else if (!([docArray count]>=1))
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"You can not submit document, please upload at least one document." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
        else
        {
            [activityIndicator showView];
            NSDictionary*SearchDict=  @{@"p_greatplus_user_id":[UserDefaultStorage getUserDealerID],@"p_dealer_id":[UserDefaultStorage getDealerID],@"p_pi_contact_person_name":_contectPersonTXT.text,@"p_pi_mobile_number":__CustContactTXT.text,@"p_pi_email_id":_emailTXT.text,@"p_pi_pan_number":_panNoTXT.text};
            
            [helper docStatus:SearchDict];
        }
        
        
        
    }
  
    
}

-(void)freamingText
{
    _contectPersonTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
    _contectPersonTXT.layer.borderWidth= 1.0f;
    [_contectPersonTXT.layer setCornerRadius:4.0f];
    
    __CustContactTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
    __CustContactTXT.layer.borderWidth= 1.0f;
    [__CustContactTXT.layer setCornerRadius:4.0f];
    
    _emailTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
    _emailTXT.layer.borderWidth= 1.0f;
    [_emailTXT.layer setCornerRadius:4.0f];
    
    _panNoTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
    _panNoTXT.layer.borderWidth= 1.0f;
    [_panNoTXT.layer setCornerRadius:4.0f];
    
    //remove padding
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _contectPersonTXT.leftView = paddingView;
    _contectPersonTXT.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    __CustContactTXT.leftView = paddingView1;
    __CustContactTXT.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _emailTXT.leftView = paddingView2;
    _emailTXT.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _panNoTXT.leftView = paddingView3;
    _panNoTXT.leftViewMode = UITextFieldViewModeAlways;
}
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField==_emailTXT)
    {
        [self NSStringIsValidEmail:_emailTXT.text];
    }
    
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==__CustContactTXT)
    {
        
        if(__CustContactTXT.text.length >= 10 && range.length == 0)
        {
            return NO;
        }
       
    }
    if (textField==_panNoTXT)
    {
        if(_panNoTXT.text.length >= 10 && range.length == 0)
        {
            return NO;
        }
    }

  
    return YES;
}
-(void)disableField
{
    _contectPersonTXT.text=[[dataDic objectForKey:@"customerinfo"] objectForKey:@"CONTACT_PERSON"];
    __CustContactTXT.text=[[dataDic objectForKey:@"customerinfo"] objectForKey:@"CONTACT_MOBILE_NO"];
    _emailTXT.text=[[dataDic objectForKey:@"customerinfo"] objectForKey:@"PI_EMAIL_ID"];
    _panNoTXT.text=[[dataDic objectForKey:@"customerinfo"] objectForKey:@"PI_PAN_NUMBER"];
    _contectPersonTXT.userInteractionEnabled=NO;
    __CustContactTXT.userInteractionEnabled=NO;
    _emailTXT.userInteractionEnabled=NO;
    _panNoTXT.userInteractionEnabled=NO;
    _uploadNewDocBTN.userInteractionEnabled=NO;
    _submitDocBTN.userInteractionEnabled=NO;
    _submitDocBTN.hidden=YES;
    _uploadDocImg.hidden=YES;
    
    
}
-(void)enableField
{
    _contectPersonTXT.text=@"";
    __CustContactTXT.text=@"";
    _emailTXT.text=@"";
    _panNoTXT.text=@"";
    _contectPersonTXT.userInteractionEnabled=YES;
    __CustContactTXT.userInteractionEnabled=YES;
    _emailTXT.userInteractionEnabled=YES;
    _panNoTXT.userInteractionEnabled=YES;
    _uploadNewDocBTN.userInteractionEnabled=YES;
    _submitDocBTN.userInteractionEnabled=YES;
    _submitDocBTN.hidden=NO;
    _uploadDocImg.hidden=NO;
    
}
- (IBAction)backBtnAct:(id)sender
{
//    HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
//    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
//    
//    HomeViewControllerVC.menuString=@"Left";
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
