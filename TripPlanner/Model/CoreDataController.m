//
//  CoreDataController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 27/05/21.
//

#import "CoreDataController.h"


@implementation CoreDataController

-(instancetype)init{
    if(self = [super init]){
        AppDelegate *application = UIApplication.sharedApplication.delegate;
        self.context = application.persistentContainer.viewContext;
    }
    return self;
}

+(CoreDataController *)sharedInstance{
    return [[CoreDataController alloc] init];
}

- (void)saveContext {
    NSError *error;
    [self.context save:&error];
    
    if(error) {
        NSLog(@"%@", error.description);
    }
}

-(void)addTrip:(Trip *)Ntrip{
    
    NSEntityDescription *entityTrip = [NSEntityDescription entityForName:@"TripCoreData" inManagedObjectContext:self.context];
    TripCoreData *trip = [[TripCoreData alloc]initWithEntity:entityTrip insertIntoManagedObjectContext:self.context];
    
    trip.nameTrip=Ntrip.nameTrip;
    trip.descriptionTrip=Ntrip.descriptionTrip;
    trip.departure=Ntrip.departure;
    trip.destination=Ntrip.destination;
    trip.startTrip=Ntrip.startTrip;
    trip.finishTrip=Ntrip.finishTrip;
    trip.hotelName=trip.hotelName;
    trip.imageTrip=trip.imageTrip;
    trip.meanTransport=trip.meanTransport;
    
    [self saveContext];
}

-(void)replaceTrip:(TripCoreData *)Ntrip{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TripCoreData" inManagedObjectContext:self.context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];

    
    [self saveContext];
}

-(void)removeTrip:(TripCoreData *)Ntrip{
       
    [self.context deleteObject:Ntrip];
    [self saveContext];
}

-(NSArray *)recoverTrip{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TripCoreData"];
    request.returnsObjectsAsFaults = false;
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    if(error)
    {
        NSLog(@"%@", error.description);
    }
   
    return result;
}

-(NSMutableSet *)recoverStage:(TripCoreData *)data {
    return [data mutableSetValueForKey:@"stages"];
}

-(void)addDisplacement:(TripCoreData *)data
                      :(DisplacementCoreData *)d {
    [[data mutableSetValueForKey:@"stages"] addObject:d];
    [self saveContext];
}

-(void)deleteDisplacement:(TripCoreData *)data
                         :(DisplacementCoreData *)d{
    [[data mutableSetValueForKey:@"stages"] removeObject:d];
    [self saveContext];
}

-(void)updateDisplacement {
    [self saveContext];
}
-(void)addPermanence:(TripCoreData *)data
                      :(PermanenceCoreData *)p {
    [[data mutableSetValueForKey:@"stages"] addObject:p];
    [self saveContext];
}

-(void)deletePermanence:(TripCoreData *)data
                         :(PermanenceCoreData *)p{
    [[data mutableSetValueForKey:@"stages"] removeObject:p];
    [self saveContext];
}

-(void)updatePermanence {
    [self saveContext];
}

@end
