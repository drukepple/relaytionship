//
//  RTCoreDataAgent.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/18/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTCoreDataAgent.h"
#import "Runner.h"
#import "Leg.h"
#import "Van.h"

@interface RTCoreDataAgent (Private)
- (void) initializeDefaultData;
@end

@implementation RTCoreDataAgent

- (id) initWithStoreName:(NSString *)storeName {
	if (self = [super initWithStoreName:storeName]) {
		// If there is no data, pre-populate wiht 12 runners and 36 legs.
		[self initializeDefaultData];
	}
	return self;
}

- (void) initializeDefaultData {
	// If there is no data, pre-populate wiht 12 runners and 36 legs.
	if ([self fetchAllEntitiesOfName:@"Runner"].count == 0) {
		Runner *r;
		Leg *l;
		Van *v;
		
		for (int i = 1; i <= 2; i++) {
			v = [self makeVan:i];
			
			for (int j = 1; j <= 6; j++) {
				int runnerIndex = ((i-1)*6)+j;
				r = (Runner *)[self makeRunner:[NSString stringWithFormat:@"Runner %d", runnerIndex]];
				r.numberValue = runnerIndex;
				r.van = v;
				
				for (int k = 1; k <= 3; k++) {
					int legIndex = runnerIndex + (12 * (k-1));
					//NSLog(@"van %d -- runner %d :: mult: %d -- leg: %d", i, j, runnerIndex, legIndex);
					l = [self makeLeg:legIndex distance:5.0];
					l.runner = r;
				}
			}
		}
		
//		for (int i = 1; i <= 12; i++) {
//			r = (Runner *)[self insertEntityWithName:@"Runner"];
//			r.name = [NSString stringWithFormat:@"Runner %d", i];
//			for (int j = 1; j <= 3; j++) {
//				l = (Leg *)[self insertEntityWithName:@"Leg"];
//				l.number = [NSNumber numberWithInt:j * i];
//				l.distance = [NSNumber numberWithDouble:5.0];
//				l.runner = r;
//			}
//		}
		
		//
		
		[self saveContext];
	}
	
	if ([self fetchAllEntitiesOfName:@"AppSettings"].count == 0) {
//		self.selectedTab = RTCoreDataAgentAppSettingsTabTeamRoster;
//		self.isTiming = NO;
//		AppSettings *a = (AppSettings *)[self insertEntityWithName:@"AppSettings"];
//		a.selectedTab = RTCoreDataAgentAppSettingsTabTeamRoster;
		[self appSettings];
		[self saveContext];
		NSLog(@"Just set default first tab");
	}

}



#pragma mark - Creation
- (Van *)makeVan:(int16_t)number {
	Van *v = (Van *)[self insertEntityWithName:@"Van"];
	v.numberValue = number;
	return v;
}

- (Runner *)makeRunner:(NSString *)name {
	Runner *r = (Runner *)[self insertEntityWithName:@"Runner"];
	r.name = name;
	return r;
}

- (Leg *)makeLeg:(int16_t)number distance:(float)distance {
	Leg *l = (Leg *)[self insertEntityWithName:@"Leg"];
	l.numberValue = number;
	l.distanceValue = distance;
	return l;
}

- (LegTime *) makeLegTime {
	LegTime *l = (LegTime *)[self insertEntityWithName:@"LegTime"];
	l.startTime = [NSDate date];
	int completedLegs = [self allCompletedLegs].count;
	l.leg = [self legByIndex:completedLegs];
	//NSLog(@"--------------------------------\nMAKE LEG TIME\ncompletedLegs: %d\ntargetLeg: %@", completedLegs, l.leg);
	[self saveContext];
	return l;
}

#pragma mark - Retrieval

#pragma mark Runner
- (Runner *)runnerByIndexPath:(NSIndexPath *)indexPath {
	int16_t runnerNumber = ((indexPath.section+0) * 6) + (indexPath.row+1);
//	NSLog(@"runnerNumber: %d", runnerNumber);
	Runner *r = (Runner *)[self fetchFirstEntityOfName:@"Runner" withPredicate:@"number = %d", runnerNumber];
	return r;
}
//- (Runner *r)runnerByIndexPath:(NSIndexPath *)indexPath {
//	Runner *r = (Runner *)[self fetchFirstEntityOfName:@"Runner" withPredicate:@"number = %d AND van.number = %d", indexPath.row+1 + (indexPath.section * 6), indexPath.section+1];
//
//}
#pragma mark Leg
- (Leg *)legByIndex:(int16_t)index {
	return (Leg*)[self fetchFirstEntityOfName:@"Leg" withPredicate:@"number = %d", index + 1];
}
- (NSArray *) allLegs {
	return [self fetchAllEntitiesOfName:@"Leg" sortedOn:@"number" ascending:YES];
}

- (NSArray *) allLegTimes {
	return [self fetchAllEntitiesOfName:@"LegTime" sortedOn:@"leg.number" ascending:YES];
}
- (NSArray *) allCompletedLegs {
	NSArray *_allLegs = [self allLegs];
	NSMutableArray *_allCompletedLegs = [[NSMutableArray alloc] init];
	for (Leg *l in _allLegs) {
		if (l.legTime.endTime != nil) {
			[_allCompletedLegs addObject:l];
		}
	}
	return [_allCompletedLegs copy];
//	return [self fetchEntitiesOfName:@"Leg" withPredicate:@"legTime.endTime != nil"];
}



#pragma mark - AppSettings
- (AppSettings *) appSettings {
	AppSettings *a;
	NSArray *appSettings =[self fetchAllEntitiesOfName:@"AppSettings"];
	if (appSettings.count == 0) {
		a = (AppSettings *)[self insertEntityWithName:@"AppSettings"];
	} else {
		a = (AppSettings *)[appSettings objectAtIndex:0];
	}
	return a;
}
- (void) setSelectedTab:(enum RTCoreDataAgentAppSettingsTab)selectedTab {
	AppSettings *a = [self appSettings];
	a.selectedTabValue = selectedTab;
	[self saveContext];
}
- (enum RTCoreDataAgentAppSettingsTab)selectedTab {
	AppSettings *a = [self appSettings];
	return a.selectedTabValue;
}
- (void) setIsTiming:(BOOL)isTiming {
	[self appSettings].isTimingValue = isTiming;
	[self saveContext];
}
- (BOOL) isTiming {
	return [self appSettings].isTimingValue;
}


@end
