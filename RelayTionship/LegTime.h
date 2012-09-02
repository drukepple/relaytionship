#import "_LegTime.h"

@interface LegTime : _LegTime {}
// Custom logic goes here.

-(NSTimeInterval) elapsedTime;

+(NSString*) formatSecondsToString:(NSTimeInterval)timeInterval;

@end
