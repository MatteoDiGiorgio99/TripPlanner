//
//  TripDataSource.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 11/05/21.
//

#import <Foundation/Foundation.h>
#import "TripList.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TripDataSource <NSObject>

- (TripList *) getTrips;

@end

NS_ASSUME_NONNULL_END
