//
//  TripList.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 10/05/21.
//

#import "TripList.h"

@interface TripList()

@property (nonatomic,strong) NSMutableArray *mytrip;

@end

@implementation TripList

-(instancetype)init{
    if(self = [super init]){
        _mytrip = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSArray *)getAll{
    return self.mytrip;
}

-(void)add:(Trip *)f{
    [self.mytrip addObject:f];
}

-(void)remove:(Trip *)f{
    [self.mytrip removeObject:f];
}

-(Trip *)getAtIndex:(NSInteger)index{
    return [self.mytrip objectAtIndex:index];
}

-(long)size{
    return self.mytrip.count;
}

@end
