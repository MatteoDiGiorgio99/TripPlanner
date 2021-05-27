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
        if([self.stage isKindOfClass:[Permanence class]]) {
            [self setPermanenceSettings];
            
            Permanence *stage = (Permanence *)self.stage;
            
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
        [self.stagesList removeObject:self.stage];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)saveItem:(id)sender {
    if(self.stage == nil) {
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
                
                PermanenceCoreData *permanence = [[PermanenceCoreData alloc] initWithContext:controller.context];
                
                permanence.arrivalDate = self.arrivalDate.date;
                permanence.departureDate = self.startDate.date;
                permanence.destination = self.destinationCity.text;
                permanence.meanTransport = @"";
                
                switch(result){
                    case NSOrderedAscending:
                        [alertController addAction:actionOk];
                        [self presentViewController:alertController animated:YES completion:nil];
                        break;
                    case NSOrderedDescending:
                        [controller addPermanence:self.trip:permanence];
                        [self.navigationController popViewControllerAnimated:YES];
                        break;
                    case NSOrderedSame:
                        [controller addPermanence:self.trip:permanence];
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
                CoreDataController *controller = CoreDataController.sharedInstance;
                
                DisplacementCoreData *displacement = [[DisplacementCoreData alloc] initWithContext:controller.context];
                
                displacement.departure = self.departureCity.text;
                displacement.destination = self.destinationCity.text;
                displacement.displacementDate = self.arrivalDate.date;
                displacement.meanTransport = self.selectedTransport;
                
                [controller addDisplacement:self.trip:displacement];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } else {
        
        //Aggiornamento
        
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
                
            Permanence *stageP= [[Permanence alloc] initWithDestination:self.destinationCity.text ArrivalDate:self.arrivalDate.date DepartureDate:self.startDate.date MeanTransport:@""];
                
                NSInteger index = [self.stagesList indexOfObject:self.stage];
                
                switch(result){
                    case NSOrderedAscending:
                        [alertController addAction:actionOk];
                        [self presentViewController:alertController animated:YES completion:nil];
                        break;
                    case NSOrderedDescending:
                   
                        [self.stagesList replaceObjectAtIndex:index withObject:stageP];
                        [self.navigationController popViewControllerAnimated:YES];
                    
                        break;
                    case NSOrderedSame:
                
                        [self.stagesList replaceObjectAtIndex:index withObject:stageP];
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
                /// TODO: Aggiornamento
                
                [self.navigationController popViewControllerAnimated:YES];
                    
            }
        }
    }
}

@end
