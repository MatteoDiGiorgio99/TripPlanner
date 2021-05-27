//
//  PermanenceCoreData.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 27/05/21.
//

#import <CoreData/CoreData.h>
#import "Poi.h"

NS_ASSUME_NONNULL_BEGIN

@interface PermanenceCoreData : NSManagedObject

@property(nonatomic, strong) NSString *destination;
@property(nonatomic, strong) NSDate *arrivalDate;
@property(nonatomic, strong) NSDate *departureDate;
@property(nonatomic,strong) NSString *meanTransport;



@end

NS_ASSUME_NONNULL_END
