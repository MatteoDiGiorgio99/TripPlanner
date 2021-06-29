//
//  StagesTableViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import "StagesTableViewController.h"
#import "DetailStagesTableViewController.h"
#import "StagesMapViewController.h"
#import "Stage.h"

@interface StagesTableViewController ()

@end

@implementation StagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self sortStages];
    [self searchLocationStartTrip];
    
    for (NSObject<Stage> *obj in self.stages) {
        [self searchLocation:obj];
    }
    
    self.title=@"Stages";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //[self sortStages];
    
    for (NSObject<Stage> *obj in self.stages) {
        [self searchLocation:obj];
    }
    
    [self.tableView reloadData];
}

-(void) sortStages {
    /*for (int i = 0; i < [self.stages count]; i++) {
        for (int j = 0; j < [self.stages count] - 1; j++) {
            NSObject<Stage> *a = [self.stages objectAtIndex:j];
            NSObject<Stage> *b = [self.stages objectAtIndex:j + 1];
            
            NSComparisonResult result = [a.getDateToCompare compare:b.getDateToCompare];
            
            switch (result) {
                case NSOrderedAscending:
                    break;
                case NSOrderedDescending:
                    self.stages[j] = b;
                    self.stages[j + 1] = a;
                    break;
                case NSOrderedSame:
                    break;
            }
        }
    }*/
}

-(void)searchLocation:(id<Stage>) stage {
    
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    [searchRequest setNaturalLanguageQuery:stage.displayDestination];
   
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
       
        if (!error) {
            NSManagedObject<Stage> *stage;
            for (NSManagedObject<Stage> *currentStage in self.stages) {
                if([currentStage.displayDestination containsString:response.mapItems.firstObject.name]) {
                    stage = currentStage;
                    break;
                }
            }
            
            if(response.mapItems.count > 0) {
                CoreDataController *controller = CoreDataController.sharedInstance;

                //PoiCoreData *poiToAdd = [[PoiCoreData alloc] initWithContext:controller.context];
                
                //poiToAdd.latitude = response.mapItems.firstObject.placemark.coordinate.latitude;
                
                //poiToAdd.longitude = response.mapItems.firstObject.placemark.coordinate.longitude;
                
           //     [controller setCoordinate:stage:poiToAdd];
            }
        }
    }];
}

-(void)searchLocationStartTrip {
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    [searchRequest setNaturalLanguageQuery:self.trip.departure];
   
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
       
        if (!error) {
            if(response.mapItems.count > 0) {
                self.departureTripCoordinates = response.mapItems.firstObject.placemark.coordinate;
            }
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StageCell" forIndexPath:indexPath];
    
    NSObject<Stage> *stage = self.stages.allObjects[indexPath.row];
    
    cell.textLabel.text = [stage displayName];
    cell.detailTextLabel.text = [stage displayDate];
    
    return cell;
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"NewStage"]){
        if([segue.destinationViewController isKindOfClass:[DetailStagesTableViewController class]]) {
            DetailStagesTableViewController *vc = (DetailStagesTableViewController *)segue.destinationViewController;
            
           
            vc.stage = nil;
            vc.trip = self.trip;
            vc.stagesList = self.stages;
        }
    }
    
    if([segue.identifier isEqualToString:@"EditStage"]){
        if([segue.destinationViewController isKindOfClass:[DetailStagesTableViewController class]]) {
            DetailStagesTableViewController *vc = (DetailStagesTableViewController *)segue.destinationViewController;
            
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            
        
            vc.stage = self.stages.allObjects[indexPath.row];
            vc.trip = self.trip;
            vc.stagesList = self.stages;
        }
    }
    if([segue.identifier isEqualToString:@"ShowMap"]){
        if([segue.destinationViewController isKindOfClass:[StagesMapViewController class]]) {
            StagesMapViewController *vc = (StagesMapViewController *)segue.destinationViewController;
            
           // NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
           
            vc.stages = self.stages;
            vc.trip = self.trip;
            vc.departureTripCoordinates = self.departureTripCoordinates;
        }
        
    }
}

@end
