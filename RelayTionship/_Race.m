// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Race.m instead.

#import "_Race.h"

const struct RaceAttributes RaceAttributes = {
	.isFinished = @"isFinished",
	.startTime = @"startTime",
};

const struct RaceRelationships RaceRelationships = {
};

const struct RaceFetchedProperties RaceFetchedProperties = {
};

@implementation RaceID
@end

@implementation _Race

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Race" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Race";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Race" inManagedObjectContext:moc_];
}

- (RaceID*)objectID {
	return (RaceID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isFinishedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isFinished"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic isFinished;



- (BOOL)isFinishedValue {
	NSNumber *result = [self isFinished];
	return [result boolValue];
}

- (void)setIsFinishedValue:(BOOL)value_ {
	[self setIsFinished:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsFinishedValue {
	NSNumber *result = [self primitiveIsFinished];
	return [result boolValue];
}

- (void)setPrimitiveIsFinishedValue:(BOOL)value_ {
	[self setPrimitiveIsFinished:[NSNumber numberWithBool:value_]];
}





@dynamic startTime;











@end
