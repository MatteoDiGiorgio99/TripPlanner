//
//  NewTripTableViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 11/05/21.
//

#import "NewTripTableViewController.h"
#import "TripListTableViewController.h"
#import "StagesTableViewController.h"
#import "Stage.h"

@interface NewTripTableViewController ()
@property (nonnull, nonatomic, strong) NSArray *transportation;
@property (nonatomic, strong) NSString *selectedTransport;
@property (nonatomic, strong) NSMutableArray<Stage> *protoStage;

@property (weak, nonatomic) IBOutlet UITextField *descriptionTrip;
@property (weak, nonatomic) IBOutlet UITextField *nameTrip;
@property (weak, nonatomic) IBOutlet UITextField *departureCity;
@property (weak, nonatomic) IBOutlet UITextField *destinationCity;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *finishDate;
@property (weak, nonatomic) IBOutlet UITextField *hotelName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property (weak, nonatomic) IBOutlet UIPickerView *meanOfTransport;

@end

@implementation NewTripTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.startDate.minimumDate=[NSDate date];
    self.finishDate.minimumDate=[NSDate date];
    
    self.transportation = @[@"Car", @"Bike", @"Motorbike", @"Train", @"Boat", @"Airplane"];
    
    self.selectedTransport = self.transportation[0];
    
    self.meanOfTransport.dataSource = self;
    self.meanOfTransport.delegate = self;
    
    self.protoStage = [[NSMutableArray<Stage> alloc] init];
    
    if(self.trip != nil) {
        // TODO: Carico dati dalla classe alla View
        self.title=@"Edit Trip";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        [formatter setDateFormat:@"MM/dd/yy HH:mm"];
        
        self.nameTrip.text=self.trip.nameTrip;
        self.descriptionTrip.text=self.trip.descriptionTrip;
        self.departureCity.text = self.trip.departure;
        self.destinationCity.text = self.trip.destination;
        self.startDate.date=[formatter dateFromString:self.trip.startTrip];
        self.finishDate.date=[formatter dateFromString:self.trip.finishTrip];
        self.hotelName.text=self.trip.hotelName;
        
        if(self.trip.meanTransport != nil) {
            NSInteger index = [self.transportation indexOfObject:self.trip.meanTransport];
            [self.meanOfTransport selectRow:index inComponent:0 animated:YES];
        }
        
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
            return @"Stages";
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
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        [formatter setDateFormat:@"MM/dd/yy HH:mm"];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Date not valid"
                         message:@"The finish trip date is not valid"
                         preferredStyle:UIAlertControllerStyleAlert];
       //We add buttons to the alert controller by creating UIAlertActions:
       UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                  style:UIAlertActionStyleDefault
                                                  handler:nil];
        NSComparisonResult result=[self.finishDate.date compare:self.startDate.date];
        
        if([self.departureCity.text isEqual:@""] || [self.destinationCity.text isEqual:@""] || [self.nameTrip.text isEqual:@""])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information Trip Not Valid"
                             message:@"You are missed important information of trip"
                             preferredStyle:UIAlertControllerStyleAlert];
           //We add buttons to the alert controller by creating UIAlertActions:
           UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                      style:UIAlertActionStyleDefault
                                                      handler:nil];
            
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else{
            switch(result){
                case NSOrderedAscending:
                    
                       [alertController addAction:actionOk];
                       [self presentViewController:alertController animated:YES completion:nil];
                    break;
                case NSOrderedDescending:
                            
                    self.trip = [[Trip alloc] init];
                    self.trip.nameTrip = self.nameTrip.text;
                    self.trip.descriptionTrip = self.descriptionTrip.text;
                    self.trip.departure = self.departureCity.text;
                    self.trip.destination = self.destinationCity.text;
                    self.trip.startTrip=[formatter stringFromDate:self.startDate.date];
                    self.trip.finishTrip = [formatter stringFromDate:self.finishDate.date];
                    self.trip.imageTrip=[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.destinationCity.text]];
                    self.trip.hotelName=self.hotelName.text;
                    self.trip.meanTransport=self.selectedTransport;
                    self.trip.stages = self.protoStage;
                    [[self.tripDataSource getTrips] add:self.trip];
                    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
                    break;
                case NSOrderedSame:
                    
                    self.trip = [[Trip alloc] init];
                    self.trip.nameTrip = self.nameTrip.text;
                    self.trip.descriptionTrip = self.descriptionTrip.text;
                    self.trip.departure = self.departureCity.text;
                    self.trip.destination = self.destinationCity.text;
                    self.trip.startTrip=[formatter stringFromDate:self.startDate.date];
                    self.trip.finishTrip = [formatter stringFromDate:self.finishDate.date];
                    self.trip.imageTrip=[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.destinationCity.text]];
                    self.trip.hotelName=self.hotelName.text;
                    self.trip.meanTransport=self.selectedTransport;
                    self.trip.stages = self.protoStage;
                    [[self.tripDataSource getTrips] add:self.trip];
                    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
                    break;
            }
        }
    } else {
        //Aggiornamento
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        [formatter setDateFormat:@"MM/dd/yy HH:mm"];

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Date not valid"
                         message:@"The finish trip date is not valid"
                         preferredStyle:UIAlertControllerStyleAlert];
       //We add buttons to the alert controller by creating UIAlertActions:
       UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                  style:UIAlertActionStyleDefault
                                                  handler:nil];
        NSComparisonResult result=[self.finishDate.date compare:self.startDate.date];
        if([self.departureCity.text isEqual:@""] || [self.destinationCity.text isEqual:@""] || [self.nameTrip.text isEqual:@""])
        {
            UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"Information Trip Not Valid"
                             message:@"You are missed important information of trip"
                             preferredStyle:UIAlertControllerStyleAlert];
           //We add buttons to the alert controller by creating UIAlertActions:
           UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                      style:UIAlertActionStyleDefault
                                                      handler:nil];
            
            [alertController2 addAction:actionOk];
            [self presentViewController:alertController2 animated:YES completion:nil];
            
        }
        else{
        switch(result){
            case NSOrderedAscending:
                
                [alertController addAction:actionOk];
                [self presentViewController:alertController animated:YES completion:nil];
                break;
            case NSOrderedDescending:
                        
                
                self.trip.nameTrip = self.nameTrip.text;
                self.trip.descriptionTrip = self.descriptionTrip.text;
                self.trip.departure = self.departureCity.text;
                self.trip.destination = self.destinationCity.text;
                self.trip.startTrip=[formatter stringFromDate:self.startDate.date];
                self.trip.finishTrip = [formatter stringFromDate:self.finishDate.date];
                self.trip.imageTrip=[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.destinationCity.text]];
                self.trip.hotelName=self.hotelName.text;
                self.trip.meanTransport=self.selectedTransport;
                self.trip.stages = self.protoStage;
               
                [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
                break;
            case NSOrderedSame:
                
                
                self.trip.nameTrip = self.nameTrip.text;
                self.trip.descriptionTrip = self.descriptionTrip.text;
                self.trip.departure = self.departureCity.text;
                self.trip.destination = self.destinationCity.text;
                self.trip.startTrip=[formatter stringFromDate:self.startDate.date];
                self.trip.finishTrip = [formatter stringFromDate:self.finishDate.date];
                self.trip.imageTrip=[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.destinationCity.text]];
                self.trip.hotelName=self.hotelName.text;
                self.trip.meanTransport=self.selectedTransport;
                self.trip.stages = self.protoStage;
                
                [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
                break;
        }
        }
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"StagesTableView"]){
        if([segue.destinationViewController isKindOfClass:[StagesTableViewController class]]) {
            StagesTableViewController *vc = (StagesTableViewController *)segue.destinationViewController;
            
            if(self.trip != nil) {
                vc.stages = self.trip.stages;
            } else {
                vc.stages = self.protoStage;
            }
            
            vc.trip=self.trip;
        }
    }
}

@end
