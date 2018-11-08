//
//  ViewController.m
//  UICollerctionViewHorizontal
//
//  Created by MAC on 2018/11/8.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "ViewController.h"
#import "CollModel.h"
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_RATE   ([UIScreen mainScreen].bounds.size.width/375.0)
#import "imageCell.h"
#import "LHHorizontalPageFlowlayout.h"
static NSString * const imageC = @"imageCell";
static NSString * const moreImageC = @"imageCell";
static const NSInteger kItemCountPerRow = 5; //每行显示5个
static const NSInteger kRowCount = 3; //每页显示行数
static float imageHeight = 80;//cell 高度
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * modelArray;
@property (nonatomic, strong) UICollectionView * moreCollectionView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *appArray = [[self getDict] objectForKey:@"dictInfo"];
    for (int i = 0; i < appArray.count; i++) {
        NSDictionary * appDic = appArray[i];
        CollModel * model = [[CollModel alloc]init];
        model.title = [appDic objectForKey:@"title"];
        model.url = [appDic objectForKey:@"url"];
        [self.modelArray addObject:model];
    }
    [self createCollectionView];
    [self createRightCollectionView];
}

- (NSDictionary *)getDict {
    NSString * string  = @"{\"dictInfo\":[{\"title\":\"你好啊\",\"url\":\"1.jpeg\"},{\"title\":\"你好啊\",\"url\":\"2.jpeg\"},{\"title\":\"你好啊\",\"url\":\"3.jpeg\"},{\"title\":\"你好啊\",\"url\":\"4.jpeg\"},{\"title\":\"你好啊\",\"url\":\"5.jpeg\"},{\"title\":\"你好啊\",\"url\":\"6.jpeg\"},{\"title\":\"是很好\",\"url\":\"7.jpeg\"},{\"title\":\"你好啊\",\"url\":\"1.jpeg\"},{\"title\":\"你好啊\",\"url\":\"2.jpeg\"},{\"title\":\"你好啊\",\"url\":\"3.jpeg\"},{\"title\":\"你好啊\",\"url\":\"4.jpeg\"},{\"title\":\"你好啊\",\"url\":\"5.jpeg\"},{\"title\":\"你好啊\",\"url\":\"6.jpeg\"},{\"title\":\"是很好\",\"url\":\"7.jpeg\"},{\"title\":\"你好啊\",\"url\":\"1.jpeg\"},{\"title\":\"你好啊\",\"url\":\"2.jpeg\"},{\"title\":\"你好啊\",\"url\":\"3.jpeg\"},{\"title\":\"你好啊\",\"url\":\"4.jpeg\"},{\"title\":\"你好啊\",\"url\":\"5.jpeg\"},{\"title\":\"你好啊\",\"url\":\"6.jpeg\"},{\"title\":\"是很好\",\"url\":\"7.jpeg\"}]}";
    NSDictionary *infoDic = [self dictionaryWithJsonString:string];
    return infoDic;
}


-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers  error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (void)createCollectionView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, imageHeight * SCREEN_RATE) collectionViewLayout:layout];
    _collectionView.tag = 11;
    _collectionView.backgroundColor = [UIColor colorWithRed:186 / 255.0 green:186 / 255.0 blue:186 / 255.0 alpha:0.9];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.bounces = NO;
    _collectionView.alwaysBounceHorizontal = YES;
    _collectionView.alwaysBounceVertical = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[imageCell class] forCellWithReuseIdentifier:imageC];
}

- (void)createRightCollectionView{
    
    LHHorizontalPageFlowlayout * layout = [[LHHorizontalPageFlowlayout alloc] initWithRowCount:kRowCount itemCountPerRow:kItemCountPerRow];
    [layout setColumnSpacing:0 rowSpacing:0 edgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _moreCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, imageHeight * SCREEN_RATE * kRowCount) collectionViewLayout:layout];
    _moreCollectionView.backgroundColor = [UIColor clearColor];
    _moreCollectionView.tag = 22;
    _moreCollectionView.dataSource = self;
    _moreCollectionView.delegate = self;
    _moreCollectionView.bounces = NO;
    _moreCollectionView.alwaysBounceHorizontal = YES;
    _moreCollectionView.alwaysBounceVertical = NO;
    _moreCollectionView.backgroundColor = [UIColor colorWithRed:186 / 255.0 green:186 / 255.0 blue:186 / 255.0 alpha:0.9];
    _moreCollectionView.showsHorizontalScrollIndicator = NO;
    _moreCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_moreCollectionView];
    [_moreCollectionView registerClass:[imageCell class] forCellWithReuseIdentifier:moreImageC];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArray.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollModel * model = self.modelArray[indexPath.row];
    imageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageC forIndexPath:indexPath];
    cell.itemModel = model;
    return cell;
}

// 返回每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat CWidth =  imageHeight * SCREEN_RATE;
    CGFloat CHeight = imageHeight * SCREEN_RATE;
    return CGSizeMake(CWidth, CHeight);
}

#pragma mark - UICollectionViewDelegate点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollModel * model = self.modelArray[indexPath.row];
    NSLog(@"self.appModelArray----%@",model.title);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
