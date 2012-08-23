#import "LegTime.h"

@implementation LegTime

-(NSTimeInterval) elapsedTime {
	return [self.endTime timeIntervalSinceDate:self.startTime];
}

@end
