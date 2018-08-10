//
//  GreatePlusCheckOutFormVC.m
//  GreatPlus
//
//  Created by Apple on 11/01/17.
//  Copyright © 2017 Charle. All rights reserved.
//

#import "GreatePlusCheckOutFormVC.h"
#import "GreatPlusChekOutVC.h"
#import "GreatePlusCheckProductCell.h"
#import "UserDefaultStorage.h"
#import "POAcvityView.h"
#import "MailClassViewController.h"
#import "GreatPlusSharedHeader.h"
#import "GreatPlusCCAvenueWVC.h"
//#import "GreatPlusAppDelegate.h"
#import "historyModel.h"
#import "define.h"
#import "MyWebServiceHelper.h"
#import "HomeViewController.h"


@interface GreatePlusCheckOutFormVC ()
{
int RowHeight;
int HeaderHeight;
int FooterHeight;
int invoiceFooterHeight;
long ProductRowCount;
long InvoiceRowCount;

    NSMutableArray*info;
    NSMutableArray*invoiceInfo;
    NSArray*transectionArray;
    NSDictionary*dataDic;
    NSString*tableCheck;
    GreatePlusCheckProductCell *ProductCell;
    MyWebServiceHelper *helper;
    POAcvityView *activityIndicator;
    NSDictionary*OrderIDInfoDic;
    NSString *PaymentGatewayType;
    NSPredicate *emailTest;
    NSString*pay;
    UIPickerView*pickerView;
    UIPickerView*pickerViewtwo;
    UIView*timeBackgroundView;
    NSUInteger pickerRow;
    NSUInteger CitypickerRow;
    NSString*pickercheck;
    NSString*cashORcard;
    NSMutableArray*serialArr;
    NSString*payByLink;
    NSString*messageStr;
    NSString*transectionType;
}
@end
@implementation GreatePlusCheckOutFormVC

- (void)viewDidLoad {
    /* table tag--111 for ProductDetail
     111 for ProductDetail
     112 for Invoice
     */
    [super viewDidLoad];
    RowHeight=36;
    HeaderHeight=0;
    FooterHeight=0;
    invoiceFooterHeight=53;
    pickerView.delegate=self;
    pickerRow=0;
    _CityPickerBTN.userInteractionEnabled=NO;
    _CustAddressTXTW.textColor=[UIColor lightGrayColor];
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    
    self.navigationController.navigationBarHidden = YES;
    
    _paymentPayTxt.inputAccessoryView = keyboardDoneButtonView;
    _CustContactTXT.inputAccessoryView = keyboardDoneButtonView;
    _CustPincodeTXT.inputAccessoryView = keyboardDoneButtonView;

ProductCell=[[GreatePlusCheckProductCell alloc]init];
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    helper =[[MyWebServiceHelper alloc] init];
    helper.webApiDelegate=self;
    [self freamingText];
    [self initFream];
}
-(void)viewWillAppear:(BOOL)animated
{
    _CustNameTXT.text=@"";
    _CustEmailTXT.text=@"";
    _CustContactTXT.text=@"";
    _CustStateTXT.text=@"";
    _CustPincodeTXT.text=@"";
    _CustCityTXT.text=@"";
    _serialNumTxt.text=@"";
    _paymentPayTxt.text=@"";
    [self RefreshViewController];
    
    //Sumit Uncomment after API integration.
   // [self transectionApi];


}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    timeBackgroundView.hidden=YES;
}

