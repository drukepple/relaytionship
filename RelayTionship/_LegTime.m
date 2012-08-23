// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LegTime.m instead.

#import "_LegTime.h"

const struct LegTimeAttributes LegTimeAttributes = {
	.endTime = @"endTime",
	.mileageForProjection = @"mileageForProjection",
	.projectedEndTime = @"projectedEndTime",
	.secondsForProjection = @"secondsForProjection",
	.startTime = @"startTime",
};

const struct LegTimeRelationships LegTimeRelationships = {
	.leg = @"leg",
};

const struct LegTimeFetchedProperties LegTimeFetchedProperties = {
};

@implementation LegTimeID
@end

@implementation _LegTime

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LegTime" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LegTime";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LegTime" inManagedObjectContext:moc_];
}

- (LegTimeID*)objectID {
	return (LegTimeID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"mileageForProjectionValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"mileageForProjection"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"secondsForProjectionValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"secondsForProjection"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic endTime;






@dynamic mileageForProjection;



- (float)mileageForProjectionValue {
	NSNumber *result = [self mileageForProjection];
	return [result floatValue];
}

- (void)setMileageForProjectionValue:(float)value_ {
	[self setMileageForProjection:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveMileageForProjectionValue {
	NSNumber *result = [self primitiveMileageForProjection];
	return [result floatValue];
}

- (void)setPrimitiveMileageForProjectionValue:(float)value_ {
	[self setPrimitiveMileageForProjection:[NSNumber numberWithFloat:value_]];
}





@dynamic projectedEndTime;






@dynamic secondsForProjection;



- (float)secondsForProjectionValue {
	NSNumber *result = [self secondsForProjection];
	return [result floatValue];
}

- (void)setSecondsForProjectionValue:(float)value_ {
	[self setSecondsForProjection:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveSecondsForProjectionValue {
	NSNumber *result = [self primitiveSecondsForProjection];
	return [result floatValue];
}

- (void)setPrimitiveSecondsForProjectionValue:(float)value_ {
	[self setPrimitiveSecondsForProjection:[NSNumber numberWithFloat:value_]];
}





@dynamic startTime;






@dynamic leg;

	






@end
