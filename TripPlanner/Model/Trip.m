//
//  Trip.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 10/05/21.
//

#import "Trip.h"

@implementation Trip
- (instancetype)initWithDestination:(NSString *)destination
                         NameTrip:(NSString *)nameTrip
                         DescriptionTrip:(NSString *)descriptionTrip
                         ImageTrip:(NSObject *)imageTrip
                         StartTrip:(NSString *)startTrip
                         FinishTrip:(NSString *)finishTrip{
    if(self = [super init]){
        _destination = [destination copy];
        _nameTrip=[nameTrip copy];
        _descriptionTrip=[descriptionTrip copy];
        _imageTrip = [imageTrip copy];
        _startTrip = [startTrip copy];
        _finishTrip = [finishTrip copy];
    }
    return self;
}

- (instancetype)initWithDestination:(NSString *)destination
                         StartTrip:(NSString *)startTrip
                         FinishTrip:(NSString *)finishTrip {
    return [self initWithDestination:destination Departure:@"" ImageTrip:nil DateDeparture:startTrip];
}

-(instancetype)initWithDestination:(NSString *)destination
                         Departure:(NSString *)departure
                         ImageTrip:(NSObject *)imageTrip
                         DateDeparture:(NSString *)datedeparture{
                       
    return [ self initWithDestination:destination Departure:departure ImageTrip:imageTrip DateDeparture:datedeparture];
}
@end
