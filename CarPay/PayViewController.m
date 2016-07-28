//
//  PayViewController.m
//  CarPay
//
//  Created by qianfeng on 16/7/27.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "PayViewController.h"

#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"

#define PARTNER    @"2088611922925773"
#define SELLER     @"esok@esok.cn"

#define PRIVATEKEY  @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBANfEOGuHDyStqzetu37gO0Lxy9ucCVpT3t7oao/oYHyeQIhI4sxu7dnTbSdsR3DKglHg+9sNbIvubxxeLPvfjrF/Lvky0sYIGBRYyQXQb+kwOq0dwqHGvqN4FP1EwI69CfQP/a2J/z4D0stF/htv4B24dxag7mxZIKLJJvwstUbnAgMBAAECgYEAtVsDhTXPP6gNqs4HM3xrszgjfiIoJlkqkjfOIclTGEu3uBVzNBvlJdq0+5bicWZ1pTay2ors+qzdjX2G1+ovN2x9ZIZyVDL0P1CqgzwEu7hCIC5I/hlcMIux+h0U93stRxeimdCcbj2hCfzewE77hP4GQ6F4llzgDtvm9X41CYkCQQDy+63bcv7huWydUOuN7ObhOTAjoAe5SxJL89UkFkMGwJYqUm2cRNAkaJ3OPBBBXEeDpBjh323L6g0pUnM6q32lAkEA41NJY+GAXVUAWnAKNJHfXEi3XopnStsPRRL6gRCqTcceWEicq6CtyHEIxJuldiG0AP2u+Fh5faWx4phXKFEkmwJAFdGt2f/ojWJ2M2Y50MPOM7lL7lcHeocYPIPHxvbMzAVtNp2yRA8V1b8jNIrGNuhPb63DojzLAj2hMu25dTJDFQJAFi24CVCk73YtlKU9uadJvX0ytryWG02IDdsuKY1wsCnvIfnjnzMMAXRVwKjW2dGr+DTH717ia4nQ8ySdzEcuZQJAf1aGvpNuRP9Sf043ymPbhBVEb2bji6ltOr9R1VpCuaojP/EAYEAanzHLvcG+kc0QAk57+7hWp3smNQu+aYt1oQ=="

@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getHttpData];
}

- (void)getHttpData{

    
    Order *order = [[Order alloc] init];
    order.partner = PARTNER;
    order.sellerID = SELLER;
    order.outTradeNO = @"8888425692345234";
    order.subject = @"测试商品";
    order.body = @"商品描述";
    order.totalFee = @"0.01";
    order.notifyURL = @"http://www.baidu.com";
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    
    
    NSString *appScheme = @"alipaydemosh";
    NSString *orderSpec = [order description];
    
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(PRIVATEKEY);
    NSString *signedString = [signer signString:orderSpec];
    
    NSString* orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderSpec, signedString, @"RSA"];
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"%@",resultDic);
    }];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
