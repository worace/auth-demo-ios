//
//  AuthDemoViewController.m
//  AuthDemo
//
//  Created by Horace Williams on 4/22/14.
//  Copyright (c) 2014 WoracesWorkshop. All rights reserved.
//

#import "AuthDemoViewController.h"
#import "CredentialStore.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "AuthApiClient.h"

@interface AuthDemoViewController ()
@property (nonatomic, strong) CredentialStore *credentialStore;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@end

@implementation AuthDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.credentialStore = [[CredentialStore alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"will appear!");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)fetchMessage:(id)sender {
    if ([self.credentialStore isLoggedIn]) {
        self.messageTextView.text = @"";
        NSLog(@"attempting to fetch message");
        [SVProgressHUD show];
        [[[AuthApiClient alloc] init] getUserInfoWithToken:[self.credentialStore authToken]
                                                completion:^(NSString *body, NSError *error) {
                                                    if(error) {
                                                        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"Something went wrong: %@", error]];
                                                    } else if(body){
                                                        self.messageTextView.text = [NSString stringWithFormat:@"response: %@", body];
                                                        [SVProgressHUD dismiss];
                                                    } else {
                                                        [SVProgressHUD showErrorWithStatus:@"Dunno!?"];
                                                    }
                                                }];

    } else {
        NSLog(@"not logged in, segueing to login");
        [self performSegueWithIdentifier:@"LoginRequired" sender:self];
    }
}


- (IBAction)clearCredentials:(id)sender {
    [[[CredentialStore alloc] init] clearSavedCredentials];
    self.messageTextView.text = @"";
}


@end
