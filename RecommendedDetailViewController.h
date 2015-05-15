//
//  RecommendedDetailViewController.h
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 5/1/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlacesInfo.h"

@interface RecommendedDetailViewController : UIViewController

@property(strong, nonatomic) PlacesInfo *place;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *openHours;
@property (weak, nonatomic) IBOutlet UITextField *priceLevel;
@property (weak, nonatomic) IBOutlet UITextField *ratings;
@property (weak, nonatomic) IBOutlet UITextField *contact;
@property (weak, nonatomic) IBOutlet UITextField *website;

@property (weak, nonatomic) IBOutlet UITextView *reviews;

@end
