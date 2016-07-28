//
//  ViewController.m
//  CarPay
//
//  Created by qianfeng on 16/7/27.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "ViewController.h"
#import "NetManager.h"
#import "PayViewController.h"

#define SUBMIT_FORM @"method=order_submit&session_id=%@"
#define API_SERVER @"http://10.11.62.27/mcmp1605/data_enter.php?"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [btn setTitle:@"支付" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tapWithButtn2) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:btn];
    
}

- (void)tapWithButtn2{
    

    NSString * session_id = @"96293c885e0b7aadeef8e979d59124b8";
    
    NSDictionary * dic = @{@"address_id": @"9228",@"goods_ids":@"4725",@"goods_will_buy_num":@"1",@"messages":@"1234123",@"pay_method":@"1",@"suppliers":@"49",@"spec_ids":@"-1",@"from_cart":@"0",@"bonus":@"-1",@"doorToDoor":@"0",@"station_id":@"0"};
    
    NSString * str = [NSString stringWithFormat:@"%@%@",API_SERVER,SUBMIT_FORM];
    NSString * urlStr = [NSString stringWithFormat:str,session_id];
    
    [[NetManager shareManager] requestPostUrl:urlStr WithDict:dic WithSuccessBlock:^(id data) {
        NSLog(@"%@",data);
        PayViewController * vc = [[PayViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
    } andFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } andShowLoding:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
