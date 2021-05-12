//
//  MyTripsTableViewController.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 12/05/21.
//

#import <UIKit/UIKit.h>
#import "TripDataSource.h"
#import "Trip.h"



@interface MyTripsTableViewController : UITableViewController

@property (nonatomic, strong) id<TripDataSource> tripDataSource;
@property (nonatomic, strong) Trip *trip;

@end


