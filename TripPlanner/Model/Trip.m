//
//  Trip.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 10/05/21.
//

#import "Trip.h"

@implementation Trip
- (instancetype)initWithDestination:(NSString *)destination
                          Departure:(NSString *)departure
                         NameTrip:(NSString *)nameTrip
                         DescriptionTrip:(NSString *)descriptionTrip
                         ImageTrip:(NSObject *)imageTrip
                         StartTrip:(NSString *)startTrip
                         FinishTrip:(NSString *)finishTrip
                         HotelName:(NSString *)hotelName
                         MeanTransport:(NSString *)meanTransport
                             Stages:(NSMutableArray<Stage> *) stages {
    if(self = [super init]){
        _destination = [destination copy];
        _departure = [departure copy];
        _nameTrip=[nameTrip copy];
        _descriptionTrip=[descriptionTrip copy];
        _imageTrip = [imageTrip copy];
        _startTrip = [startTrip copy];
        _finishTrip = [finishTrip copy];
        _hotelName=[hotelName copy];
        _meanTransport=[meanTransport copy];
        _stages=stages;
    }
    return self;
}

-(instancetype)initWithDestination:(NSString *)destination
                         Departure:(NSString *)departure
                         ImageTrip:(NSObject *)imageTrip
                         DateDeparture:(NSString *)datedeparture
                     DateArrival:(NSString *)datearrival
                            Stages:(NSMutableArray<Stage> *) stages{
                       
    return [self initWithDestination:destination Departure:departure NameTrip:@"" DescriptionTrip:@"" ImageTrip:imageTrip StartTrip:datedeparture FinishTrip:datearrival HotelName:@"" MeanTransport:@"Car" Stages:stages];
}
@end
