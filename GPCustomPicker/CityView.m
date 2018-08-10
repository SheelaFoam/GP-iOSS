/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "CityView.h"
#import "GreatPlusSharedHeader.h"
#import "MailClassViewController.h"

@implementation CityView
@synthesize cityTable;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    cityTable.delegate = self;
    cityTable.dataSource = self;
    searchArray = [[NSArray alloc] init];
    mNavTitle.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"title"];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Delear"]) {
        cityContainer = [[NSMutableArray alloc] initWithArray:[MailClassViewController sharedInstance].mDelearListArray];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Location"]) {
        cityContainer = [[NSMutableArray alloc] initWithArray:[MailClassViewController sharedInstance].mLocationArray];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Product List"]) {
        cityContainer = [[NSMutableArray alloc] initWithArray:[MailClassViewController sharedInstance].mProductListArray];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Colour List"]) {
        cityContainer = [[NSMutableArray alloc] initWithArray:[MailClassViewController sharedInstance].mColourListArray];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Order Status"]) {
        serchBar.hidden = YES;
        cityTable.frame = CGRectMake(cityTable.frame.origin.x, 50.0f, cityTable.frame.size.width, cityTable.frame.size.height + 44);
        cityContainer = [[NSMutableArray alloc] initWithArray:[MailClassViewController sharedInstance].mOrderStatusArray];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select State"]) {
        cityContainer = [[NSMutableArray alloc] initWithArray:[MailClassViewController sharedInstance].mStateArray];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Category"]) {
        cityContainer = [[NSMutableArray alloc] initWithArray:[MailClassViewController sharedInstance].mCategoryArray];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Product"]) {
         cityContainer = [[NSMutableArray alloc] initWithArray:[MailClassViewController sharedInstance].mProductArray];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Product Size"]) {
         cityContainer = [[NSMutableArray alloc] initWithArray:[MailClassViewController sharedInstance].mSizeArray];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Thickness"]) {
        cityContainer = [[NSMutableArray alloc] initWithArray:[MailClassViewController sharedInstance].mThicknessArray];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [cityContainer count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Delear"]) {
        
        BOOL isKeyExists      = [[cityContainer objectAtIndex:indexPath.row]  objectForKey:@"channel_partner_name"] != nil;
        if (isKeyExists) {
             cell.textLabel.text = [[cityContainer objectAtIndex:indexPath.row]  objectForKey:@"channel_partner_name"];
        } else {
            cell.textLabel.text = [[cityContainer objectAtIndex:indexPath.row]  objectForKey:@"DEALER_NAME"];
        }

    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Location"]) {
        cell.textLabel.text = [[cityContainer objectAtIndex:indexPath.row]  objectForKey:@"location_name"];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Product List"]) {
        cell.textLabel.text = [[cityContainer objectAtIndex:indexPath.row]  objectForKey:@"product_display_name"];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Colour List"]) {
        cell.textLabel.text = [[cityContainer objectAtIndex:indexPath.row]  objectForKey:@"color"];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Order Status"]) {
        cell.textLabel.text = [[cityContainer objectAtIndex:indexPath.row]  objectForKey:@"Name"];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select State"]) {
        cell.textLabel.text = [[cityContainer objectAtIndex:indexPath.row]  objectForKey:@"STATE"];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Category"]) {
        cell.textLabel.text = [[cityContainer objectAtIndex:indexPath.row]  objectForKey:@"SUB_SUB_PRODUCT_SEGMENT_2016"];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Product"]) {
        cell.textLabel.text = [[cityContainer objectAtIndex:indexPath.row]  objectForKey:@"PRODUCT_DISPLAY_NAME"];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Product Size"]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@x%@",[[cityContainer objectAtIndex:indexPath.row]  objectForKey:@"LENGTH"],[[cityContainer objectAtIndex:indexPath.row]  objectForKey:@"BREDTH"]];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Thickness"]) {
        cell.textLabel.text = [[cityContainer objectAtIndex:indexPath.row]  objectForKey:@"THICK"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.textColor = [UIColor colorWithRed:64/255.0f green:64/255.0f blue:64/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:RobotoRegular size:13.0f];
    
    if ([[[cityContainer objectAtIndex:indexPath.row] objectForKey:@"SELECTED"] isEqualToString:@"YES"]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [cityContainer setValue:@"NO" forKey:@"SELECTED"];
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
	if ([selectedCell accessoryType] == UITableViewCellAccessoryNone) {
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [[cityContainer objectAtIndex:indexPath.row] setObject:@"YES" forKey:@"SELECTED"];
        
	} else {
        [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
        [[cityContainer objectAtIndex:indexPath.row] setObject:@"NO" forKey:@"SELECTED"];
    }
    [cityTable reloadData];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(doneBtnTapped:) userInfo:nil
                                    repeats:NO];
}

- (IBAction)doneBtnTapped:(id)sender {
    
    BOOL mBOOL = NO;
    if ([delegate respondsToSelector:@selector(onCityDone:selectedClentFocus:)]) {
        
        temp = [NSMutableArray array];        
        for (dic in cityContainer) {
            
            if ([[dic objectForKey:@"SELECTED"] isEqualToString:@"YES"]) {
                mBOOL = YES;
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Delear"]) {
                    [temp addObject:dic];
                } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Location"]) {
                    [temp addObject:dic];
                } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Product List"]) {
                    [temp addObject:dic];
                } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Colour List"]) {
                    [temp addObject:dic];
                } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Order Status"]) {
                    [temp addObject:dic];
                } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select State"]) {
                    [temp addObject:dic];
                } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Category"]) {
                    [temp addObject:dic];
                }  else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Product"]) {
                    [temp addObject:dic];
                } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Product Size"]) {
                    [temp addObject:dic];
                } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Thickness"]) {
                    [temp addObject:dic];
                }
            }
        }
        
        if (mBOOL == YES) {
              [delegate onCityDone:self selectedClentFocus:temp];
        } else {
            [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] delegate:self tag:0];
        }
    }
}

