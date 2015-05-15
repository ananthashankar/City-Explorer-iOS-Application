//
//  RecommendedDetailViewController.m
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 5/1/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import "RecommendedDetailViewController.h"
#import "MapViewController.h"

@interface RecommendedDetailViewController ()

@end

@implementation RecommendedDetailViewController

@synthesize place;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *routeButton = [[UIBarButtonItem alloc]initWithTitle:@"Get Route" style:UIBarButtonItemStylePlain target:self action:@selector(routeAction) ];
    self.navigationItem.rightBarButtonItem = routeButton;
    self.name.text = place.name;
    self.openHours.text = place.openHours;
    NSString *tmp = [NSString stringWithFormat:@"%ld",place.priceLevel];
    self.priceLevel.text = tmp;
    tmp = [NSString stringWithFormat:@"%f",place.rating];
    self.ratings.text = tmp;
    tmp = [NSString stringWithFormat:@"%ld",place.contact];
    self.contact.text = tmp;
    self.website.text = place.website;
    self.reviews.text = place.reviews;
    self.imageView.image = [UIImage imageNamed:place.imageName];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) routeAction{
    
    [self performSegueWithIdentifier:@"recommendedRouteView" sender:self];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"recommendedRouteView"]){
        
        MapViewController *mvc = (MapViewController *)[segue destinationViewController];
        mvc.a = place.latitude;
        mvc.b = place.longitude;
        
        NSString *fullInfo = @"Name: ";
        fullInfo = [fullInfo stringByAppendingString:place.name];
        NSString *fullInfo1 = [fullInfo stringByAppendingString:@"\n"];
        fullInfo1 = [fullInfo1 stringByAppendingString:@"Open Now: "];
        fullInfo1 = [fullInfo1 stringByAppendingString:place.openHours];
        NSString *fullInfo2 = [fullInfo1 stringByAppendingString:@"\n"];
        fullInfo2 = [fullInfo2 stringByAppendingString:@"Price Level: "];
        NSString *fullInfo3 = [NSString stringWithFormat:@"%@%ld", fullInfo2,place.priceLevel];
        NSString *fullInfo4 = [fullInfo3 stringByAppendingString:@"\n"];
        fullInfo4 = [fullInfo4 stringByAppendingString:@"Rating: "];
        NSString *fullInfo5 = [NSString stringWithFormat:@"%@%f", fullInfo4,place.rating];
        NSString *fullInfo6 = [fullInfo5 stringByAppendingString:@"\n"];
        fullInfo6 = [fullInfo6 stringByAppendingString:@"Address: "];
        fullInfo6 = [fullInfo6 stringByAppendingString:place.address];
        
        mvc.detailInfo = fullInfo6;
        mvc.flag = 1;
        
    }
}


@end
