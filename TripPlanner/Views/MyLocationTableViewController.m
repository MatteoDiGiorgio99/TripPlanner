//
//  MyLocationTableViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 11/05/21.
//

#import "MyLocationTableViewController.h"
#import <MapKit/MapKit.h>



@interface MyLocationTableViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *latitudeText;
@property (weak, nonatomic) IBOutlet UITextField *longitudeText;
@property (weak, nonatomic) IBOutlet MKMapView *locationMap;
@property (strong, nonatomic)  CLLocationManager *locationManager;


- (void) centerMapToLocationLatitude:(double)locaLat
                   LocationLongitude:(double)locaLon
                   zoom:(double)zoom;

- (void) centerMapToLocation:(CLLocationCoordinate2D)location zoom:(double)zoom;

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations;

@end

@implementation MyLocationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"My Location";
    
    self.locationMap.showsUserLocation = YES;
    self.locationMap.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
   
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 0;
    
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
        
    NSLog(@"%@", [NSString stringWithFormat:@"Latitude: %f, Longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude]);
    
 
}

- (void) centerMapToLocation:(CLLocationCoordinate2D)location zoom:(double)zoom{
    MKCoordinateRegion mapRegion;
    mapRegion.center = location;
    mapRegion.span.latitudeDelta = zoom;
    mapRegion.span.longitudeDelta = zoom;
    
    [self.locationMap setRegion:mapRegion];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

      [self.locationManager stopUpdatingLocation];
      [self centerMapToLocation:self.locationManager.location.coordinate zoom:0.3];
}


- (void) centerMapToLocationLatitude:(double)locaLat
                        LocationLongitude:(double)locaLon
                        zoom:(double)zoom{
    
    MKCoordinateRegion mapRegion;
    CLLocationCoordinate2D location;
    MKPointAnnotation *annotation =[[MKPointAnnotation alloc] init];
    
    location.latitude=locaLat;
    location.longitude=locaLon;
    mapRegion.center = location;
    annotation.coordinate=location;
    mapRegion.span.latitudeDelta =zoom;
    mapRegion.span.longitudeDelta =zoom;
 
    [self.locationMap setRegion:mapRegion];
    [self.locationMap addAnnotation:annotation];
}


- (IBAction)refreshButton:(id)sender {
    self.latitudeText.text= @"";
    self.longitudeText.text=@"";
}
- (IBAction)currentLocButton:(id)sender {
    [self centerMapToLocationLatitude:[self.latitudeText.text doubleValue] LocationLongitude:[self.longitudeText.text doubleValue] zoom:0.2];
 
}

@end
