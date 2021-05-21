//
//  Permanence.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import "Permanence.h"

@implementation Permanence
- (instancetype) initWithDestination:(NSString *)destination
                         ArrivalDate:(NSDate *) arrivalDate
                         DepartureDate:(NSDate *) departureDate
                         MeanTransport:(NSString *)meanTransport{
    if(self = [super init]) {
  
        _destination = destination;
        _arrivalDate = arrivalDate;
        _departureDate = departureDate;
        _meanTransport = meanTransport;
    }
    
    return self;
}

-(NSString *) displayName {
    return self.destination;
}

-(NSString *) displayDestination {
    return self.destination;
}

-(NSString *) displayDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yy"];
    
    return [NSString stringWithFormat:@"%@ - %@", [dateFormatter stringFromDate:self.departureDate], [dateFormatter stringFromDate:self.arrivalDate]];
}

-(NSDate *) getDateToCompare {
    return self.departureDate;
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
