//
//  NZQMyCommentListPage.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/28.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQMyCommentListPage.h"
#import "NZQCommentListCell.h"

@interface NZQMyCommentListPage ()

@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UITextField *inputTextView;

//回复评论，接口需要的参数。
@property (nonatomic,strong)NSMutableDictionary *mainDic;

@end

@implementation NZQMyCommentListPage

- (void)viewDidLoad{
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, kScreenHeight - 180);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.page = 1;
    [self loadMore:NO];
    
    //setUI
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 65)];
    header.backgroundColor = [UIColor whiteColor];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 50, 5)];
    [lineView addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(2.5, 2.5)];
    lineView.centerX = header.width * 0.5;
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [header addSubview:lineView];
    
    @weakify(self);
    [lineView addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        [weak_self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(15, lineView.bottom +  12.5, 3, 15)];
    [lineView2 addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(1.5, 1.5)];
    lineView2.backgroundColor = [UIColor zqBlueColor];
    [header addSubview:lineView2];
    
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake( lineView2.right + 15, lineView.bottom +  10, 200, 20)];
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textColor = [UIColor blackColor];
    titleLab.text = @"评论";
    [header addSubview:titleLab];
    
    [self.view addSubview:header];
    
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.preferredContentSize.height - 54, self.view.width, 54)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    _inputTextView = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, _bottomView.width - _bottomView.height -40, _bottomView.height)];
    _inputTextView.placeholder = @"请留下您的足迹";
    _inputTextView.backgroundColor = [UIColor whiteColor];
    _inputTextView.font = [UIFont systemFontOfSize:15];
    [_bottomView addSubview:_inputTextView];
    
    UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(_bottomView.width - _bottomView.height, 0, _bottomView.height, _bottomView.height)];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"cinct_113"] forState:UIControlStateNormal];
    [sendBtn setImage:[UIImage imageNamed:@"btn_comments"] forState:UIControlStateNormal];
    [_bottomView addSubview:sendBtn];
    
    [sendBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        [weak_self userTapSendBtn];
    }];
    
    
    
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.top += header.height;
    contentInset.bottom += _bottomView.height;
    self.tableView.contentInset = contentInset;
    
}

- (void)loadMore:(BOOL)isMore{
    
    NZQWeak(self);
    NSDictionary *para;
    
    if (isMore) {
        self.page += 1;
        para = @{@"uid":userID,
                 @"id":@(_zqId),
                 @"page":@(self.page),
                 };
    }else{
        self.page = 1;
        para = @{@"uid":userID,
                 @"id":@(_zqId),
                 @"page":@(self.page),
                 };
    }

    [[NZQRequestManager sharedManager] GET:BaseUrlWith(DataBuildCommList) parameters:para completion:^(NZQBaseResponse *response) {
        [weakself endHeaderFooterRefreshing];

        if (response.error) {
            //错误提示
            [weakself.tableView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                [weakself.tableView.mj_header beginRefreshing];
            }];
            return ;
        }

        if (![response.responseObject[@"state"] boolValue]) {
            //发生错误
            [weakself.tableView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                [weakself.tableView.mj_header beginRefreshing];
            }];
            return ;
        }
        
        NSDictionary *dataDic = response.responseObject[@"ext"][@"data"];
        [weakself.mainDic setValue:dataDic[@"uid"] forKey:@"replyuid"];
        weakself.inputTextView.placeholder = @"请留下您的足迹";

        NSArray *array = dataDic[@"list"];
        if (isMore) {
            
            [weakself.dataArray addObjectsFromArray:array];
        }else{
            [weakself.dataArray removeAllObjects];
            [weakself.dataArray addObjectsFromArray:array];
        }

        //没有数据
        if (weakself.dataArray.count==0) {
            [weakself.tableView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
                [weakself.tableView.mj_header beginRefreshing];
            }];

            return;
        }
        
        if (weakself.dataArray.count == [response.responseObject[@"ext"][@"data"][@"count"] integerValue]) {
            [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
        }

        [weakself.tableView reloadData];
    }];
    
}

#pragma mark - 事件
- (void)userTapSendBtn{
    
    if (_inputTextView.text.length == 0) {
        [MBProgressHUD showInfo:@"请输入评论内容" ToView:self.view];
        return;
    }
    
    [_mainDic setValue:_inputTextView.text forKey:@"content"];
    
    
    [self showLoading];
    @weakify(self);
    [[NZQRequestManager sharedManager] POST:BaseUrlWith(DataBuildComm) parameters:_mainDic completion:^(NZQBaseResponse *response) {
        [weak_self dismissLoading];
        if (response.error) {
            //错误提示
            return ;
        }
        
        if (![response.responseObject[@"state"] boolValue]) {
            //发生错误
            return ;
        }else{
            //成功
             weak_self.inputTextView.text = @"";
            [weak_self loadMore:NO];
        }
    }];
    
    
}


#pragma mark TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dataDic = self.dataArray[indexPath.row];
    NZQCommentListCell *cell = [NZQCommentListCell commentCellWithTableView:tableView];
    cell.dataDic = dataDic;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //计算cell高度
    NSDictionary *dataDic = self.dataArray[indexPath.row];
    NSString *content = dataDic[@"content"];
    CGFloat contentH = [content heightForFont:[UIFont systemFontOfSize:13] width:self.view.width - 70];
    
    NSArray *replyArray = dataDic[@"commentReplyEntities"];
    NSMutableAttributedString *allStr = [[NSMutableAttributedString alloc]init];
    for (NSDictionary *subDic in replyArray) {
        
        NSString *nameStr = subDic[@"nickname"];
        NSMutableAttributedString *subStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@: %@\n\n",nameStr,subDic[@"content"]]];
        [subStr addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, nameStr.length)];
        [subStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(nameStr.length, subStr.length - nameStr.length)];
        [allStr insertAttributedString:subStr atIndex:allStr.length];
    }
    [allStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, allStr.length)];
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect replyBounds = [allStr boundingRectWithSize:CGSizeMake(self.view.width - 86, CGFLOAT_MAX) options:options context:nil];
    
    if (allStr.length > 0) {
        replyBounds.size = CGSizeMake(replyBounds.size.width, replyBounds.size.height+20);
    }else{
        replyBounds.size = CGSizeMake(replyBounds.size.width, 0);
    }
    
    return replyBounds.size.height + 76 + contentH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dataDic = self.dataArray[indexPath.row];
    self.inputTextView.placeholder = [NSString stringWithFormat:@"回复：%@",dataDic[@"nickname"]];
    self.inputTextView.text = @"";
    [_mainDic setObject:dataDic[@"id"] forKey:@"reply_id"];
    [_mainDic setObject:dataDic[@"id"] forKey:@"relationid"];
    [_mainDic setObject:dataDic[@"uid"] forKey:@"replyuid"];
    
}


#pragma mark 加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray  = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableDictionary *)mainDic{
    if (!_mainDic) {
        _mainDic = [NSMutableDictionary dictionary];
        [_mainDic setValue:userID forKey:@"uid"];
        [_mainDic setValue:keyID forKey:@"keyid"];
        [_mainDic setValue:@(0) forKey:@"reply_id"];
        [_mainDic setValue:@(_zqId) forKey:@"relation_id"];
        [_mainDic setValue:@(0) forKey:@"relationid"];

    }
    return _mainDic;
}

@end
