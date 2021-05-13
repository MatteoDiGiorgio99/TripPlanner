//
//  NewTripTableViewController.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 11/05/21.
//

#import <UIKit/UIKit.h>
#import "TripDataSource.h"
#import "Trip.h"

@interface NewTripTableViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) id<TripDataSource> tripDataSource;
@property (nonatomic, strong) Trip *trip;

@end
