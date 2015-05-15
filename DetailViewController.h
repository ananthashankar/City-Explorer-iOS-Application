//
//  DetailViewController.h
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 4/22/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <iAd/iAd.h>

@interface DetailViewController : UIViewController <CLLocationManagerDelegate, ADBannerViewDelegate>

{
CLPlacemark *thePlacemark;
}
@property(strong, nonatomic) NSString *detailInfo;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *openNow;
@property (weak, nonatomic) IBOutlet UITextField *priceLevel;
@property (weak, nonatomic) IBOutlet UITextField *rating;
@property (weak, nonatomic) IBOutlet UITextView *address;
@property (nonatomic) float a;
@property (nonatomic) float b;


@property (weak, nonatomic) IBOutlet ADBannerView *adBanner;



@end
