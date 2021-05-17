//
//  Stage.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Stage <NSObject>

-(NSString *) displayName;
-(NSString *) displayDate;

@end

NS_ASSUME_NONNULL_END