-(void)GetProdutList
{
    [activityIndicator showView];
    
    NSDictionary*dic=@{@"mode":@"list_item",
                       @"p_greatplus_user_id":[UserDefaultStorage getUserDealerID],
                       @"p_dealer_id":[UserDefaultStorage getDealerID],
                       @"p_transaction_id":[OrderIDInfoDic valueForKey:@"op_transaction_id"]
                       };
    [helper getProduct:dic];
}
-(void)cityList
{
   [activityIndicator showView];
    
    NSDictionary*dic=@{};
    [helper getStateCity:dic];

}
- (IBAction)BackBTNAct:(id)sender {
    
//    HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
//    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
//
//    HomeViewControllerVC.menuString=@"Left";

    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)NavigateToCheckOut:(id)sender
{
    GreatPlusChekOutVC  *ChekOutVC=[[GreatPlusChekOutVC alloc] init];
    [self.navigationController pushViewController:ChekOutVC animated:YES];
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
    
    if (tableView==self.ProductTV)
    {
    if([info count]==0)
    {
        return 1;
    }
    else
        
    {
        return [info count];}
    }
    else
    
       return  [invoiceInfo count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"ProductCell";
    if(tableView==self.ProductTV)
    {
        if([info count]>0)
        {
        
        ProductCell = (GreatePlusCheckProductCell *)[self.ProductTV dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (ProductCell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"GreatePlusCheckProductCell" owner:self options:nil];
        ProductCell = [cellArray objectAtIndex:0];
    }
        [ProductCell.deleteBTN addTarget:self action:@selector(deleteProduct:) forControlEvents:UIControlEventTouchUpInside];
        [ProductCell.deleteIMG setImage:[UIImage imageNamed:@"deleteR"]];
        
        ProductCell.deleteBTN.tag=indexPath.row;        
        ProductCell.gCardLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"GCARD_NUMBER"];
        ProductCell.productLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"SUB_PRODUCT"];
        if (![[[info objectAtIndex:indexPath.row] objectForKey:@"MRP_RATE"] isEqual:[NSNull null]])
        {
            ProductCell.mrpLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"MRP_RATE"];

        }
        
        return  ProductCell;
        }
        else
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
            if (cell == nil)
            {
                
              
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.textLabel.font = [UIFont systemFontOfSize:11.0];
            cell.textLabel.textAlignment= NSTextAlignmentCenter;



            cell.textLabel.text=@"There are currently no items in your cart.";
            return cell;
        }
    }
    else
    {
    UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (Cell == nil)
    {
        Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            }

        Cell.detailTextLabel.font=[UIFont systemFontOfSize:13.0];
        Cell.textLabel.font=[UIFont systemFontOfSize:15.0];
        Cell.detailTextLabel.textColor=[UIColor blackColor];
        Cell.textLabel.textColor=[UIColor lightGrayColor];
            //Cell.detailTextLabel.textColor=[UIColor colorWithRed:30.0/255.0f green:175.0/255.0f  blue:180.0/255.0f  alpha:1.0f];
        Cell.textLabel.textColor=[UIColor blackColor];
        Cell.textLabel.text=[[invoiceInfo objectAtIndex:indexPath.row] objectForKey:@"TRAN_DESCRIPTION"];
        Cell.detailTextLabel.text=[NSString stringWithFormat:@"%@%@",@"₹",[[invoiceInfo objectAtIndex:indexPath.row] objectForKey:@"TRAN_AMOUNT"]];
        NSLog(@"count>>>>%lu",(unsigned long)[invoiceInfo count]);
        if (indexPath.row==[invoiceInfo count]-2)
        {
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 36, 320,1)];
            line.backgroundColor = [UIColor grayColor];
            [Cell addSubview:line];
        }
        return  Cell;

    }

    
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *hW;
    if (tableView==self.ProductTV) {
    hW=self.ProductHeaderVW;
    }
    else
    {
    hW=self.InvoiceHW;

    }
    return hW;
}
- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section {
    UIView *hW;
    if (tableView==self.InvoiceTV) {
        hW=self.InvoiceFW;
    }
    else
    {
        hW=[[UIView alloc] initWithFrame:CGRectZero];
        
    }
    return hW;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return RowHeight;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.ProductTV) {
        HeaderHeight=149;
    }
    else
    {
        HeaderHeight=70;
    }

    return HeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (tableView==self.ProductTV)
    
   return  FooterHeight=0;
    
    else
    
   return  invoiceFooterHeight=53;
    

   // return FooterHeight;
}

