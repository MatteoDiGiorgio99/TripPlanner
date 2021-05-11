//
//  TripList.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 10/05/21.
//

#import <Foundation/Foundation.h>
#import "Trip.h"
NS_ASSUME_NONNULL_BEGIN

@interface TripList : NSObject

-(long)size;
-(NSArray *)getAll;
-(void)add:(Trip *)f;
-(void)remove:(Trip *)f;
-(Trip *)getAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
