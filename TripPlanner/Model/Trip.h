//
//  Trip.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 10/05/21.
//

#import <Foundation/Foundation.h>
#import "Stage.h"

@interface Trip : NSObject

- (instancetype)initWithDestination:(NSString *)destination
                         NameTrip:(NSString *)nameTrip
                         DescriptionTrip:(NSString *)descriptionTrip
                         ImageTrip:(NSObject *)imageTrip
                         StartTrip:(NSString *)startTrip
                         FinishTrip:(NSString *)finishTrip
                         HotelName:(NSString *)hotelName
                         MeanTransport:(NSString *)meanTransport
                             Stages:(NSMutableArray<Stage> *) stages;

-(instancetype)initWithDestination:(NSString *)destination
                         Departure:(NSString *)departure
                         ImageTrip:(NSObject *)imageTrip
                         DateDeparture:(NSString *)datedeparture
                     DateArrival:(NSString *)datearrival
                            Stages:(NSMutableArray<Stage> *) stages;
                          

@property (nonatomic, strong) NSString *destination;
@property (nonatomic, strong) NSString *nameTrip;
@property (nonatomic, strong) NSString *descriptionTrip;
@property (nonatomic, strong) NSObject *imageTrip;
@property (nonatomic, strong) NSString *startTrip;
@property (nonatomic, strong) NSString *finishTrip;
@property (nonatomic, strong) NSString *departure;
@property (nonatomic, strong) NSString *datedeparture;
@property (nonatomic, strong) NSString *hotelName;
@property (nonatomic, strong) NSString *meanTransport;
@property (nonatomic, strong) NSMutableArray<Stage> *stages;

@end
