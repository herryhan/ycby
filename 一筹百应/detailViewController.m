//
//  detailViewController.m
//  一筹百应
//
//  Created by 庄园 on 17/10/17.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "detailViewController.h"
#import "supportModel.h"
#import "supportTableViewCell.h"
#import <MJRefresh.h>
#import "supportCountTableViewCell.h"
#import "project_basicModel.h"
#import "project_basicViewModel.h"
#import "project_infoView.h"
#import "projectDetailBottomView.h"
#import "proveViewController.h"
#import "MJPhotoBrowser.h"
#import "weProveViewController.h"

@interface detailViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSInteger current;
    
}
@property (strong, nonatomic) NSArray *publicModelArray;

@property (nonatomic,strong) NSMutableArray *DataArray;

@property (nonatomic, strong) UITableView *supportTableView;

@property (nonatomic,strong) NSNumber *countNum;

@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,strong) project_basicModel *baseModel;

@property (nonatomic,strong) project_infoView *headerView;
@property (nonatomic,strong) projectDetailBottomView *bottomView;

@end

@implementation detailViewController

- (projectDetailBottomView *)bottomView{
    declareWeakSelf;
    if (!_bottomView) {
        _bottomView = [[projectDetailBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-55, SCREEN_WIDTH, 55)];
        [_bottomView setCollectionBtnPress:^{
            [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
            
            [SVProgressHUD show];
            NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
            parmas[@"token"] = [SPAccountTool account].token;
            parmas[@"project_id"] = weakSelf.project_id;
            parmas[@"state"] = @(![weakSelf.baseModel.is_focus boolValue]);
            [ycbyHttpRequest postWithURL:@"/service/user/update_user_focus_project/" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@",responseObject);
                NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSLog(@"%@",jsonDict[@"msg"]);
                weakSelf.baseModel.is_focus = @(![weakSelf.baseModel.is_focus boolValue]);
                [weakSelf.bottomView setModel:weakSelf.baseModel];
                [SVProgressHUD dismiss];
                if ([weakSelf.baseModel.is_focus boolValue]) {
                     [SVProgressHUD showSuccessWithStatus:@"关注成功"];
                }else{
                     [SVProgressHUD showSuccessWithStatus:@"已取消关注"];
                }
               
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
        }];
        [_bottomView setLinkerBtnPress:^{
            
        }];
        
       [self.view addSubview:_bottomView];
    }
    return _bottomView;
}
- (void)creatViewModel{
    declareWeakSelf;
    
    project_basicViewModel *model = [[project_basicViewModel alloc]init];
    self.baseModel = [[project_basicModel alloc]init];
    
    [model setBlockWithReturnBlock:^(id returnValue) {
        
        _publicModelArray = returnValue;
        weakSelf.baseModel = _publicModelArray[0];
        
        [weakSelf.bottomView setModel:weakSelf.baseModel];
        [weakSelf.headerView setModel:weakSelf.baseModel];
        CGFloat height = [weakSelf.headerView setValueWithDic:weakSelf.baseModel];
        UIView *tableHeaderView = _supportTableView.tableHeaderView;
        tableHeaderView.height = height;
        [_supportTableView setTableHeaderView:tableHeaderView];
        
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [model fetchBasicInfo:self.project_id andToken:[SPAccountTool account].token];
    
}
- (void)viewDidLoad {
    declareWeakSelf;
    
    [super viewDidLoad];
    [self.view addSubview:self.bottomView];
    [self contitle:@"项目详情"];
    self.projectTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        current=1;
        [weakSelf requestData:current];
    }];
    
    
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //footer.refreshingTitleHidden = YES;
    [footer setTitle:@"没有更多的祝福语了" forState:MJRefreshStateNoMoreData];
    self.supportTableView.mj_footer = footer;
    
    [ self.supportTableView.mj_header beginRefreshing];
    
    [self creatViewModel];
    
    self.headerView = [[project_infoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270)];
    [self.headerView setShowPics:^(NSArray*imagesUrlArray, NSInteger imageSelectedIndex,UIImageView *imageV) {
        NSMutableArray *photoArray = [NSMutableArray array];
        MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc] init];
        NSLog(@"%ld",imageSelectedIndex);
        for (int i = 0 ; i<imagesUrlArray.count; i++) {
            NSString *imagurl =imagesUrlArray[i][@"img_url"];
            MJPhoto *photo = ({
                MJPhoto *photo = [[MJPhoto alloc] init];
                photo.url = [NSURL URLWithString:imagurl];
                photo.srcImageView = imageV;
                photo;
            });
            [photoArray addObject:photo];
        }
    
        photoBrowser.photos = photoArray;
        photoBrowser.currentPhotoIndex = imageSelectedIndex;
        [photoBrowser show];
    }];
    [self.headerView setProveBtnBlock:^{
        NSLog(@"ddd");
        weProveViewController *weProveVc = [[weProveViewController alloc]init];
        weProveVc.projectId = weakSelf.project_id;
        
        [weakSelf.navigationController pushViewController:weProveVc animated:YES];
    }];
    
    [self.headerView setShowProveDetailBlock:^{
        proveViewController *proveVc = [[proveViewController alloc]init];
        proveVc.projectId = weakSelf.project_id;
        
        [weakSelf.navigationController pushViewController:proveVc animated:YES];
    }];
    
    self.supportTableView.tableHeaderView = self.headerView;

}
-(void)loadMoreData{
    
    current = current+1;
    [self requestData:current];
    
}
//懒加载tableview
-(UITableView *)projectTableView{
    
    if (!_supportTableView) {
        
        _supportTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-55) style:UITableViewStyleGrouped];
        _supportTableView.delegate= self;
        _supportTableView.dataSource = self;
        [self.view addSubview:_supportTableView];
    }
    return _supportTableView;
    
}
-(UILabel *)countLabel{

    if (!_countLabel) {
        _countLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-50, 20)];
    }
    return _countLabel;
    
}
- (NSMutableArray *)DataArray {
    if (!_DataArray) {
        _DataArray = [NSMutableArray array];
    }
    return _DataArray;
}

