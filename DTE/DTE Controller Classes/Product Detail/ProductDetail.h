//
//  ProductDetail.h
//  DTE
//
//  Created by Divya Jain on 5/16/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetail : UIViewController
{
    __weak IBOutlet UIImageView *imgProduct;
    __weak IBOutlet UILabel *lblProductName;
    __weak IBOutlet UILabel *lblProductPrice;
    __weak IBOutlet UILabel *lblProductAvailability;
    __weak IBOutlet UITextView *txtProductReview;
    __weak IBOutlet UILabel *lblProductQuantity;
    __weak IBOutlet UILabel *lblProductWeight;
    __weak IBOutlet UIButton *btnAddToCart;
    
}
@property(nonatomic, strong) NSDictionary*product;
- (IBAction)AddToCartAction:(id)sender;
- (IBAction)QuantityAction:(id)sender;
- (IBAction)WeightAction:(id)sender;
- (IBAction)BackAction:(id)sender;
- (IBAction)SearchProductAction:(id)sender;
- (IBAction)CartAction:(id)sender;
- (IBAction)SettingsAction:(id)sender;

@end
