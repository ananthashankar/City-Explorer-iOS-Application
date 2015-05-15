//
//  MapAnnotationPoint.m
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 4/19/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import "MapAnnotationPoint.h"

@implementation MapAnnotationPoint

@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;

-(id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate  {
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
        
    }
    return self;
}

-(NSString *)title {
    if ([_name isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return _name;
}

-(NSString *)subtitle {
    return _address;
}


@end
