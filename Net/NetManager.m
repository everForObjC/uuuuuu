//
//  NetManager.m
//  CarPay
//
//  Created by qianfeng on 16/7/27.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "NetManager.h"

@interface NetManager ()

@property (nonatomic,strong) AFHTTPSessionManager * sessionManager;

@end


@implementation NetManager

+ (instancetype)shareManager{
    static NetManager * netManager = nil;
    if (netManager == nil) {
        netManager = [[NetManager alloc]init];
        netManager.sessionManager = [AFHTTPSessionManager manager];
        netManager.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        netManager.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
    }
    return netManager;
}

- (void)requestGetUrl:(NSString *)url WithSuccessBlock:(SuccessBlock)successB andFailedBlock:(FailedBlock)failB{
    
}

- (void)requestGetUrl:(NSString *)url WithSuccessBlock:(SuccessBlock)successB andFailedBlock:(FailedBlock)failB andShowLoding:(BOOL)loading{
    
    //    UIView * action = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //    [self.view addSubview:action];
    //    [action showActivityIndicator:YES];
    
    [self.sessionManager GET:url parameters:nil progress: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successB([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failB(error);
    }];
    
}

- (void)requestPostUrl:(NSString*)url WithDict:(NSDictionary *)dic WithSuccessBlock:(SuccessBlock)successB andFailedBlock:(FailedBlock)failB andShowLoding:(BOOL)loading{
    
    //    UIView * action = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //    [self.view addSubview:action];
    //    [action showActivityIndicator:YES];
    
    [self.sessionManager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //\u8bf7\u6c42\u65b9\u6cd5\u53c2\u6570\u9519\u8bef
        successB([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failB(error);
    }];
    
}

@end
