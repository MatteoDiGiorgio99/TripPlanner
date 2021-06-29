//
//  DisplacementCoreData.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 27/05/21.
//

#import "DisplacementCoreData.h"

@implementation DisplacementCoreData

@dynamic departure;
@dynamic destination;
@dynamic displacementDate;
@dynamic meanTransport;


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

-(NSString *) meanofTransportSelected{
    return self.meanTransport;
}



@end
