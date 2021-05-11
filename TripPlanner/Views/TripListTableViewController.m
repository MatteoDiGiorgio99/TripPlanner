//
//  TripListTableViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 10/05/21.
//

#import "TripListTableViewController.h"
#import "TripList.h"
#import "ExampleTripDataSource.h"
#import "NewTripTableViewController.h"

@interface TripListTableViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageNextTrip;
@property (weak, nonatomic) IBOutlet UILabel *destinationTripLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTripLabel;
@property (weak, nonatomic) IBOutlet UILabel *MyTripsLabel;
@property (weak, nonatomic) IBOutlet UILabel *MyLocationLabel;




@end

@implementation TripListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"My Profile";
    
    self.tripDataSource = [[ExampleTripDataSource alloc] init];
    
    if (self.dateTripLabel != nil) {
        // TODO: METODO PER ANDARE A VEDERE LA PARTENZA PIU VICINA
    }
    
    _destinationTripLabel.text=@"No trips saved";
    _dateTripLabel.text=@"-----";
    _MyTripsLabel.text=@"My Trips (0)";
    _MyLocationLabel.text=@"My Location";
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if([[self.tripDataSource getTrips] size] > 0) {
       
        self.thetrip = [[self.tripDataSource getTrips] getAtIndex:0];
        self.destinationTripLabel.text = [self.thetrip destination];
        self.dateTripLabel.text=[NSString stringWithFormat:@"%@ to %@",[self.thetrip startTrip],[self.thetrip finishTrip]];
        self.MyTripsLabel.text=[NSString stringWithFormat:@"My Trips (%li)",[[self.tripDataSource getTrips]size]];
        self.imageNextTrip.image=[self.thetrip imageTrip];
    }
}

/*
- (void) loadImage{
    if(self.thetrip.imageTrip != nil){
        dispatch_async(dispatch_queue_create("imageDownload", NULL), ^{
            NSURL *url = [NSURL URLWithString:self.thetrip.imageTrip];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageNextTrip.image = image;
            });
        });
    }
}*/

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"My Next Trip";
            break;
        case 1:
            return @"Menù";
            break;
            
        default:
            return nil;
            break;
    }
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"NewTrip"]) {
        if([segue.destinationViewController isKindOfClass:[NewTripTableViewController class]]) {
            NewTripTableViewController *vc = (NewTripTableViewController *)segue.destinationViewController;
            
            vc.trip = nil;
            vc.tripDataSource = self.tripDataSource;
        }
    }
    
}

@end
