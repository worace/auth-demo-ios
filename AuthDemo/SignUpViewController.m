//
//  SignUpViewController.m
//  AuthDemo
//
//  Created by Horace Williams on 4/27/14.
//  Copyright (c) 2014 WoracesWorkshop. All rights reserved.
//

#import "SignUpViewController.h"
#import "AuthApiClient.h"
#import "CredentialStore.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)submitLoginInfo:(id)sender {
    AuthApiClient *client = [[AuthApiClient alloc] init];
    [client signUpUserWithUsername:self.userNameField.text withEmail:self.emailField.text withPassword:self.passwordField.text withPwConfirm:self.confirmPasswordField.text success:^(AFHTTPRequestOperation *op, id responseObject) {
        if(op.response.statusCode == 200) {
            [[[CredentialStore alloc] init] setAuthToken:responseObject[@"auth_token"]];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"received non-200 response: %@", responseObject);
        }
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        NSLog(@"error: %@", error);
    }];
}
@end
