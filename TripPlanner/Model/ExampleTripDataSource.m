//
//  ExampleTripDataSource.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 11/05/21.
//

#import "ExampleTripDataSource.h"
#import "TripList.h"

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
    
}

- (TripList *) getTrips {
    return [self trips];
}

@end
