//
//  BannerCycleView.m
//  BannerCycleView
//
//  Created by Michael on 2017/2/8.
//  Copyright © 2017年 com.chinabidding. All rights reserved.
//

#import "BannerCycleView.h"
#import "UIView+Extesion.h"
#import "UIColor+Extension.h"

@interface BannerCycleView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, assign) NSInteger multiplier;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSMutableDictionary *cellClassDictionary;

@property (nonatomic, strong) NSMutableDictionary *cellReusableDictionary;

@property (nonatomic, strong) NSString *reusableIdentifier;

@property (nonatomic, assign) NSInteger visibleRow;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *myTimer;

@end

@implementation BannerCycleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.itemSpace = 0;
        self.cycleEnabled = YES;
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    self.collectionView.frame = self.bounds;
    [self addSubview:self.collectionView];
    
    self.collectionView.clipsToBounds = NO;
    self.clipsToBounds = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    if (frame.size.width > 0 && frame.size.height > 0) {
        self.collectionView.frame = frame;
    }
    
    self.pageControl.width = [self.pageControl sizeForNumberOfPages:self.itemCount].width;
    switch (self.pageControlPosition) {
        case BannerCyclePageControlPositionCenter:
        {
            self.pageControl.centerX = self.collectionView.centerX + self.pageControlOffset.x;
            self.pageControl.bottom = self.collectionView.bounds.size.height - 15.0f + self.pageControlOffset.y;
            break;
        }
        case BannerCyclePageControlPositionLeft:
        {
            self.pageControl.left = 0 + self.pageControlOffset.x;
            self.pageControl.bottom = self.collectionView.bounds.size.height - 15.0f + self.pageControlOffset.y;
            break;
        }
        case BannerCyclePageControlPositionRight:
        {
            self.pageControl.right = self.collectionView.right + self.pageControlOffset.x;
            self.pageControl.bottom = self.collectionView.bounds.size.height - 15.0f + self.pageControlOffset.y;
            break;
        }
        default:
            break;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if ([self.dataSource respondsToSelector:@selector(numberOfRowsInCycleView:)]) {
        self.itemCount = [self.dataSource numberOfRowsInCycleView:self];
    }
    [self startTimer];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(numberOfRowsInCycleView:)]) {
        self.itemCount = [self.dataSource numberOfRowsInCycleView:self];
    }
    self.pageControl.numberOfPages = self.itemCount;
    return self.itemCount * self.multiplier;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *showView = nil;
    self.visibleRow = indexPath.row;
    if ([self.dataSource respondsToSelector:@selector(cycleView:cellForItemAtRow:)]) {
        showView = [self.dataSource cycleView:self cellForItemAtRow:indexPath.row % self.itemCount];
    }
    
    return showView;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self itemSizeWithIndex:indexPath.row % self.itemCount];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.itemSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.itemSpace;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(cycleView:didSelectItemAtRow:)]) {
        [self.delegate cycleView:self didSelectItemAtRow:indexPath.row % self.itemCount];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self adjustCollectionView];
    if ([self.delegate respondsToSelector:@selector(cycleView:didScrollToItemAtRow:)]) {
        [self.delegate cycleView:self didScrollToItemAtRow:self.index];
    }
    self.pageControl.currentPage = self.index;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.timeInterval > 0) {
        [self pauseTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.timeInterval > 0) {
        [self resumeTimer];
    }
}

#pragma mark - private methods
- (void)adjustCollectionView
{
    [self collectionScrollToIndex:self.itemCount * (NSInteger)(self.multiplier / 2) + self.index animation:NO];
}

- (void)collectionScrollToIndex:(NSInteger)index animation:(BOOL)animation
{
    if (index < self.itemCount * self.multiplier && index >= 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animation];
    }
}

- (void)startTimer
{
    [self stopTimer];
    [self.myTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.timeInterval]];
}

- (void)pauseTimer
{
    if (![self.myTimer isValid]) {
        return;
    }
    [self.myTimer setFireDate:[NSDate distantFuture]];
}

- (void)stopTimer
{
    if ([self.myTimer isValid]) {
        [self.myTimer invalidate];
        self.myTimer = nil;
    }
}

-(void)resumeTimer
{
    if (![self.myTimer isValid]) {
        return;
    }
    [self.myTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.timeInterval]];
}

