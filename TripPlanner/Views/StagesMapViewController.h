//
//  StagesMapViewController.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 18/05/21.
//

#import <UIKit/UIKit.h>
#import "Stage.h"
#import "Trip.h"
#import <MapKit/MapKit.h>

@interface StagesMapViewController : UIViewController<MKMapViewDelegate>

@property CLLocationCoordinate2D departureTripCoordinates;
@property (nonatomic, strong) Trip *trip;
@property (nonatomic, strong) NSMutableArray<Stage> *stages;

@end
