//
//  CoreDataController.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 27/05/21.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Trip.h"
#import "AppDelegate.h"
#import "DisplacementCoreData.h"
#import "PermanenceCoreData.h"
#import "TripCoreData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataController : NSObject

-(instancetype)init;
+(CoreDataController *)sharedInstance;

-(void)addTrip:(Trip *)Ntrip;
-(void)replaceTrip:(TripCoreData *)Ntrip;
-(void)removeTrip:(TripCoreData *)Ntrip;
-(NSArray *)recoverTrip;
-(NSMutableSet *)recoverStage:(TripCoreData *)data;
-(void)addDisplacement:(TripCoreData *)data
                      :(DisplacementCoreData *)d;
-(void)deleteStage:(TripCoreData *)data
                  :(NSManagedObject<Stage> *)d;
-(void)updateDisplacement:(TripCoreData *)data
                         :(NSManagedObject<Stage> *)d
                         :(DisplacementCoreData *)d2;
-(void)addPermanence:(TripCoreData *)data
                    :(PermanenceCoreData *)p;
-(void)updatePermanence:(TripCoreData *)data
                       :(NSManagedObject<Stage> *)p
                       :(PermanenceCoreData *)p2;

-(void)saveContext;

@property(nonatomic,strong)NSManagedObjectContext *context;

@end

NS_ASSUME_NONNULL_END
