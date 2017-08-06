//
//  DTEHome.h
//  DTE
//
//  Created by Divya Jain on 5/1/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
@interface DTEHome : BaseClass<UIScrollViewDelegate,SlideNavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate>
{

    __weak IBOutlet UIView *vwError;
    __weak IBOutlet UIScrollView *myScrollView;
    __weak IBOutlet UIPageControl *pgCtrl;
    __weak IBOutlet UIImageView *imgVw;
    __weak IBOutlet UIView *sliderVw;
    
    __weak IBOutlet UIScrollView *sliderScrollVw;
    
    __weak IBOutlet UITableView *tblCategories;
    BOOL pageControlIsChangingPage;
    
    __weak IBOutlet NSLayoutConstraint *tblHeight;
    
    NSArray* arrCategories;
     UIDocumentInteractionController *_docController;
    NSInteger selectedRow;

}
- (IBAction)changePage:(id)sender;
- (IBAction)MenuAction:(id)sender;
- (IBAction)ShareAction:(id)sender;
- (IBAction)CartAction:(id)sender;
- (IBAction)SettingsAction:(id)sender;
- (IBAction)RetryAction:(id)sender;

@end
