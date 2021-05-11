//
//  NewTripTableViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 11/05/21.
//

#import "NewTripTableViewController.h"
#import "TripListTableViewController.h"
@interface NewTripTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *departureCity;
@property (weak, nonatomic) IBOutlet UITextField *destinationCity;
@property (weak, nonatomic) IBOutlet UITextField *startDate;
@property (weak, nonatomic) IBOutlet UITextField *finishDate;
@property (weak, nonatomic) IBOutlet UITextField *meanOfTransport;
@property (weak, nonatomic) IBOutlet UITextField *hotelName;
@property (weak, nonatomic) IBOutlet UITextField *pointOfInterest1;
@property (weak, nonatomic) IBOutlet UITextField *pointOfInterest2;
@property (weak, nonatomic) IBOutlet UITextField *pointOfInterest3;
@property (weak, nonatomic) IBOutlet UITextField *pointOfInterest4;

@end

@implementation NewTripTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"New Trip";

}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Destination";
            break;
        case 1:
            return @"Means of transport";
            break;
        case 2:
            return @"Hotel";
            break;
        case 3:
            return @"Point of Interest";
            break;
        default:
            return nil;
            break;
    }
}

- (IBAction)saveButton:(id)sender {
    if(self.trip == nil) {
        self.trip = [[Trip alloc] init];
        
        self.trip.departure = self.departureCity.text;
        self.trip.datedeparture = self.startDate.text;
        self.trip.destination = self.destinationCity.text;
        self.trip.finishTrip = self.finishDate.text;
        
        [[self.tripDataSource getTrips] add:self.trip];
    }
}

@end
