//
//  project_infoView.m
//  一筹百应
//
//  Created by 韩先伟 on 2017/10/23.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "project_infoView.h"

@implementation project_infoView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *arrayOfViews = [[NSBundle mainBundle]loadNibNamed:@"Project_basicInfo" owner:self options:nil];
        if (arrayOfViews.count<1) {
            return nil;
        }else{
            for (id obj in arrayOfViews) {
                if ([obj isKindOfClass:[project_infoView class]]) {
                    self = obj;
                    self.frame = frame;
                    self.headImage.layer.cornerRadius = 15;
                    self.headImage.layer.masksToBounds = YES;
                    self.stateLabel.backgroundColor = UIColorFromRGBA(71, 163, 78, 1);
                    self.stateLabel.textColor = [UIColor whiteColor];
                    self.stateLabel.layer.cornerRadius = 5;
                    self.stateLabel.layer.masksToBounds = YES;
                    
//                    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
//                    NSDictionary *paraStyle = @[]
                    self.targetMoneyLabel.textColor = UIColorFromRGBA(202,44, 51, 1);
                    self.gotMoneyLabel.textColor = UIColorFromRGBA(202,44, 51, 1);
                    self.helpCountLabel.textColor = UIColorFromRGBA(202,44, 51, 1);
                   
                    self.lineView.backgroundColor = UIColorFromRGBA(233, 233, 233, 1);
                    self.horLineview1.backgroundColor =UIColorFromRGBA(233, 233, 233, 1);
                    self.horLineView2.backgroundColor = UIColorFromRGBA(233, 233, 233, 1);
                    self.proveLine1.backgroundColor = UIColorFromRGBA(233, 233, 233, 1);
                    self.proveLine2.backgroundColor = UIColorFromRGBA(233, 233, 233, 1);
                    self.proveLine3.backgroundColor = UIColorFromRGBA(233, 233, 233, 1);
                    self.backgroundColor = UIColorFromRGBA(250, 248, 255, 1);
                    self.firstProveStringLabel.backgroundColor = UIColorFromRGBA(244, 244, 244, 1);
                    
                }
            }
        }
    }
    
    return self;
    
}

- (void)setModel:(project_basicModel *)model{
    _model = model;
}

