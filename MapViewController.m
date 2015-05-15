//
//  MapViewController.m
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 4/18/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import "MapViewController.h"
#import "DetailViewController.h"

@interface MapViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation MapViewController

CLPlacemark *thePlacemark;
MKRoute *routeDetails;

@synthesize detailInfo;
@synthesize buttonTitle;
@synthesize searchBar;
@synthesize mapView;
@synthesize locationManager;
@synthesize flag;
@synthesize a;
@synthesize b;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction) ];
    
    [[self navigationItem] setLeftBarButtonItem:backButton];
    self.navigationItem.title = @"Click The Below Categories";
    
    self.searchBar.delegate = self;
    self.mapView.delegate = self;
    
    [self.mapView setShowsUserLocation:YES];
    
    locationManager = [[CLLocationManager alloc] init];
    
    [locationManager setDelegate:self];
    
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    if(self.flag == 1){
        
        self.routeCreation;
        
    }
    
   
}

- (void) backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
} */

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    // calculate coordinate and distance between east and west point to set radius
    
    MKMapRect mRect = self.mapView.visibleMapRect;
    MKMapPoint eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect));
    MKMapPoint westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect));
    
    currenDist = MKMetersBetweenMapPoints(eastMapPoint, westMapPoint);
    
    currentCentre = self.mapView.centerCoordinate;
}

// Send url to google
-(void) queryGooglePlaces: (NSString *) googleType {
    
    // Remove any root if exists
    
    [self.mapView removeOverlay:routeDetails.polyline];
    
    // Create String URL
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&keyword=%@&sensor=true&key=%@", currentCentre.latitude, currentCentre.longitude, [NSString stringWithFormat:@"%i", currenDist], googleType, kGOOGLE_API_KEY];
    
    //Convert to URL
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    
    NSLog(@"URL : %@", googleRequestURL);
    
    
    // URL Result.
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}


-(void)fetchedData:(NSData *)responseData {
    //JSON parsing
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    
    //Results in array with key results.
    NSArray* places = [json objectForKey:@"results"];
    
    
  NSLog(@"Google Data: %@", places);
    
    [self plotPositions:places];
}

  - (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1800, 1800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    // Add an annotation to current position
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = @"You're Here!!!!";
   
    
    [self.mapView addAnnotation:point];
}

- (IBAction)menuButtonPressed:(id)sender {
    
    UIButton *button = (UIButton *)sender;
 
 //   self.buttonTitle = @"Nearby ";
 //   self.buttonTitle = [self.buttonTitle stringByAppendingString:[button.titleLabel.text lowercaseString]];
    
    self.buttonTitle = [button.titleLabel.text lowercaseString];
    self.buttonTitle = [self.buttonTitle stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSLog(@"%@", self.buttonTitle);
    [self queryGooglePlaces:self.buttonTitle];
}


/*- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
} */

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.searchBar resignFirstResponder];
    NSLog(@"%@",self.searchBar.text);
    NSString *searchQuery = [self.searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [self queryGooglePlaces:searchQuery];
    
    
  /*  
   
   // Code for implementing search bar result display in maps
   
   CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder geocodeAddressString:self.searchBar.text completionHandler:^(NSArray *placemarks, NSError *error){
        
        // Mark Location and Center
        
        CLPlacemark *placeMark = [placemarks objectAtIndex:0];
        MKCoordinateRegion region;
        CLLocationCoordinate2D newLocation = [placeMark.location coordinate];
        region.center = [(CLCircularRegion *)placeMark.region center];
        
        // Drop Pin
        MKPointAnnotation *annotation = [[ MKPointAnnotation alloc] init];
        [annotation setCoordinate:newLocation];
        [annotation setTitle:self.searchBar.text];
        [self.mapView addAnnotation:annotation];
        
        // Scroll to search result
        MKMapRect mr = [self.mapView visibleMapRect];
        MKMapPoint pt = MKMapPointForCoordinate([annotation coordinate]);
        mr.origin.x = pt.x - mr.size.width * 0.5;
        mr.origin.y = pt.y - mr.size.height * 0.25;
        
        [self.mapView setVisibleMapRect:mr animated:YES];
        
    }]; */
    
}
- (IBAction)clearRoutePressed:(id)sender {
    
    [self.mapView removeOverlay:routeDetails.polyline];
    
}

/*
// implement this
- (IBAction)editEnded:(id)sender{
    [sender resignFirstResponder];
} */

