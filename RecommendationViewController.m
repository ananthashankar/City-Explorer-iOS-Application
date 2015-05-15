//
//  RecommendationViewController.m
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 5/1/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import "RecommendationViewController.h"
#import "TableViewController.h"

@interface RecommendationViewController ()

@end

@implementation RecommendationViewController
NSMutableArray *places;
@synthesize dbm;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dbm = [[DBManager alloc] initWithDatabaseFilename:@"FINAL_PROJECT.sql"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)categorySearchPressed:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    //   self.buttonTitle = @"Nearby ";
    //   self.buttonTitle = [self.buttonTitle stringByAppendingString:[button.titleLabel.text lowercaseString]];
    
    self.category = [button.titleLabel.text lowercaseString];
    
    
    
    NSString *query = [NSString stringWithFormat:@"select * from recommendations where category='%@'", self.category];
    
    NSArray *dbData = [[NSArray alloc] initWithArray:[self.dbm loadDataFromDB:query]];
    
    
    NSLog(@"%ld", dbData.count);
    
    if(dbData.count > 0){
        places = [[NSMutableArray alloc]init];
        for(int i = 0; i < dbData.count; i++){
            self.placesInfo = [[PlacesInfo alloc]init];
            self.placesInfo.name = [[dbData objectAtIndex:i] objectAtIndex:0];
            self.placesInfo.openHours = [[dbData objectAtIndex:i]objectAtIndex:1];
            self.placesInfo.priceLevel = [[[dbData objectAtIndex:i]objectAtIndex:2] integerValue];
            self.placesInfo.rating = [[[dbData objectAtIndex:i]objectAtIndex:3] floatValue];
            self.placesInfo.address = [[dbData objectAtIndex:i]objectAtIndex:4];
            self.placesInfo.latitude = [[[dbData objectAtIndex:i]objectAtIndex:5] floatValue];
            self.placesInfo.longitude = [[[dbData objectAtIndex:i]objectAtIndex:6] floatValue];
            self.placesInfo.reviews = [[dbData objectAtIndex:i]objectAtIndex:7];
            self.placesInfo.imageName = [[dbData objectAtIndex:i]objectAtIndex:8];
            self.placesInfo.contact = [[[dbData objectAtIndex:i]objectAtIndex:9] integerValue];
            self.placesInfo.website = [[dbData objectAtIndex:i]objectAtIndex:10];
            self.placesInfo.category = [[dbData objectAtIndex:i]objectAtIndex:11];
            
            [places addObject:self.placesInfo];
            NSLog(@"%ld", places.count);
        }
        
        [self performSegueWithIdentifier:@"tablelistView" sender:self];
    }
    
    
    
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    if([segue.identifier isEqualToString:@"tablelistView"]){
        UINavigationController *lvc = (UINavigationController *)[segue destinationViewController];
        TableViewController *tvc = (TableViewController*)lvc.viewControllers[0];
        tvc.places = places;
    }
}


@end