-(void)deleteProduct:(id)sender
{
    [activityIndicator showView];
    NSDictionary*SearchDict=@{@"p_greatplus_user_id":[UserDefaultStorage getUserDealerID],
                              @"p_gcard_number":[[info objectAtIndex:[sender tag]] objectForKey:@"GCARD_NUMBER"],
                              @"p_invoice_dtl_id":[[info objectAtIndex:[sender tag]] objectForKey:@"INVOICE_DTL_ID"],
                              @"p_dealer_id":[UserDefaultStorage getDealerID],
                              @"p_invoice_id":@"",
                              @"p_transaction_id":[OrderIDInfoDic valueForKey:@"op_transaction_id"]
};
    NSLog(@"delete%@",SearchDict);
    [helper deleteProduct:SearchDict];
}
-(void)initFream
{
    _paymentPayTxt.layer.borderColor=[[UIColor colorWithRed:30.0/255.0f green:175.0/255.0f  blue:180.0/255.0f  alpha:1.0f]CGColor];

    CGRect TableFrame=self.ProductTV.frame;
    
    if ([info count]==0)
    {
        TableFrame.size.height=RowHeight+149+FooterHeight;

    }
    else
    {
    TableFrame.size.height=[info count]*RowHeight+152+FooterHeight;
    }
    self.ProductTV.frame=TableFrame;
    
    CGRect ProductFrame=self.ProductVW.frame;
    ProductFrame.size.height=TableFrame.size.height+10;
    self.ProductVW.frame=ProductFrame;
    CGRect TableFrame1;
    if ([info count]==0)
    {
        TableFrame1=self.InvoiceTV.frame;
        TableFrame1.size.height=120;
        self.InvoiceTV.frame=TableFrame1;
    }
    else{
        TableFrame1=self.InvoiceTV.frame;
        TableFrame1.size.height=[invoiceInfo count]*RowHeight+invoiceFooterHeight+70;
        self.InvoiceTV.frame=TableFrame1;
    }


    
    CGRect InvoiceVWFrame=self.InvoiceVW.frame;
    InvoiceVWFrame.origin.y=ProductFrame.size.height+15+ProductFrame.origin.y;
    InvoiceVWFrame.size.height=TableFrame1.size.height;
    self.InvoiceVW.frame=InvoiceVWFrame;
    
    CGRect payVMFream=self.payView.frame;
    payVMFream.origin.y=InvoiceVWFrame.size.height+15+InvoiceVWFrame.origin.y;
    self.payView.frame=payVMFream;
    
    
    [self.InvoiceVW addSubview:self.InvoiceTV];
    self.ProductTV.delegate=self;
    self.ProductTV.dataSource=self;
    
    self.InvoiceTV.delegate=self;
    self.InvoiceTV.dataSource=self;
    [self.view setBackgroundColor:[UIColor colorWithRed:231.0/255.0f green:232.0/255.0f  blue:236.0/255.0f  alpha:1.0f]];
       [self.CheckoutFormSV setContentSize:(CGSizeMake([UIScreen mainScreen].applicationFrame.size.width,self.payView.frame.origin.y+self.payView.frame.size.height+200))];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_CustNameTXT resignFirstResponder];
    [_CustEmailTXT resignFirstResponder];
    [_CustContactTXT resignFirstResponder];
   // [_CustStateTXT resignFirstResponder];
    [_CustPincodeTXT resignFirstResponder];
    [_CustCityTXT resignFirstResponder];
    [_serialNumTxt resignFirstResponder];
    [_paymentPayTxt resignFirstResponder];
    [_CustAddressTXTW resignFirstResponder];
    [self scrollVievEditingFinished:textField];
    return YES;
}
- (IBAction)doneClicked:(id)sender
{
    CGPoint point = CGPointMake(0, point1.y-20);
    [self.CheckoutFormSV setContentOffset:point animated:YES];
    [self.view endEditing:YES];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

       if([text isEqualToString:@"\n"])
       {
           [textView resignFirstResponder];
           CGPoint point = CGPointMake(0, textView.frame.origin.y-10);
           [self.CheckoutFormSV setContentOffset:point animated:YES];

                  return NO;
        }

    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Address*"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
        CGPoint point = CGPointMake(0, textView.frame.origin.y);
         [self.CheckoutFormSV setContentOffset:point animated:YES];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Address*";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

#pragma mark -
#pragma mark UITextFieldDelegate
CGPoint point1;
- (void) scrollViewAdaptToStartEditingTextField:(UITextField*)textField
{
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:self.CheckoutFormSV];
    pt = rc.origin;
     point1 = CGPointMake(0,pt.y - 1.5 * textField.frame.size.height);
    [self.CheckoutFormSV setContentOffset:point1 animated:YES];
}

- (void) scrollVievEditingFinished:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, point1.y-10);
    [self.CheckoutFormSV setContentOffset:point animated:YES];
}
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    timeBackgroundView.hidden=YES;
    [self scrollViewAdaptToStartEditingTextField:textField];
    return YES;
}