- (IBAction)segmentPress:(id)sender {
    
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)plotPositions:(NSArray *)data {
    
    // Delete previous pins
    for (id<MKAnnotation> annotation in mapView.annotations) {
        if ([annotation isKindOfClass:[MapAnnotationPoint class]]) {
            [mapView removeAnnotation:annotation];
        }
    }
    
    // Extract data from the json parsing with respect to each element
    
    for (int i=0; i<[data count]; i++) {
        NSString *opennow = @"Not Available";
        NSString *rating;
        NSString *priceLevel;
        NSString *fullInfo;
        
        NSDictionary* place = [data objectAtIndex:i];
        
        NSDictionary *geo = [place objectForKey:@"geometry"];
        
        NSDictionary *loc = [geo objectForKey:@"location"];
        
        NSString *name=[place objectForKey:@"name"];
        
        NSString *vicinity=[place objectForKey:@"vicinity"];
        
        NSDictionary *openingHours = [place objectForKey:@"opening_hours"];
        
        if (openingHours != nil){
            opennow = [openingHours objectForKey:@"open_now"];
            if([opennow integerValue] == 0){
                opennow = @"Closed";
            } else {
                opennow = @"Open";
            }
        }
        
        rating = [place objectForKey:@"rating"];
        if(rating == nil){
            rating = @"Not Available";
        }
        
        priceLevel = [place objectForKey:@"price_level"];
        if(priceLevel == nil){
            priceLevel = @"Not Available";
        }
        
        
        fullInfo = @"Name: ";
        fullInfo = [fullInfo stringByAppendingString:name];
        NSString *fullInfo1 = [fullInfo stringByAppendingString:@"\n"];
        fullInfo1 = [fullInfo1 stringByAppendingString:@"Open Now: "];
        fullInfo1 = [fullInfo1 stringByAppendingString:opennow];
        NSString *fullInfo2 = [fullInfo1 stringByAppendingString:@"\n"];
        fullInfo2 = [fullInfo2 stringByAppendingString:@"Price Level: "];
        NSString *fullInfo3 = [NSString stringWithFormat:@"%@%@", fullInfo2,priceLevel];
        NSString *fullInfo4 = [fullInfo3 stringByAppendingString:@"\n"];
        fullInfo4 = [fullInfo4 stringByAppendingString:@"Rating: "];
        NSString *fullInfo5 = [NSString stringWithFormat:@"%@%@", fullInfo4,rating];
        NSString *fullInfo6 = [fullInfo5 stringByAppendingString:@"\n"];
        fullInfo6 = [fullInfo6 stringByAppendingString:@"Address: "];
        fullInfo6 = [fullInfo6 stringByAppendingString:vicinity];
        
        CLLocationCoordinate2D placeCoord;
        
        placeCoord.latitude=[[loc objectForKey:@"lat"] doubleValue];
        placeCoord.longitude=[[loc objectForKey:@"lng"] doubleValue];
        
        // Create and Add Pin
        MapAnnotationPoint *placeObject = [[MapAnnotationPoint alloc] initWithName:name address:fullInfo6 coordinate:placeCoord];
        [mapView addAnnotation:placeObject];
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSString *title;
    NSString *subtitle;
    id <MKAnnotation> annotation = [view annotation];
    
    if ([annotation isKindOfClass:[MapAnnotationPoint class]])
    {
        // Add Place Information to Annotation
        
        title = ((MapAnnotationPoint*)annotation).name;
        NSLog(@"here : %@", title);
        subtitle = ((MapAnnotationPoint*)annotation).address;
        self.detailInfo = ((MapAnnotationPoint*)annotation).address;
        
        CLLocationCoordinate2D placeCoord;
        
        placeCoord.latitude = ((MapAnnotationPoint*)annotation).coordinate.latitude;
        placeCoord.longitude=((MapAnnotationPoint*)annotation).coordinate.longitude;
        
    //  NSDictionary *addressDict1 = [[NSDictionary alloc] init];
        
        NSDictionary *addressDict1 = @{
                                       (NSString *) kABPersonAddressStreetKey : @" ",
                                       (NSString *) kABPersonAddressCityKey : @" ",
                                       (NSString *) kABPersonAddressStateKey : @" ",
                                       (NSString *) kABPersonAddressZIPKey : @" ",
                                       (NSString *) kABPersonAddressCountryKey : @" ",
                                       (NSString *) kABPersonAddressCountryCodeKey : @" "
                                       };
        
        thePlacemark = [[MKPlacemark alloc]initWithCoordinate:placeCoord addressDictionary:addressDict1];
        
        a = placeCoord.latitude;
        b = placeCoord.longitude;
        
        [self performSegueWithIdentifier:@"detailView" sender:self];
        
        
       
    }
    
 /*   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:subtitle delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Get Route", nil];
    [alertView show];  */
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

- (void) routeCreation{
    
    // Plot Route to the Destination
    
  /*  if (buttonIndex == 0) { // Set buttonIndex == 0 to handel "Ok"/"Yes" button response
        // Cancel button response
        NSLog(@"Cancel Pressed");
        thePlacemark = [[MKPlacemark alloc]init];
    } else {
        NSLog(@"OK Pressed"); */
    
    // create placemark
    
    CLLocationCoordinate2D placeCoord;
    
    placeCoord.latitude = a;
    placeCoord.longitude=b;
    
    //  NSDictionary *addressDict1 = [[NSDictionary alloc] init];
    
    NSDictionary *addressDict1 = @{
                                   (NSString *) kABPersonAddressStreetKey : @" ",
                                   (NSString *) kABPersonAddressCityKey : @" ",
                                   (NSString *) kABPersonAddressStateKey : @" ",
                                   (NSString *) kABPersonAddressZIPKey : @" ",
                                   (NSString *) kABPersonAddressCountryKey : @" ",
                                   (NSString *) kABPersonAddressCountryCodeKey : @" "
                                   };
    
    thePlacemark = [[MKPlacemark alloc]initWithCoordinate:placeCoord addressDictionary:addressDict1];
    
/*    MKCoordinateRegion region;
    float spanX = 1.00725;
    float spanY = 1.00725;
    region.center.latitude = thePlacemark.location.coordinate.latitude;
    region.center.longitude = thePlacemark.location.coordinate.longitude;
    region.span = MKCoordinateSpanMake(spanX, spanY);
    [self.mapView setRegion:region animated:YES];
    [self.mapView addAnnotation:thePlacemark];  */
    
    NSLog(@"Info : %@", self.detailInfo);
    
    NSArray *info = [self.detailInfo componentsSeparatedByString:@"\n"];
    
    NSString *name=[info objectAtIndex:0];
    
    MapAnnotationPoint *placeObject = [[MapAnnotationPoint alloc] initWithName:name address:self.detailInfo coordinate:placeCoord];
    [self.mapView addAnnotation:placeObject];
    
    
        for (id<MKAnnotation> annotation in mapView.annotations) {
            if ([annotation isKindOfClass:[MapAnnotationPoint class]]) {
                
                // Remove pins other than selected destination
                
                if(((MapAnnotationPoint*)annotation).coordinate.latitude == thePlacemark.location.coordinate.latitude ||
                   ((MapAnnotationPoint*)annotation).coordinate.longitude == thePlacemark.location.coordinate.longitude){
                    
                    NSLog(@"This Selected Destination Retained");
                    
                } else {
                
                    [mapView removeAnnotation:annotation];
                    
                }
            }
        }
        
        // Draw the root
        
        MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:thePlacemark];
        [directionsRequest setSource:[MKMapItem mapItemForCurrentLocation]];
        [directionsRequest setDestination:[[MKMapItem alloc] initWithPlacemark:placemark]];
        directionsRequest.transportType = MKDirectionsTransportTypeAutomobile;
        MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
        [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
            if (error) {
                NSLog(@"Error %@", error.description);
            } else {
                routeDetails = response.routes.lastObject;
              NSString  *d = [NSString stringWithFormat:@"%0.1f Miles", routeDetails.distance/1609.344];
                NSString *msg =  [d stringByAppendingString:@" away from your current location"];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Distance from Current Location"
                                                                message:msg
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
                [self.mapView addOverlay:routeDetails.polyline];
            }
        }];

}

// root draw support

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    
    MKPolylineRenderer  * routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:routeDetails.polyline];
    routeLineRenderer.strokeColor = [UIColor redColor];
    routeLineRenderer.lineWidth = 5;
    return routeLineRenderer;
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    // Define your reuse identifier.
    static NSString *identifier = @"MapAnnotationPoint";
    
    if ([annotation isKindOfClass:[MapAnnotationPoint class]]) {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = rightButton;
        return annotationView;
    }
    return nil;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"detailView"]){
    DetailViewController *dvc = (DetailViewController*)[segue destinationViewController];
        dvc.detailInfo = self.detailInfo;
        dvc.a = self.a;
        dvc.b = self.b;
    }
    
}


- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
    MKCoordinateRegion region;
    
    
    region = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate,1800,1800);
    
    
    [mv setRegion:region animated:YES];
}

@end
