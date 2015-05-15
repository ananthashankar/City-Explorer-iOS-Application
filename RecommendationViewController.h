//
//  RecommendationViewController.h
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 5/1/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "PlacesInfo.h"

@interface RecommendationViewController : UIViewController

@property(strong, nonatomic) DBManager *dbm;
@property(strong, nonatomic) NSString *category;
@property(strong, nonatomic) PlacesInfo *placesInfo;

@end
