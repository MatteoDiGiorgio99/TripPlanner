//
//  GeoTrip.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 11/05/21.
//

#import "Poi.h"
#import "Trip.h"

NS_ASSUME_NONNULL_BEGIN

@interface GeoTrip : Trip

@property (nonatomic, strong) Poi *location;

@end

NS_ASSUME_NONNULL_END
