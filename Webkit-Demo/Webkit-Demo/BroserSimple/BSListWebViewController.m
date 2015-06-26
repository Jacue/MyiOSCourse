//
//  BSListWebViewController.m
//  Webkit-Demo
//
//  Created by luowei on 15/6/24.
//  Copyright (c) 2015 rootls. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "BSListWebViewController.h"
#import "WK.h"
#import "WKPagesCollectionView.h"
#import "WKPagesCollectionViewCell.h"
#import "WKPagesCollectionViewFlowLayout.h"
#import "BSViewController.h"
#import "MyWebView.h"
#import "Defines.h"


@interface BSListWebViewController()<WKPagesCollectionViewDataSource,WKPagesCollectionViewDelegate>

@property(nonatomic, strong) WKPagesCollectionView *collectionView;
@end

@implementation BSListWebViewController


- (instancetype)initWithWebView:(MyWebView *)webView {
    self = [super init];
    if (self) {
        __weak __typeof(self) weakSelf = self;
        self.updateDatasourceBlock = ^(MyWebView *wb){
            if(!weakSelf.windows){
                weakSelf.windows = @[wb].mutableCopy;
            }else{
                [weakSelf.windows addObject:wb];
            }

        };
        self.updateDatasourceBlock(webView);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _collectionView= [[WKPagesCollectionView alloc] initWithFrame:self.view.frame];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    [_collectionView registerClass:[WKPagesCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    _collectionView.maskShow=YES;

    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addWebView:)];
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    toolbar.items = @[addItem,flexibleSpace,settingItem];
    [self.view addSubview:toolbar];

    toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[toolbar]|" options:0 metrics:nil views:@{@"toolbar":toolbar}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[toolbar(44)]|" options:0 metrics:nil views:@{@"toolbar":toolbar}]];

}


//设置
- (void)setting {

}

//添加一个webView
- (void)addWebView:(id)sender {
    [_collectionView appendItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_collectionView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


#pragma mark UICollectionViewDataSource Implementation

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _windows.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    MyWebView *webView = _windows[(NSUInteger) indexPath.row];

    static NSString* identity=@"cell";
    WKPagesCollectionViewCell* cell=(WKPagesCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:identity forIndexPath:indexPath];
    cell.collectionView=collectionView;

    //对webView截图
    UIGraphicsBeginImageContextWithOptions(webView.bounds.size, YES, 1.0);
    [webView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIImageView* imageView= [[UIImageView alloc] initWithImage:image];

    imageView.frame=self.view.bounds;
    [cell.cellContentView addSubview:imageView];

    return cell;
}

#pragma mark UICollectionViewDelegate Implementation

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [self viewWillAppear:YES];

    MyWebView *webView = _windows[(NSUInteger) indexPath.row];
    self.updateActiveWindowBlock(webView);

//    BSViewController *viewController = (BSViewController *)self.parentViewController;
//    BSViewController *viewController = (BSViewController *)[self.view.superview nextResponder];
    [self dismissViewControllerAnimated:YES completion:^{
//        [viewController.activeWindow reload];
    }];
}



#pragma mark WKPagesCollectionViewDataSource Implementation

- (void)collectionView:(WKPagesCollectionView *)collectionView willRemoveCellAtIndexPath:(NSIndexPath *)indexPath {
    [_windows removeObjectAtIndex:(NSUInteger) indexPath.row];
}

- (void)willAppendItemInCollectionView:(WKPagesCollectionView *)collectionView {

    //添加一个webView,block会回调_windows addObject
    MyWebView *webView = nil;
    self.addWebViewBlock(&webView,HOME_URL);
}


@end
