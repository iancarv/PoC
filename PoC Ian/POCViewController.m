//
//  ViewController.m
//  PoC Ian
//
//  Created by Ian Carvalho on 17/04/15.
//  Copyright (c) 2015 Ian. All rights reserved.
//

#import "POCViewController.h"

@interface POCViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) MKMapView *mapView;

@end

@implementation POCViewController

BOOL fetched;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    _locationManager.distanceFilter = 9999;
    _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    [self.locationManager startUpdatingLocation];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.mapView];
    self.mapView.showsUserLocation = YES;
    fetched = NO;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Metodos Privados

- (void)addPinFromPlace:(POCPlace *)place  {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:place.latitude longitude:place.longitude];
    [self addPinToMapAtLocation:location withTitle:place.name];
}

- (void)addPinToMapAtLocation:(CLLocation *)location withTitle:(NSString *)title{
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location.coordinate;
    point.title = title;
    point.subtitle = @"";
    
    [self.mapView addAnnotation:point];
}

// Metodo de conveniencia para melhorar a experiencia de usuario. 
// Fonte: https://gist.github.com/andrewgleave/915374
- (void) zoomMapViewToAnotations {
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(zoomRect)) {
            zoomRect = pointRect;
        } else {
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
    }
    [self.mapView setVisibleMapRect:zoomRect animated:YES];

    double inset = -zoomRect.size.width * 0.1;
    [self.mapView setVisibleMapRect:MKMapRectInset(zoomRect, inset, inset) animated:YES];
}



#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (!fetched) {
        POCFourSquareFinder *finder = [[POCFourSquareFinder alloc] init];
        finder.delegate = self;
        [finder searchPlacesFromLocation:[locations objectAtIndex:0]];
        fetched = YES;
    }
}

#pragma mark - POCPlaceFinderDelegate

- (void)placeFinder:(POCPlaceFinder *)finder foundPlaces:(NSArray *)places {
    for (POCPlace *place in places) {
        if ([place isKindOfClass:[POCPlace class]]) {
            [self addPinFromPlace:place];
        }
    }
    [self zoomMapViewToAnotations];
}

@end

