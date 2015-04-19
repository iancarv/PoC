//
//  POCFourSquareFinder.m
//  PoC Ian
//
//  Created by Ian Carvalho on 17/04/15.
//  Copyright (c) 2015 Ian. All rights reserved.
//

#import "POCFourSquareFinder.h"
#import <RestKit/RestKit.h>

@interface POCFourSquareFinder ()

@property (strong, nonatomic) NSString *clientID;
@property (strong, nonatomic) NSString *clientSecret;

@end

@implementation POCFourSquareFinder

- (void)searchPlacesFromLocation:(CLLocation *)location {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[POCPlace class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"name":   @"name",
                                                  @"location.lat":     @"latitude",
                                                  @"location.lng":        @"longitude"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:@"/v2/venues/search"  keyPath:@"response.venues" statusCodes:nil];
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%f,%f&client_id=%@&client_secret=%@&v=20140806", location.coordinate.latitude, location.coordinate.longitude, _clientID, _clientSecret];
    
    [self searchWithURLString:urlString andDescriptor:responseDescriptor];

}




-(void)setUp {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ApiKeys" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    _clientID = [dict objectForKey:@"kFourSquareClientId"];
    _clientSecret = [dict objectForKey:@"kFourSquareClientSecret"];
}

@end
