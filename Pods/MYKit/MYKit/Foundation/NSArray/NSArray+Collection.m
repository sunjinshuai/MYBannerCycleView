//
//  NSArray+Collection.m
//  revo-retail
//
//  Created by Badchoice on 25/5/16.
//  Copyright © 2016 Revo. All rights reserved.
//

#import "NSArray+Collection.h"
#import "NSString+Collection.h"
#import <pthread.h>
#import <objc/runtime.h>

@implementation NSArray (Collection)

- (NSArray <id> * _Nullable)filter:(BOOL (^ _Nonnull)(id _Nonnull object))condition {
    if (condition) {
        return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return condition(evaluatedObject);
        }]];
    } else {
        NSLog(@"过滤条件不能为nil");
        return nil;
    }
}

- (NSArray <id> * _Nullable)reject:(BOOL (^ _Nonnull)(id _Nonnull object))condition {
    if (condition) {
        return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return !condition(evaluatedObject);
        }]];
    }
    return nil;
}

- (NSArray <id> * _Nullable)filterWith:(NSString * _Nullable)keyPath {
    if (keyPath) {
        return [self filter:^BOOL(id object) {
            return [[object valueForKeyPath:keyPath] boolValue];
        }];
    }
    return nil;
}

- (NSArray <id> * _Nullable)rejectWith:(NSString * _Nullable)keyPath {
    if (keyPath) {
        return [self reject:^BOOL(id object) {
            return [[object valueForKeyPath:keyPath] boolValue];
        }];
    }
    return nil;
}

- (_Nullable id)first:(BOOL (^ _Nonnull)(id _Nonnull object))condition __attribute__((nonnull (1))) {
    if (condition) {
        NSUInteger index = [self indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return condition(obj);
        }];
        return (index == NSNotFound) ? nil : self[index];
    }
    return nil;
}

- (_Nullable id)first:(BOOL (^ _Nonnull)(id _Nonnull object))condition default:(_Nullable id)defaultObject {
    id object = [self first:condition];
    return (object) ? object : defaultObject;
}

- (_Nullable id)last:(BOOL (^ _Nonnull)(_Nonnull id))condition {
    if (condition) {
        return [self.reverse first:condition];
    }
    return nil;
}

- (_Nullable id)last:(BOOL (^ _Nonnull)(id _Nonnull object))condition default:(_Nullable id)defaultObject {
    if (condition) {
        return defaultObject;
    }
    id object = [self last:condition];
    return (object) ? object : defaultObject;
}

- (NSNumber * _Nullable)contains:(BOOL (^ _Nonnull)(id _Nonnull object))checker {
    if (checker) {
        bool __block found = false;
        [self eachWithIndex:^(id object, int index, BOOL *stop) {
            if (checker(object)){
                found = true;
                *stop = true;
            }
        }];
        return @(found);
    }
    return nil;
}

- (NSNumber * _Nullable)doesntContain:(BOOL (^ _Nullable)(id _Nonnull object))checker {
    if (checker) {
        bool __block found = false;
        [self eachWithIndex:^(id object, int index, BOOL *stop) {
            if (checker(object)){
                found = true;
                *stop = true;
            }
        }];
        return @(!found);
    }
    return nil;
}

- (NSArray <id> * _Nullable)where:(NSString * _Nullable)keyPath like:(id _Nullable)value {
    if (keyPath) {
        return [self whereAny:@[keyPath] like:value];
    }
    return nil;
}

- (NSArray <id> * _Nullable)where:(NSString * _Nullable)keyPath is:(id _Nullable)value {
    return [self whereAny:@[keyPath] is:value];
}

- (NSArray <id> * _Nullable)whereAny:(NSArray * _Nullable)keyPaths is:(id _Nullable)value {
    if (keyPaths) {
        NSMutableArray* predicates = [NSMutableArray new];
        [keyPaths each:^(NSString* keypath) {
            NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K = %@",keypath,value];
            [predicates addObject:predicate];
        }];
        NSPredicate *resultPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:predicates];
        return [self filteredArrayUsingPredicate:resultPredicate];
    }
    return nil;
}

