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
#import "MyTripsTableViewController.h"
#import "AppDelegate.h"

@interface TripListTableViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageNextTrip;
@property (weak, nonatomic) IBOutlet UILabel *destinationTripLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTripLabel;
@property (weak, nonatomic) IBOutlet UILabel *MyTripsLabel;
@property (weak, nonatomic) IBOutlet UILabel *MyLocationLabel;
@property bool notificationGranted;


@end

@implementation TripListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNAuthorizationOptions options = UNAuthorizationOptionAlert+UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            self.notificationGranted = granted;
        }];
    
    self.title=@"My Profile";
    
    self.tripDataSource = [[ExampleTripDataSource alloc] init];
    
    if (self.dateTripLabel != nil) {
        // TODO: METODO PER ANDARE A VEDERE LA PARTENZA PIU VICINA
    }
    
    _destinationTripLabel.text=@"No trips saved";
    _dateTripLabel.text=@"-----";
    _MyTripsLabel.text=@"My Trips (0)";
    _MyLocationLabel.text=@"My Location";
    
        
        if([[self.tripDataSource getTrips] size] > 0) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yy"];
            
            self.thetrip = [[self.tripDataSource getTrips] getAtIndex:0];
            
            for (NSInteger i = 0; i < [[self.tripDataSource getTrips] size]; i++) {
               
                NSDate *today = [NSDate date];
                NSDate *oneDaysPlus = [today dateByAddingTimeInterval:+1*24*60*60];
                NSDate *dateSelectedTrip = [dateFormatter dateFromString:self.thetrip.startTrip];
                
                NSComparisonResult result = [oneDaysPlus compare:dateSelectedTrip];
                NSComparisonResult result2 = [today compare:dateSelectedTrip];
               if(result == NSOrderedDescending && result2== NSOrderedAscending)
               {
                   if(self.notificationGranted) {
                        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                       UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
                       content.title = @"Trip Next to Start";
                       content.body = [NSString stringWithFormat:@"the %@-%@ trip is about to start in less than 24 hours",self.thetrip.departure,self.thetrip.destination];
                       content.sound = [UNNotificationSound defaultSound];
                           
                       UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
                           
                       UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:self.thetrip.nameTrip content:content trigger:trigger];
                           
                       [center addNotificationRequest:request withCompletionHandler:nil];
                   }
               }
            }
    }
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if([[self.tripDataSource getTrips] size] > 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yy HH:mm"];
        
        self.thetrip = [[self.tripDataSource getTrips] getAtIndex:0];
        
        for (NSInteger i = 0; i < [[self.tripDataSource getTrips] size]; i++) {
            Trip *element = [[self.tripDataSource getTrips] getAtIndex:i];
            
            
            NSDate *dateArrayElement = [dateFormatter dateFromString:element.startTrip];
            NSDate *dateSelectedTrip = [dateFormatter dateFromString:self.thetrip.startTrip];
            
            NSComparisonResult result = [dateSelectedTrip compare:dateArrayElement];
            
            
            switch (result) {
                case NSOrderedAscending:
                    break;
                case NSOrderedDescending:
                    self.thetrip = element;
                case NSOrderedSame:
                    break;
            }
        }
        
        self.destinationTripLabel.text = [self.thetrip destination];
        self.dateTripLabel.text=[NSString stringWithFormat:@"%@ to %@",[self.thetrip startTrip],[self.thetrip finishTrip]];
        self.MyTripsLabel.text=[NSString stringWithFormat:@"My Trips (%li)",[[self.tripDataSource getTrips]size]];
        self.imageNextTrip.image=[self.thetrip imageTrip];
        
        for (NSInteger i = 0; i < [[self.tripDataSource getTrips] size]; i++) {
            
            Trip *element = [[self.tripDataSource getTrips] getAtIndex:i];
            NSDate *dateArrayElementNot = [dateFormatter dateFromString:element.startTrip];
            
            NSDate *today = [NSDate date];
            NSDate *oneDaysPlus = [today dateByAddingTimeInterval:+1*24*60*60];
            
            NSComparisonResult result = [oneDaysPlus compare:dateArrayElementNot];
            NSComparisonResult result2 = [ today compare:dateArrayElementNot];
            
            if(result == NSOrderedDescending && result2== NSOrderedAscending)
              {
                 if(self.notificationGranted) {
                        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
                        content.title = @"Trip Next to Start";
                        content.body = [NSString stringWithFormat:@"the %@-%@ trip is about to start in less than 24 hours",self.thetrip.departure,self.thetrip.destination];
                        content.sound = [UNNotificationSound defaultSound];
                           
                        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
                           
                        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:self.thetrip.nameTrip content:content trigger:trigger];
                           
                        [center addNotificationRequest:request withCompletionHandler:nil];
            }
        }
      }
    }
    else
    {
        _destinationTripLabel.text=@"No trips saved";
        _dateTripLabel.text=@"-----";
        _MyTripsLabel.text=@"My Trips (0)";
        _MyLocationLabel.text=@"My Location";
        _imageNextTrip.image=nil;
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
    if([segue.identifier isEqualToString:@"MyTrips"]){
        if([segue.destinationViewController isKindOfClass:[MyTripsTableViewController class]]) {
            MyTripsTableViewController *vc = (MyTripsTableViewController *)segue.destinationViewController;
            
            vc.tripDataSource=self.tripDataSource;
        }
    }
}

@end
