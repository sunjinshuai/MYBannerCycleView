//
//  NSArray+Collection.h
//  revo-retail
//
//  Created by Badchoice on 25/5/16.
//  Copyright © 2016 Revo. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 保留策略
typedef NS_ENUM(NSUInteger, ReserveStrategy) {
    ReserveStrategyAll,
    ReserveStrategyCurrent,
    ReserveStrategyOther,
};

/// 保留权重
typedef NS_ENUM(NSUInteger, ReserveWeight) {
    ReserveWeightCurrent,
    ReserveWeightOther,
};

/**
 if Source Array is nil all return nil else not return nil
 */
@interface NSArray <T: id> (Collection)

/**
 过滤

 @param condition (不能为空)过滤条件 为nil 则返回nil
 @return 满足过滤条件的新数组
 */
- (NSArray <T> * _Nullable)filter:(BOOL (^ _Nonnull)(T _Nonnull object))condition __attribute__((nonnull(1)));


/**
 过滤

 @param keyPath 通过keyPath获取 Item.keyPath的值 要保证item.keyPath能够能够响应转boolValue的消息 为nil 返回nil
 @return 满足过滤条件的新数组
 */
- (NSArray <T> * _Nullable)filterWith:(NSString * _Nullable)keyPath;


/**
 丢弃

 @param condition (不能为空)丢弃条件 为nil的话则返回nil
 @return 不满足丢弃条件的新数组
 */
- (NSArray <T> * _Nullable)reject:(BOOL (^ _Nonnull)(T _Nonnull object))condition __attribute__((nonnull(1)));


/**
 丢弃

 @param keyPath (不能为空)通过keyPath获取 Item.keyPath的值 要保证item.keyPath能够能够响应转boolValue的消息 为nil 返回nil
 @return 满足过滤条件的新数组
 */
- (NSArray <T> * _Nullable)rejectWith:(NSString * _Nullable)keyPath;


/**
 筛选

 @param condition (不能为空)筛选条件 为nil 返回nil
 @return 满足条件的第一个项
 */
- (T _Nullable)first:(BOOL (^ _Nonnull)(T _Nonnull object))condition __attribute__((nonnull(1)));


/**
 筛选

 @param condition (不能为空)筛选条件 为nil返回原数组第一个项 数组数量为0 返回nil
 @param defaultObject 缺省值
 @return 满足条件的第一项
 */
- (_Nullable T)first:(BOOL (^ _Nonnull)(_Nonnull T  object))condition default:(_Nullable id)defaultObject __attribute__((nonnull(1)));


/**
 筛选
 
 @param condition (不能为空)筛选条件 为nil 返回nil
 @return 满足条件的最后项
 */
- (_Nullable T)last:(BOOL (^ _Nonnull)(T _Nonnull))condition __attribute__((nonnull(1)));


/**
 筛选
 
 @param condition 筛选条件 为nil 返回nil
 @param defaultObject 缺省值
 @return 满足条件的最后项
 */
- (_Nullable T)last:(BOOL (^ _Nonnull)(T _Nonnull object))condition default:(_Nullable id)defaultObject __attribute__((nonnull(1)));


/**
 包含

 @param checker (不能为空)包含条件 为nil 返回nil
 @return 包含结果
 */
- (NSNumber * _Nullable)contains:(BOOL (^ _Nonnull)(T _Nonnull object))checker __attribute__((nonnull (1)));


/**
 不包含

 @param checker (不能为空)不包含条件 为nil 返回nil
 @return 不包含结果
 */
- (NSNumber * _Nullable)doesntContain:(BOOL (^ _Nullable)(T _Nonnull object))checker;


/**
 查找

 @param keyPath 为nil 返回nil
 @param value 对比值
 @return 查找like结果
 */
- (NSArray <T> * _Nullable)where:(NSString * _Nullable)keyPath like:(T _Nullable)value;


/**
 查找

 @param keyPath keyPath 为nil 返回nil
 @param value 对比值
 @return 查找is结果
 */
- (NSArray <T> * _Nullable)where:(NSString * _Nullable)keyPath is:(T _Nullable)value;


/**
 查找
 
 @param keyPaths 为nil 返回nil
 @param value 对比值
 @return 查找is结果
 */
