//
//  Permanence.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import <Foundation/Foundation.h>
#import "Stage.h"

NS_ASSUME_NONNULL_BEGIN

@interface Permanence : NSObject<Stage>
- (instancetype) initWithDestination:(NSString *)destination
                         ArrivalDate:(NSDate *) arrivalDate
                       DepartureDate:(NSDate *) departureDate;

@property(nonatomic, strong) NSString *destination;
@property(nonatomic, strong) NSDate *arrivalDate;
@property(nonatomic, strong) NSDate *departureDate;

@end

NS_ASSUME_NONNULL_END