- (IBAction)addProductBtn:(id)sender
{
    NSDictionary*SearchDict;

   if(_serialNumTxt.text==nil|| [_serialNumTxt.text length]<=0)
    {
        [_serialNumTxt becomeFirstResponder];
 [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Enter Serial Number" delegate:self tag:0];
        
    }
    else
    {
                 [activityIndicator showView];

                SearchDict=  @{@"mode":@"add_item",
                               @"p_greatplus_user_id":[UserDefaultStorage getUserDealerID],
                               @"p_dealer_id":[UserDefaultStorage getDealerID],
                               @"p_non_eo":@"",
                               @"p_gcard_number":_serialNumTxt.text,
                               @"p_customer_mobile":[UserDefaultStorage getUserDealerID],
                               @"p_transaction_id":[OrderIDInfoDic valueForKey:@"op_transaction_id"],
                               @"p_transaction_date":@"",};
                [helper getProduct:SearchDict];
        NSLog(@"addpro%@",SearchDict);

    }
}



- (IBAction)payByCard:(id)sender
{        cashORcard=@"CardPayment";

    [self MoveToCCAvenue];
}
- (IBAction)PayByCashAct:(id)sender
{
    cashORcard=@"CashPayment";

    [self showFieldAlert];

}


- (IBAction)PayLinkToCustomerAction:(id)sender {
    cashORcard=@"PayLink";
    
    [self showFieldAlert];
}
-(void)showFieldAlert
{
    [self medentryFileldColour];
    
    if(_CustNameTXT.text==nil|| [_CustNameTXT.text length]<=0)
    {
        [_CustNameTXT becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:mandatoryFieldsAlert delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    else if(_CustEmailTXT.text==nil|| [_CustEmailTXT.text length]<=0)
    {
        
        [_CustEmailTXT becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:mandatoryFieldsAlert delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    else if ([emailTest evaluateWithObject:_CustEmailTXT.text] == NO)
    {
        
        [_CustEmailTXT becomeFirstResponder];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@" Please enter correct email id." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    else if (!([_CustContactTXT.text length]==10))
    {
        [_CustContactTXT becomeFirstResponder];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Please enter 10 digit contact number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
    }
    else if(_CustStateTXT.text==nil|| [_CustStateTXT.text length]<=0)
    {
        [_CustStateTXT becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:mandatoryFieldsAlert delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    
    else  if(_CustCityTXT.text==nil|| [_CustCityTXT.text length]<=0)
    {
        [_CustCityTXT becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:mandatoryFieldsAlert delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
        
    }
    else if(_CustPincodeTXT.text==nil|| [_CustPincodeTXT.text length]<=0)
    {
        [_CustPincodeTXT becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:mandatoryFieldsAlert delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    else if (!([_CustPincodeTXT.text length]==6))
    {
        [_CustPincodeTXT becomeFirstResponder];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Please enter 6 digit PIN number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    else if([_CustAddressTXTW.text isEqualToString:@"Address*"])
    {
        [_CustAddressTXTW becomeFirstResponder];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:mandatoryFieldsAlert delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        _CustAddressTXTW.layer.borderColor=[[UIColor redColor]CGColor];
        
    }
    
    else if ([_paymentPayTxt.text length]==0||[_paymentPayTxt.text intValue]<=0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@" Kindly enter the product you wish to purchase or first enter the INR to be paid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
    }
    else
    {

        if ([cashORcard isEqualToString:@"CardPayment"])
        {
            pay=@"payByCard";

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"OK", nil];
            
            UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:@"Transaction saved. Redirecting for online payment.\"Please do not refresh or close the window.\""];
            NSString*str1=[NSString stringWithFormat:@"Transaction saved. Redirecting for online payment.\"Please do not refresh or close the window.\""];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([str1 rangeOfString:@"\"Please do not refresh or close the window.\""].location,[str1 rangeOfString:@"\"Please do not refresh or close the window.\""].length)];
            lbl.attributedText = attributedStr; lbl.textAlignment = NSTextAlignmentCenter;
            lbl.numberOfLines=0;
            [alert setValue:lbl forKey:@"accessoryView"];
            [alert show];

        }
        else if ([cashORcard isEqualToString:@"CashPayment"])
        {
            pay=@"payByCash";
            


            if([info count]==0)
            {
                
                
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                                    message:@"Transaction successful"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:@"OK", nil];
                    
                    [alert show];
                    

                
            }
            else
            {
                NSString *myString = @"Transaction successful. Guarantee against serial ";
                NSString *joinedString = [serialArr componentsJoinedByString:@","];
                NSString*myString1 = [myString stringByAppendingString:joinedString];
                NSString*messageString = [myString1 stringByAppendingString:@" has been registered successfully."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                                message:messageString
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"OK", nil];
                
                [alert show];

            }
           
            

        }
        else if ([cashORcard isEqualToString:@"PayLink"])
        {
            [self PayLinkAPI];
        
        }

        
          }
}
-(void)medentryFileldColour
{
    
    if(_CustNameTXT.text==nil|| [_CustNameTXT.text length]<=0)
    {
        
        
        _CustNameTXT.layer.borderColor=[[UIColor redColor]CGColor];
    }
    else
    {
        _CustNameTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
        
    }
    
    if(_CustEmailTXT.text==nil|| [_CustEmailTXT.text length]<=0)
    {
        
        _CustEmailTXT.layer.borderColor=[[UIColor redColor]CGColor];
    }
    else
    {
        _CustEmailTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
        
        
    }
    if ([emailTest evaluateWithObject:_CustEmailTXT.text] == NO)
    {
        
        _CustEmailTXT.layer.borderColor=[[UIColor redColor]CGColor];
        
    }
    else
    {
        _CustEmailTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
        
    }
    
    if (!([_CustContactTXT.text length]==10))
    {

        
        _CustContactTXT.layer.borderColor=[[UIColor redColor]CGColor];
        
    }
    else
    {
        _CustContactTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
        
    }
    if(_CustStateTXT.text==nil|| [_CustStateTXT.text length]<=0)
    {
        
        _CustStateTXT.layer.borderColor=[[UIColor redColor]CGColor];
        
        
    }
    else
    {
        _CustStateTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
        
    }
    
    if(_CustCityTXT.text==nil|| [_CustCityTXT.text length]<=0)
    {
        _CustCityTXT.layer.borderColor=[[UIColor redColor]CGColor];
        
        
    }
    else
    {
        _CustCityTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
        
    }
    if(_CustPincodeTXT.text==nil|| [_CustPincodeTXT.text length]<=0)
    {
        _CustPincodeTXT.layer.borderColor=[[UIColor redColor]CGColor];
        
        
    }
    else
    {
        _CustPincodeTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
        
    }
    if (!([_CustPincodeTXT.text length]==6))
    {
        _CustPincodeTXT.layer.borderColor=[[UIColor redColor]CGColor];
    }
    else
    {
        _CustPincodeTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
        
    }
    if([_CustAddressTXTW.text isEqualToString:@"Address*"])
    {
        

        _CustAddressTXTW.layer.borderColor=[[UIColor redColor]CGColor];
        
    }
    else
    {
        
        _CustAddressTXTW.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
        
    }
    
    if ([_paymentPayTxt.text length]==0||[_paymentPayTxt.text intValue]<=0)
    {
        _paymentPayTxt.layer.borderColor=[[UIColor redColor]CGColor];

        
    }
    else
    {
        _paymentPayTxt.layer.borderColor=[[UIColor colorWithRed:30.0/255.0f green:175.0/255.0f  blue:180.0/255.0f  alpha:1.0f]CGColor];

    }

    

}
-(void)RefreshViewController
{       payByLink=@"";
        pickerRow=0;
        _CustNameTXT.text=@"";
        _CustEmailTXT.text=@"";
        _CustContactTXT.text=@"";
        _CustStateTXT.text=@"";
        _CustPincodeTXT.text=@"";
        _CustCityTXT.text=@"";
        _serialNumTxt.text=@"";
        _paymentPayTxt.text=@"";
        _CustAddressTXTW.text=@"Address*";
        _CustAddressTXTW.textColor=[UIColor lightGrayColor];
        [info removeAllObjects];
        [invoiceInfo removeAllObjects];
        [self.InvoiceTV reloadData];
        [self.ProductTV reloadData];
        [self initFream];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);

    if([apiName isEqualToString:@"PayLink"])
    {
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [dataDic valueForKey:@"message"];
                NSLog(@"count>>>%lu",(unsigned long)[info count]);
                [activityIndicator hideView];
                //[self RefreshViewController];
                messageStr=[dataDic valueForKey:@"message"];
                payByLink=@"yes";
                [self paybyCashData];

              //  [self transectionApi];
                               //str is now "hello world"
                
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[dataDic valueForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
                
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [activityIndicator hideView];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[dataDic valueForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            });
        }
    }
   else if([apiName isEqualToString:@"getProduct"])
    {
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                info=[[dataDic valueForKey:@"data"] mutableCopy];
                NSLog(@"count>>>%lu",(unsigned long)[info count]);
                invoiceInfo=[[dataDic valueForKey:@"invoice_summary"] mutableCopy];
                [self.ProductTV reloadData];
                [self.InvoiceTV reloadData];
                [self initFream];
                [self SetInvoicePayment:invoiceInfo];
                _serialNumTxt.text=@"";
                [activityIndicator hideView];
               //  __,__ has been registered successfully.
                
                
                NSString*serialNumber=[[NSString alloc]init];
                serialArr=[[NSMutableArray alloc]init];
                int i;
                for (i=0; i<=[[dataDic objectForKey:@"data"] count]-1; i++)
                {
                serialNumber=[[[dataDic objectForKey:@"data"] objectAtIndex:i]objectForKey:@"GCARD_NUMBER"];
                    [serialArr addObject:serialNumber];

              }
                //str is now "hello world"
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[dataDic valueForKey:@"op_message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];

            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [activityIndicator hideView];

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[dataDic valueForKey:@"op_message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            });
        }
    }
    else if([apiName isEqualToString:@"deleteProduct"])
    {
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                info=[dataDic valueForKey:@"data"];
                    info=[[dataDic valueForKey:@"data"] mutableCopy];
                invoiceInfo=[[dataDic valueForKey:@"invoice_summary"] mutableCopy];
                [self.ProductTV reloadData];
                [self.InvoiceTV reloadData];
                [self initFream];
                [self SetInvoicePayment:invoiceInfo];
                if ([info count]==0)
                {
                    _paymentPayTxt.text=@"";

                    [self.InvoiceTV reloadData];
                }
               
                [activityIndicator hideView];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[dataDic valueForKey:@"msg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [activityIndicator hideView];
            });        }
    }
    else if([apiName isEqualToString:@"PayByCash"])
    {
        if ([[dataDic valueForKey:@"status"] isEqual:@1])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator hideView];
           
                if ([payByLink isEqualToString:@"yes"])
                {
                
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:messageStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                }
            [self RefreshViewController];
            [self transectionApi];

        });
        } else
            {
                dispatch_async(dispatch_get_main_queue(), ^{ [activityIndicator hideView]; });
            }
    }
    else if([apiName isEqualToString:@"transectionInfo"])
    {
        if ([[dataDic valueForKey:@"status"] isEqual:@1])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator hideView];
                OrderIDInfoDic=[dataDic valueForKey:@"data"];
                NSLog(@"OrderIDInfoDic>>%@",OrderIDInfoDic);
                self.inviceIDLab.text=[NSString stringWithFormat:@"%@ %@",@"Invoice Id:",[OrderIDInfoDic valueForKey:@"op_transaction_id"]];
    transectionType=[[dataDic objectForKey:@"data"] objectForKey:@"op_service_provider_name"];
                if ([historyModel sharedhistoryModel].stateAndCityArray.count==0)
                {
                [self cityList];
                    NSLog(@"cityListAPI");
                }


        });
        } else
        {
            dispatch_async(dispatch_get_main_queue(), ^{ [activityIndicator hideView]; });
        }
    }
    else if([apiName isEqualToString:@"getStateCity"])
    {
        if ([[dataDic valueForKey:@"status"] isEqual:@1])
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [activityIndicator hideView];
                [historyModel sharedhistoryModel].stateAndCityArray=[dataDic valueForKey:@"data"];
            });
        } else
        {
            dispatch_async(dispatch_get_main_queue(), ^{ [activityIndicator hideView]; });
        }
    }
}

