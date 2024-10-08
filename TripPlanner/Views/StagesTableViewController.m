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
    
   [self sortStages];
    
    self.title=@"Stages";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self sortStages];
    
    [self.tableView reloadData];
}

-(void) sortStages {
    self.OrderList = [[NSMutableArray<Stage> alloc] init];
    
    NSArray *oldArray = [self.stages allObjects];
    for(int i = 0; i < oldArray.count; i++) {
        [self.OrderList addObject:[oldArray objectAtIndex:i]];
    }
    
    for (int i = 0; i < [self.OrderList count]; i++) {
        for (int j = 0; j < [self.OrderList count] - 1; j++) {
            NSManagedObject<Stage> *a = [self.OrderList objectAtIndex:(j)];
            NSManagedObject<Stage> *b = [self.OrderList objectAtIndex:(j + 1)];
            
            NSComparisonResult result = [a.getDateToCompare compare:b.getDateToCompare];
            
            switch (result) {
                case NSOrderedAscending:
                    break;
                case NSOrderedDescending:
                   self.OrderList[j] = b;
                   self.OrderList[j + 1] = a;
                    break;
                case NSOrderedSame:
                    break;
            }
        }
    }
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
    
    NSObject<Stage> *stage = [self.OrderList objectAtIndex:indexPath.row];
    
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
            vc.stagesList = self.OrderList;
        }
    }
    
    if([segue.identifier isEqualToString:@"EditStage"]){
        if([segue.destinationViewController isKindOfClass:[DetailStagesTableViewController class]]) {
            DetailStagesTableViewController *vc = (DetailStagesTableViewController *)segue.destinationViewController;
            
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            
        
            vc.stage = self.OrderList[indexPath.row];
            vc.trip = self.trip;
            vc.stagesList = self.OrderList;
        }
    }
    if([segue.identifier isEqualToString:@"ShowMap"]){
        if([segue.destinationViewController isKindOfClass:[StagesMapViewController class]]) {
            StagesMapViewController *vc = (StagesMapViewController *)segue.destinationViewController;
            
           // NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
           
            vc.stages = self.OrderList;
            vc.trip = self.trip;
        }
        
    }
}

@end
