//
//  NZQUpMyRuralVideoPage.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/27.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQUpMyRuralVideoPage.h"
#import "NZQPickPhotoTool.h"
#import "NZQUpLoadImageCell.h"
#import "NZQVerticalFlowLayout.h"
#import <ZFPlayer.h>
#import <TZImagePickerController.h>
#import "NZQContactViewController.h"

@interface NZQUpMyRuralVideoPage ()<UICollectionViewDelegate,UICollectionViewDataSource,NZQVerticalFlowLayoutDelegate,TZImagePickerControllerDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UIView *imgBgView;
@property (nonatomic,strong)UIImageView *playImg;
@property (nonatomic,strong)UIImageView *videoImage;
@property (nonatomic,strong)NSURL *videoUrl;
@property (nonatomic,strong)ZFPlayerView *playerView;
@property (nonatomic,strong)UIView *downView;
@property (nonatomic,strong)UILabel *selectTagLab;
@property (nonatomic,strong)UIView *containerView;
@property (nonatomic,strong)UITextField *titleTF;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)NSMutableDictionary *upParam;


@property (nonatomic,strong)UITextField *tf1;//名称
@property (nonatomic,strong)UITextField *tf2;//位置
@property (nonatomic,strong)UITextField *tf3;//联系方式
@property (nonatomic,strong)UITextField *tf4;//所属人

@end

