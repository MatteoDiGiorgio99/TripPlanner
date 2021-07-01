//
//  StagesMapViewController.h
//  TripPlanner
//
//  Created by Matteo Di Giorgio on 18/05/21.
//

#import <UIKit/UIKit.h>
#import "Stage.h"
#import "Poi.h"
#import <MapKit/MapKit.h>
#import "TripCoreData.h"
#import "StageCoreData.h"
@interface StagesMapViewController : UIViewController<MKMapViewDelegate>

@property (nonatomic, strong) NSMutableArray<Poi *> *stagesPosition;
@property (nonatomic, strong) TripCoreData *trip;
@property (nonatomic, strong) NSMutableArray<Stage> *stages;
@property (nonatomic, strong) NSMutableArray<Stage> *mapStages;

@end
