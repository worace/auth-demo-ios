//
//  AuthApiClient.m
//  AuthDemo
//
//  Created by Horace Williams on 4/22/14.
//  Copyright (c) 2014 WoracesWorkshop. All rights reserved.
//

#import "AuthApiClient.h"

#import "AFNetworking.h"
#import "AuthDemoConfig.h"


@implementation AuthApiClient

+ (AuthApiClient *)sharedClient {
    NSLog(@"AuthApiClient.sharedClient");
    static AuthApiClient * _sharedClient;
    if (_sharedClient == nil) {
        NSLog(@"shared client is nil, lets make it");
        NSURL *baseUrl = [NSURL URLWithString:[AuthDemoConfig rootUrl]];
        _sharedClient = [[AuthApiClient alloc] initWithBaseURL:baseUrl];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _sharedClient;
};

- (AFHTTPRequestOperation *) getUserInfoWithToken:(NSString *)token completion:(void (^)(NSString *, NSError *))completion {
    return [[[self class] sharedClient] GET:@"api/v1/users/me.json"
                           parameters:@{@"AuthToken":token}
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  if (operation.response.statusCode == 200) {
                                      completion(responseObject, nil);
                                  } else {
                                      NSLog(@"received bad response: %@", responseObject);
                                      NSLog(@"status: %ld", (long)operation.response.statusCode);
                                  }
                                  
                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  completion(nil, error);
                              }];
}

- (AFHTTPRequestOperation *) getUserAuthTokenForEmail:(NSString *)email
                                         withPassword:(NSString *)password
                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    return [[[self class] sharedClient] POST:@"api/v1/auth_tokens.json"
                                  parameters:@{@"email": email, @"password": password}
                                     success:success
                                     failure:failure];
}


- (AFHTTPRequestOperation *) signUpUserWithUsername:(NSString *)username
                                          withEmail:(NSString *)email
                                       withPassword:(NSString *)password
                                      withPwConfirm:(NSString *)pwConfirm
                                            success:(void (^)(AFHTTPRequestOperation *, id))success
                                            failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    return [[[self class] sharedClient] POST:@"api/v1/users.json"
                                  parameters:@{@"username": username, @"email": email, @"password": password, @"password_confirmation":pwConfirm}
                                     success:success
                                     failure:failure];
}


@end