-(void)SetInvoicePayment:(NSArray *)PaymentInvoiceArr
{
    for (int i=0;i<= [PaymentInvoiceArr count]-1; i++)
    {
        
    if ([[[PaymentInvoiceArr objectAtIndex:i] valueForKey:@"TRAN_DESCRIPTION"] isEqualToString:@"TOTAL"])
        {
            _paymentPayTxt.text=[[PaymentInvoiceArr objectAtIndex:i] valueForKey:@"TRAN_AMOUNT"] ;
        }
    }


}
-(void)MoveToCCAvenue
{
    [self showFieldAlert];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];

    if ([MailClassViewController isNetworkConnected])
    {

    if ([pay isEqualToString:@"payByCard"])
    {
        if ([title isEqualToString:@"OK"])
        {
            pay=@"";
            GreatPlusCCAvenueWVC *CCAvenue=[[GreatPlusCCAvenueWVC alloc] init];
            CCAvenue.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            //            CCAvenue.currency   =CCAV_Currency;
            //            CCAvenue.accessCode = CCAV_Merch_AccesCode;
            //            CCAvenue.merchantId = CCAV_MerchantID;
            CCAvenue.amount  = _paymentPayTxt.text;
            CCAvenue.orderId= [OrderIDInfoDic valueForKey:@"op_transaction_id"];
            //            CCAvenue.redirectUrl = CCAV_Redirect_URL;
            //            CCAvenue.cancelUrl   = CCAV_Cancel_URL;
            //            CCAvenue.rsaKeyUrl   = CCAV_RSAKey_URL;
            CCAvenue.language= @"EN";
            CCAvenue.billing_name= _CustNameTXT.text;
            CCAvenue.billing_city= _CustCityTXT.text;
            CCAvenue.billing_state= _CustStateTXT.text;
            CCAvenue.billing_email= _CustEmailTXT.text;
            CCAvenue.billing_country = @"India";
            CCAvenue.billing_zip     = _CustPincodeTXT.text;
            CCAvenue.billing_email   = _CustEmailTXT.text;
            CCAvenue.billing_tel     = _CustContactTXT.text;
            CCAvenue.billing_address = _CustAddressTXTW.text;
            CCAvenue.merchant_param1 = [OrderIDInfoDic valueForKey:@"op_service_provider_name"];
            CCAvenue.merchant_param2 = [UserDefaultStorage getUserDealerID];
            CCAvenue.merchant_param3 = [UserDefaultStorage getDealerID];
            CCAvenue.merchant_param4 = [OrderIDInfoDic valueForKey:@"op_merchant_id"];
            CCAvenue.subAccountID=[OrderIDInfoDic valueForKey:@"op_merchant_id"];
            
            if ([[OrderIDInfoDic valueForKey:@"op_service_provider_name"] isEqualToString:@"CCAVENUE"])
            {
                //CCAVENUE
                CCAvenue.currency   =CCAV_Currency;
                CCAvenue.accessCode = CCAV_Merch_AccesCode;
                CCAvenue.merchantId = CCAV_MerchantID;
                CCAvenue.redirectUrl= CCAV_Redirect_URL;
                CCAvenue.cancelUrl  = CCAV_Cancel_URL;
                CCAvenue.rsaKeyUrl  = CCAV_RSAKey_URL;
                CCAvenue.paymentURL=@"https://secure.ccavenue.com/transaction/initTrans";
            }
            else
            {
                CCAvenue.currency   =HDFC_Currency;
                CCAvenue.accessCode = HDFC_Merch_AccesCode;
                CCAvenue.merchantId = HDFC_MerchantID;
                CCAvenue.redirectUrl = HDFC_Redirect_URL;
                CCAvenue.cancelUrl   = HDFC_Cancel_URL;
                CCAvenue.rsaKeyUrl   = HDFC_RSAKey_URL;
                CCAvenue.paymentURL=@"https://secure.ccavenue.com/transaction/initTrans";
            }
            
            [self presentViewController:CCAvenue animated:YES completion:nil];
        }
       else if ([title isEqualToString:@"Cancel"])
        {
        
            pay=@"";

        }
    }
    
    if ([pay isEqualToString:@"payByCash"])
    {
        if ([title isEqualToString:@"OK"])
        {
            pay=@"";

            [self paybyCashData];
        
        }
        else if ([title isEqualToString:@"Cancel"])
        {
            pay=@"";
        }
    }
    }
    else {
        [MailClassViewController showAlertViewWithTitle:@"Connection.!!!" message:OhnoAlert delegate:self tag:NetworkAlertTag];
    }
}

