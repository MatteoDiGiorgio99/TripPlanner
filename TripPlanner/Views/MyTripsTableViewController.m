//
//  MyTripsTableViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 12/05/21.
//

#import "MyTripsTableViewController.h"
#import "ExampleTripDataSource.h"
#import "TripList.h"
#import "NewTripTableViewController.h"
#import <QuartzCore/QuartzCore.h>

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
    
    CGSize  itemSize = CGSizeMake(210, 130);
    UIGraphicsBeginImageContextWithOptions(itemSize, false, self.view.contentScaleFactor);
    CGRect  imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return cell;
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"EditTrip"]){
        if([segue.destinationViewController isKindOfClass:[NewTripTableViewController class]]) {
            NewTripTableViewController *vc = (NewTripTableViewController *)segue.destinationViewController;
            
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            
            vc.trip = [[self.tripDataSource getTrips] getAtIndex:indexPath.row];
            vc.tripDataSource=self.tripDataSource;
        }
    }
}


@end
