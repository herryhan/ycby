//
//  project_basicViewModel.h
//  一筹百应
//
//  Created by 韩先伟 on 2017/10/21.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModelClass.h"

@interface project_basicViewModel  : ViewModelClass

-(void)fetchBasicInfo:(NSString *)pro_id andToken:(NSString *)token;


@end
