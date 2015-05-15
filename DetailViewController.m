//
//  DetailViewController.m
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 4/22/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import "DetailViewController.h"
#import "MapViewController.h"

@interface DetailViewController ()


@end

@implementation DetailViewController

@synthesize a;
@synthesize b;

//CLPlacemark *thePlacemark;
@synthesize detailInfo;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.adBanner.delegate = self;
    
    // Hiding ad banner.
    self.adBanner.alpha = 0.0;
    

    
    
    NSArray *info = [self.detailInfo componentsSeparatedByString:@"\n"];
    
    NSLog(@"%@", detailInfo);
    
    self.name.text = (NSString*)[info objectAtIndex:0];
    self.openNow.text = (NSString*)[info objectAtIndex:1];
    self.priceLevel.text = (NSString*)[info objectAtIndex:2];
    self.rating.text = (NSString*)[info objectAtIndex:3];
    self.address.text = (NSString*)[info objectAtIndex:4];
    
    
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"getRoute"]){
        MapViewController *mvc = (MapViewController*)[segue destinationViewController];
        mvc.flag = 1;
        mvc.a = self.a;
        mvc.b = self.b;
        mvc.detailInfo = self.detailInfo;
    }
    
}


@end
