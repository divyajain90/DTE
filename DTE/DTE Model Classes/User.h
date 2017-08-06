//
//  User.h
//  DTE
//
//  Created by Divya Jain on 5/8/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//


//{"CustomerId":8865,"CustomerName":"divya jain","CustomerGuid":"572e7aec-52c4-458b-9df9-604e5fdddedb","Msg":"Registration successfully done.","ShippingAddress":[],"BillingAddress":[{"AddressId":13099,"CustomerId":8865,"IsBillingAddress":true,"FirstName":"divya","LastName":"","PhoneNumber":"9461573514","Email":"p@gmail.com","Address1":"","Address2":"","City":"","StateProvinceId":217,"StateProvince":"Rajasthan","ZipPostalCode":"","CreatedOn":"\/Date(1494224218787)\/","UpdatedOn":"\/Date(1494224218787)\/","PhoneCountryCode":"","PhoneStdCode":"","MobileNo":""}]}


#define UserDefaultsUserKey @"user"


#define CustomerId @"CustomerId"
#define CustomerName @"CustomerName"
#define CustomerGuid @"CustomerGuid"
#define ShippingAddress @"ShippingAddress"
#define BillingAddress @"BillingAddress"



#define BillingAddressId @"AddressId"
#define BillingCustomerId @"CustomerId"
#define BillingIsBillingAddress @"IsBillingAddress"
#define BillingFirstName @"FirstName"
#define BillingLastName @"LastName"
#define BillingPhoneNumber @"PhoneNumber"
#define BillingEmail @"Email"
#define BillingAddress1 @"Address1"
#define BillingAddress2 @"Address2"
#define BillingCity @"City"
#define BillingStateProvinceId @"StateProvinceId"
#define BillingZipPostalCode @"ZipPostalCode"
#define BillingCreatedOn @"CreatedOn"
#define BillingUpdatedOn @"UpdatedOn"
#define BillingPhoneCountryCode @"PhoneCountryCode"
#define BillingPhoneStdCode @"PhoneStdCode"
#define BillingMobileNo @"MobileNo"





#import <Foundation/Foundation.h>
typedef void(^userInfoCompletion)(NSError*error,NSDictionary* res);

@interface User : NSObject
@property (assign)BOOL isLoggedIn;

//parameters for Sign Up
@property(nonatomic,strong)NSString* fName;
@property(nonatomic,strong)NSString* email;
@property(nonatomic,strong)NSString* lName;
@property(nonatomic,strong)NSString* mobile;
@property(nonatomic,strong)NSString* password;

// parameters in signUP response
@property(nonatomic,strong)NSString* customerName;
@property(nonatomic,strong)NSString* customerGuid;
@property(nonatomic,strong)NSString* customerId;
@property(nonatomic,strong)NSDictionary* shippingAddress;
@property(nonatomic,strong)NSArray* billingAddress;

//@property(nonatomic,strong)NSString* billingFirstName;
//@property(nonatomic,strong)NSString* billingLastName;
//@property(nonatomic,strong)NSString* billingAddressId;
//@property(nonatomic,strong)NSString* billingCustomerId;



@property(nonatomic,strong)NSMutableDictionary*response;
@property (copy, nonatomic) userInfoCompletion completeUserInfo;

+(instancetype)sharedUser;
-(void)signUP:(User*)user withCompletionBlock:(userInfoCompletion)completionBlock;
-(void)signIn:(User*)user WithCompletionBlock:(userInfoCompletion)completionBlock;
- (void)saveUser;
-(void)logout;

//-(void)signUpWithCompletionBlock:(signUPCompletion)completionBlock;

//-(void)signUP:(User*)user spinner:(BOOL)spinner withCompletionBlock:(signUPCompletion)completionBlock;

@end
