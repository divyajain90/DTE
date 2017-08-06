//
//  Utility.m
//  AtmelApp
//
//  Created by Divya Jain on 7/18/16.
//  Copyright © 2016 Divya Jain. All rights reserved.
//

#import "Utility.h"
#import "MBProgressHUD.h"
@implementation Utility

#pragma mark - HUD utility methods
+(void)showHUDOnView:(UIView*)view
{
    [MBProgressHUD showHUDAddedTo:view animated:YES];

}

+(void)hideHUDOnView:(UIView*)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}


+(void)showMessage:(NSString*)message OnView:(UIView*)view
{
    
    MBProgressHUD * hud =  [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
//    hud.yOffset = CGRectGetHeight(view.frame) - 100; //For bottom location.
    [hud hide:YES afterDelay:1.0];


}
+(void)showHUDWithMessage:(NSString*)message OnView:(UIView*)view
{
    MBProgressHUD * hud =  [MBProgressHUD showHUDAddedTo:view animated:YES];

    hud.labelText = message;

}

#pragma mark - date formatting methods
+(NSString*)getDateInStringFromDate:(NSDate*)date WithDataFormat:(NSString*)dateFormat
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return  [dateFormatter stringFromDate:date];
}

@end
