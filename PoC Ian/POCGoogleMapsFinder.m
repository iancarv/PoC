//
//  POCGoogleMapsFinder.m
//  PoC Ian
//
//  Created by Ian Carvalho on 19/04/15.
//  Copyright (c) 2015 Ian. All rights reserved.
//

#import "POCGoogleMapsFinder.h"

#define kGoogleMapRadius 1000

@interface POCGoogleMapsFinder ()

@property (strong, nonatomic) NSString *clientKey;

@end

@implementation POCGoogleMapsFinder

//https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&types=food&name=harbour&sensor=false&key=AIzaSyBK1mBjSuIZqqA79Y8foYKQDdQYEUUCsu4



- (NSString *)requestURLForLocation:(CLLocation *)location {
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=%d&sensor=false&key=%@", location.coordinate.latitude, location.coordinate.longitude, kGoogleMapRadius, _clientKey];
    return urlString;
}

- (RKResponseDescriptor *)responseDescriptor {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[POCPlace class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"name":   @"name",
                                                  @"geometry.location.lat":     @"latitude",
                                                  @"geometry.location.lng":        @"longitude"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:@"/maps/api/place/nearbysearch/json"  keyPath:@"results" statusCodes:nil];
    return responseDescriptor;
}

-(void)setUp {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ApiKeys" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
#warning Adicionar proprias chaves no arquivo ApiKeys.plist
    _clientKey = [dict objectForKey:@"kGoogleMapKey"];
}

@end