@implementation NZQUpMyRuralVideoPage

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
    scrollView.backgroundColor = [UIColor bgViewColor];
    scrollView.tag = 100;
    [self.view addSubview:scrollView];
    scrollView.frame = CGRectMake(0, self.nzq_navgationBar.bottom, self.view.width, self.view.height - self.nzq_navgationBar.bottom );
    
    
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor bgViewColor];
    [scrollView addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.mas_equalTo(scrollView.width);
    }];
    
    CGFloat tfHeight = 54;
    UIView *firstView = [[UIView alloc]init];
    firstView.backgroundColor = [UIColor whiteColor];
    [_containerView addSubview:firstView];
    
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(tfHeight*4);
    }];
    
    
    UILabel *lab1 = [[UILabel alloc]init];
    lab1.text = @"项目名称";
    lab1.textColor = [UIColor darkGrayColor];
    lab1.font = [UIFont systemFontOfSize:15];
    [firstView addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(tfHeight);
        make.width.mas_equalTo(100);
    }];
    
    _tf1 = [[UITextField alloc]init];
    _tf1.placeholder = @"请输入";
    _tf1.font = [UIFont systemFontOfSize:15];
    [firstView addSubview:_tf1];
    [_tf1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab1.mas_right);
        make.top.mas_equalTo(lab1.mas_top);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(tfHeight);
    }];
    [_tf1 addLineWithLinePlace:NZQLinePlaceDown];
    
    
    UILabel *lab2 = [[UILabel alloc]init];
    lab2.text = @"地理位置";
    lab2.textColor = [UIColor darkGrayColor];
    lab2.font = [UIFont systemFontOfSize:15];
    [firstView addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(lab1.mas_bottom);
        make.height.mas_equalTo(tfHeight);
        make.width.mas_equalTo(100);
    }];
    
    _tf2 = [[UITextField alloc]init];
    _tf2.placeholder = @"请输入";
    _tf2.font = [UIFont systemFontOfSize:15];
    [firstView addSubview:_tf2];
    [_tf2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab2.mas_right);
        make.top.mas_equalTo(lab2.mas_top);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(tfHeight);
    }];
    [_tf2 addLineWithLinePlace:NZQLinePlaceDown];
    
    UIImageView *rightView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tfHeight/3, tfHeight/3)];
    [rightView setImage:[UIImage imageNamed:@"cinct_182"]];
    rightView.contentMode = UIViewContentModeScaleAspectFit;
    rightView.userInteractionEnabled = YES;
    _tf2.rightView = rightView;
    _tf2.rightViewMode = UITextFieldViewModeAlways;
    [rightView addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        
    }];
    
    
    UILabel *lab3 = [[UILabel alloc]init];
    lab3.text = @"联系方式";
    lab3.textColor = [UIColor darkGrayColor];
    lab3.font = [UIFont systemFontOfSize:15];
    [firstView addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(lab2.mas_bottom);
        make.height.mas_equalTo(tfHeight);
        make.width.mas_equalTo(100);
    }];
    
    _tf3 = [[UITextField alloc]init];
    _tf3.placeholder = @"请输入";
    _tf3.font = [UIFont systemFontOfSize:15];
    [firstView addSubview:_tf3];
    [_tf3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab3.mas_right);
        make.top.mas_equalTo(lab3.mas_top);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(tfHeight);
    }];
    [_tf3 addLineWithLinePlace:NZQLinePlaceDown];
    
    
    UILabel *lab4 = [[UILabel alloc]init];
    lab4.text = @"所属人";
    lab4.textColor = [UIColor darkGrayColor];
    lab4.font = [UIFont systemFontOfSize:15];
    [firstView addSubview:lab4];
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(lab3.mas_bottom);
        make.height.mas_equalTo(tfHeight);
        make.width.mas_equalTo(100);
    }];
    
    _tf4 = [[UITextField alloc]init];
    _tf4.placeholder = @"请输入";
    _tf4.font = [UIFont systemFontOfSize:15];
    [firstView addSubview:_tf4];
    [_tf4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab4.mas_right);
        make.top.mas_equalTo(lab4.mas_top);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(tfHeight);
    }];
    
    
    //项目介绍
    UIView *view2 = [[UIView alloc]init];
    view2.backgroundColor = [UIColor whiteColor];
    [_containerView addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(firstView.mas_bottom).offset(NZQSpace);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    UILabel *titleLab2 = [[UILabel alloc]init];
    titleLab2.font = [UIFont systemFontOfSize:16];
    titleLab2.textColor = [UIColor blackColor];
    titleLab2.text = @"项目介绍";
    [view2 addSubview:titleLab2];
    [titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(NZQSpace);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(54);
    }];
    
    _textView = [[UITextView alloc]init];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"请输入"];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, title.length)];
    _textView.attributedPlaceholder = title;
    _textView.font = [UIFont systemFontOfSize:16];
    
    [view2 addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLab2.mas_bottom);
        make.left.mas_equalTo(NZQSpace);
        make.right.mas_equalTo(-NZQSpace);
        make.height.mas_equalTo(140);
    }];
    
    
    
    UIView *upVideView = [[UIView alloc]init];
    upVideView.backgroundColor = [UIColor whiteColor];
    [_containerView addSubview:upVideView];
    
    [upVideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(view2.mas_bottom).offset(NZQSpace);
        make.height.mas_equalTo(180);
    }];
    
    _videoImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_input_film_1"]];
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
    [_containerView addSubview:_imgBgView];
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
    
    @weakify(self);
    _downView = [[UIView alloc]init];
    _downView.backgroundColor = _containerView.backgroundColor;
    [_containerView addSubview:_downView];
    [_downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.imgBgView.mas_bottom).offset(NZQSpace);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(70);
    }];
    
    
    UIButton *upBtn = [[UIButton alloc]init];
    [upBtn setTitle:@"确认上传" forState:UIControlStateNormal];
    upBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [upBtn setBackgroundImage:[UIImage imageNamed:@"cinct_113"] forState:UIControlStateNormal];
    [_downView addSubview:upBtn];
    
    [upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(44);
        make.right.mas_equalTo(-44);
        make.bottom.mas_equalTo(weakself.downView.bottom).offset(-NZQSpace);
        make.height.mas_equalTo(40);
    }];;
    [upBtn addRoundedCorners:UIRectCornerAllCorners WithRect:CGRectMake(0, 0, self.view.width - 44*2, 40) WithCornerRadii:CGSizeMake(20, 20)];
    [upBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weak_self tapUpBtnEvent];
        });
    }];
    
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.downView.mas_bottom);
    }];
    
}

