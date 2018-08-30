//
//  NZQOtherVideoListPage.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/29.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQOtherVideoListPage.h"
#import "NZQAutoRefreshFooter.h"
#import "NZQCardInfoViewController.h"
#import "NZQFansCell.h"

@interface NZQOtherVideoListPage ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger page;

@end

@implementation NZQOtherVideoListPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self makeData];
}

- (void)makeData{
    
    _page ++;
    @weakify(self);
    NSDictionary *param = @{@"page":@(_page),
                            @"uid":userID,
                            @"keyid":keyID,
                            @"art_uid":@(_art_id)
                            };;
    
    [[NZQRequestManager sharedManager] GET:BaseUrlWith(DataBuildMyfocus) parameters:param completion:^(NZQBaseResponse *response) {
        if (response.error) {
            //错误提示
            [weak_self.tableView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                
            }];
            return ;
        }
        
        if (![response.responseObject[@"state"] boolValue]) {
            //发生错误
            [weak_self.tableView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                
            }];
            return ;
        }
        
        NSArray *workList = response.responseObject[@"ext"][@"list"][@"list"];
        [weak_self.dataArray addObjectsFromArray:workList];
        
        
        //没有数据
        if (weak_self.dataArray.count==0) {
            [weak_self.tableView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
                
            }];
            return;
        }
        
        //所有数据加载完毕了
        if (weak_self.dataArray.count == [response.responseObject[@"ext"][@"list"][@"count"] integerValue]) {
            [weak_self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [weak_self.tableView reloadData];
    }];
    
}

- (void)setUI{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.tableView reloadData];
}

#pragma mark TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dataDic = self.dataArray[indexPath.row];
    NZQFansCell *cell = [NZQFansCell fansCellWithTableView:tableView];
    cell.dataDic = dataDic;

    cell.tapfouceBtn = ^(NZQFansCell *cell) {
        NSString *url;
        if (cell.operBtn.selected) {
            url = BaseUrlWith(DataBuildCancelFocus);
        }else{
            url = BaseUrlWith(DataBuildAddFocus);
        }
        
        NSDictionary *dic = @{@"uid":userID,@"keyid":keyID,@"focus_uid":cell.dataDic[@"uid"]};
        [[NZQRequestManager sharedManager] POST:url parameters:dic completion:^(NZQBaseResponse *response) {
            if (response.error) {
                //错误提示
                return ;
            }
            
            if (![response.responseObject[@"state"] boolValue]) {
                //发生错误
                return ;
            }else{
                cell.operBtn.selected = !cell.operBtn.selected;
            }
        }];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    return self.topicService.topicViewModels[indexPath.row].cellHeight;
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark -加载
- (UITableView *)tableView{
    
    if(!_tableView){
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        @weakify(self);
        _tableView.mj_footer = [NZQAutoRefreshFooter footerWithRefreshingBlock:^{
            [weak_self makeData];
        }];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
