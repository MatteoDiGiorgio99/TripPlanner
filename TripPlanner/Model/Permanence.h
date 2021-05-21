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
                         DepartureDate:(NSDate *) departureDate
                         MeanTransport:(NSString *)meanTransport;
  

@property(nonatomic, strong) NSString *destination;
@property(nonatomic, strong) NSDate *arrivalDate;
@property(nonatomic, strong) NSDate *departureDate;
@property(nonatomic,strong) NSString *meanTransport;
@property(nonatomic,strong) Poi *coordinatePOI;

@end

NS_ASSUME_NONNULL_END
