//
//  ProductDetail.m
//  DTE
//
//  Created by Divya Jain on 5/16/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "ProductDetail.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FPPopoverController.h"
#import "FPPopoverTableController.h"

@interface ProductDetail ()<FPPopupViewDelegate>

@end
FPPopoverController *popoverQty;
FPPopoverController *popoverWeight;


@implementation ProductDetail
#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performSelector:@selector(setUI) withObject:nil afterDelay:0.4];
    [self updateProductDetails];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUI
{
    btnAddToCart.layer.cornerRadius = 4;
    btnAddToCart.layer.masksToBounds = YES;
    lblProductQuantity.layer.cornerRadius = 4;
    lblProductQuantity.layer.masksToBounds = YES;
    lblProductWeight.layer.cornerRadius = 4;
    lblProductWeight.layer.masksToBounds = YES;

}

-(void)updateProductDetails
{
    NSURL *prodImgURL = [NSURL URLWithString:self.product[@"ImageURL"]];
    [imgProduct sd_setImageWithURL:prodImgURL placeholderImage:nil];
    lblProductName.text = [@" " stringByAppendingString:self.product[@"ProductName"]] ;
    NSArray * productWeights =self.product[@"ProductWeights"];
    NSDictionary* prodWeights = [productWeights objectAtIndex:0];

    lblProductWeight.text = prodWeights[@"Weight"];
    lblProductPrice.text = [@"₹ " stringByAppendingString:prodWeights[@"Price"]];
    lblProductQuantity.text = @"1";
    lblProductAvailability.text = @"In Stock";
    txtProductReview.text = self.product[@"SmallDescription"];
    
}

#pragma mark - Actions

- (IBAction)AddToCartAction:(id)sender {
    ALERT_UnderProcess;

}

- (IBAction)QuantityAction:(id)sender {
//    //the view controller you want to present as popover
//    FPPopoverTableController *controller = [[FPPopoverTableController alloc] init];
//    controller.itemsArr = @[@"1",@"2",@"3"];
//    controller.delegate = self;
//    
//    //our popover
//    popoverQty = [[FPPopoverController alloc] initWithViewController:controller];
//    popoverQty.border = NO;
//    popoverQty.tint = FPPopoverWhiteTint;
//    
//    //the popover will be presented from the okButton view
//    [popoverQty presentPopoverFromView:sender];
    ALERT_UnderProcess;

}

- (IBAction)WeightAction:(id)sender {
//    //the view controller you want to present as popover
//    FPPopoverTableController *controller = [[FPPopoverTableController alloc] init];
//    controller.itemsArr = @[@"1",@"2",@"3"];
//    controller.delegate = self;
//    
//    //our popover
//    popoverWeight = [[FPPopoverController alloc] initWithViewController:controller];
//    popoverWeight.border = NO;
//    popoverWeight.tint = FPPopoverWhiteTint;
//    
//    //the popover will be presented from the okButton view
//    [popoverWeight presentPopoverFromView:sender];
    ALERT_UnderProcess;


}

- (IBAction)BackAction:(id)sender {
    GO_BACK;
}

- (IBAction)SearchProductAction:(id)sender
{
    ALERT_UnderProcess;
}
- (IBAction)CartAction:(id)sender
{
    ALERT_UnderProcess;
}
- (IBAction)SettingsAction:(id)sender
{
    ALERT_UnderProcess;
}

#pragma mark - FPPopover Delegate
//-(void)selectedTableRow:(NSUInteger)rowNum
//{
//    if (popoverWeight) {
//        [popoverWeight dismissPopoverAnimated:YES];
//        lblProductWeight.text = @"";
//
//    }
//    else{
//        [popoverQty dismissPopoverAnimated:YES];
//        lblProductQuantity.text = @"";
//
//    }
//
//}
//

-(void)selectedItem:(NSString *)item selectedRow:(NSUInteger)rowNum
{

}
- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
}

@end
