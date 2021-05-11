//
//  GeoTrip+MapAnnotation.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 11/05/21.
//

#import "GeoTrip+MapAnnotation.h"

@implementation GeoTrip (MapAnnotation)
- (CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.location.latitude;
    coordinate.longitude = self.location.longitude;
    return coordinate;
}
@end
