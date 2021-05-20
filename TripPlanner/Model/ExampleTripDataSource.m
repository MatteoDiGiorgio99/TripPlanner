//
//  ExampleTripDataSource.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 11/05/21.
//

#import "ExampleTripDataSource.h"
#import "TripList.h"
#import "Permanence.h"
#import "Displacement.h"

#import <UIKit/UIKit.h>

@interface ExampleTripDataSource()

@property (nonatomic, strong) TripList *trips;

- (void) addTrips;

@end

@implementation ExampleTripDataSource

- (instancetype) init {
    if(self = [super init]) {
        _trips = [[TripList alloc] init];
        [self addTrips];
    }
    
    return self;
}

- (void) addTrips {
   NSMutableArray<Stage> *array = [[NSMutableArray<Stage> alloc] init];
    
    [array addObject:[[Displacement alloc] initWithDeparture:@"Rome" Destination:@"Piacenza" ArrivalDate:[[NSDate alloc] init]]];
    
    [array addObject:[[Displacement alloc] initWithDeparture:@"Piacenza" Destination:@"Paris" ArrivalDate:[[NSDate alloc] init]]];
    
    [array addObject:[[Permanence alloc] initWithDestination:@"London" ArrivalDate:[[NSDate alloc] init] DepartureDate:[[NSDate alloc] init]]];
    
    [self.trips add: [[Trip alloc] initWithDestination:@"Londra" Departure:@"Roma" ImageTrip:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",@"Londra"]] DateDeparture:@"05/02/2021" DateArrival:@"07/02/2021" Stages:array]];
}

- (TripList *) getTrips {
    return [self trips];
}

@end
