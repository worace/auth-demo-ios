//
//  LoginViewController.m
//  AuthDemo
//
//  Created by Horace Williams on 4/22/14.
//  Copyright (c) 2014 WoracesWorkshop. All rights reserved.
//

#import "LoginViewController.h"
#import "AuthApiClient.h"
#import "CredentialStore.h"
#import "SVProgressHUD.h"

@interface LoginViewController ()
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)submitLoginInfo:(id)sender {
    NSLog(@"submitted login");
    NSString *email = self.emailField.text;
    NSString *password = self.passwordField.text;
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [SVProgressHUD show];
    AuthApiClient *client = [[AuthApiClient alloc] init];
    [client getUserAuthTokenForEmail:email
                        withPassword:password
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 NSLog(@"success");
                                 NSLog(@"response: %@", responseObject);
                                 NSLog(@"token: %@", responseObject[@"auth_token"]);
                                 [[[CredentialStore alloc] init] setAuthToken:responseObject[@"auth_token"]];
                                 [SVProgressHUD dismiss];
                                 [self.navigationController popViewControllerAnimated:YES];
                             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 NSLog(@"failure");
                                 NSLog(@"error: %@", error);
                                 [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"Something went wrong: %@", error]];
                             }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
