//
//  CredentialStore.m
//  AuthDemo
//
//  Created by Horace Williams on 4/22/14.
//  Copyright (c) 2014 WoracesWorkshop. All rights reserved.
//

#import "CredentialStore.h"
#import "SSKeychain.h"

#define SERVICE_NAME @"AuthDemo"
#define AUTH_TOKEN_KEY @"AuthToken"

@implementation CredentialStore

- (BOOL)isLoggedIn {
    return [self authToken] != nil;
}

- (void)clearSavedCredentials {
    NSLog(@"clearing credentials");
    [SSKeychain deletePasswordForService:SERVICE_NAME account:AUTH_TOKEN_KEY];
}

- (NSString *)authToken {
    return [SSKeychain passwordForService:SERVICE_NAME account:AUTH_TOKEN_KEY];
}

- (void)setAuthToken:(NSString *)authToken {
    [SSKeychain setPassword:authToken
                 forService:SERVICE_NAME
                    account:AUTH_TOKEN_KEY];
}

@end
