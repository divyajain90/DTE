//
//  APIManager.h
//  DTE
//
//  Created by Divya Jain on 5/8/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^APIinfoCompletionBlock)(_Nullable id response,NSError *_Nullable error );

@interface APIManager : AFHTTPSessionManager

@property(nonatomic,strong) NSArray* categories;



+(instancetype)sharedManager;
+(BOOL)isNetworkAvailable;

-(void)registerUser:(User*)user completionBlock:(APIinfoCompletionBlock)block;

-(void)signInUser:(User*)user completionBlock:(APIinfoCompletionBlock)block;

-(void)getAllCategories;
-(void)getAllCategoriesWithCompletionHandler:(APIinfoCompletionBlock)block;

-(void)getProductsByCategoryID:(NSString*)categoryID withCompletionBlock:(APIinfoCompletionBlock)block;
-(void)getProductDetailByProductID:(NSString*)productID withCompletionBlock:(APIinfoCompletionBlock)block;
@end
NS_ASSUME_NONNULL_END
