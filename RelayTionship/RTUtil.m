//
//  RTUtil.m
//  RelayTionship
//
//  Created by Dru Kepple on 9/1/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTUtil.h"

static NSDateFormatter *clockFormatter;
static NSDateFormatter *timeFormatter;

@implementation RTUtil

+ (NSDateFormatter *) clockFormatter {
	if (clockFormatter == nil) {
		clockFormatter = [[NSDateFormatter alloc] init];
		NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
		[clockFormatter setLocale:enUSPOSIXLocale];
		clockFormatter.AMSymbol = @"am";
		clockFormatter.PMSymbol = @"pm";
		[clockFormatter setDateFormat:@"h:mm a"];
	}
	return clockFormatter;
}
+ (NSDateFormatter *) timeFormatter {
	if (timeFormatter == nil) {
		timeFormatter = [[NSDateFormatter alloc] init];
		NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
		[timeFormatter setLocale:enUSPOSIXLocale];
		[timeFormatter setDateFormat:@"h:mm"];
	}
	return timeFormatter;
}



@end
