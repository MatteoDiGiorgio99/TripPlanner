//
//  StagesTableViewController.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import <UIKit/UIKit.h>
#import "TripDataSource.h"
#import "Trip.h"

NS_ASSUME_NONNULL_BEGIN

@interface StagesTableViewController : UITableViewController

@property (nonatomic, strong) id<TripDataSource> tripDataSource;
@property (nonatomic, strong) Trip *trip;

@end

NS_ASSUME_NONNULL_END
