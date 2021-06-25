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
#include "StageCoreData.h"

@interface DetailStagesTableViewController : UITableViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) NSManagedObject<Stage>* stage;
@property (nonatomic, strong) NSMutableArray<Stage> *stagesList;
@property (nonatomic, strong) TripCoreData *trip;
@property (nonatomic, strong) StageCoreData *stageData;
@property (nonatomic, strong) DisplacementCoreData* displacement;
@property (nonatomic, strong) PermanenceCoreData* permanence;
@end
