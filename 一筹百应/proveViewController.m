//
//  proveViewController.m
//  一筹百应
//
//  Created by 韩先炜 on 2018/1/17.
//  Copyright © 2018年 择善基金. All rights reserved.
//

#import "proveViewController.h"
#import "proveModel.h"
#import "proveTableViewCell.h"
#import <MJRefresh.h>
@interface proveViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger current;
    
}
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UILabel *headerLabel;
@property (nonatomic,strong)UITableView *proveTableView;

@end

@implementation proveViewController

- (UITableView *)proveTableView{
    if (!_proveTableView) {
        _proveTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+45, SCREEN_WIDTH, SCREEN_HEIGHT-64-45) style:UITableViewStyleGrouped];
        
        _proveTableView.delegate = self;
        _proveTableView.dataSource = self;
        _proveTableView.estimatedRowHeight = 44 ; //44为任意值
        _proveTableView.rowHeight = UITableViewAutomaticDimension;
        [self.view addSubview:_proveTableView];
    }
    return _proveTableView;
}
-(UILabel *)headerLabel{
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 45)];
        _headerLabel.text = [NSString stringWithFormat:@"    0人实名证实"];
        _headerLabel.font = [UIFont systemFontOfSize:14];
        _headerLabel.textColor = [UIColor lightGrayColor];
        UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH-20, 0.5)];
        [lineImage setImage:[UIImage imageNamed:@"239色块"]];
        [_headerLabel addSubview:lineImage];
    }
    return _headerLabel;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self contitle:@"实名证实"];
    [self uiconfig];
}
- (void)uiconfig{
    declareWeakSelf;
    [self.view addSubview:self.headerLabel];
    self.proveTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        current=1;
        [weakSelf requestData:current];
    }];
    
    
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    [footer setTitle:@"没有那么多了" forState:MJRefreshStateNoMoreData];
    self.proveTableView.mj_footer = footer;
    
    [ self.proveTableView.mj_header beginRefreshing];
}
- (void)requestData:(NSInteger )index{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"project_id"] = self.projectId;
    params[@"page"] = @(current);
    params[@"page_num"] = @(10);
    [ycbyHttpRequest postWithURL:@"/service/project/project_prove/" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",jsonDict);
       
        if ([jsonDict[@"info"] count]!=0) {
            self.headerLabel.attributedText = [hudCustom convertNumColor: [NSString stringWithFormat:@"    %@人实名证实",jsonDict[@"info"][@"count_num"]] withFontSize:14];
            if (index==1) {
                [self.dataArray removeAllObjects];
                self.dataArray =[NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[proveModel class] json:jsonDict[@"info"][@"prove"]]];
                [self.proveTableView.mj_header endRefreshing];
                [self.proveTableView.mj_footer resetNoMoreData];
            }else {
                NSArray * tempArray = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[proveModel class] json:jsonDict[@"info"][@"prove"]]];
                [self.dataArray addObjectsFromArray:tempArray];
                if (tempArray.count == 0) {
                    
                    [self.proveTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    
                    [self.proveTableView.mj_footer endRefreshing];
                }
                
            }

            [self.proveTableView reloadData];
            
        }else{
            [self.proveTableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)loadMoreData{
    
    current = current+1;
    [self requestData:current];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid=@"TableViewCell";
        
    proveTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"proveTableViewCell" owner:self options:nil].firstObject;
    }
        
        cell.model = self.dataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
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
