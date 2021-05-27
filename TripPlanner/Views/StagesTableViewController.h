//
//  StagesTableViewController.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TripCoreData.h"
#import "StageCoreData.h"

@interface StagesTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableSet *stages;
@property (nonatomic, strong) TripCoreData *trip;
@property CLLocationCoordinate2D departureTripCoordinates;

@end
