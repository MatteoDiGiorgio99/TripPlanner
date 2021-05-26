//
//  StagesMapViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 18/05/21.
//

#import "StagesMapViewController.h"
#import <MapKit/MapKit.h>
#import "Displacement.h"

@interface StagesMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *stagesMapPoint;
@property MKPolyline *polyline;
@property MKPolyline *polyline2;
@property MKPolylineRenderer *lineView;

@end

@implementation StagesMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title=@"Stages Map";
    
    [self.stagesMapPoint removeOverlay:self.polyline];
    [self.stagesMapPoint removeOverlay:self.polyline2];
    self.stagesMapPoint.delegate = self;
    
    MKPointAnnotation *annotation =[[MKPointAnnotation alloc] init];
    
    annotation.coordinate=self.departureTripCoordinates;
    annotation.title= [NSString stringWithFormat:@"%@",self.trip.departure];

    [self.stagesMapPoint addAnnotation:annotation];
    
    [self drawPOI];
}

-(void) drawPOI {
    CLLocationCoordinate2D points[self.stages.count + 1];
    NSString *TypeTransport[self.stages.count +1];
    points[0] = self.departureTripCoordinates;
    
    NSInteger i = 1;
    for (NSObject<Stage> *stage in self.stages) {
        if([stage isKindOfClass:[Displacement class]]) {
            points[i] = CLLocationCoordinate2DMake(stage.coordinate.latitude, stage.coordinate.longitude);
            TypeTransport[i] = stage.meanofTransportSelected;
            NSLog(@"%f", [[stage coordinate] latitude]);
            
            [self annotationLocation:stage];
            
            i++;
        }
    }
    
    for (NSInteger k=1; k < i; k++) {
        if([TypeTransport[k] isEqual:@"Car"] ||[TypeTransport[k] isEqual:@"Bike"] || [TypeTransport[k] isEqual:@"Motorbike"] )
        {
            MKDirectionsRequest *directions = [[MKDirectionsRequest alloc] init];
            directions.source = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:points[k - 1]]];
            directions.destination = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:points[k]]];
            
            directions.requestsAlternateRoutes = NO;
            
            if([TypeTransport[k] isEqual:@"Bike"])
            {
                directions.transportType = MKDirectionsTransportTypeWalking;
            }
            else
            {
                directions.transportType = MKDirectionsTransportTypeAutomobile;
            }
        
            MKDirections *dir = [[MKDirections alloc] initWithRequest:directions];
            
            [dir calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                if (!error) {
                    for (MKRoute *route in [response routes]) {
                        
                       // CLLocationDistance distance = route.distance;
                        
                        [self.stagesMapPoint addOverlay:[route polyline]];
                       
                        [self.stagesMapPoint setVisibleMapRect:route.polyline.boundingMapRect];
                    }
                }
            }];
            
        } else {
            CLLocationCoordinate2D arr[2] = { points[k - 1], points[k] };
            
            self.polyline2 = [MKPolyline polylineWithCoordinates:arr count:2];
            self.polyline2.title = @"Retta";
            
            [self.stagesMapPoint setVisibleMapRect:[self.polyline2 boundingMapRect]]; //If you want the route to be visible
            [self.stagesMapPoint addOverlay:self.polyline2];
        }
    }
}

-(void) annotationLocation:(NSObject<Stage> *)item {
    CLLocationCoordinate2D location;
    
    location.latitude=item.coordinate.latitude;
    location.longitude=item.coordinate.longitude;
   
    MKPointAnnotation *annotation =[[MKPointAnnotation alloc] init];
    NSInteger position = [self.stages indexOfObject:item]+1;
    
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
    if(![overlay.title isEqual:@"Retta"])
    {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.strokeColor = UIColor.blueColor;
        renderer.lineWidth = 5.0;
        
        return renderer;
    }
    else
    {
        self.lineView = [[MKPolylineRenderer alloc] initWithPolyline:self.polyline2];
                    self.lineView.fillColor = [UIColor redColor];
                    self.lineView.strokeColor = [UIColor redColor];
                    self.lineView.lineWidth = 5;
        return self.lineView;
    }
   
}

@end
