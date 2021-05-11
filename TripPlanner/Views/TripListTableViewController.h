//
//  TripListTableViewController.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 10/05/21.
//

#import <UIKit/UIKit.h>
#import "Trip.h"
#import "TripDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface TripListTableViewController : UITableViewController

@property (nonatomic, strong) id<TripDataSource> tripDataSource;
@property (nonatomic, strong) Trip *thetrip;

@end

NS_ASSUME_NONNULL_END
