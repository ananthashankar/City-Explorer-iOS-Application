//
//  PlacesInfo.h
//  Anantha Shankar Arun Kumar Assignment8
//
//  Created by Anantha Shankar Arun Kumar on 5/1/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlacesInfo : NSObject
{
    
    NSString *name;
    NSString *openHours;
    NSInteger priceLevel;
    float rating;
    NSString *address;
    float latitude;
    float longitude;
    NSString *reviews;
    NSString *imageName;
    NSInteger contact;
    NSString *website;
    NSString *category;
    
}

@property NSString *name;
@property NSString *openHours;
@property NSInteger priceLevel;
@property float rating;
@property NSString *address;
@property float latitude;
@property float longitude;
@property NSString *reviews;
@property NSString *imageName;
@property NSInteger contact;
@property NSString *website;
@property NSString *category;


@end
