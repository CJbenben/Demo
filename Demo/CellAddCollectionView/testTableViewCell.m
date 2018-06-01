//
//  testTableViewCell.m
//  Demo
//
//  Created by ChenJie on 2018/6/1.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "testTableViewCell.h"
#import "textCollectionViewCell.h"
#import <Masonry.h>

@interface testTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign)CGFloat hightED;
@end

@implementation testTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self.hightED = 0.0;
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [self.contentView addSubview:self.lable];
        
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(-50);
            make.height.mas_equalTo(50);//先随定一个
        }];
    }
    return self;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection =     UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[textCollectionViewCell class] forCellWithReuseIdentifier:@"123"];
        _collectionView.backgroundColor = [UIColor yellowColor];
        
    }
    return _collectionView;
}

-(void)setDataArr:(NSArray *)dataArr{
    [self.collectionView reloadData]; //重新换数据源的时候 记得重回用的cell上的colletionView重新加载数据
    self.hightED = 0; //当重新换数据源的时候 初始化自己的高度. (如果不写 就有一种意外比如 比如一个cell被重用,开始这个cell的collectionView的cell 和重用之后是一样的  self.hightED != hight  重用之前 和重用之后的内容高度 很定是一样的啊 那么他的高度是不用跟新 但是更新tableViewCell的高度的 代理方法还是 要走吧)
    _dataArr = dataArr;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataArr.count == 0) {
        return 1;
    }else{
        return self.dataArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    textCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"123" forIndexPath: indexPath];
    cell.backgroundColor = [UIColor blackColor];
    
    [self updateCollectionViewHight:self.collectionView.collectionViewLayout.collectionViewContentSize.height];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(40, 60);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}


-(void)updateCollectionViewHight:(CGFloat)hight{
    
    NSLog(@"+%@",self);
    NSLog(@"++ %f",self.hightED);
    NSLog(@"+++ %f",hight);
    
    if (self.hightED != hight) { //这个判断起到两个作用 第一 以为这个方法被调用多次这样写 保证 每个cell里面调用一次,切只调用一次  第二是当cell被重用从用的cell上的collectionView内容高度不一样的时候重新 更新跟新高度
        self.hightED = hight;
        
        NSLog(@"+++++%ld",self.indexPath.row);
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(hight);
        }];
        
        if (_deleget && [_deleget respondsToSelector:@selector(uodataTableViewCellHight:andHight:andIndexPath:)]) {
            [self.deleget uodataTableViewCellHight:self andHight:hight andIndexPath:self.indexPath];
        }
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end

