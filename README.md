# BannerCycleView

**BannerCycleView**是用UICollectionView实现的，使用的时候也特别简单，就跟使用UICollectionView一样的清爽。

- [我的github](https://github.com/sunjinshuai)
- [我的个人博客](https://sunjinshuai.github.io/)

![BannerCycleView.gif](http://upload-images.jianshu.io/upload_images/588630-ed997a60d2dbc4a9.gif?imageMogr2/auto-orient/strip)

首先，BannerCyclePageControlPosition是确定pageControl的位置，默认值是中间位置。

```
BannerCyclePageControlPositionCenter
BannerCyclePageControlPositionLeft
BannerCyclePageControlPositionRight
```
然后，BannerCycleView的代理方法
```
/**
*  代理方法取轮播总数（参考UITableView或UICollectionView）
*
*  @param cycleView 轮播视图
*
*  @return 轮播总数
*/
- (NSInteger)numberOfRowsInCycleView:(BannerCycleView *)cycleView;
/**
*  代理方法取轮播子视图（参考UITableView或UICollectionView）
*
*  @param cycleView 轮播视图
*  @param row       子视图索引
*
*  @return 轮播子视图（继承自系统UICollectionViewCell）
*/
- (UICollectionViewCell *)cycleView:(BannerCycleView *)cycleView cellForItemAtRow:(NSInteger)row;

/**
*  代理方法取子视图大小
*
*  @param cycleView 轮播视图
*  @param row       子视图索引
*
*  @return 子视图大小
*/
- (CGSize)cycleView:(BannerCycleView *)cycleView sizeForItemAtRow:(NSInteger)row;
/**
*  代理方法视图滚动到子视图时回调
*
*  @param cycleView 滚动视图
*  @param row       子视图索引
*/
- (void)cycleView:(BannerCycleView *)cycleView didScrollToItemAtRow:(NSInteger)row;
/**
*  代理方法子视图点击时回调
*
*  @param cycleView 滚动视图
*  @param row       子视图索引
*/
- (void)cycleView:(BannerCycleView *)cycleView didSelectItemAtRow:(NSInteger)row;

```
最后，设置定时器的属性
```
/** 是否循环(default = YES) */
@property (nonatomic, assign) BOOL cycleEnabled;
/** 自动滚动间隔(default = 0) */
@property (nonatomic, assign) CGFloat timeInterval;
```

看是不是像UICollectionView一样的清爽。
代码规范，结构清晰，个人感觉没有一点冗余代码，欢迎各路大神批评指正。
喜欢的可以给star。