- (CGFloat)setValueWithDic:(project_basicModel *) publicModel {
    NSLog(@"lauchtime:%@",publicModel.limit_time);
    NSInteger dayLastCount = [self getDifferenceByDate:publicModel.limit_time];
    
    if (dayLastCount>=0) {
        self.stateLabel.text = @"进行中";
        self.timeLabel.attributedText =[hudCustom convertNumColor:[NSString stringWithFormat:@"剩余 %ld 天",dayLastCount] withFontSize:14];
    }else{
        self.stateLabel.text = @"已结束";
        self.timeLabel.text = @"已结束";
    }

    [self.headImage sd_setImageWithURL:[NSURL URLWithString:publicModel.headimg_url]];
    self.projectTopicLabel.text = publicModel.project_name;
    self.nickName.text = publicModel.nickname;
    self.targetMoneyLabel.text =[NSString stringWithFormat:@"%@元",publicModel.targe_money];
    self.gotMoneyLabel.text =[NSString stringWithFormat:@"%@元",publicModel.ready_money];
    self.helpCountLabel.text = [NSString stringWithFormat:@"%@次",publicModel.help_count];;
    
    self.percentProgress.progress = [publicModel.ready_money floatValue]/[publicModel.targe_money floatValue];
    self.percentProgress.trackTintColor = UIColorFromRGBA(233, 233, 233, 1);
    self.percentProgress.progressTintColor = UIColorFromRGBA(202,44, 51, 1);
    self.percentLabel.text = [NSString stringWithFormat:@"%0.2f％",[publicModel.ready_money floatValue]/[publicModel.targe_money floatValue]*100 ];
    self.detailLabel.text = publicModel.project_detail;
    
    CGRect detailRect = [self rectSizeWithString:self.detailLabel.text andFont:[UIFont systemFontOfSize:15]];
    self.detailLabelConstraint.constant = detailRect.size.height+10;
    
    //图片集
    long  row = publicModel.imgArray.count/3;
    if (publicModel.imgArray.count%3 != 0){
        row +=1;
    }
    for (int i=0; i<publicModel.imgArray.count; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(20+(SCREEN_WIDTH-40)/3*(i%3), detailRect.size.height+10+50+10 + i/3*(SCREEN_WIDTH-40)/3, (SCREEN_WIDTH-40)/3, (SCREEN_WIDTH-40)/3)];
        
        [image sd_setImageWithURL:[NSURL URLWithString:publicModel.imgArray[i][@"img_url"]]];
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.clipsToBounds = YES;
        image.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImages:)];
        [image addGestureRecognizer:tap];
        image.tag = 10+i;
        [self.detailView addSubview:image];
        
    }

    self.detailViewConstraint.constant = detailRect.size.height+50+10+row*(SCREEN_WIDTH-40)/3+10+10;
    
    
    self.patientNameLabel.text = [NSString stringWithFormat:@"患者:%@",publicModel.patient_name];
    self.payeeNameLabel.text = [NSString stringWithFormat:@"收款人:%@",publicModel.payee_name];
    self.sickNameLabel.text =[NSString stringWithFormat:@"所患疾病:%@",publicModel.sick_name];
    self.hospitalNameLabel.text =[NSString stringWithFormat:@"诊断证明已审核  诊断医院:%@",publicModel.hospital_name];
    //设置发起人承诺书的NSLayoutConstraint
    CGRect promiseHeight = [self rectSizeWithString:self.promiseLabel.text andFont:[UIFont systemFontOfSize:15]];
    
    NSLayoutConstraint *promiseOneConstraint = [NSLayoutConstraint constraintWithItem:self.promiseLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:promiseHeight.size.height];
    [self.promiseLabel addConstraint:promiseOneConstraint];

    NSLayoutConstraint *promiseTwoConstraint = [NSLayoutConstraint constraintWithItem:self.promiseView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:promiseHeight.size.height+60];
    
    
    [self.promiseView addConstraint:promiseTwoConstraint];
    
    //证实人
    [self.proveBtn setTitleColor:UIColorFromRGBA(202, 44, 51, 1) forState:UIControlStateNormal];
    self.countLabel.attributedText =[hudCustom convertNumColor:[NSString stringWithFormat:@"有%@人证实",publicModel.proveCountNum] withFontSize:15];
    self.firstProveStringLabel.text = publicModel.fisrtProveString;
    NSLayoutConstraint *imageProveOneConstraint = [NSLayoutConstraint constraintWithItem:self.imageBgView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:(SCREEN_WIDTH-40-90)/10+20];
    [self.imageBgView addConstraint:imageProveOneConstraint];
    
    NSLayoutConstraint *proveConstraint = [NSLayoutConstraint constraintWithItem:self.proveView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:40+(SCREEN_WIDTH-40-90)/10+20+10+20];
    [self.proveView addConstraint:proveConstraint];   
    
    for (int i = 0; i<publicModel.imageArray.count; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10*i+(SCREEN_WIDTH-40-90)/10*i, 10, (SCREEN_WIDTH-40-90)/10, (SCREEN_WIDTH-40-90)/10)];
        [image sd_setImageWithURL:[NSURL URLWithString:publicModel.imageArray[i][@"headimg_url"]]];
        image.layer.cornerRadius = (SCREEN_WIDTH-40-90)/10/2;
        image.layer.masksToBounds = YES;
        [self.imageBgView addSubview:image];
    
        NSLog(@"count %ld",publicModel.imageArray.count);
        
    }
    return 410+250+20+detailRect.size.height+20+row*(SCREEN_WIDTH-40)/3+10+promiseHeight.size.height+60+40+(SCREEN_WIDTH-40-90)/10+20+10+20+10+10;
    
}

-(CGRect)rectSizeWithString:(NSString *)string andFont:(UIFont *)font{
    
    return [string  boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
}
- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font {
    
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 10000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:10];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return height;
    
}
//计算时间相差

- (NSInteger)getDifferenceByDate:(NSString *)date {
    //获得当前时间
    NSDate *now = [NSDate date];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *oldDate = [dateFormatter dateFromString:date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:now  toDate:oldDate  options:0];
    return [comps day];
}
- (IBAction)proveDetailBtnPress:(UIButton *)sender {
    
    _showProveDetailBlock();
    
}
- (IBAction)proveBtnPress:(UIButton *)sender {
    NSLog(@"dddddd");
    _proveBtnBlock();
    
}
- (void)showImages:(UITapGestureRecognizer *)ges{
    _showPics(_model.imgArray,ges.view.tag-10,(UIImageView *)ges.view);
}

@end