- (NSArray <T> * _Nullable)whereAny:(NSArray * _Nullable)keyPaths is:(T _Nullable)value;


/**
 查找

 @param keyPath 为nil 返回nil
 @param value 对比值
 @return 查找like结果
 */
- (NSArray <T> * _Nullable)whereAny:(NSArray * _Nullable)keyPath like:(T _Nullable)value;


/**
 遍历

 @param operation 遍历操作
 */
- (void)each:(void (^ _Nullable)(T _Nonnull object))operation;


/**
 遍历

 @param operation 遍历操作
 */
- (void)eachWithIndex:(void(^ _Nullable)(T _Nonnull object, int index, BOOL * _Nonnull stop))operation;



/**
 排序

 @return 按照 compare 结果排序
 */
- (NSArray <T> *_Nullable)sort;


/**
 排序

 @param key 排序key
 @return 按照key取值排序
 */
- (NSArray <T> * _Nullable)sort:(NSString * _Nullable)key;


/**
 排序

 @param key 排序key
 @param ascending 是否采用倒序
 @return 排序结果
 */
- (NSArray <T> * _Nullable)sort:(NSString * _Nullable)key ascending:(BOOL)ascending;


/**
 排序

 @param callback 是否倒序
 @return 排序结果
 */
- (NSArray <T> * _Nullable)sortWith:(NSComparisonResult (^ _Nullable)(T _Nonnull a, T _Nonnull b))callback;


/**
 排序

 @param key  排序key
 @param ascending 是否倒序
 @return 排序结果
 */
- (NSArray <T> * _Nullable)sortWithNilAtTheEnd:(NSString * _Nullable)key ascending:(BOOL)ascending;

/// NSArray reverted
/**
 排序

 @return 倒序结果
 */
- (NSArray <T> *_Nullable)reverse;


/**
 切片

 @param howMany 截取起点
 @return 从截取起点到数组结尾
 */
- (NSArray <T> * _Nullable)slice:(NSInteger)howMany;

/**
 切片

 @param howMany 截取终点
 @return 从开头到截取终点
 */
- (NSArray <T> * _Nullable)take:(NSInteger)howMany;

/// NSArray from [0 , howMany] and removes them from current array

/**
 切片

 @param howMany 截取终点 [0 , howMany] 将会被删除
 @return 剩下的数据数组
 */
- (NSArray <T> * _Nullable)splice:(NSInteger)howMany;


/**
 映射

 @param block 回调 为nil 返回nil
 @return 映射数组
 */
- (NSArray <id> * _Nullable)map:(id _Nonnull (^ _Nullable)(T _Nonnull obj, NSUInteger idx))block;


/**
 扁平映射

 @param block 回调 为nil 返回nil
 @return 映射数组 [block(item)]
 */
- (NSArray <id>* _Nullable)flatMap:(id _Nonnull (^_Nullable)(T _Nonnull obj, NSUInteger idx))block;


/**
 扁平映射

 @param keyPath 为nil 返回nil 根据每个item 执行block进行映射
 @param block block 回调 为nil 返回nil
 @return 映射数组 [block(item)]
 */
- (NSArray <id>* _Nullable)flatMap:(NSString * _Nullable)keyPath block:(_Nonnull id (^ _Nullable)(T _Nonnull obj, NSUInteger idx))block;

/**
 * @return NSArray of all element.keyPath
 */

/**
 映射

 @param keyPath 为nil 返回nil
 @return 映射数组[item.keyPath]
 */
- (NSArray <id> * _Nullable)pluck:(NSString * _Nullable)keyPath;

/**
 * @return NSDictionary of all element.keyPath with the key
 */

/**
 映射

 @param keyPath 为nil 返回nil
 @param keyKeyPath 为nil 返回nil
 @return @{item.keyPath: item.keyKeyPath}
 */
- (NSDictionary* _Nullable)pluck:(NSString* _Nullable)keyPath key:(NSString* _Nullable)keyKeyPath;


/**
 扁平 [[1,2,3],[4,5,6]] becomes [1,2,3,4,5,6]

 @return 扁平后的数组
 */
- (NSArray <id> *_Nullable)flatten;

/// NSArray removes one level with key so [{"hola" => [1,2]},{"hola"=>[3,4]}] becomes [1,2,3,4]

