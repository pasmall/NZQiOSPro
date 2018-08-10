//
//  NZQUpVide0ViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/9.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQUpVide0ViewController.h"
#import "NZQPickPhotoTool.h"
#import "NZQUpLoadImageCell.h"
#import "NZQVerticalFlowLayout.h"

#import <TZImagePickerController.h>

#import "NZQSelectTypeViewController.h"

@interface NZQUpVide0ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,NZQVerticalFlowLayoutDelegate,TZImagePickerControllerDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UIView *imgBgView;
@property (nonatomic,strong)UIImageView *playImg;
@property (nonatomic,strong)UIImageView *videoImage;

@end

@implementation NZQUpVide0ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI{
    NZQWeak(self);
    
    CGFloat NZQSpace = 15;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    scrollView.frame = CGRectMake(0, self.nzq_navgationBar.bottom, self.view.width, self.view.height - self.nzq_navgationBar.bottom );

    
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor bgViewColor];
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.mas_equalTo(scrollView.width);
    }];

    UIView *upVideView = [[UIView alloc]init];
    upVideView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:upVideView];
    
    [upVideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(180);
    }];
    
    _videoImage = [[UIImageView alloc]init];
    _videoImage.backgroundColor = [UIColor orangeColor];
    [upVideView addSubview:_videoImage];
    [_videoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(NZQSpace);
        make.bottom.right.mas_equalTo(-NZQSpace);
    }];
    _videoImage.userInteractionEnabled = YES;
    [_videoImage addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        [weakself selectVideEvent];
    }];
    
    _playImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_information_play"]];
    _playImg.hidden = YES;
    [_videoImage addSubview:_playImg];
    
    [_playImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(48, 48));
        make.center.mas_equalTo(weakself.videoImage).centerOffset(CGPointMake(0,0));
    }];

    
    //图片选择
    self.imgBgView = [[UIView alloc]init];
    _imgBgView.backgroundColor = [UIColor blueColor];
    [containerView addSubview:_imgBgView];
    [_imgBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(upVideView.mas_bottom).offset(NZQSpace);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(110);
    }];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120) collectionViewLayout:[[NZQVerticalFlowLayout alloc] initWithDelegate:self]];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.contentInset = UIEdgeInsetsZero;
    self.collectionView.alwaysBounceVertical = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
 
    [_imgBgView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.left.mas_equalTo(0);
    }];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NZQUpLoadImageCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([NZQUpLoadImageCell class])];
    
    //标题
    UIView *textFiledView = [[UIView alloc]init];
    textFiledView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:textFiledView];
    [textFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.imgBgView.mas_bottom).offset(NZQSpace);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(54);
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textColor = [UIColor blackColor];
    titleLab.text = @"标题";
    [textFiledView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    
    UITextField *titleTF = [[UITextField alloc]init];
    titleTF.placeholder = @"请输入";
    titleTF.font = [UIFont systemFontOfSize:16];
    [textFiledView addSubview:titleTF];
    [titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.left.mas_equalTo(titleLab.mas_right);
    }];
    
    UIView *downView = [[UIView alloc]init];
    downView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:downView];
    [downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textFiledView.mas_bottom).offset(NZQSpace);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(260);
    }];
    
    UILabel *titleLab2 = [[UILabel alloc]init];
    titleLab2.font = [UIFont systemFontOfSize:16];
    titleLab2.textColor = [UIColor blackColor];
    titleLab2.text = @"描述";
    [downView addSubview:titleLab2];
    [titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(NZQSpace);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(54);
    }];
    
    UITextView *textView = [[UITextView alloc]init];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"请输入"];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, title.length)];
    textView.attributedPlaceholder = title;
    textView.font = [UIFont systemFontOfSize:16];
    
    [downView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLab2.mas_bottom);
        make.left.mas_equalTo(NZQSpace);
        make.right.mas_equalTo(-NZQSpace);
        make.height.mas_equalTo(100);
    }];
    
    UILabel *tagBtn = [[UILabel alloc]init];
    tagBtn.text = @"#标签#";
    tagBtn.textColor = [UIColor blackColor];
    tagBtn.font = [UIFont systemFontOfSize:15];
    tagBtn.textAlignment= NSTextAlignmentCenter;
    tagBtn.backgroundColor = [UIColor bgViewColor];
    [downView addSubview:tagBtn];
    [tagBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textView.mas_bottom);
        make.left.mas_equalTo(NZQSpace);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(34);
    }];
    [tagBtn addRoundedCorners:UIRectCornerAllCorners WithRect:CGRectMake(0, 0, 80, 34) WithCornerRadii:CGSizeMake(17, 17)];
    [tagBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        NZQSelectTypeViewController *selectVc = [[NZQSelectTypeViewController alloc]initWithCallBack:^(NSArray *array) {
            
        }];
        [self.navigationController pushViewController:selectVc animated:YES];
    }];
    
    
    UIButton *upBtn = [[UIButton alloc]init];
    [upBtn setTitle:@"确认上传" forState:UIControlStateNormal];
    upBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [upBtn setBackgroundImage:[UIImage imageNamed:@"cinct_113"] forState:UIControlStateNormal];
    [downView addSubview:upBtn];
    
    [upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(44);
        make.right.mas_equalTo(-44);
        make.bottom.mas_equalTo(downView.bottom).offset(-NZQSpace);
        make.height.mas_equalTo(40);
    }];;
    [upBtn addRoundedCorners:UIRectCornerAllCorners WithRect:CGRectMake(0, 0, self.view.width - 44*2, 40) WithCornerRadii:CGSizeMake(20, 20)];
    [upBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        
    }];
    
    [containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(downView.mas_bottom);
    }];
    
    
    
}

