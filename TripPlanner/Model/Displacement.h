//
//  Displacement.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import <Foundation/Foundation.h>
#import "Stage.h"

NS_ASSUME_NONNULL_BEGIN

@interface Displacement : NSObject<Stage>

- (instancetype) initWithDeparture:(NSString *) departure
                         Destination:(NSString *)destination
                         ArrivalDate:(NSDate *) displacementDate
                         MeanTransport:(NSString *)meanTransport;

@property(nonatomic, strong) NSString *departure;
@property(nonatomic, strong) NSString *destination;
@property(nonatomic, strong) NSDate *displacementDate;
@property(nonatomic,strong)  NSString *meanTransport;
@property(nonatomic,strong)  Poi *coordinatePOI;


@end

NS_ASSUME_NONNULL_END
