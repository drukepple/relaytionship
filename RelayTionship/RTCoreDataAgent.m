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
		NSArray *miles = [NSArray arrayWithObjects:[NSNumber numberWithFloat:5.64],
						  [NSNumber numberWithFloat:5.67],
						  [NSNumber numberWithFloat:3.93],
						  [NSNumber numberWithFloat:7.18],
						  [NSNumber numberWithFloat:6.08],
						  [NSNumber numberWithFloat:6.75],
						  [NSNumber numberWithFloat:6.32],
						  [NSNumber numberWithFloat:4.55],
						  [NSNumber numberWithFloat:6.96],
						  [NSNumber numberWithFloat:5.12],
						  [NSNumber numberWithFloat:4.84],
						  [NSNumber numberWithFloat:6.32],
						  
						  [NSNumber numberWithFloat:4.21],
						  [NSNumber numberWithFloat:6.08],
						  [NSNumber numberWithFloat:7.25],
						  [NSNumber numberWithFloat:4.10],
						  [NSNumber numberWithFloat:7.13],
						  [NSNumber numberWithFloat:5.23],
						  [NSNumber numberWithFloat:5.89],
						  [NSNumber numberWithFloat:5.75],
						  [NSNumber numberWithFloat:5.00],
						  [NSNumber numberWithFloat:6.81],
						  [NSNumber numberWithFloat:4.18],
						  [NSNumber numberWithFloat:4.92],

						  [NSNumber numberWithFloat:3.75],
						  [NSNumber numberWithFloat:5.96],
						  [NSNumber numberWithFloat:5.60],
						  [NSNumber numberWithFloat:4.20],
						  [NSNumber numberWithFloat:6.11],
						  [NSNumber numberWithFloat:5.35],
						  [NSNumber numberWithFloat:4.00],
						  [NSNumber numberWithFloat:4.09],
						  [NSNumber numberWithFloat:7.72],
						  [NSNumber numberWithFloat:3.36],
						  [NSNumber numberWithFloat:7.20],
						  [NSNumber numberWithFloat:5.23],

						  nil];
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
					l = [self makeLeg:legIndex distance:[[miles objectAtIndex:legIndex-1] floatValue]];
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


- (void) setProjectedShowsCountdown:(BOOL)projectedShowsCountdown {
	[self appSettings].projectedShowsCountdownValue = projectedShowsCountdown;
	[self saveContext];
}
- (BOOL) projectedShowsCountdown {
	return [self appSettings].projectedShowsCountdownValue;
}



#pragma mark - Race
- (Race *) race {
	Race *r;
	NSArray *race = [self fetchAllEntitiesOfName:@"Race"];
	if (race.count == 0) {
		r = (Race *)[self insertEntityWithName:@"Race"];
	} else {
		r = (Race *)[race objectAtIndex:0];
	}
	return r;
}

- (BOOL) raceIsFinished {
	NSArray *allTimes = [self allLegTimes];
	for (LegTime *l in allTimes) {
		if (l.endTime == nil) return NO;
	}
	return YES;
}


- (NSDate*) calculateTimeToFinishOfLeg:(NSInteger)legNumberFinished projected:(BOOL)projected {
//	NSLog(@"calculateTimeToFinishOfLeg");
	NSArray *legs = [self allLegs];
	NSDate *finish = [self.race.startTime copy];
//	NSLog(@"start time: %@", finish);
	Leg *l;
	// We want to include the legNumberFinished in our calculation, but it's 1-based and the
	// loop is 0-based, so the i < legNumberFinished is accurate.
	for (int i = 0; i < legNumberFinished; i++) {
//		NSLog(@"Loop %d", i);
//	for (Leg *l in legs) {
		l = [legs objectAtIndex:i];
//		NSLog(@"Leg: %@", l);
		if (projected && l.legTime.endTime) {
//			NSLog(@"    projected");
			finish = [finish dateByAddingTimeInterval:[l.legTime.endTime timeIntervalSinceDate:l.legTime.startTime]];
		} else {
//			NSLog(@"    scheduled");
			float secsPerMile = l.projectedPaceValue * 60;
			NSTimeInterval projectedDuration = secsPerMile * l.distanceValue;
			finish = [finish dateByAddingTimeInterval:projectedDuration];
		}
//		NSLog(@"finish: %@", finish);
	}
//	NSLog(@"finish: %@", finish);
	return finish;
}

- (NSDate *)calculateFinishTime:(BOOL)projected {
	return [self calculateTimeToFinishOfLeg:[self allLegs].count projected:projected];
	///////////////////////////
	NSArray *legs = [self allLegs];
	NSDate *finish = [self.race.startTime copy];
	for (Leg *l in legs) {
		if (projected && l.legTime.endTime) {
			finish = [finish dateByAddingTimeInterval:[l.legTime.endTime timeIntervalSinceDate:l.legTime.startTime]];
		} else {
			float secsPerMile = l.projectedPaceValue * 60;
			NSTimeInterval projectedDuration = secsPerMile * l.distanceValue;
			finish = [finish dateByAddingTimeInterval:projectedDuration];
		}
	}
	return finish;
}



@end
