//
//  NewTripTableViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 11/05/21.
//

#import "NewTripTableViewController.h"
#import "TripListTableViewController.h"

@interface NewTripTableViewController ()
@property (nonnull, nonatomic, strong) NSArray *transportation;
@property (nonatomic, strong) NSString *selectedTransport;

@property (weak, nonatomic) IBOutlet UITextField *descriptionTrip;
@property (weak, nonatomic) IBOutlet UITextField *nameTrip;
@property (weak, nonatomic) IBOutlet UITextField *departureCity;
@property (weak, nonatomic) IBOutlet UITextField *destinationCity;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *finishDate;
@property (weak, nonatomic) IBOutlet UITextField *hotelName;
@property (weak, nonatomic) IBOutlet UITextField *pointOfInterest1;
@property (weak, nonatomic) IBOutlet UITextField *pointOfInterest2;
@property (weak, nonatomic) IBOutlet UITextField *pointOfInterest3;
@property (weak, nonatomic) IBOutlet UITextField *pointOfInterest4;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property (weak, nonatomic) IBOutlet UIPickerView *meanOfTransport;

@end

@implementation NewTripTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transportation = @[@"Car", @"Bike", @"Motorbike", @"Train", @"Boat", @"Airplane"];
    
    self.meanOfTransport.dataSource = self;
    self.meanOfTransport.delegate = self;
    
    if(self.trip != nil) {
        // TODO: Carico dati dalla classe alla View
        self.title=@"Edit Trip";
        
        self.nameTrip.text=self.trip.nameTrip;
        self.descriptionTrip.text=self.trip.descriptionTrip;
        self.departureCity.text = self.trip.departure;
        self.destinationCity.text = self.trip.destination;
        self.hotelName.text=self.trip.hotelName;
        
        NSInteger index = [self.transportation indexOfObject:self.trip.meanTransport];
        [self.meanOfTransport selectRow:index inComponent:0 animated:YES];
        
    } else {
        self.title=@"New Trip";
        self.deleteButton.enabled = false;
    }
}

//Controller Data Source
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.transportation.count;
}

// Controller Delegates
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.transportation[row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedTransport = self.transportation[row];
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

- (IBAction)deleteTrip:(id)sender {
    if(self.trip != nil) {
        
        [[self.tripDataSource getTrips] remove:self.trip];
        self.nameTrip.text=@"";
        self.descriptionTrip.text=@"";
        self.departureCity.text=@"";
        self.destinationCity.text=@"";
        self.hotelName.text=@"";
        self.selectedTransport=@"";
        [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
        
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
        self.trip.imageTrip=[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.destinationCity.text]];
        self.trip.hotelName=self.hotelName.text;
        self.trip.meanTransport=self.selectedTransport;
        [[self.tripDataSource getTrips] add:self.trip];
        [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
    } else {
        //Aggiornamento
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
        self.trip.imageTrip=[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.destinationCity.text]];
        self.trip.hotelName=self.hotelName.text;
        self.trip.meanTransport=self.selectedTransport;
        [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
    }
}

@end
