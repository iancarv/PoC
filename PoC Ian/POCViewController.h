//
//  ViewController.h
//  PoC Ian
//
//  Created by Ian Carvalho on 17/04/15.
//  Copyright (c) 2015 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "POCFourSquareFinder.h"
#import "POCGoogleMapsFinder.h"

@interface POCViewController : UIViewController <CLLocationManagerDelegate, POCPlaceFinderDelegate>


@end

