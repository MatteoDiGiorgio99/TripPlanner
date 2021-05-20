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
@property MKPolyline *polyline;
@property MKPolylineRenderer *lineView;

@end

@implementation StagesMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title=@"Stages Map";
    
    [self.stagesMapPoint removeOverlay:self.polyline];
    self.stagesMapPoint.delegate = self;
    
    MKPointAnnotation *annotation =[[MKPointAnnotation alloc] init];
    
    annotation.coordinate=self.departureTripCoordinates;
    annotation.title= [NSString stringWithFormat:@"%@",self.trip.departure];

    [self.stagesMapPoint addAnnotation:annotation];
    
    [self drawPOI];
}

-(void) drawPOI {
    CLLocationCoordinate2D points[self.stages.count + 1];
    points[0] = self.departureTripCoordinates;
    
    NSInteger i = 1;
    for (NSObject<Stage> *stage in self.stages) {
        points[i] = CLLocationCoordinate2DMake(stage.coordinate.latitude, stage.coordinate.longitude);
        
        NSLog(@"%f", [[stage coordinate] latitude]);
        
        [self annotationLocation:stage];
        
        i++;
    }
    
    for (NSInteger k=1; k < self.stages.count + 1; k++) {
        MKDirectionsRequest *directions = [[MKDirectionsRequest alloc] init];
        directions.source = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:points[k - 1]]];
        directions.destination = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:points[k]]];
        
        directions.requestsAlternateRoutes = NO;
        directions.transportType = MKDirectionsTransportTypeAutomobile;
        
        MKDirections *dir = [[MKDirections alloc] initWithRequest:directions];
        
        [dir calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
            if (!error) {
                for (MKRoute *route in [response routes]) {
                    [self.stagesMapPoint addOverlay:[route polyline]];
                    [self.stagesMapPoint setVisibleMapRect:route.polyline.boundingMapRect];
                }
            }
        }];
    }
}

-(void) annotationLocation:(NSObject<Stage> *)item {
    CLLocationCoordinate2D location;
    
    location.latitude=item.coordinate.latitude;
    location.longitude=item.coordinate.longitude;
   
    MKPointAnnotation *annotation =[[MKPointAnnotation alloc] init];
    NSInteger position = [self.stages indexOfObject:item];
    
    annotation.coordinate=location;
    annotation.title= [NSString stringWithFormat:@"%li-%@",(long)position,item.displayName];

    [self.stagesMapPoint addAnnotation:annotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *AnnotationIdentifer = @"MapAnnotationView";
    
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifer];
    
    if(!view){
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:AnnotationIdentifer];
        view.canShowCallout = YES;
    }
    
    return view;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = UIColor.blueColor;
    renderer.lineWidth = 5.0;
    
    return renderer;
}

@end
