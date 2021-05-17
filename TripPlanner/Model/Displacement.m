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
                       ArrivalDate:(NSDate *) displacementDate {
    if(self = [super init]) {
        _departure = departure;
        _destination = destination;
        _displacementDate = displacementDate;
    }
    
    return self;
}

-(NSString *) displayName {
    return [NSString stringWithFormat:@"%@ - %@", self.departure, self.destination];
}

-(NSString *) displayDate {
    return [NSString stringWithFormat:@"%@", self.displacementDate];
}
@end