-(void)paybyCashData
{
    NSString*paymentMode;
    if ([payByLink isEqualToString:@"yes"])
    {
        if([transectionType isEqualToString:@"CCAVENUE"])
        {
            paymentMode=@"CCAVENUE-Pay Link to Customer";

        }
        else
        {
            paymentMode=@"HDFC-Pay Link to Customer";

        }
    }
    else
    {
        paymentMode=@"Cash";

    }
    NSDictionary*InputDict= @{@"p_greatplus_user_id":[UserDefaultStorage getUserDealerID],  @"p_dealer_id":[UserDefaultStorage getDealerID],
                              @"p_transaction_date":@"",
                              @"p_invoice_id":@"",
                              @"p_payment_mode":paymentMode,
                              @"p_transaction_id":[OrderIDInfoDic valueForKey:@"op_transaction_id"],
                              @"p_customer_name":_CustNameTXT.text,
                              @"p_email":_CustEmailTXT.text,
                              @"p_city":_CustCityTXT.text,
                              @"p_state":_CustStateTXT.text,
                              @"p_pin_code":_CustPincodeTXT.text,
                              @"p_address":_CustAddressTXTW.text,
                              @"p_payment_amount":_paymentPayTxt.text,
                              @"p_contact_number":_CustContactTXT.text,};
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:PayByCashLoading];
    [activityIndicator showView];
    [helper PayByCash:InputDict];

}

