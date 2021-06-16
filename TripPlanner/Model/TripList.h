//
//  TripList.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 10/05/21.
//

#import <Foundation/Foundation.h>
#import "Trip.h"
#import "CoreDataController.h"
#import "TripCoreData.h"
#import "PoiCoreData.h"
#import "DisplacementCoreData.h"
#import "PermanenceCoreData.h"
#import "StageCoreData.h"

NS_ASSUME_NONNULL_BEGIN

@interface TripList : NSObject

-(long)size;
-(NSArray *)getAll;
-(void)add:(Trip *)f;
-(void)replace:(TripCoreData *)f;
-(void)remove:(TripCoreData *)f;
-(TripCoreData *)getAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
