//
//  Utility.h
//  AtmelApp
//
//  Created by Divya Jain on 7/18/16.
//  Copyright © 2016 Divya Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject
+(void)showHUDOnView:(UIView*)view;
+(void)hideHUDOnView:(UIView*)view;
+(void)showMessage:(NSString*)message OnView:(UIView*)view;
+(void)showHUDWithMessage:(NSString*)message OnView:(UIView*)view;
+(NSString*)getDateInStringFromDate:(NSDate*)date WithDataFormat:(NSString*)dateFormat;

@end
