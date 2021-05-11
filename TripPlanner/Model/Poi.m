//
//  Poi.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 11/05/21.
//

#import "Poi.h"

@implementation Poi

- (instancetype) initWithlatitude:(double)latitude
                    longitude:(double)longitude{
    if(self = [super init]){
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;
}
@end
