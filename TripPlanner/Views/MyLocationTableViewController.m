//
//  MyLocationTableViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 11/05/21.
//

#import "MyLocationTableViewController.h"
#import <MapKit/MapKit.h>
#import "GeoTrip+MapAnnotation.h"


@interface MyLocationTableViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *latitudeText;
@property (weak, nonatomic) IBOutlet UITextField *longitudeText;
@property (weak, nonatomic) IBOutlet MKMapView *locationMap;

- (void) centerMapToLocationLatitude:(double)locaLat
                   LocationLongitude:(double)locaLon
                   zoom:(double)zoom;

@end

@implementation MyLocationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"My Location";
    self.locationMap.delegate = self;
}

- (void) centerMapToLocationLatitude:(double)locaLat
                        LocationLongitude:(double)locaLon
                        zoom:(double)zoom{
    MKCoordinateRegion mapRegion;
    CLLocationCoordinate2D location;
    location.latitude=locaLat;
    location.longitude=locaLon;
    mapRegion.center = location;
    mapRegion.span.latitudeDelta =zoom;
    mapRegion.span.longitudeDelta =zoom;
    [self.locationMap setRegion:mapRegion];
}
- (IBAction)refreshButton:(id)sender {
    self.latitudeText.text= @"";
    self.longitudeText.text=@"";
}
- (IBAction)currentLocButton:(id)sender {
    [self centerMapToLocationLatitude:[self.latitudeText.text doubleValue] LocationLongitude:[self.longitudeText.text doubleValue] zoom:0.1];
 
}

@end
