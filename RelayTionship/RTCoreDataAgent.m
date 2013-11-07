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
		NSArray *miles = [NSArray arrayWithObjects:
						  [NSNumber numberWithFloat:7.1],
						  [NSNumber numberWithFloat:4.8],
						  [NSNumber numberWithFloat:5.5],
						  [NSNumber numberWithFloat:4.5],
						  [NSNumber numberWithFloat:9.4],
						  [NSNumber numberWithFloat:3.6],
						  [NSNumber numberWithFloat:5.5],
						  [NSNumber numberWithFloat:6.6],
						  [NSNumber numberWithFloat:2.7],
						  [NSNumber numberWithFloat:2.4],
						  [NSNumber numberWithFloat:5.4],
						  [NSNumber numberWithFloat:2.4],
						  
						  [NSNumber numberWithFloat:6.2],
						  [NSNumber numberWithFloat:2.4],
						  [NSNumber numberWithFloat:2.2],
						  [NSNumber numberWithFloat:2.1],
						  [NSNumber numberWithFloat:3.2],
						  [NSNumber numberWithFloat:10.0],
						  [NSNumber numberWithFloat:5.8],
						  [NSNumber numberWithFloat:3.1],
						  [NSNumber numberWithFloat:7.3],
						  [NSNumber numberWithFloat:8.5],
						  [NSNumber numberWithFloat:3.9],
						  [NSNumber numberWithFloat:3.1],

						  [NSNumber numberWithFloat:4.8],
						  [NSNumber numberWithFloat:3.4],
						  [NSNumber numberWithFloat:4.0],
						  [NSNumber numberWithFloat:5.1],
						  [NSNumber numberWithFloat:6.5],
						  [NSNumber numberWithFloat:3.7],
						  [NSNumber numberWithFloat:5.1],
						  [NSNumber numberWithFloat:7.6],
						  [NSNumber numberWithFloat:3.0],
						  [NSNumber numberWithFloat:6.7],
						  [NSNumber numberWithFloat:7.7],
						  [NSNumber numberWithFloat:7.3],

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
//				r.defaultPaceValue = 8.0;
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

#pragma mark Van
- (NSArray *) allVans {
	return [self fetchAllEntitiesOfName:@"Van" sortedOn:@"number" ascending:YES];
}

#pragma mark Runner
- (Runner *)runnerByIndexPath:(NSIndexPath *)indexPath {
	int16_t runnerNumber = ((indexPath.section+0) * 6) + (indexPath.row+1);
//	NSLog(@"runnerNumber: %d", runnerNumber);
	Runner *r = (Runner *)[self fetchFirstEntityOfName:@"Runner" withPredicate:@"number = %d", runnerNumber];
	return r;
}

- (NSArray *) allRunners {
	return [self fetchAllEntitiesOfName:@"Runner" sortedOn:@"number" ascending:YES];
}

- (Runner *) currentRunner {
//	NSLog(@"current Leg: %@", (Leg*)[self currentLeg]);
	return ((Leg*)[self currentLeg]).runner;
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

- (Leg *) currentLeg {
	int numLegTimes = [[self allLegTimes] count];
//	NSLog(@"leg times count: %d", numLegTimes);
	if (numLegTimes <= 0) {
		return nil;
	} else {
		// Subtract one because we got the count, which is 1-based, and using it for the index, which is 0-based.
		return [[self allLegs] objectAtIndex:numLegTimes-1];
	}
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
	if (allTimes.count == 0) {
		return NO;
	}
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





#pragma mark - Data Modification
- (void) reset {
	NSArray *legs = [self allLegs];
	for (Leg *leg in legs) {
		if (leg.legTime) {
			[self deleteEntity:leg.legTime];
		}
	}
	self.isTiming = NO;
}


@end
