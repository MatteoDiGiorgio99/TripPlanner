//
//  Poi.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 11/05/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Poi : NSObject

- (instancetype) initWithlatitude:(double)latitude
                    longitude:(double)longitude;

@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;


@end

NS_ASSUME_NONNULL_END