- (void)requestData:(NSInteger )index{
    
    NSMutableDictionary *parama = [[NSMutableDictionary alloc]init];
    parama[@"project_id"]= self.project_id;
    parama[@"page"] = @(index);
    parama[@"page_num"] = @(10);
    
    
    [ycbyHttpRequest postWithURL:@"/service/project/project_support/" params:parama success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",jsonDict[@"info"]);
        if ([jsonDict[@"info"] count]!=0) {
            self.countNum = jsonDict[@"info"][@"count_num"];
            if (index==1) {
                self.countLabel = nil;
                [self.DataArray removeAllObjects];
                self.DataArray =[NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[supportModel class] json:jsonDict[@"info"][@"support"]]];
                [self.supportTableView.mj_header endRefreshing];
                [self.supportTableView.mj_footer resetNoMoreData];
            }else {
                NSArray * tempArray = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[supportModel class] json:jsonDict[@"info"][@"support"]]];
                [self.DataArray addObjectsFromArray:tempArray];
                if (tempArray.count == 0) {
                    
                    [self.supportTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    
                    [self.supportTableView.mj_footer endRefreshing];
                }
                
            }
            
            [self.supportTableView reloadData];
            
        }else{
              [self.supportTableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataArray.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        static NSString *cellid=@"ID";
        supportCountTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[supportCountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }

        cell.countString = [NSString stringWithFormat:@"共收到%@个爱心",self.countNum];
        return cell;
        
    }else{
        static NSString *cellid=@"TableViewCell";
        
        supportTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[supportTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        
        cell.model = self.DataArray[indexPath.row-1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        return cell;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 40;
    }else{
         return 70;
    }
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