/**
 扁平 [{"hola" => [1,2]},{"hola"=>[3,4]}] becomes [1,2,3,4]

 @param keyPath 为nil 返回nil
 @return 扁平后的数组
 */
- (NSArray <id> * _Nullable)flatten:(NSString * _Nullable)keyPath;

/**
 * @return reduces the array to a single value, passing the result of each iteration into the subsequent iteration
 * initial carry value is `nil`
 */


/**
 减少

 @param block 为nil 返回nil
 @return 处理结果
 */
- (id _Nullable)reduce:(id _Nonnull(^ _Nullable)(T _Nonnull carry, T _Nonnull object))block;

/**
 * @return reduces the array to a single value, passing the result of each iteration into the subsequent iteration
 * initial carry value is `carry`
 */

/**
 减少

 @param block 为nil 返回nil
 @param carry 初始化值
 @return 处理结果
 */
- (id _Nullable)reduce:(id _Nonnull (^ _Nullable)(T _Nonnull carry, T _Nonnull object))block carry:(T _Nullable)carry;

/**
 * Final collection is run through the transformer
 * and then the output of that is returned
 */

/**
 管道

 @param block 为nil 返回nil
 @return 处理结果
 */
- (id _Nullable)pipe:(id _Nonnull (^ _Nullable)(NSArray <T> * _Nonnull array))block;

/**
 * If condition is true, the collection is run throught block and is result is returned
 * if condition is false, it is ignored, and self is returned
 */

/**
 过滤

 @param condition 是否使用block的旗标
 @param block 回掉 为nil 返回nil
 @return 处理结果
 */
- (id _Nullable)when:(BOOL)condition block:(T _Nonnull (^ _Nullable)(NSArray * _Nonnull array))block;

/**
 * returns NSDictionary by grouping the array items by a given key:
 */

/**
 分组

 @param keyPath 为nil 返回nil
 @return NSDictionary by grouping the array items by a given key:
 */
- (NSDictionary * _Nullable)groupBy:(NSString* _Nullable)keyPath;


/**
 分组

 @param keypath 为nil 返回nil
 @param block 执行block 为nil 返回nil
 @return 分组处理结果
 */
- (NSDictionary* _Nullable)groupBy:(NSString* _Nullable)keypath block:(NSString* _Nonnull (^ _Nullable)(id _Nonnull object, NSString* _Nonnull key))block;

/**
 * return NSDictionary copping to keypath all the elements of the keypath so
 *   [
 *       {"groups" => [1,2]   },
 *       {"groups" => [2,3,3] }
 *   ]
 *   becomes
 *   {
 *       1 => [
 *           {"groups" => [1,2]}
 *       ]
 *       2 => [
 *           {"groups" => [1,2]},
 *           {"groups" => [2,3,3]}
 *       ]
 *       3 => [
 *           {"groups" => [2,3,3]}
 *           {"groups" => [2,3,3]}
 *       ]
 *   }
 */
- (NSDictionary * _Nullable)expand:(NSString * _Nullable)keyPath;

/**
 * return same as expand but with uniques test so dictionary doesn't have duplicated values
 */
- (NSDictionary * _Nullable)expand:(NSString * _Nullable)keypath unique:(BOOL)unique;


/**
 最大

 @return 最大项
 */
- (T _Nullable)maxObject;

/**
 * Returns the greatests element.keypath in the array
 */

/**
 最大

 @param keyPath 为nil 返回nil
 @return 最大项
 */
-(T _Nullable)maxObject:(NSString * _Nullable)keyPath;


/**
 最大

 @param block 为nil 返回nil
 @return 最大项
 */
- (T _Nullable)maxObjectFor:(double (^ _Nullable)(T _Nonnull obj))block;

/**
 最小

 @return 最小项
 */
- (T _Nullable)minObject;


/**
 最小

 @param keyPath 为nil 返回nil
 @return 最小项
 */
- (T _Nullable)minObject:(NSString * _Nullable)keyPath;

/**
 * Returns the minimum block(element) in the array
 */

/**
 最小

 @param block 为nil 返回nil
 @return block(item)的最小值
 */
- (T _Nullable)minObjectFor:(double (^ _Nullable)(T _Nonnull obj))block;


/**
 随机

 @return 随机排序数组
 */
-(T _Nonnull)random;


/**
 随机

 @param quantity 随机的数量
 @return 随机排序数组
 */