- (NSArray <id> * _Nullable)whereAny:(NSArray * _Nullable)keyPaths like:(id _Nullable)value {
    NSMutableArray* orPredicates = [NSMutableArray new];
    [keyPaths each:^(NSString* keypath) {
        NSMutableArray* andPredicates = [NSMutableArray new];
        NSArray *terms = [value componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [terms each:^(NSString* term) {
            NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K contains[cd] %@",keypath,term];
            [andPredicates addObject:predicate];
        }];
        [orPredicates addObject:[NSCompoundPredicate andPredicateWithSubpredicates:andPredicates]];
    }];
    
    NSPredicate *resultPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:orPredicates];
    return [self filteredArrayUsingPredicate:resultPredicate];
}


- (void)each:(void (^ _Nullable)(id _Nonnull object))operation {
    if (operation) {
        [self enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
            operation(object);
        }];
    }
}

- (void)eachWithIndex:(void(^ _Nullable)(id _Nonnull object, int index, BOOL * _Nonnull stop))operation {
    if (operation) {
        [self enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
            operation(object, (int)idx, stop);
        }];
    }
}

- (NSArray <id> *_Nullable)sort {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        return [a compare:b];
    }];
}

- (NSArray <id> * _Nullable)sort:(NSString* _Nullable)key {
    return [self sort:key ascending:YES];
}

