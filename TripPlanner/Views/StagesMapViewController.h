//
//  StagesMapViewController.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 18/05/21.
//

#import <UIKit/UIKit.h>
#import "Stage.h"

NS_ASSUME_NONNULL_BEGIN

@interface StagesMapViewController : UIViewController

@property (nonatomic, strong) NSMutableArray<Stage> *stages;

@end

NS_ASSUME_NONNULL_END