- (NSArray <T> *_Nullable)random:(NSUInteger)quantity;


/**
 混乱

 @return 混乱排序数组
 */
- (NSArray <T> *_Nullable)shuffled;


/**
 交换

 @return 交换排序数组
 */
- (NSArray * _Nullable)permutations;


/**
 压缩

 @param other 其他数组
 @return 压缩后的数组
 */
- (NSArray * _Nullable)zip:(NSArray * _Nullable)other;

/**
 * Associates
 */
- (NSDictionary * _Nullable)mapToAssoc:(NSArray * _Nullable (^ _Nullable)(id _Nullable obj, NSUInteger idx))block;


/**
 去重复后

 @return NSCountedSet实例
 */
- (NSCountedSet * _Nullable)countedSet;

/**
 * Returns an string concatedated with delimiter
 */
- (NSString * _Nullable)implode:(NSString * _Nullable)delimiter;

/// 数组转化为字符串
- (NSString * _Nullable)toString;

/// 数组转化为JSON字符串
- (NSString * _Nullable)toJson;

#pragma mark - Operators


/**
 交集 相同的元素根据哈希去重复

 @param b 其他数组
 @return 俩个数组的交集
 */
- (NSArray <T> * _Nullable)intersect:(NSArray <T> * _Nullable)b;

/**
 并集 相同的元素根据哈希去重复

 @param b 其他数组
 @return 俩个数组的并集
 */
- (NSArray <T> * _Nullable)union:(NSArray <T> * _Nullable)b;

/**
 合并数组

 @param b 其他数组
 @return 合并数组
 */
- (NSArray <T> * _Nullable)join:(NSArray <T> * _Nullable)b;

/**
 差集

 @param b 其他数组
 @return 差集数组
 */
- (NSArray <T> * _Nullable)diff:(NSArray <T> * _Nullable)b;
- (NSArray <T> * _Nullable)minus:(NSArray <T> * _Nullable)b;
- (NSArray <T> * _Nullable)distinct;
- (NSArray <T> * _Nullable)distinct:(NSString * _Nullable)keypath;

/**
 * Returns all the combinations with all array items
 */
- (NSArray <T> * _Nullable)crossJoin:(NSArray <T> * _Nullable)list;
+ (NSArray <T> * _Nullable)cartesianProduct:(NSArray <T> * _Nullable)arrays; // used by the cross join

#pragma mark - Set Operators
- (NSNumber * _Nullable)sum;
- (NSNumber * _Nullable)sum:(NSString * _Nullable)keypath;
- (NSNumber * _Nullable)sumWith:(NSNumber * _Nonnull  (^ _Nullable)(id _Nonnull object))block;
- (NSNumber * _Nullable)avg;
- (NSNumber * _Nullable)avg:(NSString * _Nullable)keypath;
- (NSNumber * _Nullable)max;
- (NSNumber * _Nullable)max:(NSString * _Nullable)keypath;
- (NSNumber * _Nullable)min;
- (NSNumber * _Nullable)min:(NSString * _Nullable)keypath;

/// 去重复
- (NSArray <T> * _Nonnull)uniqueObjectOperate;
/// 取交集并且设置相同时的保留策略
- (NSArray <T> *_Nullable)intersectOperate:(NSArray <T> * _Nullable)other strategy:(ReserveStrategy)strategy;
/// 取交集并且设置保留数量
- (NSArray <T> *_Nullable)intersectOperate:(NSArray <T> * _Nullable)other weight:(ReserveWeight)weight lowerLimit:(NSInteger)lowerLimit upperLimit:(NSInteger)upperLimit;
- (NSArray <T> *_Nullable)intersectOperate:(NSArray <T> * _Nullable)other weight:(ReserveWeight)weight appearCount:(NSInteger)count;
/// 差集
- (NSArray <T> *_Nullable)distinctOperate:(NSArray <T> * _Nullable)other;
/// 相同的元素分组
- (NSArray <NSArray <T> *> * _Nullable)sameObjectGroupOperate;

@end

@interface NSObject  (Uniqueness)

/// 根据需求需重写该函数 默认使用对象的hash
- (BOOL)customEqualTo:(id _Nullable)object;
/// 内部使用 外界无需设置
@property (nonatomic, assign) BOOL operateFlag;

@end