-(void)webApiResponseError:(NSError *)errorDictionary
{
    [activityIndicator hideView];
}
-(void)transectionApi
{
    [activityIndicator showView];

    NSDictionary*dic1=@{@"p_greatplus_user_id":[UserDefaultStorage getUserDealerID],@"p_dealer_id":[UserDefaultStorage getDealerID]};
    [helper transectionInfo:dic1];

}
-(void)PayLinkAPI
{
    NSDictionary*InputDict= @{@"p_dealer_id":[UserDefaultStorage getDealerID],
                              @"p_customer_name":_CustNameTXT.text,
                              @"p_email":_CustEmailTXT.text,
                              @"p_payment_amount":_paymentPayTxt.text,
                              @"p_contact_number":_CustContactTXT.text,};
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:PayByCashLoading];
    [activityIndicator showView];
    if ([transectionType isEqualToString:@"CCAVENUE"])
    {
        NSLog(@"CCAVENUE");
        [helper PayLinkToCustomerCCAV:InputDict];

    }
    else
    {
        NSLog(@"HDFC");
        [helper PayLinkToCustomerHDFC:InputDict];
    }
    
    
}
-(void)freamingText
{
    _CustNameTXT.delegate=self;
    _CustEmailTXT.delegate=self;
    _CustContactTXT.delegate=self;
    _CustStateTXT.delegate=self;
    _CustPincodeTXT.delegate=self;
    _CustCityTXT.delegate=self;
    _serialNumTxt.delegate=self;
    _paymentPayTxt.delegate=self;
    _CustAddressTXTW.delegate=self;
    // textField boarder colour
    
    _CustNameTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
    _CustNameTXT.layer.borderWidth= 1.0f;
    [_CustNameTXT.layer setCornerRadius:4.0f];
    
    _CustEmailTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
    _CustEmailTXT.layer.borderWidth= 1.0f;
    [_CustEmailTXT.layer setCornerRadius:4.0f];
    
    _CustContactTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
    _CustContactTXT.layer.borderWidth= 1.0f;
    [_CustContactTXT.layer setCornerRadius:4.0f];
    
    _CustStateTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
    _CustStateTXT.layer.borderWidth= 1.0f;
    [_CustStateTXT.layer setCornerRadius:4.0f];
    
    _CustPincodeTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
    _CustPincodeTXT.layer.borderWidth= 1.0f;
    [_CustPincodeTXT.layer setCornerRadius:4.0f];
    
    _CustCityTXT.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
    _CustCityTXT.layer.borderWidth= 1.0f;
    [_CustCityTXT.layer setCornerRadius:4.0f];
    
    
    _CustAddressTXTW.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
    _CustAddressTXTW.layer.borderWidth= 1.0f;
    [_CustAddressTXTW.layer setCornerRadius:4.0f];
    
    _serialNumTxt.layer.borderColor=[[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f  blue:246.0/255.0f  alpha:1.0f]CGColor];
    _serialNumTxt.layer.borderWidth= 2.0f;
    _paymentPayTxt.layer.borderColor=[[UIColor colorWithRed:30.0/255.0f green:175.0/255.0f  blue:180.0/255.0f  alpha:1.0f]CGColor];
    _paymentPayTxt.layer.borderWidth= 1.0f;
    
    //remove padding
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _CustNameTXT.leftView = paddingView;
    _CustNameTXT.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _CustEmailTXT.leftView = paddingView1;
    _CustEmailTXT.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _CustContactTXT.leftView = paddingView2;
    _CustContactTXT.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _CustStateTXT.leftView = paddingView3;
    _CustStateTXT.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _CustPincodeTXT.leftView = paddingView4;
    _CustPincodeTXT.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _serialNumTxt.leftView = paddingView5;
    _serialNumTxt.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _CustCityTXT.leftView = paddingView6;
    _CustCityTXT.leftViewMode = UITextFieldViewModeAlways;
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
    if(textField==_CustEmailTXT)
    {
        [self NSStringIsValidEmail:_CustEmailTXT.text];
    }
        
        //
}


