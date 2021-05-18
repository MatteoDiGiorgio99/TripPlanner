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
    for (int i = 0; i < [self.stages count]; i++) {
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
    
    NSObject<Stage> *stage = [self.stages objectAtIndex:indexPath.row];
    
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
            vc.stagesList = self.stages;
        }
    }
    
    if([segue.identifier isEqualToString:@"EditStage"]){
        if([segue.destinationViewController isKindOfClass:[DetailStagesTableViewController class]]) {
            DetailStagesTableViewController *vc = (DetailStagesTableViewController *)segue.destinationViewController;
            
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            
            vc.stage = [self.stages objectAtIndex:indexPath.row];
            vc.stagesList = self.stages;
        }
    }
    if([segue.identifier isEqualToString:@"ShowMap"]){
        if([segue.destinationViewController isKindOfClass:[StagesMapViewController class]]) {
            StagesMapViewController *vc = (StagesMapViewController *)segue.destinationViewController;
            
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
            vc.stages = self.stages;
        }
        
    }
}

@end