- (NSArray <id> * _Nullable)sort:(NSString * _Nullable)key ascending:(BOOL)ascending {
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
    return [self sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (NSArray <id> * _Nullable)sortWith:(NSComparisonResult (^ _Nullable)(id _Nonnull a, id _Nonnull b))callback {
    if (callback) {
        return [self sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            return callback(a,b);
        }];
    }
    return self;
}

- (NSArray <id> * _Nullable)sortWithNilAtTheEnd:(NSString * _Nullable)key ascending:(BOOL)ascending {
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:!ascending comparator:^NSComparisonResult(id obj1, id obj2)  {
        return [obj2 compare:obj1];
    }];
    return [self sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (NSArray <id> *_Nullable)reverse {
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSArray <id> * _Nullable)slice:(NSInteger)howMany {
    if(howMany > self.count) return @[];
    if (self.count > howMany) {
        return  [self subarrayWithRange:NSMakeRange(howMany, self.count - howMany)];
    } else {
        return @[];
    }
}

- (NSArray <id> * _Nullable)take:(NSInteger)howMany {
    if (howMany > 0)
        return  [self subarrayWithRange:NSMakeRange(0, MIN(howMany,self.count))];
    else
        return  [self subarrayWithRange:NSMakeRange(MAX(0, (int)self.count + howMany), MIN(-howMany,self.count))];
}

- (NSArray <id> * _Nullable)splice:(NSInteger)howMany {
    if (![self isKindOfClass:NSMutableArray.class]){
        [NSException raise:@"Array is not mutable" format:@"Array needs to be mutable"];
    }
    NSArray* chunk = [self take:howMany];
    [(NSMutableArray*)self removeObjectsInRange:NSMakeRange(0, MIN(howMany, self.count))];
    return chunk;
}

- (NSArray <id> * _Nullable)map:(id _Nullable (^ _Nullable)(id _Nonnull obj, NSUInteger idx))block {
    if (block) {
        NSMutableArray* result = [NSMutableArray arrayWithCapacity:self.count];
        [self enumerateObjectsUsingBlock:^(id currentObject, NSUInteger index, BOOL *stop) {
            id mappedCurrentObject = block(currentObject, index);
            if (mappedCurrentObject) {
                [result addObject:mappedCurrentObject];
            }
        }];
        return result;
    }
    return nil;
}

- (NSArray <id> * _Nullable)flatMap:(id _Nonnull (^_Nullable)(id _Nonnull obj, NSUInteger idx))block {
    if (block) {
        NSMutableArray* results = [NSMutableArray new];
        [self each:^(NSArray* array) {
            [results addObject:[array map:^id(id obj, NSUInteger idx) {
                return block(obj,idx);
            }]];
        }];
        return results;
    }
    return nil;
}

- (NSArray <id> * _Nullable)flatMap:(NSString * _Nullable)keyPath block:(_Nonnull id (^ _Nullable)(id _Nonnull obj, NSUInteger idx))block {
    if (keyPath && block) {
        NSMutableArray* results = [NSMutableArray new];
        [self each:^(id object) {
            [results addObject:[[object valueForKeyPath:keyPath] map:^id(id obj, NSUInteger idx) {
                return block(obj,idx);
            }]];
        }];
        return results;
    }
    return nil;
}

- (NSArray <id> *_Nullable)flatten {
    NSMutableArray* results = [NSMutableArray new];
    [self each:^(NSArray* array) {
        [results addObjectsFromArray:array];
    }];
    return results;
}

- (NSArray <id> * _Nullable)flatten:(NSString* _Nullable)keyPath {
    if (keyPath) {
        NSMutableArray* results = [NSMutableArray new];
        [self each:^(id object) {
            [results addObjectsFromArray:[object valueForKeyPath:keyPath]];
        }];
        return results;
    }
    return nil;
}

- (NSArray <id> * _Nullable)pluck:(NSString * _Nullable)keyPath {
    if (keyPath) {
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
        [self each:^(id object) {
            NSObject* value = [object valueForKeyPath:keyPath];
            if(value) [result addObject:[object valueForKeyPath:keyPath]];
        }];
        return result;
    }
    return nil;
}

- (NSDictionary* _Nullable)pluck:(NSString* _Nullable)keyPath key:(NSString* _Nullable)keyKeyPath {
    if (keyPath && keyKeyPath) {
        NSMutableDictionary* result = [NSMutableDictionary dictionaryWithCapacity:self.count];
        [self each:^(id object) {
            result[[object valueForKey:keyKeyPath]] = [object valueForKey:keyPath];
        }];
        return result;
    }
    return nil;
}

- (id _Nullable)reduce:(id _Nonnull (^ _Nullable)(id _Nonnull carry, id _Nonnull object))block carry:(id _Nullable)carry {
    if (block) {
        id __block carry2 = carry;
        [self each:^(id object) {
            carry2 = block(carry2,object);
        }];
        return carry2;
    }
    return nil;
}

- (id _Nullable)reduce:(id _Nonnull(^ _Nullable)(id _Nonnull carry, id _Nonnull object))block {
    if (block) {
        return [self reduce:block carry:nil];
    }
    return nil;
}

- (id _Nullable)pipe:(id _Nonnull (^ _Nullable)(NSArray <id> * _Nonnull array))block {
    if (block) {
        return block(self);
    }
    return nil;
}

- (id _Nullable)when:(BOOL)condition block:(id _Nonnull (^ _Nullable)(NSArray* _Nonnull array))block {
    if (block) {
        if(condition) return block(self);
        return self;
    }
    return nil;
}

- (NSDictionary* _Nullable)groupBy:(NSString* _Nullable)keyPath {
    if (keyPath) {
        return [self groupBy:keyPath block:^NSString *(id object, NSString *key) {
            return key;
        }];
    }
    return nil;
}

- (NSDictionary* _Nullable)groupBy:(NSString* _Nullable)keyPath block:(NSString* _Nonnull (^ _Nullable)(id _Nonnull object, NSString* _Nonnull key))block {
    if (keyPath && block) {
        NSMutableDictionary *result = [NSMutableDictionary new];
        NSString* finalKeypath = [NSString stringWithFormat:@"%@.@distinctUnionOfObjects.self",keyPath];
        NSArray *distinct = [self valueForKeyPath:finalKeypath];
        [distinct each:^(NSString* value) {
            NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"%K = %@", keyPath,value];
            NSArray *objects        = [self filteredArrayUsingPredicate:predicate];
            [result setObject:objects forKey:block(objects[0], value)];
        }];
        return result;
    }
    return nil;
}

- (NSDictionary*)expand:(NSString*)keyPath {
    if (keyPath) {
        return [self expand:keyPath unique:NO];
    }
    return nil;
}

- (NSDictionary *_Nullable)expand:(NSString * _Nullable)keypath unique:(BOOL)unique {
    if (keypath) {
        if(unique) keypath = [NSString stringWithFormat:@"%@.@distinctUnionOfObjects.self",keypath];
        NSMutableDictionary* result = [NSMutableDictionary new];
        [self each:^(id object) {
            [[object valueForKeyPath:keypath] each:^(id key) {
                if(result[key] == nil) result[key] = [NSMutableArray new];
                [result[key] addObject:object];
            }];
        }];
        return result;
    }
    return nil;
}

- (id _Nullable)maxObject {
    if (self.count > 0) {
        return [self reduce:^id(id carry, id object) {
            return (object > carry ) ? object : carry;
        } carry:self.firstObject];
    }
    return nil;
}

- (id _Nullable)maxObject:(NSString * _Nullable)keyPath {
    if (keyPath) {
        return [self reduce:^id(id carry, id object) {
            return ([[object valueForKeyPath:keyPath] doubleValue] > [[carry valueForKeyPath:keyPath] doubleValue]) ? object : carry;
        } carry:self.firstObject];
    }
    return nil;
}

- (id _Nullable)maxObjectFor:(double (^ _Nullable)(id _Nonnull obj))block {
    if (block) {
        return [self reduce:^id(id carry, id object) {
            return block(object) > block(carry) ? object : carry;
        } carry:self.firstObject];
    }
    return nil;
}

- (id _Nullable)minObject {
    if (self.count > 0) {
        return [self reduce:^id(id carry, id object) {
            return (object < carry ) ? object : carry;
        } carry:self.firstObject];
    }
    return nil;
}

- (id _Nullable)minObjectFor:(double (^ _Nullable)(id _Nonnull obj))block {
    if (block) {
        return [self reduce:^id(id carry, id object) {
            return block(object) < block(carry) ? object : carry;
        } carry:self.firstObject];
    }
    return nil;
}

- (id _Nullable)minObject:(NSString *)keyPath {
    if (keyPath) {
        return [self reduce:^id(id carry, id object) {
            return ([[object valueForKeyPath:keyPath] doubleValue] < [[carry valueForKeyPath:keyPath] doubleValue] ) ? object : carry;
        } carry:self.firstObject];
    }
    return nil;
}

- (id _Nonnull)random {
    if (self.count > 0) {
        NSUInteger randomIndex = arc4random() % self.count;
        return self[randomIndex];
    }
    return nil;
}

- (NSArray <id> *_Nullable)random:(NSUInteger)quantity {
    return [self.shuffled take:quantity];
}

- (NSArray <id> *_Nullable)shuffled {
    NSMutableArray* copy = self.mutableCopy;
    for (NSUInteger i = self.count; i > 1; i--)
        [copy exchangeObjectAtIndex:i - 1 withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    return copy;
}

- (NSArray <id> * _Nullable)zip:(NSArray* _Nullable)other {
    if (other) {
        NSInteger size = MIN(self.count, other.count);
        if (size == 0) {
            return self;
        }
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:size];
        for (NSUInteger idx = 0; idx < size; idx++) {
            [result addObject:[NSArray arrayWithObjects:[self objectAtIndex:idx], [other objectAtIndex:idx], nil]];
        }
        return result;
    }
    return self;
}

- (NSDictionary * _Nullable)mapToAssoc:(NSArray * _Nullable (^ _Nullable)(id _Nullable obj, NSUInteger idx))block {
    if (block) {
        NSArray* pairs = [self map:block];
        return [pairs reduce:^id(NSMutableDictionary* dict, NSArray* mapped) {
            dict[mapped[0]] = mapped[1];
            return dict;
        } carry:[NSMutableDictionary new]];
    }
    return nil;
}

- (NSCountedSet* _Nullable)countedSet {
    return [NSCountedSet setWithArray:self];
}

- (NSString * _Nullable)implode:(NSString * _Nullable)delimiter {
    return [self componentsJoinedByString:delimiter];
}

- (NSString * _Nullable)toString {
    NSString* exploded = [self implode:@","];
    return [NSString stringWithFormat:@"[%@]",exploded];
}

- (NSString* _Nullable)toJson {
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&err];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
//==============================================
#pragma mark - Operators
//==============================================
- (NSNumber*)operator:(NSString*)operator keypath:(NSString*)keypath {
    NSString* finalKeyPath;
    if(keypath != nil)
        finalKeyPath = [NSString stringWithFormat:@"%@.@%@.self",keypath, operator];
    else
        finalKeyPath = [NSString stringWithFormat:@"@%@.self",operator];
    
    return [self valueForKeyPath:finalKeyPath];
}

- (NSNumber* _Nullable)sum {
    return [self operator:@"sum" keypath:nil];
}

- (NSNumber * _Nullable)sum:(NSString * _Nullable)keypath {
    return [self operator:@"sum" keypath:keypath];
}

- (NSNumber* _Nullable)avg {
    return [self operator:@"avg" keypath:nil];
}

- (NSNumber * _Nullable)avg:(NSString * _Nullable)keypath {
    return [self operator:@"avg" keypath:keypath];
}

- (NSNumber* _Nullable)max {
    return [self operator:@"max" keypath:nil];
}

- (NSNumber * _Nullable)max:(NSString * _Nullable)keypath {
    return [self operator:@"max" keypath:keypath];
}

- (NSNumber*)min {
    return [self operator:@"min" keypath:nil];
}

- (NSNumber * _Nullable)min:(NSString * _Nullable)keypath {
    return [self operator:@"min" keypath:keypath];
}

- (NSNumber * _Nullable)sumWith:(NSNumber * _Nonnull  (^ _Nullable)(id _Nonnull object))block {
    if (block) {
        return [self reduce:^id(NSNumber* carry, id object) {
            return @(carry.floatValue + block(object).floatValue);
        } carry:@(0)];
    }
    return [self sum];
}

//==============================================
#pragma mark - Set operations
//==============================================
- (NSArray <id> * _Nullable)intersect:(NSArray * _Nullable)b {
    NSMutableOrderedSet *setA = [NSMutableOrderedSet orderedSetWithArray:self];
    NSOrderedSet *setB        = [NSOrderedSet orderedSetWithArray:b];
    [setA intersectOrderedSet:setB];
    return [setA array];
}

- (NSArray <id> * )union:(NSArray*)b {
    NSMutableOrderedSet *setA = [NSMutableOrderedSet orderedSetWithArray:self];
    NSOrderedSet *setB        = [NSOrderedSet orderedSetWithArray:b];
    [setA unionOrderedSet:setB];
    return [setA array];
}

- (NSArray <id> *)minus:(NSArray*)b {
    NSMutableOrderedSet *setA = [NSMutableOrderedSet orderedSetWithArray:self];
    NSOrderedSet *setB        = [NSOrderedSet orderedSetWithArray:b];
    [setA minusOrderedSet:setB];
    return [setA array];
}

- (NSArray <id>*)diff:(NSArray*)b {
    return [self minus:b];
}

- (NSArray <id>*)join:(NSArray*)b {
    return [self arrayByAddingObjectsFromArray:b];
}

- (NSArray <id> *)distinct {
    NSOrderedSet *distinct = [NSOrderedSet orderedSetWithArray:self];
    return [distinct array];
}

- (NSArray <id>* _Nullable)distinct:(NSString* _Nullable)keypath {
    if (keypath) {
        NSString* finalKeypath = [NSString stringWithFormat:@"%@.@distinctUnionOfObjects.self",keypath];
        return [self valueForKeyPath:finalKeypath];
    }
    return nil;
}

-(NSArray <id> *)crossJoin:(NSArray*)list{
    if ([list.firstObject isKindOfClass:NSArray.class]) {
        return [self.class cartesianProduct:[@[self] join:list]];
    }
    return [self.class cartesianProduct:@[self, list]];
}

+ (NSArray <id> * _Nullable)cartesianProduct:(NSArray * _Nullable)arrays {
    int arraysCount = (int)arrays.count;
    unsigned long resultSize = 1;
    for (NSArray *array in arrays)
        resultSize *= array.count;
    NSMutableArray *product = [NSMutableArray arrayWithCapacity:resultSize];
    for (unsigned long i = 0; i < resultSize; ++i) {
        NSMutableArray *cross = [NSMutableArray arrayWithCapacity:arraysCount];
        [product addObject:cross];
        unsigned long n = i;
        for (NSArray *array in arrays) {
            [cross addObject:[array objectAtIndex:n % array.count]];
            n /= array.count;
        }
    }
    return product;
}

- (NSArray <id> * _Nullable)permutations {
    NSMutableArray * permutations = [NSMutableArray new];
    for (NSObject *object in self) {
        [permutations addObject:@[object]];
    }
    for (int i = 1; i < self.count ; i++){
        NSMutableArray *aCopy = permutations.copy;
        [permutations removeAllObjects];
        for (NSObject *object in self) {
            for (NSArray *oldArray in aCopy){
                if ([oldArray containsObject:object] == NO) {
                    NSMutableArray *newArray = [NSMutableArray arrayWithArray:oldArray];
                    [newArray addObject:object];
                    [permutations addObject:newArray];
                }
            }
        }        
    }
    return permutations;
}

- (NSArray <id> * _Nonnull)uniqueObjectOperate {
    if (self.count == 0) {
        return @[];
    }
    if (self.count == 1) {
        return [[NSMutableArray alloc] initWithObjects:self[0], nil];
    }
    NSMutableArray * array = [NSMutableArray array];
    pthread_mutex_t mutex = PTHREAD_ONCE_INIT;
    [array addObject:self[0]];
    for (NSInteger i = 0; i < self.count;  i ++) {
        for (NSInteger j = 0; j < array.count; j ++) {
            NSObject * object0 = self[i];
            NSObject * object1 = array[j];
            if (![array containsObject:object0]) {
                if (![object1 customEqualTo:object0]) {
                    pthread_mutex_lock(&mutex);
                    [array addObject:object0];
                    pthread_mutex_unlock(&mutex);
                }
            }
        }
    }
    pthread_mutex_destroy(&mutex);
    return array;
}

- (NSArray <id> *_Nullable)intersectOperate:(NSArray <id> * _Nullable)other strategy:(ReserveStrategy)strategy {
    if (!other) {
        return @[];
    }
    NSArray <NSArray <id> *> * array0 = [self sameObjectGroupOperate];
    NSArray <NSArray <id> *> * array1 = [other sameObjectGroupOperate];
    if (array0.count == 0 || array1.count == 0) {
        return @[];
    }

    for (NSArray <id> * item0 in array0) {
        for (NSArray <id> * item1 in array1) {
            if (item0.operateFlag) {
                continue;
            }
            if ([(NSObject *)item0[0] customEqualTo:item1[0]]) {
                item0.operateFlag = YES;
                item1.operateFlag = YES;
            }
        }
    }

    for (NSArray <id> * item0 in array1) {
        for (NSArray <id> * item1 in array0) {
            if (item0.operateFlag) {
                continue;
            }
            if ([(NSObject *)item0[0] customEqualTo:item1[0]]) {
                item0.operateFlag = YES;
                item1.operateFlag = YES;
            }
        }
    }
    NSMutableArray * resultArray = [NSMutableArray array];
    pthread_mutex_t mutex = PTHREAD_ONCE_INIT;

    if (strategy == ReserveStrategyAll) {
        for (NSArray <id> * item in array0) {
            if (item.operateFlag) {
                for (id subItem in item) {
                    pthread_mutex_lock(&mutex);
                    [resultArray addObject:subItem];
                    pthread_mutex_unlock(&mutex);
                }
            }
        }
        for (NSArray <id> * item in array1) {
            if (item.operateFlag) {
                for (id subItem in item) {
                    pthread_mutex_lock(&mutex);
                    [resultArray addObject:subItem];
                    pthread_mutex_unlock(&mutex);
                }
            }
        }
    } else if (strategy == ReserveStrategyCurrent) {
        for (NSArray <id> * item in array0) {
            if (item.operateFlag) {
                for (id subItem in item) {
                    pthread_mutex_lock(&mutex);
                    [resultArray addObject:subItem];
                    pthread_mutex_unlock(&mutex);
                }
            }
        }
    } else if (strategy == ReserveStrategyOther) {
        for (NSArray <id> * item in array1) {
            if (item.operateFlag) {
                for (id subItem in item) {
                    pthread_mutex_lock(&mutex);
                    [resultArray addObject:subItem];
                    pthread_mutex_unlock(&mutex);
                }
            }
        }
    }
    pthread_mutex_destroy(&mutex);
    return resultArray;
}

- (NSArray <id> *_Nullable)intersectOperate:(NSArray <id> * _Nullable)other weight:(ReserveWeight)weight lowerLimit:(NSInteger)lowerLimit upperLimit:(NSInteger)upperLimit {
    if (!other) {
        return @[];
    }
    /// 保证 上限大于等于下限
    if (lowerLimit > upperLimit) {
        NSLog(@"lowerLimit > upperLimit");
        return @[];
    }

    /// 保证 上限下限都大于1
    if (lowerLimit < 1 || upperLimit < 1) {
        return @[];
    }

    NSArray <NSArray <id> *> * array0 = [self sameObjectGroupOperate];
    NSArray <NSArray <id> *> * array1 = [other sameObjectGroupOperate];
    if (array0.count == 0 || array1.count == 0) {
        return @[];
    }
    for (NSArray <id> * item0 in array0) {
        for (NSArray <id> * item1 in array1) {
            if (item0.operateFlag) {
                continue;
            }
            if ([(NSObject *)item0[0] customEqualTo:item1[0]]) {
                item0.operateFlag = YES;
                item1.operateFlag = YES;
            }
        }
    }

    for (NSArray <id> * item0 in array1) {
        for (NSArray <id> * item1 in array0) {
            if (item0.operateFlag) {
                continue;
            }
            if ([(NSObject *)item0[0] customEqualTo:item1[0]]) {
                item0.operateFlag = YES;
                item1.operateFlag = YES;
            }
        }
    }
    NSMutableArray * resultArray = [NSMutableArray array];
    pthread_mutex_t mutex = PTHREAD_ONCE_INIT;
    for (NSArray <id> * item in array0) {
        NSLog(@"%d", item.operateFlag);
    }

    for (NSArray <id> * item in array1) {
        NSLog(@"%d", item.operateFlag);
    }

    NSArray <NSArray <id> *> * havaSameArray0 = [array0 filter:^BOOL(NSArray<id> * _Nonnull object) {
        if (object.operateFlag) {
            return YES;
        }
        return NO;
    }];
    NSArray <NSArray <id> *> * havaSameArray1 = [array1 filter:^BOOL(NSArray<id> * _Nonnull object) {
        if (object.operateFlag) {
            return YES;
        }
        return NO;
    }];

    for (NSArray <id> * item0 in havaSameArray0) {
        for (NSArray <id> * item1 in havaSameArray1) {
            if ([item0[0] customEqualTo:item1[0]]) {
                pthread_mutex_lock(&mutex);
                NSArray <id> * temp = nil;
                if (weight == ReserveWeightCurrent) {
                    temp = [item0 join:item1];
                } else if (weight == ReserveWeightOther) {
                    temp = [item1 join:item0];
                }

                NSLog(@"|%ld-----%ld|", (long)lowerLimit, (long)upperLimit);
                NSLog(@"%lu", (unsigned long)temp.count);

                /// 保证
                if (lowerLimit <= temp.count) {
                    if (lowerLimit + upperLimit > temp.count) {
                        for (id it in temp) {
                            [resultArray addObject:it];
                        }
                    } else {
                        for (NSInteger i = 0; i < lowerLimit + upperLimit - lowerLimit; i ++) {
                            [resultArray addObject:temp[i]];
                        }
                    }
                } else {
                    continue;
                }
                pthread_mutex_unlock(&mutex);
            }
        }
    }

    pthread_mutex_destroy(&mutex);
    return resultArray;
}

- (NSArray <id> *_Nullable)intersectOperate:(NSArray <id> * _Nullable)other weight:(ReserveWeight)weight appearCount:(NSInteger)count {
    return [self intersectOperate:other weight:weight lowerLimit:count upperLimit:count];
}

- (NSArray <id> *_Nullable)distinctOperate:(NSArray <id> * _Nullable)other {
    if (!other || other.count == 0) {
        return self;
    }
    NSArray <NSArray <id> *> * array0 = [self sameObjectGroupOperate];
    NSArray <NSArray <id> *> * array1 = [other sameObjectGroupOperate];
    if (array0.count == 0 || array1.count == 0) {
        return @[];
    }

    for (NSArray <id> * item0 in array0) {
        for (NSArray <id> * item1 in array1) {
            if (item0.operateFlag) {
                continue;
            }
            if ([(NSObject *)item0[0] customEqualTo:item1[0]]) {
                item0.operateFlag = YES;
                item1.operateFlag = YES;
            }
        }
    }

    for (NSArray <id> * item0 in array1) {
        for (NSArray <id> * item1 in array0) {
            if (item0.operateFlag) {
                continue;
            }
            if ([(NSObject *)item0[0] customEqualTo:item1[0]]) {
                item0.operateFlag = YES;
                item1.operateFlag = YES;
            }
        }
    }
    NSMutableArray * resultArray = [NSMutableArray array];
    pthread_mutex_t mutex = PTHREAD_ONCE_INIT;
    for (NSArray <id> * item in array0) {
        if (!item.operateFlag) {
            for (id subItem in item) {
                pthread_mutex_lock(&mutex);
                [resultArray addObject:subItem];
                pthread_mutex_unlock(&mutex);
            }
        }
    }
    pthread_mutex_destroy(&mutex);
    return resultArray;
}

- (NSArray <NSArray <id> *> * _Nullable)sameObjectGroupOperate {
    NSMutableArray * array = [NSMutableArray arrayWithArray:self];
    NSMutableArray * dateMutablearray = [@[] mutableCopy];
    pthread_mutex_t mutex = PTHREAD_ONCE_INIT;
    for (int i = 0; i < array.count; i ++) {
        id string = array[i];
        NSMutableArray *tempArray = [@[] mutableCopy];
        [tempArray addObject:string];
        for (int j = i + 1; j < array.count; j ++) {
            id jstring = array[j];
            if ([string customEqualTo:jstring]) {
                pthread_mutex_lock(&mutex);
                [tempArray addObject:jstring];
                [array removeObjectAtIndex:j];
                pthread_mutex_unlock(&mutex);
                j -= 1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
    pthread_mutex_destroy(&mutex);
    return dateMutablearray;
}

@end


@interface NSObject ()



@end

@implementation NSObject (Uniqueness)

- (BOOL)customEqualTo:(id _Nullable)object {
    if (object) {
        return self.hash == ((NSObject *)object).hash;
    }
    return NO;
}

- (void)setOperateFlag:(BOOL)operateFlag {
    objc_setAssociatedObject(self, @selector(operateFlag), @(operateFlag), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)operateFlag {
    return objc_getAssociatedObject(self, _cmd) != nil ? [objc_getAssociatedObject(self, _cmd) boolValue] : NO;
}

@end
