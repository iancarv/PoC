//
//  POCPlaceFinder.m
//  PoC Ian
//
//  Created by Ian Carvalho on 17/04/15.
//  Copyright (c) 2015 Ian. All rights reserved.
//

#import "POCPlaceFinder.h"
#import <RestKit/RestKit.h>

@interface POCPlaceFinder ()


@end


@implementation POCPlaceFinder

- (id)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)searchPlacesFromLocation:(CLLocation *)location {
    
}

- (void)setUp {
    
}

- (void)searchWithURLString:(NSString *)urlString andDescriptor:(RKResponseDescriptor *)responseDescriptor {
    NSLog(@"comecou");
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        [self.delegate placeFinder:self foundPlaces:[result array]];
        NSLog(@"terminou");
    } failure:nil];
    [operation start];
}


@end
