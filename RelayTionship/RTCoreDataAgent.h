//
//  RTCoreDataAgent.h
//  RelayTionship
//
//  Created by Dru Kepple on 8/18/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "TKECoreDataAgent.h"
#import "Van.h"
#import "Runner.h"
#import "Leg.h"
#import "AppSettings.h"
#import "LegTime.h"

enum RTCoreDataAgentAppSettingsTab {
	RTCoreDataAgentAppSettingsTabTeamRoster = 0,
	RTCoreDataAgentAppSettingsLegs = 1,
	RTCoreDataAgentAppSettingsTabTimer = 2
	};

@interface RTCoreDataAgent : TKECoreDataAgent

- (Van *)makeVan:(int16_t)number;
- (Runner *)makeRunner:(NSString *)name;
- (Leg *)makeLeg:(int16_t)number distance:(float)distance;

@property (assign, nonatomic) enum RTCoreDataAgentAppSettingsTab selectedTab;
@property (assign, nonatomic) BOOL isTiming;

- (Runner *)runnerByIndexPath:(NSIndexPath *)indexPath;

- (Leg *)legByIndex:(int16_t)index;
- (NSArray *) allLegs;
- (NSArray *) allLegTimes;
- (NSArray *) allCompletedLegs;
- (LegTime *) makeLegTime;


@end
