//
//  NetManager.h
//  CarPay
//
//  Created by qianfeng on 16/7/27.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

typedef void (^SuccessBlock) (id data);
typedef void (^FailedBlock) (NSError *error);

@interface NetManager : UIViewController

+(instancetype)shareManager;

- (void)requestGetUrl:(NSString*)url WithSuccessBlock:(SuccessBlock)successB andFailedBlock:(FailedBlock)failB;

- (void)requestGetUrl:(NSString*)url WithSuccessBlock:(SuccessBlock)successB andFailedBlock:(FailedBlock)failB andShowLoding:(BOOL)loading;

- (void)requestPostUrl:(NSString*)url WithDict:(NSDictionary *)dic WithSuccessBlock:(SuccessBlock)successB andFailedBlock:(FailedBlock)failB andShowLoding:(BOOL)loading;
@end
