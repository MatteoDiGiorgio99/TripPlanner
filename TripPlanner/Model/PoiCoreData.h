//
//  PoiCoreData.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 27/05/21.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface PoiCoreData : NSManagedObject

@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;

@end

NS_ASSUME_NONNULL_END
