//
//  DetailStagesTableViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import "DetailStagesTableViewController.h"
#import "DisplacementCoreData.h"
#import "Permanence.h"
#import "Stage.h"

@interface DetailStagesTableViewController ()


@property (nonnull, nonatomic, strong) NSArray *transportation;
@property (nonatomic, strong) NSString *selectedTransport;

@property (weak, nonatomic) IBOutlet UISwitch *chooseTipeStages;
@property (weak, nonatomic) IBOutlet UITextField *departureCity;
@property (weak, nonatomic) IBOutlet UITextField *destinationCity;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *arrivalDate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteItem;
@property (weak, nonatomic) IBOutlet UIPickerView *meanofTransportStage;

@end

@implementation DetailStagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"MM/dd/yy HH:mm"];
        
   
    self.startDate.minimumDate= [formatter dateFromString:self.trip.startTrip];
    self.startDate.maximumDate = [formatter dateFromString:self.trip.finishTrip];
    self.arrivalDate.minimumDate= [formatter dateFromString:self.trip.startTrip];
    self.arrivalDate.maximumDate=[formatter dateFromString:self.trip.finishTrip];
    
    self.transportation = @[@"Car", @"Bike", @"Motorbike", @"Airplane"];
    
    self.selectedTransport = self.transportation[0];
    
    self.meanofTransportStage.dataSource = self;
    self.meanofTransportStage.delegate = self;
    
    self.title=@"Edit Stage";
    
    [self setPermanenceSettings];
    
    if(self.stage == nil) {
        self.deleteItem.enabled = NO;
    } else {
        if([self.stage isKindOfClass:[PermanenceCoreData class]]) {
            [self setPermanenceSettings];
            
            PermanenceCoreData *stage = (PermanenceCoreData *)self.stage;
            
            self.destinationCity.text = stage.destination;
            self.startDate.date = stage.departureDate;
            self.arrivalDate.date = stage.arrivalDate;
           
           
            
        } else if([self.stage isKindOfClass:[DisplacementCoreData class]]) {
            [self setDisplacementSettings];
            
            DisplacementCoreData *stage = (DisplacementCoreData *)self.stage;
            self.destinationCity.text = stage.destination;
            self.departureCity.text = stage.departure;
            self.arrivalDate.date = stage.displacementDate;
            if(self.stage.meanofTransportSelected != nil) {
                NSInteger index = [self.transportation indexOfObject:self.stage.meanofTransportSelected];
                [self.meanofTransportStage selectRow:index inComponent:0 animated:YES];
            }
            
        }
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
            return @"Type Stage";
            break;
        case 1:
            return @"Insert Stage";
            break;
        case 2:
            return @"Transport";
        default:
            return nil;
            break;
    }
}


- (IBAction)typeStageEventChanged:(UISwitch *)sender forEvent:(UIEvent *)event {
    if(sender.on) {
        [self setPermanenceSettings];
    } else {
        [self setDisplacementSettings];
    }
}


- (void) setDisplacementSettings {
    self.chooseTipeStages.on = NO;
    
    self.departureCity.enabled = YES;
    self.destinationCity.enabled = YES;
    
    self.startDate.enabled = NO;
    self.arrivalDate.enabled = YES;
    
    self.meanofTransportStage.userInteractionEnabled=YES;
}

- (void) setPermanenceSettings {
    self.chooseTipeStages.on = YES;
    
    self.departureCity.enabled = NO;
    self.destinationCity.enabled = YES;
    
    self.startDate.enabled = YES;
    self.arrivalDate.enabled = YES;
    
    self.meanofTransportStage.userInteractionEnabled=NO;
}

