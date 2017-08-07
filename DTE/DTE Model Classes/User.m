//
//  User.m
//  DTE
//
//  Created by Divya Jain on 5/8/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//
#import "User.h"

@implementation User
@synthesize fName;
@synthesize lName;
@synthesize email;
@synthesize mobile;
@synthesize password;
@synthesize customerId;
@synthesize customerName;
@synthesize customerGuid;
@synthesize shippingAddress;
@synthesize billingAddress;


+(instancetype)sharedUser
{
    static User*sharedUser = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (sharedUser == nil)
        {
            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultsUserKey];
            if (data != nil)
            {
                sharedUser = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                if (sharedUser == nil)
                {
                    sharedUser = [[self alloc] init];
                }
                
            } else {
                sharedUser = [[self alloc] init];
            }
        }
    });
    
    return sharedUser;
}

-(id)init
{
    if (self = [super init]) {
        customerName = nil;
        fName = nil;
        lName = nil;
        email = nil;
        mobile = nil;
        password= nil;
        customerId= nil;
        customerGuid = nil;
        shippingAddress=nil;
        billingAddress= nil;
        self.isLoggedIn = false;
        NSLog(@"Hello World");

    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    
    if (copy) {
        
        [copy setFName:[self.fName copyWithZone:zone]];
        [copy setLName:[self.lName copyWithZone:zone]];
        [copy setEmail:[self.email copyWithZone:zone]];
        [copy setMobile:[self.mobile copyWithZone:zone]];
        [copy setPassword:[self.password copyWithZone:zone]];
        [copy setCustomerId:[self.customerId copyWithZone:zone]];
        [copy setCustomerName:[self.customerName copyWithZone:zone]];
        
    }
    
    return copy;
}
- (void)encodeWithCoder:(NSCoder *)coder;
{
//    [coder encodeObject:itemId forKey:@"itemId"];
//       [coder encodeInt:promptForPrice forKey:@"promptforprice"];
//    [coder encodeFloat:itemCost forKey:@"itemcost"];
//        [coder encodeBool:receiveAlert forKey:@"receivealert"];
//    [coder encodeObject:supplierName forKey:@"suppliername"];
    
    
    [coder encodeObject:fName forKey:@"fName"];
    [coder encodeObject:lName forKey:@"lName"];
    [coder encodeObject:mobile forKey:@"mobile"];
    [coder encodeObject:email forKey:@"email"];
    [coder encodeObject:password forKey:@"password"];
    [coder encodeObject:customerId forKey:@"ID"];
    [coder encodeObject:customerName forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    
    if (self != nil)
    {
//        itemId = [coder decodeObjectForKey:@"itemId"];
//        price = [coder decodeFloatForKey:@"price"];
        
        fName = [coder decodeObjectForKey:@"fName"];
        lName = [coder decodeObjectForKey:@"lName"];
        mobile = [coder decodeObjectForKey:@"mobile"];
        email = [coder decodeObjectForKey:@"email"];
        password = [coder decodeObjectForKey:@"password"];
        customerId = [coder decodeObjectForKey:@"ID"];
        customerName = [coder decodeObjectForKey:@"name"];
    }
    
    return self;
}

-(void)signUP:(User*)user withCompletionBlock:(userInfoCompletion)completionBlock;
{
    self.completeUserInfo = completionBlock;
    if (self.completeUserInfo) {
        [[APIManager sharedManager] registerUser:self completionBlock:^(id  _Nullable response, NSError * _Nullable error) {
            if (error) {
            self.completeUserInfo(error,nil);
   
            }
            else
            {
                NSDictionary* userDict = [response mutableCopy];
                user.customerId =userDict[CustomerId];
                user.customerName = userDict[CustomerName];
                user.customerGuid = userDict[CustomerGuid];
                user.shippingAddress = userDict[ShippingAddress];
                user.billingAddress = userDict[BillingAddress];
                self.completeUserInfo(nil,response);
            }
        }];
    }
//    self.completeUserInfo = nil;
}

-(void)logout
{
    [self clearUser];
}


- (void)clearUser {
    // reset all user data
    customerName = nil;
    fName = nil;
    lName = nil;
    email = nil;
    mobile = nil;
    password= nil;
    customerId= nil;
    customerGuid = nil;
    shippingAddress=nil;
    billingAddress= nil;
    self.isLoggedIn = false;

    // save changes
    [self saveUser];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMenu" object:nil];
}

-(void)signIn:(User*)user WithCompletionBlock:(userInfoCompletion)completionBlock
{
    self.completeUserInfo = completionBlock;
    if (self.completeUserInfo) {
        [[APIManager sharedManager]signInUser:self completionBlock:^(id  _Nullable response, NSError * _Nullable error) {
            if (error) {
                self.completeUserInfo(error,nil);

            }
            else{
                NSDictionary* userDict = [response mutableCopy];
                
                if ([response[@"Msg"] isEqualToString:@"1"]) {
                    
                    user.customerId =userDict[CustomerId];
                    user.customerName = userDict[CustomerName];
                    user.customerGuid = userDict[CustomerGuid];
                    user.shippingAddress = userDict[ShippingAddress];
                    
                    user.billingAddress = userDict[BillingAddress];
                    NSDictionary *billingDetails = user.billingAddress[0];
                    user.fName = billingDetails[BillingFirstName];
                    user.lName = billingDetails[BillingLastName];
                    user.mobile = billingDetails[BillingMobileNo];
                    user.email = billingDetails[BillingEmail];


                    [self saveUser];

                    user.isLoggedIn = true;

                }
                self.completeUserInfo(nil,response);

            }
        }];
    }

}



- (void)saveUser {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
        [GET_DEFAULTS setObject:data forKey:UserDefaultsUserKey];
        [GET_DEFAULTS synchronize];
    
//    KeychainItemWrapper *keychain =
//    [[KeychainItemWrapper alloc] initWithIdentifier:@"DTEAppLoginData" accessGroup:nil];
//    [keychain setObject:self.email forKey:(id)kSecAttrAccount];
//
//    [keychain setObject:self.password forKey:(id)kSecValueData];

    
    // [[NSNotificationCenter defaultCenter] BFN_postAsyncNotificationName:BFUserDidSaveNotification];
    }


@end
