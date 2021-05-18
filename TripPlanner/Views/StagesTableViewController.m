//
//  StagesTableViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import "StagesTableViewController.h"
#import "DetailStagesTableViewController.h"
#import "Stage.h"

@interface StagesTableViewController ()

@end

@implementation StagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"Stages";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.trip.stages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StageCell" forIndexPath:indexPath];
    
    NSObject<Stage> *stage = [self.trip.stages objectAtIndex:indexPath.row];
    
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
            vc.stagesList = self.trip.stages;
        }
    }
    
    if([segue.identifier isEqualToString:@"EditStage"]){
        if([segue.destinationViewController isKindOfClass:[DetailStagesTableViewController class]]) {
            DetailStagesTableViewController *vc = (DetailStagesTableViewController *)segue.destinationViewController;
            
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            
            vc.stage = [self.trip.stages objectAtIndex:indexPath.row];
            vc.stagesList = self.trip.stages;
        }
    }
}

@end