- (IBAction)deleteItemClick:(id)sender {
    if(self.stage != nil) {
        CoreDataController *controller = CoreDataController.sharedInstance;
        [controller deleteStage:self.trip:self.stage];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)saveItem:(id)sender {
    if(self.stage == nil) {
        
        //INSERIMENTO
        if(self.chooseTipeStages.on == YES)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Date not valid"
                             message:@"The finish trip date is not valid"
                             preferredStyle:UIAlertControllerStyleAlert];
           //We add buttons to the alert controller by creating UIAlertActions:
           UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                      style:UIAlertActionStyleDefault
                                                      handler:nil];
            NSComparisonResult result=[self.arrivalDate.date compare:self.startDate.date];
            if([self.destinationCity.text isEqual:@""])
            {
                UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"Information Stage Not Valid"
                                 message:@"You are missed important information of stage"
                                 preferredStyle:UIAlertControllerStyleAlert];
               //We add buttons to the alert controller by creating UIAlertActions:
               UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault
                                                          handler:nil];
                
                [alertController2 addAction:actionOk];
                [self presentViewController:alertController2 animated:YES completion:nil];
            }
            else{
                CoreDataController *controller = CoreDataController.sharedInstance;
                
                 self.permanence = [[PermanenceCoreData alloc] initWithContext:controller.context];
                
                self.permanence.arrivalDate = self.arrivalDate.date;
                self.permanence.departureDate = self.startDate.date;
                self.permanence.destination = self.destinationCity.text;
                self.permanence.meanTransport = @"";
                
                switch(result){
                    case NSOrderedAscending:
                        [alertController addAction:actionOk];
                        [self presentViewController:alertController animated:YES completion:nil];
                        break;
                    case NSOrderedDescending:
                        [controller addPermanence:self.trip:self.permanence];
                        [self.navigationController popViewControllerAnimated:YES];
                        break;
                    case NSOrderedSame:
                        [controller addPermanence:self.trip:self.permanence];
                        [self.navigationController popViewControllerAnimated:YES];
                        break;
                }
            }
          
        }
        else
        {
         //ADD DISPLACEMENT
            if([self.departureCity.text isEqual:@""] || [self.destinationCity.text isEqual:@""])
            {
                UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"Information Stage Not Valid"
                                 message:@"You are missed important information of stage"
                                 preferredStyle:UIAlertControllerStyleAlert];
               //We add buttons to the alert controller by creating UIAlertActions:
               UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault
                                                          handler:nil];
                
                [alertController2 addAction:actionOk];
                [self presentViewController:alertController2 animated:YES completion:nil];
            }
            else{
                CoreDataController *controller = CoreDataController.sharedInstance;
                
                self.displacement = [[DisplacementCoreData alloc] initWithContext:controller.context];
                
                self.displacement.departure = self.departureCity.text;
                self.displacement.destination = self.destinationCity.text;
                self.displacement.displacementDate = self.arrivalDate.date;
                self.displacement.meanTransport = self.selectedTransport;
                
                [controller addDisplacement:self.trip:self.displacement];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } else {
        
        //AGGIORNAMENTO
        
        if(self.chooseTipeStages.on == YES)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Date not valid"
                             message:@"The finish trip date is not valid"
                             preferredStyle:UIAlertControllerStyleAlert];
           //We add buttons to the alert controller by creating UIAlertActions:
           UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                      style:UIAlertActionStyleDefault
                                                      handler:nil];
            NSComparisonResult result=[self.arrivalDate.date compare:self.startDate.date];
            if([self.destinationCity.text isEqual:@""])
            {
                UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"Information Stage Not Valid"
                                 message:@"You are missed important information of stage"
                                 preferredStyle:UIAlertControllerStyleAlert];
               //We add buttons to the alert controller by creating UIAlertActions:
               UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault
                                                          handler:nil];
                
                [alertController2 addAction:actionOk];
                [self presentViewController:alertController2 animated:YES completion:nil];
            }
            else{
                CoreDataController *controller = CoreDataController.sharedInstance;
                
                self.permanence = [[PermanenceCoreData alloc] initWithContext:controller.context];
                
                self.permanence.arrivalDate = self.arrivalDate.date;
                self.permanence.departureDate = self.startDate.date;
                self.permanence.destination = self.destinationCity.text;
                self.permanence.meanTransport = self.selectedTransport;
           
                
                switch(result){
                    case NSOrderedAscending:
                        [alertController addAction:actionOk];
                        [self presentViewController:alertController animated:YES completion:nil];
                        break;
                    case NSOrderedDescending:
                        [controller updatePermanence:self.trip:self.stage:self.permanence];
                        [self.navigationController popViewControllerAnimated:YES];
                    
                        break;
                    case NSOrderedSame:
                        [controller updatePermanence:self.trip:self.stage:self.permanence];
                        [self.navigationController popViewControllerAnimated:YES];
                        
                        break;
                }
            }
        }
        else
        {
           if([self.departureCity.text isEqual:@""] || [self.destinationCity.text isEqual:@""])
            {
                UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"Information Stage Not Valid"
                                 message:@"You are missed important information of stage"
                                 preferredStyle:UIAlertControllerStyleAlert];
               //We add buttons to the alert controller by creating UIAlertActions:
               UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault
                                                          handler:nil];
                
                [alertController2 addAction:actionOk];
                [self presentViewController:alertController2 animated:YES completion:nil];
            }
            else{
                //Aggiornamento Displacement
                CoreDataController *controller = CoreDataController.sharedInstance;
                
                self.displacement = [[DisplacementCoreData alloc] initWithContext:controller.context];
                
                self.displacement.departure = self.departureCity.text;
                self.displacement.destination = self.destinationCity.text;
                self.displacement.displacementDate = self.arrivalDate.date;
                self.displacement.meanTransport = self.selectedTransport;
                
                [controller updateDisplacement:self.trip:self.stage:self.displacement];
                [self.navigationController popViewControllerAnimated:YES];
                    
            }
        }
    }
}

@end
