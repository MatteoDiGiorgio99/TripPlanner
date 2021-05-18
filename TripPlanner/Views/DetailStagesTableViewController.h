//
//  DetailStagesTableViewController.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 17/05/21.
//

#import <UIKit/UIKit.h>
#import "Stage.h"

@interface DetailStagesTableViewController : UITableViewController

@property (nonatomic, strong) id<Stage> stage;
@property (nonatomic, strong) NSMutableArray<Stage> *stagesList;

@end