#pragma  mark - action

- (void)selectVideEvent{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingImage = NO;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = NO;
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark -TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset{
    
}

#pragma mark - NZQVerticalFlowLayoutDelegate
- (NSInteger)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout columnsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (CGFloat)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth{
    return 80;
}

- (UIEdgeInsets)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}


#pragma mark - CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.nzq_selectedImages.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NZQWeak(self);
    NZQUpLoadImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NZQUpLoadImageCell class]) forIndexPath:indexPath];

    if (indexPath.item == self.nzq_selectedImages.count) {
        cell.photoImage = nil;
        cell.addPhotoClick = ^(NZQUpLoadImageCell *uploadImageCell) {
            [weakself alertAction];
        };
        cell.deletePhotoClick = nil;
    }else {
        cell.photoImage = self.nzq_selectedImages[indexPath.item];
        cell.addPhotoClick = nil;
        cell.deletePhotoClick = ^(UIImage *photoImage) {
//            !weakself.deleteHandler ?: weakself.deleteHandler(indexPath.item);
//            [collectionView performBatchUpdates:^{
//                [collectionView deleteItemsAtIndexPaths:@[indexPath]];
//            } completion:^(BOOL finished) {
//                [collectionView reloadData];
//            }];
        };
    }
    return cell;
}


- (void)alertAction{
    NZQWeak(self);
    [NZQPickPhotoTool showPickPhotoToolWithViewController:self maxPhotoCount:9 choosePhotoHandler:^(NSMutableArray<UIImage *> *selectedImages, NSMutableArray<PHAsset *> *selectedAccest) {
        [weakself.imgBgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(110 +  (NSInteger)(weakself.nzq_selectedImages.count/3) *90);
        }];
        [weakself.collectionView reloadData];
        
    } takePhotoHandler:^(NSMutableArray<UIImage *> *selectedImages, NSMutableArray<PHAsset *> *selectedAccest) {
        [weakself.imgBgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(110 +  (NSInteger)(weakself.nzq_selectedImages.count/3) *90);
        }];
        [weakself.collectionView reloadData];
    } deleteImage:^(void (^deleteHandler)(NSUInteger index)) {
//        weakself.deleteHandler =  deleteHandler;
    }];
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
    return [self changeTitle:self.title];
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 辅助方法
-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle{
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, title.length)];
    
    return title;
}

@end
