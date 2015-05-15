//
//  MapViewController.h
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 4/18/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotationPoint.h"
#import <AddressBook/AddressBook.h>

#define kGOOGLE_API_KEY @"AIzaSyB4E6_hM04ufmL_bwQ-q9wg0jknbR_bPHM"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@interface MapViewController : UIViewController <UISearchBarDelegate, MKMapViewDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>
{

CLLocationManager *locationManager;
CLLocationCoordinate2D currentCentre;
int currenDist;
CLLocationCoordinate2D placeCoord_temp;
    
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSString *buttonTitle;

@property (strong, nonatomic) NSString *detailInfo;
@property (nonatomic) float a;
@property (nonatomic) float b;
@property (nonatomic) NSInteger flag;
-(void) routeCreation;

@end
