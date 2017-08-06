//
//  Products.h
//  DTE
//
//  Created by Divya Jain on 5/15/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
#import "FPPopoverTableController.h"

@interface Products : BaseClass<UITableViewDelegate,UITableViewDataSource>

{
    FPPopoverController *popoverWeight;

    __weak IBOutlet UIView *vwError;
    __weak IBOutlet UILabel *lblCategoryName;
    __weak IBOutlet UITableView *tblProducts;
    NSString *strWeight;
    NSInteger indexRow;
//    NSMutableDictionary * product;

}
@property(nonatomic, copy) id Products;
@property(nonatomic, strong) NSString* strCategory;

- (IBAction)BackAction:(id)sender;
- (IBAction)SearchProductAction:(id)sender;
- (IBAction)CartAction:(id)sender;
- (IBAction)SettingsAction:(id)sender;


@end
