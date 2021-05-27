//
//  PermanenceCoreData.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 27/05/21.
//

#import "PermanenceCoreData.h"

@implementation PermanenceCoreData

@dynamic destination;
@dynamic departureDate;
@dynamic arrivalDate;
@dynamic meanTransport;

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
    return nil;//self.coordinatePOI;
}

- (void) setCoordinates:(Poi *) poi {
    //self.coordinatePOI = poi;
}
-(NSString *) meanofTransportSelected{
    return self.meanTransport;
}

@end
