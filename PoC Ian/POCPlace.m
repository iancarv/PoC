//
//  POCPlace.m
//  PoC Ian
//
//  Created by Ian Carvalho on 18/04/15.
//  Copyright (c) 2015 Ian. All rights reserved.
//

#import "POCPlace.h"

@implementation POCPlace

- (NSString *) description {
    return [NSString stringWithFormat:@"%@. %f, %f",
            _name, _latitude, _longitude];
}

@end
