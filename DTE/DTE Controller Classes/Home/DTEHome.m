//
//  DTEHome.m
//  DTE
//
//  Created by Divya Jain on 5/1/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "DTEHome.h"
#import "HomeCell.h"
#import "Products.h"
#import "SignUp.h"
#import "DTELogin.h"

@interface DTEHome ()

@end

@implementation DTEHome



#pragma mark - View lifecycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    myScrollView.delegate = self;
    tblCategories.delegate= self;
    tblCategories.dataSource= self;
    tblCategories.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    [self getCategory];

    [tblCategories reloadData];

    [self performSelector:@selector(setUP) withObject:nil afterDelay:0.4];
    }

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Misc
-(void)getCategory
{
    if (![APIManager isNetworkAvailable]) {
//        [self showAlertTitle:@"" message:@"Please check your internet connection"];
        vwError.hidden = false;

        return;
    }
    
    [[APIManager sharedManager]getAllCategoriesWithCompletionHandler:^(id  _Nullable response, NSError * _Nullable error) {
        if (!error) {
            arrCategories = [[[APIManager sharedManager] categories]mutableCopy];
            [tblCategories reloadData];
            vwError.hidden = true;

        }
        else
        {
            vwError.hidden = false;
        }
    }];

}

-(void)setUP{
    sliderScrollVw.delegate = self;
    
    [self setupScrollView:sliderScrollVw];
    pgCtrl.numberOfPages=4;
    pgCtrl.autoresizingMask=UIViewAutoresizingNone;
    myScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1200);
    
    
    

}

#pragma mark - slidingImagesMethods
- (void)setupScrollView:(UIScrollView*)scrMain {
    // we have 4 images here.
    // we will add all images into a scrollView & set the appropriate size.
    
    for (int i=1; i<=4; i++) {
        // create image
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Image%d",i]];
        // create imageView
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((i-1)*scrMain.frame.size.width, 0, scrMain.frame.size.width, scrMain.frame.size.height)];
        [imgV setBackgroundColor:[UIColor yellowColor]];
        // set scale to fill
        imgV.contentMode=UIViewContentModeScaleToFill;
        // set image
        [imgV setImage:image];
        // apply tag to access in future
        imgV.tag=i+1;
        // add to scrollView
        [scrMain addSubview:imgV];
    }
    // set the content size to 10 image width
    [scrMain setContentSize:CGSizeMake(scrMain.frame.size.width*4, scrMain.frame.size.height)];
    // enable timer after each 2 seconds for scrolling.
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollingTimer) userInfo:nil repeats:YES];
}

- (void)scrollingTimer {
    // get the current offset ( which page is being displayed )
    CGFloat contentOffset = sliderScrollVw.contentOffset.x;
    // calculate next page to display
    int nextPage = (int)(contentOffset/sliderScrollVw.frame.size.width) + 1 ;
    // if page is not 4, display it
    if( nextPage!=4 )  {
        [sliderScrollVw scrollRectToVisible:CGRectMake(nextPage*sliderScrollVw.frame.size.width, 0, sliderScrollVw.frame.size.width, sliderScrollVw.frame.size.height) animated:YES];
        pgCtrl.currentPage=nextPage;
        // else start sliding form 1 :)
    } else {
        [sliderScrollVw scrollRectToVisible:CGRectMake(0, 0, sliderScrollVw.frame.size.width, sliderScrollVw.frame.size.height) animated:NO];
        pgCtrl.currentPage=0;
    }
}

-(void)setIndiactorForCurrentPage
{
    uint page = sliderScrollVw.contentOffset.x / sliderScrollVw.frame.size.width;
    [pgCtrl setCurrentPage:page];
    
}
- (IBAction)changePage:(id)sender{
    
    CGRect frame = sliderScrollVw.frame;
    frame.origin.x = (frame.size.width-70) * pgCtrl.currentPage;
    frame.origin.y = 0;
    
    [sliderScrollVw scrollRectToVisible:frame animated:YES];
    
    pageControlIsChangingPage = NO;
}

- (IBAction)MenuAction:(id)sender {
    if ([[SlideNavigationController sharedInstance] isMenuOpen ])
        [[SlideNavigationController sharedInstance] closeMenuWithCompletion:nil];
    else
        [[SlideNavigationController sharedInstance] openMenu:MenuLeft withCompletion:nil];
}

- (IBAction)ShareAction:(id)sender {
    
    //-- set strings and URLs
    NSString *textObject = @"Information that I want to tweet or share";
//    NSString *urlString = [NSString stringWithFormat:@"http://www.mygreatdomain/%@", _selectedPageString];
    
//    NSURL *url = [NSURL URLWithString:urlString];
    
//    NSArray *activityItems = [NSArray arrayWithObjects:textObject, url,  nil];
        NSArray *activityItems = [NSArray arrayWithObjects:textObject,  nil];

    //-- initialising the activity view controller
    UIActivityViewController *avc = [[UIActivityViewController alloc]
                                     initWithActivityItems:activityItems
                                     applicationActivities:nil];
    
    
    avc.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard ];
    
    
    //-- define the activity view completion handler
    avc.completionWithItemsHandler = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        if (completed) {
                        // NSLog(@"Selected activity was performed.");
                    } else {
                        if (activityType == NULL) {
                            //   NSLog(@"User dismissed the view controller without making a selection.");
                        } else {
                            //  NSLog(@"Activity was not performed.");
                        }
                    }
    };
    
    [self presentViewController:avc animated:YES completion:nil];

    
