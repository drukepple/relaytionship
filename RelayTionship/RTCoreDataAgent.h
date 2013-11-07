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
#import "Race.h"

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
@property (assign, nonatomic) BOOL projectedShowsCountdown;


- (NSArray *) allVans;

- (Runner *)runnerByIndexPath:(NSIndexPath *)indexPath;
- (NSArray *) allRunners;
- (Runner *) currentRunner;

- (Leg *)legByIndex:(int16_t)index;
- (NSArray *) allLegs;
- (NSArray *) allLegTimes;
- (NSArray *) allCompletedLegs;
- (LegTime *) makeLegTime;
- (Leg *) currentLeg;

- (void) reset;

//- (Race *) race;
@property (readonly) Race *race;
@property (readonly) BOOL raceIsFinished;

// Would be nice to move this method into Race.  But that would require
// Race having a relationship to Legs, which is reasonable, but more
// refactoring that I care for right now.
/**
 * Caculates the clock-time of when a given leg will finish.
 * @param	legNumberFinished	The leg number (1-based) of the leg for which to calculate the finish.
 * @param	projected			If YES, will project the time.  If actual leg times exist, those will
 *								be used instead of projected leg times.  If NO, will schedule the time
 *								based soley on projected leg paces, even if actual leg times exist.
 * @return	NSDate				An NSDate object with the time of the projected/shceulded leg finish.
 *								The date will be arbitrary; whatever today is.  The time will be the
 *								only calculated value.
 */
- (NSDate*) calculateTimeToFinishOfLeg:(NSInteger)legNumberFinished projected:(BOOL)projected;
- (NSDate *)calculateFinishTime:(BOOL)projected;

@end
