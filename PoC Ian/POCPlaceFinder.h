//
//  POCPlaceFinder.h
//  PoC Ian
//
//  Created by Ian Carvalho on 17/04/15.
//  Copyright (c) 2015 Ian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <RestKit/RestKit.h>
#import "POCPlace.h"

@protocol POCPlaceFinderDelegate;

@interface POCPlaceFinder : NSObject

@property (strong, nonatomic) NSArray *places;
@property (weak) id<POCPlaceFinderDelegate> delegate;

- (void)searchPlacesFromLocation:(CLLocation *)location;
- (void)searchWithURLString:(NSString *)urlString andDescriptor:(RKResponseDescriptor *)responseDescriptor;
- (void) setUp;
- (NSString *)requestURLForLocation:(CLLocation *)location;
- (RKResponseDescriptor *)responseDescriptor;
@end

@protocol POCPlaceFinderDelegate <NSObject>

@required
- (void)placeFinder:(POCPlaceFinder*) finder foundPlaces:(NSArray *) places;


@end