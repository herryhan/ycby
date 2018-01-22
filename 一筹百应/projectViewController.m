//
//  projectViewController.m
//  一筹百应
//
//  Created by 庄园 on 17/10/12.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "projectViewController.h"
#import "homeModel.h"
#import "homeTableViewCell.h"
#import <MJRefresh.h>


@interface projectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger current;
}
@property (nonatomic, strong) NSMutableArray *DataArray;
@property (nonatomic, strong) MJRefreshAutoGifFooter *footer;

@property (nonatomic, strong) UITableView *projectTableView;

@end

@implementation projectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    declareWeakSelf;
    self.projectTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        current=1;
        [weakSelf requestData:current];
    }];
    
    
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.refreshingTitleHidden = YES;
    [footer setTitle:@"我可是有底线的哦" forState:MJRefreshStateNoMoreData];
    self.projectTableView.mj_footer = footer;
    
    [ self.projectTableView.mj_header beginRefreshing];
    
    // self.view.backgroundColor = [UIColor blueColor];
    
    // Do any additional setup after loading the view.
}

-(void)loadMoreData{
    
    current = current+1;
    [self requestData:current];
    
}
//懒加载tableview
-(UITableView *)projectTableView{
    
    if (!_projectTableView) {
        
        _projectTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49-44) style:UITableViewStyleGrouped];
        _projectTableView.delegate= self;
        _projectTableView.dataSource = self;
        [self.view addSubview:_projectTableView];
        
    }
    return _projectTableView;
}
- (NSMutableArray *)DataArray {
    if (!_DataArray) {
        _DataArray = [NSMutableArray array];
    }
    return _DataArray;
}

- (void)requestData:(NSInteger )index{
    
    NSMutableDictionary *parama = [[NSMutableDictionary alloc]init];
    parama[@"project_type"]= @(3);
    parama[@"page"] = @(index);
    parama[@"page_num"] = @(10);
    
    
    [ycbyHttpRequest postWithURL:@"/service/project/index/" params:parama success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@\n%@",jsonDict,jsonDict[@"info"]);
        
        if (index==1) {
            [self.DataArray removeAllObjects];
            self.DataArray =[NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[homeModel class] json:jsonDict[@"info"]]];
            [self.projectTableView.mj_header endRefreshing];
        }else {
            NSArray * tempArray = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[homeModel class] json:jsonDict[@"info"]]];
            [self.DataArray addObjectsFromArray:tempArray];
            if (tempArray.count == 0) {
                
                [self.projectTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                
                [self.projectTableView.mj_footer endRefreshing];
            }
            
        }
        
        [self.projectTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.DataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"TableViewCell";
    homeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"homeTableViewCell" owner:self options:nil].firstObject;
    }
    homeModel *item=self.DataArray[indexPath.section];
    
    [cell cellConfigWithModel:item];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 270;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    XorderViewController *order=[[XorderViewController alloc]init];
    //    [self.navigationController pushViewController:order animated:YES];
    NSLog(@"hhhh");
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v =[[UIView alloc] init];
    v.alpha=0;
    return v;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v =[[UIView alloc] init];
    v.alpha=0;
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
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
