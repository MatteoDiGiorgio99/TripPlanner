//
//  TripList.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 10/05/21.
//

#import "TripList.h"


@interface TripList()

@property(nonatomic,strong) CoreDataController *coreData;

@end

@implementation TripList

-(instancetype)init{
    if(self = [super init]){
        _coreData=[[CoreDataController alloc]init];
    }
    return self;
}

-(NSArray *)getAll{
    return [self.coreData recoverTrip];
}

-(void)add:(Trip *)f{
    [self.coreData addTrip:f];
}

-(void)remove:(TripCoreData *)f{
    [self.coreData removeTrip:f];
}

-(TripCoreData *)getAtIndex:(NSInteger)index{
    return [[self.coreData recoverTrip] objectAtIndex:index];
}

-(long)size{
    return [self.coreData recoverTrip].count;
}

@end