#pragma mark 加载
- (ZFPlayerView *)playerView{
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
        _playerView.cellPlayerOnCenter = YES;
        _playerView.stopPlayWhileCellNotVisable = YES;
        ZFPlayerShared.isStatusBarHidden = YES;
    }
    return _playerView;
}

- (NSMutableDictionary *)upParam{
    if (!_upParam) {
        _upParam = [NSMutableDictionary dictionary];
        [_upParam setObject:userID forKey:@"uid"];
        [_upParam setObject:keyID forKey:@"keyid"];
    }
    return _upParam;
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

- (void)tapUpBtnEvent{
    //上传视频
    if (!self.videoUrl) {
        [MBProgressHUD showWarn:@"请上传视频" ToView:self.view];
        return;
    }
    
    if (self.nzq_selectedImages.count == 0) {
        [MBProgressHUD showWarn:@"请上传图片" ToView:self.view];
        return;
    }
    
    if (_tf1.text.length == 0) {
        [MBProgressHUD showWarn:@"请输入项目名称" ToView:self.view];
        return;
    }
    
    if (_tf2.text.length == 0) {
        [MBProgressHUD showWarn:@"请输入地理位置" ToView:self.view];
        return;
    }
    
    if (_tf3.text.length == 0) {
        [MBProgressHUD showWarn:@"请输入联系方式" ToView:self.view];
        return;
    }
    
    if (_tf4.text.length == 0) {
        [MBProgressHUD showWarn:@"请输入所属人" ToView:self.view];
        return;
    }
    
    
    if (_textView.text.length == 0) {
        [MBProgressHUD showWarn:@"请输入项目介绍" ToView:self.view];
        return;
    }
    
    [MBProgressHUD showProgressToView:self.view Text:@"上传中..."];
    
    [self.upParam setObject:_tf1.text forKey:@"name"];
    [self.upParam setObject:_tf2.text forKey:@"address"];
    [self.upParam setObject:_tf3.text forKey:@"tel"];
    [self.upParam setObject:_tf4.text forKey:@"owner"];
    [self.upParam setObject:_textView.text forKey:@"info"];

    @weakify(self);
    [[NZQRequestManager sharedManager] upload:BaseUrlWith(BuilduploadVideo) parameters:nil formDataBlock:^NSDictionary<NSData *,NZQDataName *> *(id<AFMultipartFormData> formData, NSMutableDictionary<NSData *,NZQDataName *> *needFillDataDict) {
        
        NSData *data = [NSData dataWithContentsOfURL:weak_self.videoUrl];
        needFillDataDict[data] = @"userfile";
        
        return needFillDataDict;
    } progress:^(NSProgress *progress) {
        
    } completion:^(NZQBaseResponse *response) {
        
        if (response.responseObject[@"fpath"] != nil) {
            [[NSFileManager defaultManager] removeItemAtPath:[weak_self.videoUrl absoluteString] error:nil];
            [weak_self.upParam setObject:response.responseObject[@"fpath"] forKey:@"video"];
            [weak_self upImagesEvent];
        }
        
    }];
    
}

- (void)upImagesEvent{
    @weakify(self);
    [[NZQRequestManager sharedManager] upload:BaseUrlWith(BuilduploadVideo) parameters:nil formDataBlock:^NSDictionary<NSData *,NZQDataName *> *(id<AFMultipartFormData> formData, NSMutableDictionary<NSData *,NZQDataName *> *needFillDataDict) {
        
        [self.nzq_selectedImages enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            needFillDataDict[UIImageJPEGRepresentation(obj, 1)] = @"userfile";
        }];
        
        return needFillDataDict;
    } progress:^(NSProgress *progress) {
        
    } completion:^(NZQBaseResponse *response) {
        if (response.responseObject[@"fpath"] != nil) {
            [weak_self.upParam setObject:response.responseObject[@"fpath"] forKey:@"images"];
            [weak_self startUpRequest];
        }
    }];
    
}

