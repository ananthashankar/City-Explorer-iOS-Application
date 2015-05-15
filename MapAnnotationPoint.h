//
//  MapAnnotationPoint.h
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 4/19/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotationPoint : NSObject <MKAnnotation>
{
    
    NSString *_name;
    NSString *_address;
    CLLocationCoordinate2D _coordinate;
    
}

@property (copy) NSString *name;
@property (copy) NSString *address;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end
