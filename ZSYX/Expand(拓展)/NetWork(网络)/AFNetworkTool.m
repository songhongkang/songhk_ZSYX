//
//  AFNetworkTool.m
//  AFNetText2.5
//
//  Created by wxxu on 15/1/27.
//  Copyright (c) 2015年 wxxu. All rights reserved.
//

#import "AFNetworkTool.h"

@implementation AFNetworkTool

#pragma mark 检测网路状态
+ (void)netWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld", (long)status);
    }];
}

#pragma mark - JSON方式post提交数据
+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail
{
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    [manager setSecurityPolicy:[self customSecurityPolicy]];

    [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        
        NSLog(@"成功");

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail();
        
        NSLog(@"失败");
        
    }];
}


#pragma mark - JSON方式post提交数据
+ (void)getJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail();
    }];
}


#pragma mark - 文件上传 自己定义文件名
+ (void)postUploadWithUrl:(NSString *)urlStr fileDataArr:(NSArray *)fileDataArr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    // 本地上传给服务器时,没有确定的URL,不好用MD5的方式处理
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //@"http://localhost/demo/upload.php"
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        //        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
//        
//        // 要上传保存在服务器中的名称
//        // 使用时间来作为文件名 2014-04-30 14:20:57.png
//        // 让不同的用户信息,保存在不同目录中
//        //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        //        // 设置日期格式
//        //        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//        //        NSString *fileName = [formatter stringFromDate:[NSDate date]];
//        if (fileDataArr.count > 0) {
//            for (NSInteger i = 0; i < fileDataArr.count; i ++) {
//                NSData *data = UIImagePNGRepresentation(fileDataArr[i]);
//                [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"iosPic%ld.png",(long)i] mimeType:@"image/png"];
//            }
//        }
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//        if (fail) {
//            fail();
//        }
//    }];
    
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
        // 要上传保存在服务器中的名称
        // 使用时间来作为文件名 2014-04-30 14:20:57.png
        // 让不同的用户信息,保存在不同目录中
        //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //        // 设置日期格式
        //        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        //        NSString *fileName = [formatter stringFromDate:[NSDate date]];
        if (fileDataArr.count > 0) {
            for (NSInteger i = 0; i < fileDataArr.count; i ++) {
                NSData *data = UIImagePNGRepresentation(fileDataArr[i]);
                [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"iosPic%ld.png",(long)i] mimeType:@"image/png"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (fail) {
            fail();
        }
    }];
}


//[[manager POST:stringUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//    
//    [formData appendPartWithFileData:imageData name:@"key1" fileName:@"key1.png" mimeType:@"image/png"];
//    
//} progress:^(NSProgress * _Nonnull uploadProgress) {
//    
//} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//    
//    NSDictionary *dic = [[NSDictionary alloc]initWithDictionary:responseObject];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    
//    if ([[dic valueForKey:@"code"] integerValue] == 1) {
//        
//        NSArray *pathArray = [[dic valueForKey:@"result"] valueForKey:@"successFiles"];
//        NSString *path = [pathArray[0] valueForKey:@"url"];
//        [self uploadHeadImgWithPath:path];
//        
//    }else {
//        [MBProgressHUD showError:[dic valueForKey:@"msg"]];
//    }
//    
//} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    [MBProgressHUD showError:@"上传头像失败"];
//    
//}] resume];


+ (AFSecurityPolicy*)customSecurityPolicy {
//    // /先导入证书
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"jianzhijia_Https" ofType:@"cer"];//证书的路径
//    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//    
//    // AFSSLPinningModeCertificate 使用证书验证模式
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    
//    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
//    // 如果是需要验证自建证书，需要设置为YES
//    securityPolicy.allowInvalidCertificates = YES;
//    
//    //validatesDomainName 是否需要验证域名，默认为YES；
//    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
//    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
//    //如置为NO，建议自己添加对应域名的校验逻辑。
//    securityPolicy.validatesDomainName = YES;
//    
//    NSLog(@"%@", certData);
//    securityPolicy.pinnedCertificates = @[certData];
//    
//    return securityPolicy;
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"jianzhijian_zhongji" ofType:@"cer"];
    
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    securityPolicy.allowInvalidCertificates = YES;
    
    securityPolicy.validatesDomainName = NO;
    
    //    NSLog(@"%@", certData);
    securityPolicy.pinnedCertificates = @[certData];
    
    return securityPolicy;
    
}
@end