#pragma pickerDelegateMethod


- (IBAction)StatePickerBTN:(id)sender
{
    [self hidekeyboard];
    pickercheck=@"state";
    _StatePickerBTN.userInteractionEnabled=NO;
    [self CreatePicker];

}
- (IBAction)CityPickerBTN:(id)sender
{    [self hidekeyboard];
    pickercheck=@"City";
    _CityPickerBTN.userInteractionEnabled=NO;
    [self CreatePicker];
}
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if([pickercheck isEqualToString:@"state"])
    {
        return [[historyModel sharedhistoryModel].stateAndCityArray count];
    }
    else
    {
        return [[[[historyModel sharedhistoryModel].stateAndCityArray objectAtIndex:pickerRow] valueForKey:@"city"] count];

    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    if([pickercheck isEqualToString:@"state"])
    {
    return [[[historyModel sharedhistoryModel].stateAndCityArray objectAtIndex:row] valueForKey:@"state"];
    }
    else
    {
        return [[[[[historyModel sharedhistoryModel].stateAndCityArray objectAtIndex:pickerRow] valueForKey:@"city"] objectAtIndex:row] valueForKey:@"city_name"];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([pickercheck isEqualToString:@"state"])
    {
        pickerRow=row;
    }
    else
    {
        CitypickerRow=row;

    }
}

-(void)clickOnDoneButtonOnActionSheet1:(id)sender
{
    if([pickercheck isEqualToString:@"state"])
    {
        _CustStateTXT.text=[[[historyModel sharedhistoryModel].stateAndCityArray objectAtIndex:pickerRow] valueForKey:@"state"];
        _StatePickerBTN.userInteractionEnabled=YES;

        _CityPickerBTN.userInteractionEnabled=YES;
        _CustCityTXT.text=@"";
        pickerRow=0;


    }
    else
    {

        _CustCityTXT.text=[[[[[historyModel sharedhistoryModel].stateAndCityArray objectAtIndex:pickerRow] valueForKey:@"city"] objectAtIndex:CitypickerRow] valueForKey:@"city_name"];
        _CityPickerBTN.userInteractionEnabled=YES;
        CitypickerRow=0;



    }
      timeBackgroundView.hidden=YES;

}
-(void)clickOnCancelButtonOnActionSheet:(id)sender
{
    if([pickercheck isEqualToString:@"state"])
    {
        _StatePickerBTN.userInteractionEnabled=YES;
        pickerRow=0;

        
        
    }
    else
    {
        _CityPickerBTN.userInteractionEnabled=YES;
        CitypickerRow=0;

        
    }
    timeBackgroundView.hidden=YES;
 
}

-(void)CreatePicker
{
    timeBackgroundView.hidden=YES;

    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 100)];
    
    
    pickerView.hidden = NO;
    pickerView.delegate=self;
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    pickerToolbar.tintColor = [UIColor whiteColor];
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(clickOnCancelButtonOnActionSheet:)];
    
    [cancelBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                       NSForegroundColorAttributeName,
                                       nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *titleButton;
    //float pickerMarginHeight = 168;
    titleButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target: nil action: nil];
    
    [titleButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                         NSForegroundColorAttributeName,
                                         nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(clickOnDoneButtonOnActionSheet1:)];
    
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                     NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];
    
    NSArray *itemArray = [[NSArray alloc] initWithObjects:cancelBtn, flexSpace, titleButton, flexSpace, doneBtn, nil];
    timeBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,Window_Height-160, Window_Width, 170)];
    [timeBackgroundView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    [timeBackgroundView addSubview:pickerToolbar];
    [timeBackgroundView addSubview:pickerView];
//    [[GreatPlusAppDelegate appDelegate].window addSubview:timeBackgroundView];
     [[AppDelegate appDelegate].window addSubview:timeBackgroundView];
    [pickerToolbar setItems:itemArray animated:YES];
    
    
}
-(void)hidekeyboard
{
    [_CustNameTXT resignFirstResponder];
    [_CustEmailTXT resignFirstResponder];
    [_CustContactTXT resignFirstResponder];
    // [_CustStateTXT resignFirstResponder];
    [_CustPincodeTXT resignFirstResponder];
    //[_CustCityTXT resignFirstResponder];
    [_serialNumTxt resignFirstResponder];
    [_paymentPayTxt resignFirstResponder];
    [_CustAddressTXTW resignFirstResponder];
}
-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==_CustContactTXT)
{
    
    if(_CustContactTXT.text.length >= 10 && range.length == 0)
    {
        return NO;
    }
}
    if (textField==_CustPincodeTXT)
    {

     if(_CustPincodeTXT.text.length >=6 && range.length == 0)
    {
        return NO;
    }
    }
    return YES;
}



@end