#pragma mark - public methods
- (void)reloadData
{
    if (self.bounds.size.width > 0 && self.bounds.size.height > 0) {
        self.collectionView.frame = self.bounds;
    }
    
    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self adjustCollectionView];
        [self scrollToIndex:0 animation:NO];
        self.pageControl.currentPage = 0;
    });
    
    if ([self.dataSource respondsToSelector:@selector(numberOfRowsInCycleView:)]) {
        self.itemCount = [self.dataSource numberOfRowsInCycleView:self];
    }
    [self startTimer];
}

- (void)scrollToIndex:(NSInteger)index animation:(BOOL)animation
{
    [self collectionScrollToIndex:self.itemCount * (NSInteger)(self.multiplier / 2) + index animation:animation];
}

- (void)scrollToNextIndex
{
    [self adjustCollectionView];
    NSInteger nextIndex = self.index;
    if (nextIndex + 1 >= self.itemCount) {
        nextIndex = 0;
    } else {
        nextIndex++;
    }
    
    if ([self.delegate respondsToSelector:@selector(cycleView:didScrollToItemAtRow:)]) {
        [self.delegate cycleView:self didScrollToItemAtRow:nextIndex];
    }
    self.pageControl.currentPage = nextIndex;
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x + [self itemSizeWithIndex:nextIndex].width + self.itemSpace, self.collectionView.contentOffset.y) animated:YES];
}

- (void)scrollToPreviousIndex
{
    [self adjustCollectionView];
    NSInteger previousIndex = self.index;
    if (previousIndex == 0) {
        previousIndex = self.itemCount - 1;
    } else {
        previousIndex--;
    }
    
    if ([self.delegate respondsToSelector:@selector(cycleView:didScrollToItemAtRow:)]) {
        [self.delegate cycleView:self didScrollToItemAtRow:previousIndex];
    }
    self.pageControl.currentPage = previousIndex;
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x - [self itemSizeWithIndex:previousIndex].width - self.itemSpace, self.collectionView.contentOffset.y) animated:YES];
}

- (CGSize)itemSizeWithIndex:(NSInteger)index
{
   return self.collectionView.bounds.size;
}

- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forRow:(NSInteger)row
{
    
    return [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:self.visibleRow inSection:0]];
}

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier
{
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
    self.reusableIdentifier = identifier;
}

#pragma mark - getter and setter
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.minimumInteritemSpacing = self.itemSpace;
        flowLayout.minimumLineSpacing = self.itemSpace;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
    }
    return _collectionView;
}

- (NSInteger)index
{
    NSArray *itemIndexPaths = [self.collectionView indexPathsForVisibleItems];
    
    for (NSIndexPath *indexPath in itemIndexPaths) {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        if ((cell.frame.origin.x >= self.collectionView.contentOffset.x) && (CGRectGetMaxX(cell.frame) <= self.collectionView.contentOffset.x + self.collectionView.bounds.size.width)) {
            _index = indexPath.row % self.itemCount;
            break;
        }
    }
    
    return _index;
}

- (NSMutableDictionary *)cellClassDictionary
{
    if (_cellClassDictionary == nil) {
        _cellClassDictionary = [NSMutableDictionary dictionary];
    }
    return _cellClassDictionary;
}

- (NSMutableDictionary *)cellReusableDictionary
{
    if (_cellReusableDictionary == nil) {
        _cellReusableDictionary = [NSMutableDictionary dictionary];
    }
    return _cellReusableDictionary;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0 alpha:0.2f];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"ff4b9b"];
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    
    if (showPageControl) {
        [self addSubview:self.pageControl];
    } else {
        [self.pageControl removeFromSuperview];
    }
}

- (void)setCycleEnabled:(BOOL)cycleEnabled
{
    _cycleEnabled = cycleEnabled;
    
    if (cycleEnabled && self.itemCount > 1) {
        self.multiplier = 20;
    } else {
        self.multiplier = 1;
    }
    
    [self.collectionView reloadData];
}

- (NSTimer *)myTimer
{
    if (_myTimer == nil) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(scrollToNextIndex) userInfo:nil repeats:YES];
    }
    return _myTimer;
}

- (void)setItemCount:(NSInteger)itemCount
{
    _itemCount = itemCount;
    
    if (itemCount > 1) {
        self.multiplier = 20;
    } else {
        self.multiplier = 1;
    }
    
    if (self.showPageControl) {
        if (itemCount > 1) {
            self.pageControl.hidden = NO;
        } else {
            self.pageControl.hidden = YES;
        }
    }
}


@end
