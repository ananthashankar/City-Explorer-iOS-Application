//
//  LoginViewController.m
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 5/1/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import "LoginViewController.h"
#import "DBManager.h"
#import "SignUpViewController.h"

@interface LoginViewController ()

@property(nonatomic, strong) DBManager *dbm;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.adBanner.delegate = self;
    
    // Hiding ad banner.
    self.adBanner.alpha = 0.0;
    
    self.dbm = [[DBManager alloc] initWithDatabaseFilename:@"FINAL_PROJECT.sql"];
    
    
}
- (IBAction)exit:(id)sender {
    
    exit(0);
    
}

-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner will load ad.");
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner did load ad.");
    
    // Display Ad.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 1.0;
    }];
    
}

-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    NSLog(@"Ad Banner action is about to begin.");
    
    return YES;
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad Banner action did finish");
    
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Error: %@", [error localizedDescription]);
    
    // Hide on error.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 0.0;
    }];
    
}

- (IBAction)loginPressed:(id)sender {
    
    
    NSString *query = [NSString stringWithFormat:@"select * from profile where userName = '%@' and password = '%@'", self.userName.text, self.password.text];
    
    NSArray *dbData = [[NSArray alloc] initWithArray:[self.dbm loadDataFromDB:query]];
    
    if(dbData.count > 0){
        [self performSegueWithIdentifier:@"loginView" sender:self];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Message"
                                                        message:@"Please Enter Valid Credentials"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        self.userName.text = @"";
        self.password.text = @"";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"signUpView"]){
        SignUpViewController *svc = (SignUpViewController*)[segue destinationViewController];
        svc.dbm = self.dbm;
        
        
    }
}


@end
