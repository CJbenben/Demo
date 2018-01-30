//
//  HorizontalCollectionViewController.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "HorizontalCollectionViewController.h"
#import "AtzucheHomeCityCollectionView.h"
#import "AtzucheHomeCityFlowLayout.h"


#define itemW       SCREEN_WIDTH * 100/375.0

@interface HorizontalCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *imageAry;
@property (nonatomic, strong) AtzucheHomeCityCollectionView *homeCityCollectionView;

@end

@implementation HorizontalCollectionViewController

- (NSMutableArray *)imageAry {
    if (_imageAry == nil) {
        _imageAry = [@[@"http://down.tutu001.com/d/file/20110312/ae15ebaebfa15428826432e50e_560.jpg",
                       @"http://down.tutu001.com/d/file/20120315/29e47a7c992f6f1d978bfc6d8d_560.jpg",
                       @"http://pic23.nipic.com/20120919/10785657_204032524191_2.jpg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517824334&di=a6b1fb22560e3bf02b2a98aa3afd0b28&imgtype=jpg&er=1&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F08f790529822720ee889863371cb0a46f31fabb0.jpg",
                       @"http://pic41.nipic.com/20140524/18658664_170018225386_2.jpg",
                       @"http://pic1.16pic.com/00/17/71/16pic_1771338_b.jpg",
                       @"http://imgsrc.baidu.com/image/c0%3Dshijue1%2C0%2C0%2C294%2C40/sign=69ebb73d61600c33e474d68b72253b7a/8644ebf81a4c510fdb7196336a59252dd42aa565.jpg"] mutableCopy];
    }
    return _imageAry;
}

- (AtzucheHomeCityCollectionView *)homeCityCollectionView {
    if (_homeCityCollectionView == nil) {
        AtzucheHomeCityFlowLayout *layout = [[AtzucheHomeCityFlowLayout alloc] initAndSize:CGSizeMake(itemW, itemW + 35)];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _homeCityCollectionView = [[AtzucheHomeCityCollectionView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, itemW + 35) collectionViewLayout:layout];
    }
    return _homeCityCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"HorizontalCollectionViewController";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.homeCityCollectionView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.homeCityCollectionView];
    self.homeCityCollectionView.homeCityAry = self.imageAry;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
