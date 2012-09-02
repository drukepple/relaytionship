#import "LegTime.h"

@implementation LegTime


+(NSString*) formatSecondsToString:(NSTimeInterval)timeInterval {
	int secs = round(timeInterval);
	NSString *timeString;
	if (secs < 60) {
		timeString = [NSString stringWithFormat:@"0:%02d", secs];
	} else if (secs < 60 * 60) {
		int mins = floor((float)secs/60.0);
		secs -= mins * 60;
		timeString = [NSString stringWithFormat:@"%d:%02d", mins, secs];
	} else {
		int hrs = floor((float)secs/(60.0*60.0));
		secs -= hrs * 60 * 60;
		int mins = floor((float)secs/60.0);
		secs -= mins * 60;
		timeString = [NSString stringWithFormat:@"%d:%02d:%02d", hrs, mins, secs];
	}
	return timeString;
}


-(NSTimeInterval) elapsedTime {
	return [self.endTime timeIntervalSinceDate:self.startTime];
}

@end
