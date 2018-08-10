//
//  NZQSelectTypeViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/10.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQSelectTypeViewController.h"
#import "NZQVerticalFlowLayout.h"
#import "NZQSelectTypeCell.h"

#import "NZQSubCustonBuildPage.h"

static const CGFloat NZQSpacing = 15;

@interface NZQSelectTypeViewController ()<NZQVerticalFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)NSMutableArray *selectStrings;

@property (nonatomic,assign)BOOL isMulti;
@property (nonatomic,strong)UILabel *titleLab2;

@end

@implementation NZQSelectTypeViewController

- (instancetype)initWithCallBack:(selectTypesBlock)block{
    
    if (self = [super initWithTitle:self.title]) {
        _zqTypesBlock = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self makeData];
}

- (void)makeData{
    
    NZQWeak(self);
    [[NZQRequestManager sharedManager]GET:BaseUrlWith(DataBuildTagsList) parameters:nil completion:^(NZQBaseResponse *response) {
        if (response.error) {
            //错误提示
            [weakself.collectionView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                
            }];
            return ;
        }
        
        if (![response.responseObject[@"state"] boolValue]) {
            //发生错误
            [weakself.collectionView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                
            }];
            return ;
        }
        
         weakself.dataArray = response.responseObject[@"ext"][@"page"][0][@"array"];
        
//        for (int i = 0;i< weakself.dataArray.count ; i++) {
//            [weakself.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NZQSelectTypeCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%d",NSStringFromClass([NZQSelectTypeCell class]),i]];
//        }
        
        //没有数据
        if (weakself.dataArray.count==0) {
            [weakself.collectionView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:NO reloadButtonBlock:^(id sender) {

            }];
            
            return;
        }
        [weakself.collectionView reloadData];
    }];
    
}

- (void)setUI{

    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(NZQSpacing, self.nzq_navgationBar.height + NZQSpacing, 100, 21)];
    titleLab.text = @"消息";
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:titleLab];
    
    _titleLab2 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.width - NZQSpacing -100, titleLab.top, 100, 21)];
    _titleLab2.text = @"确认";
    _titleLab2.textColor = [UIColor zqBlueColor];
    _titleLab2.textAlignment = NSTextAlignmentRight;
    _titleLab2.font = [UIFont systemFontOfSize:18];
    _titleLab2.userInteractionEnabled = YES;
    [self.view addSubview:_titleLab2];
    
    NZQWeak(self);
    [_titleLab2 addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        
        if (weakself.selectStrings.count == 0) {
            [MBProgressHUD showWarn:@"至少选择一个类型" ToView:weakself.view];
            return;
        }
        
        NSMutableString *string = [NSMutableString string];
        for (NSString *str in weakself.selectStrings) {
            [string appendString:str];
            [string appendString:@","];
        }
        NZQSubCustonBuildPage *page = [[NZQSubCustonBuildPage alloc]init];
        page.zqType = string;
        [weakself.navigationController pushViewController:page animated:YES];
    }];
    
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(0);
        make.top.mas_equalTo(titleLab.mas_bottom);
    }];
    
}

#pragma mark -加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120) collectionViewLayout:[[NZQVerticalFlowLayout alloc] initWithDelegate:self]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.contentInset = UIEdgeInsetsZero;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.scrollEnabled = YES;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NZQSelectTypeCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([NZQSelectTypeCell class])];
    }
    return _collectionView;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)selectStrings{
    if (!_selectStrings) {
        _selectStrings = [NSMutableArray array];
    }
    return _selectStrings;
}


#pragma mark - NZQVerticalFlowLayoutDelegate
- (NSInteger)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout columnsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (CGFloat)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth{
    return itemWidth;
}

- (UIEdgeInsets)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}


#pragma mark - CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NZQWeak(self);
    NSDictionary *dic = self.dataArray[indexPath.row];
    NZQSelectTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NZQSelectTypeCell class]) forIndexPath:indexPath];
    cell.dataDic = dic;
    cell.tapSelectClick = ^(NZQSelectTypeCell *zqCell) {
        if (zqCell.ImgView.selected) {
            [weakself.selectStrings addObject:zqCell.dataDic[@"id"]];
        }else{
            [weakself.selectStrings removeObject:zqCell.dataDic[@"id"]];
        }
    };

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NZQSelectTypeCell *cell = (NZQSelectTypeCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = !cell.selected;
}



#pragma mark - 导航栏样式定义
- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

- (UIColor *)nzqNavigationBackgroundColor:(NZQNavigationBar *)navigationBar{
    return [UIColor clearColor];
}

- (BOOL)nzqNavigationIsHideBottomLine:(NZQNavigationBar *)navigationBar{
    
    return YES;
}

- (UIImage *)nzqNavigationBarBackgroundImage:(NZQNavigationBar *)navigationBar{
    return [UIImage imageNamed:@"navBackImage"];
}

- (UIImage *)nzqNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(NZQNavigationBar *)navigationBar{
    
    [leftButton setImage:[[UIImage imageNamed:@"navigationButtonReturn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
    leftButton.tintColor = [UIColor whiteColor];
    return [[UIImage imageNamed:@"navigationButtonReturn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (NSMutableAttributedString *)nzqNavigationBarTitle:(NZQNavigationBar *)navigationBar{
    return [[NSMutableAttributedString alloc]initWithString:@""];
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
