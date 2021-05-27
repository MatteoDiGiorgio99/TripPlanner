//
//  DetailStagesTableViewController.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import <UIKit/UIKit.h>
#import "Stage.h"
#import "TripCoreData.h"
#include "CoreDataController.h"

@interface DetailStagesTableViewController : UITableViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) id<Stage> stage;
@property (nonatomic, strong) NSMutableArray<Stage> *stagesList;
@property (nonatomic, strong) TripCoreData *trip;

@end
