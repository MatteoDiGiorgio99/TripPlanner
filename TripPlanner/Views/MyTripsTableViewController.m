//
//  MyTripsTableViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 12/05/21.
//

#import "MyTripsTableViewController.h"
#import "ExampleTripDataSource.h"
#import "TripList.h"

@interface MyTripsTableViewController ()


@end

@implementation MyTripsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"My Trips";
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.tripDataSource getTrips] size];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TripCell" forIndexPath:indexPath];
    Trip *t = [[self.tripDataSource getTrips] getAtIndex:indexPath.row];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@",t.destination];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",t.nameTrip];
    cell.imageView.image=t.imageTrip;
    
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
