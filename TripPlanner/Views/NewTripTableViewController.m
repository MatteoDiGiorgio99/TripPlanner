//
//  NewTripTableViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 11/05/21.
//

#import "NewTripTableViewController.h"
#import "TripListTableViewController.h"
@interface NewTripTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *descriptionTrip;
@property (weak, nonatomic) IBOutlet UITextField *nameTrip;
@property (weak, nonatomic) IBOutlet UITextField *departureCity;
@property (weak, nonatomic) IBOutlet UITextField *destinationCity;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *finishDate;
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
            return @"Info";
            break;
        case 1:
            return @"Destination";
            break;
        case 2:
            return @"Means of transport";
            break;
        case 3:
            return @"Hotel";
            break;
        case 4:
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
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterNoStyle];

        self.trip.nameTrip = self.nameTrip.text;
        self.trip.descriptionTrip = self.descriptionTrip.text;
        self.trip.departure = self.departureCity.text;
        self.trip.destination = self.destinationCity.text;
        self.trip.startTrip=[formatter stringFromDate:self.startDate.date];
        self.trip.finishTrip = [formatter stringFromDate:self.finishDate.date];
        self.trip.imageTrip=[UIImage imageNamed:[NSString stringWithFormat:@"/Volumes/Transcend/UNIPR/3 ANNO/PROGRAMMAZIONE MOBILE (Ciriani)/IOS/Project/TripPlanner/TripPlanner/Image/%@.jpg",self.destinationCity.text]];

        
        [[self.tripDataSource getTrips] add:self.trip];
    }
}

@end
