//
//  DisplacementCoreData.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 27/05/21.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface DisplacementCoreData : NSManagedObject

@property(nonatomic, strong) NSString *departure;
@property(nonatomic, strong) NSString *destination;
@property(nonatomic, strong) NSDate *displacementDate;
@property(nonatomic,strong)  NSString *meanTransport;

@end

NS_ASSUME_NONNULL_END
