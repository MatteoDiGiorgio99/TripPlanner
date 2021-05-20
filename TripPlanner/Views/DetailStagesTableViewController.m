//
//  DetailStagesTableViewController.m
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import "DetailStagesTableViewController.h"
#import "Displacement.h"
#import "Permanence.h"
#import "Stage.h"

@interface DetailStagesTableViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *chooseTipeStages;
@property (weak, nonatomic) IBOutlet UITextField *departureCity;
@property (weak, nonatomic) IBOutlet UITextField *destinationCity;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *arrivalDate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteItem;

@end

@implementation DetailStagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.startDate.minimumDate=[NSDate date];
    self.arrivalDate.minimumDate=[NSDate date];
    
    self.title=@"Edit Stage";
    
    [self setPermanenceSettings];
    
    if(self.stage == nil) {
        self.deleteItem.enabled = NO;
    } else {
        if([self.stage isKindOfClass:[Permanence class]]) {
            [self setPermanenceSettings];
            
            Permanence *stage = (Permanence *)self.stage;
            
            self.destinationCity.text = stage.destination;
        } else if([self.stage isKindOfClass:[Displacement class]]) {
            [self setDisplacementSettings];
            
            Displacement *stage = (Displacement *)self.stage;
            self.destinationCity.text = stage.destination;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Type Stage";
            break;
        case 1:
            return @"Insert Data";
            break;
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
}

- (void) setPermanenceSettings {
    self.chooseTipeStages.on = YES;
    
    self.departureCity.enabled = NO;
    self.destinationCity.enabled = YES;
    
    self.startDate.enabled = YES;
    self.arrivalDate.enabled = YES;
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
            Permanence *stageP= [[Permanence alloc] initWithDestination:self.destinationCity.text ArrivalDate:self.arrivalDate.date DepartureDate:self.startDate.date];
           
            [self.stagesList addObject:stageP];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else
        {
            Displacement *stageD = [[Displacement alloc] initWithDeparture:self.departureCity.text Destination:self.destinationCity.text ArrivalDate:self.arrivalDate.date];
            
            [self.stagesList addObject:stageD];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        
        if(self.chooseTipeStages.on == YES)
        {
            Permanence *stageP= [[Permanence alloc] initWithDestination:self.destinationCity.text ArrivalDate:self.arrivalDate.date DepartureDate:self.startDate.date];
           
            [self.stagesList addObject:stageP];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else
        {
            Displacement *stageD = [[Displacement alloc] initWithDeparture:self.departureCity.text Destination:self.destinationCity.text ArrivalDate:self.arrivalDate.date];
            
            [self.stagesList addObject:stageD];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
}

@end
