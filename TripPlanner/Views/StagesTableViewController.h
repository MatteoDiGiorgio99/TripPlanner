//
//  StagesTableViewController.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Trip.h"
#import "Stage.h"

@interface StagesTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray<Stage> *stages;
@property (nonatomic, strong) Trip *trip;
@property CLLocationCoordinate2D departureTripCoordinates;

@end
