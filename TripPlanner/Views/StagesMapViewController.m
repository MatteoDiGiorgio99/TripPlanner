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
    self.mapStages = [[NSMutableArray<Stage> alloc] init];
    
    [self.stagesMapPoint removeOverlay:self.polyline];
    [self.stagesMapPoint removeOverlay:self.polyline2];
    self.stagesMapPoint.delegate = self;
    
    for (NSObject<Stage> *obj in self.stages) {
        if([obj isKindOfClass:[DisplacementCoreData class]]) {
            [self.mapStages addObject:obj];
        }
    }
    
    [self searchLocationStartTrip];
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
                
                poi.index = (index + 1);
                
                [self.stagesPosition addObject:poi];
                
                if(self.stagesPosition.count == (self.mapStages.count + 1)) {
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
                
                poi.index = 0;
                
                [self.stagesPosition addObject:poi];
            }
            
            NSInteger kIndex = 0;
            for (NSObject<Stage> *obj in self.mapStages) {
                if([obj isKindOfClass:[DisplacementCoreData class]]) {
                    [self searchLocation:obj:kIndex];
                    kIndex++;
                }
            }
        }
    }];
}

-(void) drawPOI {
    CLLocationCoordinate2D points[self.mapStages.count + 1];
    NSString *TypeTransport[self.mapStages.count + 1];
    
    [self sortPoi];
    
    for (Poi *poi in self.stagesPosition) {
        points[poi.index] = CLLocationCoordinate2DMake(poi.latitude, poi.longitude);
        
        if(poi.index > 0)
            TypeTransport[poi.index] = [[self.mapStages objectAtIndex:(poi.index - 1)]meanofTransportSelected];
        
        [self annotationLocation:poi:poi.index];
    }
    
    for (NSInteger k=1; k < self.stagesPosition.count; k++) {
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

-(void) sortPoi {
    for (int i = 0; i < [self.stagesPosition count]; i++) {
        for (int j = 0; j < [self.stagesPosition count] - 1; j++) {
            Poi *a = [self.stagesPosition objectAtIndex:(j)];
            Poi *b = [self.stagesPosition objectAtIndex:(j + 1)];
            
            if(a.index > b.index) {
                self.stagesPosition[j] = b;
                self.stagesPosition[j + 1] = a;
            }
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
        NSObject<Stage> *stage = [self.mapStages objectAtIndex:(index - 1)];
        
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
