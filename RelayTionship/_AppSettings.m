// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AppSettings.m instead.

#import "_AppSettings.h"

const struct AppSettingsAttributes AppSettingsAttributes = {
	.isTiming = @"isTiming",
	.projectedShowsCountdown = @"projectedShowsCountdown",
	.selectedTab = @"selectedTab",
};

const struct AppSettingsRelationships AppSettingsRelationships = {
};

const struct AppSettingsFetchedProperties AppSettingsFetchedProperties = {
};

@implementation AppSettingsID
@end

@implementation _AppSettings

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AppSettings" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AppSettings";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AppSettings" inManagedObjectContext:moc_];
}

- (AppSettingsID*)objectID {
	return (AppSettingsID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isTimingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isTiming"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"projectedShowsCountdownValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"projectedShowsCountdown"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"selectedTabValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"selectedTab"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic isTiming;



- (BOOL)isTimingValue {
	NSNumber *result = [self isTiming];
	return [result boolValue];
}

- (void)setIsTimingValue:(BOOL)value_ {
	[self setIsTiming:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsTimingValue {
	NSNumber *result = [self primitiveIsTiming];
	return [result boolValue];
}

- (void)setPrimitiveIsTimingValue:(BOOL)value_ {
	[self setPrimitiveIsTiming:[NSNumber numberWithBool:value_]];
}





@dynamic projectedShowsCountdown;



- (BOOL)projectedShowsCountdownValue {
	NSNumber *result = [self projectedShowsCountdown];
	return [result boolValue];
}

- (void)setProjectedShowsCountdownValue:(BOOL)value_ {
	[self setProjectedShowsCountdown:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveProjectedShowsCountdownValue {
	NSNumber *result = [self primitiveProjectedShowsCountdown];
	return [result boolValue];
}

- (void)setPrimitiveProjectedShowsCountdownValue:(BOOL)value_ {
	[self setPrimitiveProjectedShowsCountdown:[NSNumber numberWithBool:value_]];
}





@dynamic selectedTab;



- (int16_t)selectedTabValue {
	NSNumber *result = [self selectedTab];
	return [result shortValue];
}

- (void)setSelectedTabValue:(int16_t)value_ {
	[self setSelectedTab:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveSelectedTabValue {
	NSNumber *result = [self primitiveSelectedTab];
	return [result shortValue];
}

- (void)setPrimitiveSelectedTabValue:(int16_t)value_ {
	[self setPrimitiveSelectedTab:[NSNumber numberWithShort:value_]];
}










@end