- (IBAction)cancelBtnTapped:(id)sender{
    
    if ([delegate respondsToSelector:@selector(onCityTableCancel:)]) {
        
        [delegate onCityTableCancel:sender];
    }
}

#pragma mark - TextField Resign Responder

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText length] == 0) {
        
        [searchBar performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:0];
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Delear"]) {
            cityContainer = [MailClassViewController sharedInstance].mDelearListArray;
        } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Location"]) {
            cityContainer = [MailClassViewController sharedInstance].mLocationArray;
        } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Product List"]) {
            cityContainer = [MailClassViewController sharedInstance].mProductListArray;
        } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Colour List"]) {
            cityContainer = [MailClassViewController sharedInstance].mColourListArray;
        } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select State"]) {
            cityContainer = [MailClassViewController sharedInstance].mStateArray;
        } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Category"]) {
            cityContainer = [MailClassViewController sharedInstance].mCategoryArray;
        }  else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Product"]) {
             cityContainer = [MailClassViewController sharedInstance].mProductArray;
        }
    } else {
        NSPredicate *predicate;
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Delear"]) {
     
            NSMutableArray *predArray = [[NSMutableArray alloc] initWithCapacity:0];
            [predArray addObject:[NSPredicate predicateWithFormat:@"channel_partner_name contains[c] %@",  searchText]];
            [predArray addObject:[NSPredicate predicateWithFormat:@"DEALER_NAME contains[c] %@",  searchText]];
            NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:predArray];
            
            searchArray = [[MailClassViewController sharedInstance].mDelearListArray filteredArrayUsingPredicate:predicate];
            cityContainer = (NSMutableArray *)searchArray;

        } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Location"]) {
            predicate = [NSPredicate predicateWithFormat:@"location_name contains[c] %@",  searchText];
            searchArray = [[MailClassViewController sharedInstance].mLocationArray filteredArrayUsingPredicate:predicate];
            cityContainer = (NSMutableArray *)searchArray;
        } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Product List"]) {
            predicate = [NSPredicate predicateWithFormat:@"product_display_name contains[c] %@",  searchText];
            searchArray = [[MailClassViewController sharedInstance].mProductListArray filteredArrayUsingPredicate:predicate];
            cityContainer = (NSMutableArray *)searchArray;
            
        } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Colour List"]) {
            predicate = [NSPredicate predicateWithFormat:@"color contains[c] %@",  searchText];
            searchArray = [[MailClassViewController sharedInstance].mColourListArray filteredArrayUsingPredicate:predicate];
            cityContainer = (NSMutableArray *)searchArray;
        } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select State"]) {
            predicate = [NSPredicate predicateWithFormat:@"STATE contains[c] %@",  searchText];
            searchArray = [[MailClassViewController sharedInstance].mStateArray filteredArrayUsingPredicate:predicate];
            cityContainer = (NSMutableArray *)searchArray;
        } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Category"]) {
            predicate = [NSPredicate predicateWithFormat:@"SUB_SUB_PRODUCT_SEGMENT_2016 contains[c] %@",  searchText];
            searchArray = [[MailClassViewController sharedInstance].mCategoryArray filteredArrayUsingPredicate:predicate];
            cityContainer = (NSMutableArray *)searchArray;
        }  else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Product"]) {
            predicate = [NSPredicate predicateWithFormat:@"PRODUCT_DISPLAY_NAME contains[c] %@",  searchText];
            searchArray = [[MailClassViewController sharedInstance].mProductArray filteredArrayUsingPredicate:predicate];
            cityContainer = (NSMutableArray *)searchArray;
        } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Product Size"]) {
            NSMutableArray *predArray = [[NSMutableArray alloc] initWithCapacity:0];
            [predArray addObject:[NSPredicate predicateWithFormat:@"LENGTH contains[c] %@",  searchText]];
            [predArray addObject:[NSPredicate predicateWithFormat:@"BREDTH contains[c] %@",  searchText]];
            NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:predArray];
            searchArray = [[MailClassViewController sharedInstance].mSizeArray filteredArrayUsingPredicate:predicate];
            cityContainer = (NSMutableArray *)searchArray;
        } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"title"] isEqualToString:@"Select Thickness"]) {
            predicate = [NSPredicate predicateWithFormat:@"THICK contains[c] %@",  searchText];
            searchArray = [[MailClassViewController sharedInstance].mThicknessArray filteredArrayUsingPredicate:predicate];
            cityContainer = (NSMutableArray *)searchArray;
        }
    }
    [cityTable reloadData];
}

@end

