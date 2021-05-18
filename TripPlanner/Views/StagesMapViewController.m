//
//  StagesMapViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 18/05/21.
//

#import "StagesMapViewController.h"
#import <MapKit/MapKit.h>

@interface StagesMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *stagesMapPoint;

@end

@implementation StagesMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title=@"Stages Map";
    
    for (NSObject<Stage> *obj in self.stages) {
        [self searchLocation:obj];
    }
}

-(void)searchLocation:(id<Stage>) stage {
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    [searchRequest setNaturalLanguageQuery:stage.displayDestination];

    // Create the local search to perform the search
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (!error) {
            for (MKMapItem *mapItem in [response mapItems]) {
                NSLog(@"Name: %@, Placemark title: %@", [mapItem name], [[mapItem placemark] title]);
                [self annotationLocation:mapItem];
            }
        }
    }];
}
-(void) annotationLocation:(MKMapItem *)item {
    
    MKCoordinateRegion mapRegion;
    CLLocationCoordinate2D location;
    MKPointAnnotation *annotation =[[MKPointAnnotation alloc] init];
    
    location.latitude=item.placemark.location.coordinate.latitude;
    location.longitude=item.placemark.location.coordinate.longitude;
   // mapRegion.center = location;
    annotation.coordinate=location;
   // mapRegion.span.latitudeDelta =-0.2;
   // mapRegion.span.longitudeDelta =-0.2;
 
   // [self.stagesMapPoint setRegion:mapRegion];
    [self.stagesMapPoint addAnnotation:annotation];
}

@end
