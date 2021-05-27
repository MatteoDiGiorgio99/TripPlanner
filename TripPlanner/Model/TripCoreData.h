//
//  TripCoreData.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 27/05/21.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface TripCoreData : NSManagedObject

@property (nonatomic, strong) NSString *nameTrip;
@property (nonatomic, strong) NSString *descriptionTrip;
@property (nonatomic, strong) NSString *departure;
@property (nonatomic, strong) NSString *destination;
@property (nonatomic, strong) NSString *startTrip;
@property (nonatomic, strong) NSString *finishTrip;
@property (nonatomic, strong) NSString *hotelName;
@property (nonatomic, strong) NSString *meanTransport;
@property (nonatomic, strong) NSObject *imageTrip;

@end

NS_ASSUME_NONNULL_END
