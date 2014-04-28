//
//  AuthApiClient.h
//  AuthDemo
//
//  Created by Horace Williams on 4/22/14.
//  Copyright (c) 2014 WoracesWorkshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface AuthApiClient : AFHTTPSessionManager
+ (id)sharedClient;
- (AFHTTPRequestOperation *)getUserInfoWithToken:(NSString *)token completion:( void(^)(NSString *body, NSError *error) )completion;
- (AFHTTPRequestOperation *)getUserAuthTokenForEmail:(NSString *)email withPassword:(NSString *)password success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
- (AFHTTPRequestOperation *)signUpUserWithUsername:(NSString *)username
                                         withEmail:(NSString *)email
                                      withPassword:(NSString *)password
                                     withPwConfirm:(NSString *)pwConfirm
                                           success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
@end