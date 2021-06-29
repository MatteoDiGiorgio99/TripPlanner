//
//  Stage.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import <Foundation/Foundation.h>
#import "Poi.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Stage <NSObject>

-(NSString *) displayName;
-(NSString *) displayDestination;
-(NSString *) displayDate;
-(NSDate *) getDateToCompare;
-(NSString *)meanofTransportSelected;
-(Poi *) coordinate;

@end

NS_ASSUME_NONNULL_END