- (void)startUpRequest{
    
    @weakify(self);
    [[NZQRequestManager sharedManager]POST:BaseUrlWith(DataUploadScenery) parameters:_upParam completion:^(NZQBaseResponse *response) {
        [self dismissLoading];
        if (response.error) {
            //错误提示
            return ;
        }
        
        if (![response.responseObject[@"state"] boolValue]) {
            //发生错误
            return ;
        }else{
            //成功
            [weak_self.navigationController pushViewController:[[NZQContactViewController alloc]initWithTitle:self.title] animated:YES];
        }
    }];
}


- (void)selectEventWithType:(NSDictionary *)dataDic{
    [_upParam setObject:dataDic[@"id"] forKey:@"buildtype"];
    
    NSString *content = [NSString stringWithFormat:@"● %@ ●",dataDic[@"content"]];
    CGFloat width =  [content widthForFont:[UIFont systemFontOfSize:15]] + 20;
    
    
    NSMutableAttributedString *tagStr = [[NSMutableAttributedString alloc] initWithString:content];
    [tagStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(1, tagStr.length -1)];
    [tagStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(1, tagStr.length -1)];
    
    [tagStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 1)];
    [tagStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, 1)];
    
    [tagStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(tagStr.length -1, 1)];
    [tagStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(tagStr.length -1, 1)];
    
    self.selectTagLab.attributedText = tagStr;
    
    [self.selectTagLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
    
    [self.selectTagLab addRoundedCorners:UIRectCornerAllCorners WithRect:CGRectMake(0, 0, width, 34) WithCornerRadii:CGSizeMake(17, 17)];
    
    [self.downView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(310);
    }];
    
    @weakify(self);
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weak_self.downView.mas_bottom);
    }];
    self.selectTagLab.hidden = NO;
    
}

#pragma mark -TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset{
    [_videoImage setImage:coverImage];
    _playImg.hidden = NO;
    [_videoImage removeAllTapGestures];
    //添加play事件
    _videoImage.tag = 110;
    PHAsset *phAsset = (PHAsset *)asset;
    
    
    [MBProgressHUD showProgressToView:self.view Text:@"处理中..."];
    if (phAsset.mediaType == PHAssetMediaTypeVideo) {
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        options.networkAccessAllowed = true;
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestExportSessionForVideo:asset options:options exportPreset:AVAssetExportPresetLowQuality resultHandler:^(AVAssetExportSession * _Nullable exportSession, NSDictionary * _Nullable info){
            
            NSDateFormatter* formater = [[NSDateFormatter alloc] init];
            [formater setDateFormat:@"yyyyMMddHHmmss"];
            NSString *fileName = [NSString stringWithFormat:@"nzq-%@.mp4",[formater stringFromDate:[NSDate date]]];
            NSString *outfilePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", fileName];
            exportSession.outputURL = [NSURL fileURLWithPath:outfilePath];
            exportSession.outputFileType = AVFileTypeMPEG4;
            [exportSession exportAsynchronouslyWithCompletionHandler:^{
                if ([exportSession status] == AVAssetExportSessionStatusCompleted) {
                    
                    self.videoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",outfilePath]];
                }else{
                    //发生错误
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self dismissLoading];
                });
                
            }];
            
        }];
    }
    
    
    @weakify(self);
    [_videoImage addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        @strongify(self);
        
        if (self.videoUrl == nil) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
            playerModel.videoURL         = self.videoUrl;
            playerModel.placeholderImage = coverImage;
            playerModel.scrollView = [self.view viewWithTag:100];
            playerModel.fatherView = self.videoImage;
            playerModel.fatherViewTag  = self.videoImage.tag;
            [self.playerView playerControlView:nil playerModel:playerModel];
            self.playerView.hasDownload = NO;
            [self.playerView autoPlayTheVideo];
        });
    }];
    
    
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