//    ------------ Or-----------
//dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            UIButton *btn = (UIButton*)sender;
//            UIImage *instaImage = [UIImage imageNamed:@"logo"];
//            NSString* imagePath = [NSString stringWithFormat:@"%@/image.jpg",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
//            [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
//            [UIImagePNGRepresentation(instaImage) writeToFile:imagePath atomically:YES];
//            _docController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:imagePath]];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_docController presentOptionsMenuFromRect:btn.frame inView:self.view animated:YES];
//
//            });
    
    
//        });
   
}

- (void)presentActivityController:(UIActivityViewController *)controller {
    
    // for iPad: make the presentation a Popover
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.leftBarButtonItem;
}

- (IBAction)CartAction:(id)sender {
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"addBadge" object:nil];
    
    ALERT_UnderProcess;
}

- (IBAction)SettingsAction:(id)sender {
    ALERT_UnderProcess;
}

- (IBAction)RetryAction:(id)sender {
    [self getCategory];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)sView
{
    CGFloat pageWidth = sView.frame.size.width;
    int page = floor((sView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (sliderScrollVw.contentOffset.x<0) {
        [sliderScrollVw setContentOffset:CGPointMake(sliderScrollVw.frame.size.width, 0) animated:NO];
    }
    else {
        [pgCtrl setCurrentPage:page];
        //        [self updateToPage:page];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender {
    
    [self setIndiactorForCurrentPage];
    
}

#pragma mark - slide menu navigation delegate
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

#pragma mark - TableView Methods

#pragma mark -- UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[[APIManager sharedManager] categories] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = (HomeCell*)[tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
    if (cell== nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil];
        cell = [nibArray objectAtIndex:0];

//        cell.backgroundColor = [UIColor clearColor];
   
        // Draw top border only on first cell
        if (indexPath.row == 0) {
            UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, self.view.bounds.size.width-30, 1)];
            topLineView.backgroundColor = [UIColor greenColor];
            [cell.contentView addSubview:topLineView];
        }
//        NSLog(@"indexpatrow %ld arr count %lu",(long)indexPath.row,(unsigned long)[arrCategories count]);
//        if ((long)indexPath.row == [arrCategories count]-1) {
//
//        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(15, cell.bounds.size.height, self.view.bounds.size.width-30, 1)];
//        bottomLineView.backgroundColor = [UIColor greenColor];
//        [cell.contentView addSubview:bottomLineView];
//        }
    }
    
    NSDictionary * category =arrCategories[indexPath.row];
    cell.lblCategoryName.text = category[@"CategoryName"];
    CGFloat height = 1000;
    tblHeight.constant = height;
    return cell;
    
}

#pragma mark -- UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//        NSDictionary * category =arrCategories[indexPath.row];
//    productsSegue
//    Products *vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier:@"Products"];
    selectedRow = indexPath.row;
    [[APIManager sharedManager] getProductsByCategoryID:@"78" withCompletionBlock:^(id  _Nullable response, NSError * _Nullable error) {
        if (!error) {
            
            [self performSegueWithIdentifier:@"productSegue" sender:response];

//            vc.Products = response;
//            [self presentViewController:vc animated:YES completion:NULL];


        }
        else
            [self showAlertTitle:@"" message:[error localizedDescription]];
        
    }];
    
    
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"productSegue"])
    {
        NSDictionary * category =arrCategories[selectedRow];

        
        Products *vc = segue.destinationViewController;
        vc.Products = sender;
        vc.strCategory = category[@"CategoryName"];
    }
}



#pragma mark - UIDocumentInteractionControllerDelegate

//===================================================================
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    return self.view.frame;
}


- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application {
    
    NSLog(@"Starting to send this puppy to %@", application);
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application {
    
    NSLog(@"We're done sending the document.");
}


//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Remove seperator inset
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    // Prevent the cell from inheriting the Table View's margin settings
//    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
//        [cell setPreservesSuperviewLayoutMargins:NO];
//    }
//    
//    // Explictly set your cell's layout margins
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}




//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
//
//    dispatch_async(queue, ^{
//        arrCategories = [[[APIManager sharedManager] categories]mutableCopy
//                         ];
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            tblCategories.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//
//            tblCategories.delegate= self;
//            tblCategories.dataSource= self;
//            [tblCategories reloadData];
//        });
//
//
//    });

//    if ([arrCategories count]==0) {
//        [self setCategory];
//    }


@end
