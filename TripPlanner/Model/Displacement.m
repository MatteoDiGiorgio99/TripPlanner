//
//  Displacement.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import "Displacement.h"

@implementation Displacement
- (instancetype) initWithDeparture:(NSString *) departure
                         Destination:(NSString *) destination
                         ArrivalDate:(NSDate *) displacementDate
                         MeanTransport:(NSString *)meanTransport{
    if(self = [super init]) {
        _departure = departure;
        _destination = destination;
        _displacementDate = displacementDate;
        _meanTransport = meanTransport;
    }
    
    return self;
}

-(NSString *) displayName {
    return [NSString stringWithFormat:@"%@ - %@", self.departure, self.destination];
}

-(NSString *) displayDestination {
    return self.destination;
}

-(NSString *) displayDate {
    return [NSString stringWithFormat:@"%@", self.displacementDate];
}

-(NSDate *) getDateToCompare {
    return self.displacementDate;
}
-(Poi *) coordinate{
    return self.coordinatePOI;
}

- (void) setCoordinates:(Poi *) poi {
    self.coordinatePOI = poi;
}
-(NSString *) meanofTransportSelected{
    return self.meanTransport;
}

@end
