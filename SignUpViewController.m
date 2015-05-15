//
//  SignUpViewController.m
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 5/1/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import "SignUpViewController.h"
#import "RecommendationViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize dbm;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createProfilePressed:(id)sender {

    if([[self.name text]  length]==0 || [[self.phone text]  length]==0 || [[self.email text]  length]==0 || [[self.userName text]  length]==0 || [[self.password text]length]==0){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Invalid Input Values"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    } else {
        
        NSString *query = [NSString stringWithFormat:@"select * from profile where userName='%@' and password = '%@'", self.userName.text, self.password.text];
        
        NSArray *dbData = [[NSArray alloc] initWithArray:[self.dbm loadDataFromDB:query]];
        if(dbData.count > 0){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"UserName Already Exists"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

            
        } else {
            
            NSString *query = [NSString stringWithFormat:@"insert into profile values('%@', '%ld', '%@', '%@', '%@')", self.name.text, [self.phone.text integerValue], self.email.text, self.userName.text, self.password.text];
            [self.dbm executeQuery:query];
            
            [self performSegueWithIdentifier:@"recommendationView" sender:self];
            
        }
    }

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"signUpView"]){
        RecommendationViewController *rvc = (RecommendationViewController*)[segue destinationViewController];
        rvc.dbm = self.dbm;
        
        
    }
}

@end
