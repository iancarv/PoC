//
//  POCPlaceFinder.h
//  PoC Ian
//
//  Created by Ian Carvalho on 17/04/15.
//  Copyright (c) 2015 Ian. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol POCPlaceFinderDelegate;

@interface POCPlaceFinder : NSObject

@property (strong, nonatomic) NSArray *places;
@property (weak) id<POCPlaceFinderDelegate> delegate;

- (void)search;

@end

@protocol POCPlaceFinderDelegate <NSObject>

@required
- (void)placeFinder:(POCPlaceFinder*)finder foundItems:(NSArray *)items;

@end