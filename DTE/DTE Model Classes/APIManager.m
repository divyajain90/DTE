//
//  APIManager.m
//  DTE
//
//  Created by Divya Jain on 5/8/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "APIManager.h"
#import "Reachability.h"
@implementation APIManager

+(instancetype)sharedManager
{
    static APIManager*sharedManager = nil;
    static dispatch_once_t onceToken;
    
    // execute initialization exactly once
    dispatch_once(&onceToken, ^{
        sharedManager = [[APIManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://demo.downtoearthorganicfood.com/"]];
    });
    return sharedManager;
}

-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
        self.categories = [[NSArray alloc] init];

    }
    return self;
}

-(void)registerUser:(User*)user completionBlock:(APIinfoCompletionBlock)block
{
    NSString *requestURL =[NSString stringWithFormat:@"MobServiceAPI.ashx?Method=Register&Email=%@&password=%@&FirstName=%@&LastName=%@&Mobile=%@",user.email,user.password,user.fName,user.lName,user.mobile];

    [self POSTInfoRequestWithUrlString:requestURL userINFO:user completionBlock:block];
}


-(void)signInUser:(User*)user completionBlock:(APIinfoCompletionBlock)block
{
    NSString *requestURL =[NSString stringWithFormat:@"MobServiceAPI.ashx?Method=Login&Email=%@&password=%@",user.email,user.password];
    [self POSTInfoRequestWithUrlString:requestURL userINFO:user completionBlock:block];


}

-(void)POSTInfoRequestWithUrlString:(NSString*)urlString userINFO:(User*)user completionBlock:(APIinfoCompletionBlock)block
{

    [self POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block(responseObject, nil);
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil, error);
        }

    }];

}


-(void)getAllCategories
{
    NSString *requestURL =[NSString stringWithFormat:@"MobServiceAPI.ashx?Method=GetAllCategories"];
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:nil];

}


-(void)getAllCategoriesWithCompletionHandler:(APIinfoCompletionBlock)block
{
    NSString *requestURL =[NSString stringWithFormat:@"MobServiceAPI.ashx?Method=GetAllCategories"];
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];
    
}


-(void)getProductsByCategoryID:(NSString*)categoryID withCompletionBlock:(APIinfoCompletionBlock)block
{
    NSString *requestURL =[NSString stringWithFormat:@"MobServiceAPI.ashx?Method=GetProductsByCategoryId&CategoryId=%@",categoryID];
    
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];

}

-(void)getProductDetailByProductID:(NSString*)productID withCompletionBlock:(APIinfoCompletionBlock)block
{
    NSString *requestURL =[NSString stringWithFormat:@"MobServiceAPI.ashx?Method=GetProductDetailByByProductId&ProductId=%@",productID];
    
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];


}


-(void)addToCart
{
}

-(void)GetCartByCustomerId
{


}

-(void)GETInfoRequestWithURLString:(NSString*)urlString param:(NSDictionary*)param completionBlock:(APIinfoCompletionBlock)block
{

    [self GET:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    if ([urlString isEqualToString:@"MobServiceAPI.ashx?Method=GetAllCategories"]) {
        self.categories = responseObject;
    }
    if (block) {
        block(responseObject, nil);
    }

    
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (block) {
        block(nil, error);
    }

}];

}
+(BOOL)isNetworkAvailable
{
    
    BOOL isOnline = YES;
    // check if we've got network connectivity
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    
    switch (myStatus) {
        case NotReachable:
            NSLog(@"There's no internet connection at all. Display error message now.");
            isOnline = NO;
            break;
            
        case ReachableViaWWAN:
            //            NSLog(@"We have a 3G connection");
            break;
            
        case ReachableViaWiFi:
            //            NSLog(@"We have WiFi.");
            break;
            
        default:
            break;
    }
    return isOnline;
    
}


@end
