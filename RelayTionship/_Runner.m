// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Runner.m instead.

#import "_Runner.h"

const struct RunnerAttributes RunnerAttributes = {
	.defaultPace = @"defaultPace",
	.name = @"name",
	.number = @"number",
};

const struct RunnerRelationships RunnerRelationships = {
	.legs = @"legs",
	.van = @"van",
};

const struct RunnerFetchedProperties RunnerFetchedProperties = {
};

@implementation RunnerID
@end

@implementation _Runner

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Runner" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Runner";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Runner" inManagedObjectContext:moc_];
}

- (RunnerID*)objectID {
	return (RunnerID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"defaultPaceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"defaultPace"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"numberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"number"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic defaultPace;



- (float)defaultPaceValue {
	NSNumber *result = [self defaultPace];
	return [result floatValue];
}

- (void)setDefaultPaceValue:(float)value_ {
	[self setDefaultPace:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveDefaultPaceValue {
	NSNumber *result = [self primitiveDefaultPace];
	return [result floatValue];
}

- (void)setPrimitiveDefaultPaceValue:(float)value_ {
	[self setPrimitiveDefaultPace:[NSNumber numberWithFloat:value_]];
}





@dynamic name;






@dynamic number;



- (int16_t)numberValue {
	NSNumber *result = [self number];
	return [result shortValue];
}

- (void)setNumberValue:(int16_t)value_ {
	[self setNumber:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveNumberValue {
	NSNumber *result = [self primitiveNumber];
	return [result shortValue];
}

- (void)setPrimitiveNumberValue:(int16_t)value_ {
	[self setPrimitiveNumber:[NSNumber numberWithShort:value_]];
}





@dynamic legs;

	
- (NSMutableSet*)legsSet {
	[self willAccessValueForKey:@"legs"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"legs"];
  
	[self didAccessValueForKey:@"legs"];
	return result;
}
	

@dynamic van;

	






@end
