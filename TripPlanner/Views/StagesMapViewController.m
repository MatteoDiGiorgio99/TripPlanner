//
//  StagesMapViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 18/05/21.
//

#import "StagesMapViewController.h"
#import <MapKit/MapKit.h>
#import "Displacement.h"
#import "DisplacementCoreData.h"
#import "CoreDataController.h"

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
    
    self.stagesPosition = [[NSMutableArray<Poi *> alloc] init];
    [self searchLocationStartTrip];
    
    [self.stagesMapPoint removeOverlay:self.polyline];
    [self.stagesMapPoint removeOverlay:self.polyline2];
    self.stagesMapPoint.delegate = self;
}

-(void)searchLocation:(id<Stage>) stage
                     :(NSInteger) index {
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    [searchRequest setNaturalLanguageQuery:stage.displayDestination];
   
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
       
        if (!error) {
            if(response.mapItems.count > 0) {
                Poi *poi = [[Poi alloc] initWithlatitude:response.mapItems.firstObject.placemark.location.coordinate.latitude longitude:response.mapItems.firstObject.placemark.location.coordinate.longitude];
                
                [self.stagesPosition insertObject:poi atIndex:(index + 1)];
                
                if(self.stagesPosition.count == (self.stages.count + 1)) {
                    [self drawPOI];
                }
            }
        }
    }];
}

-(void)searchLocationStartTrip {
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    [searchRequest setNaturalLanguageQuery:self.trip.departure];
   
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
       
        if (!error) {
            if(response.mapItems.count > 0) {
                Poi *poi = [[Poi alloc] initWithlatitude:response.mapItems.firstObject.placemark.location.coordinate.latitude longitude:response.mapItems.firstObject.placemark.location.coordinate.longitude];
                
                [self.stagesPosition insertObject:poi atIndex:0];
            }
            
            NSInteger kIndex = 0;
            for (NSObject<Stage> *obj in self.stages) {
                if([obj isKindOfClass:[DisplacementCoreData class]]) {
                    [self searchLocation:obj:kIndex];
                    kIndex++;
                }
            }
        }
    }];
}

-(void) drawPOI {
    CLLocationCoordinate2D points[self.stages.count + 1];
    NSString *TypeTransport[self.stages.count + 1];
    
    NSInteger i = 0;
    NSInteger k = 0;
    for (Poi *poi in self.stagesPosition) {
        points[i] = CLLocationCoordinate2DMake(poi.latitude, poi.longitude);
        
        if(i > 0)
            TypeTransport[i] = [[[self.stages allObjects] objectAtIndex:(k)]meanofTransportSelected];
        
        [self annotationLocation:poi:i];
        
        if(i > 0)
            k++;
        
        i++;
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

-(void) annotationLocation:(Poi *)item
                          :(NSInteger) index{
    CLLocationCoordinate2D location;
        
    location.latitude=item.latitude;
    location.longitude=item.longitude;
   
    MKPointAnnotation *annotation =[[MKPointAnnotation alloc] init];

    if(index > 0) {
        NSObject<Stage> *stage = [[self.stages allObjects] objectAtIndex:(index - 1)];
        
        annotation.coordinate=location;
        annotation.title= [NSString stringWithFormat:@"%li-%@",(long)index, stage.displayName];
    } else {
        annotation.coordinate=location;
        annotation.title= [NSString stringWithFormat:@"%li-%@",(long)index, self.trip.departure];
    }

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

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
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
