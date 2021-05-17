//
//  StagesTableViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import "StagesTableViewController.h"
#import "Stage.h"

@interface StagesTableViewController ()

@end

@implementation StagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

@end
