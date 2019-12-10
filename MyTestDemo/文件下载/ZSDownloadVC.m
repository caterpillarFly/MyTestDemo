//
//  ZSDownloadVC.m
//  MyTestDemo
//
//  Created by zhaosheng on 2018/11/1.
//  Copyright © 2018 zs. All rights reserved.
//

#import "ZSDownloadVC.h"
#import "AFURLSessionManager.h"
#import "ZSFileUploadDAO.h"

@interface ZSDownloadVC ()

@property (nonatomic) UIView *progressView;

@end

@implementation ZSDownloadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self)
    [self addMenu:@"文件下载" callback:^(id sender, id data) {
        @strongify(self)
        [self startDownload];
    }];
    
    [self addMenu:@"文件上传" callback:^(id sender, id data) {
        @strongify(self)
        [self uploadFile];
    }];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.progressView];
}

- (UIButton *)downloadButton
{
    UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    downloadButton.frame = CGRectMake(50, 120, 100, 44);
    downloadButton.backgroundColor = [UIColor blueColor];
    [downloadButton setTitle:@"下载" forState:UIControlStateNormal];
    [downloadButton addTarget:self action:@selector(startDownload) forControlEvents:UIControlEventTouchUpInside];
    
    return downloadButton;
}

- (UIView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, 0, 2)];
        _progressView.backgroundColor = [UIColor redColor];
    }
    return _progressView;
}

- (void)uploadFile
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"任务集导入测试"ofType:@"csv"];
        
    ZSFileUploadDAO *dao = [[ZSFileUploadDAO alloc] init];
    HNetworkMultiDataObj *file = [[HNetworkMultiDataObj alloc] init];
    file.filePath = filePath;
    file.fileName = @"任务集导入测试.csv";
    file.mimeType = @"text/plain";
    dao.file = file;
    dao.taskSetId = 182;
    
    [dao start:^(id sender, id data, NSError *error) {
        if (error) {
            NSLog(@"error:%@", error.localizedDescription);
        }
    }];
}

- (void)startDownload
{
    /* 创建网络下载对象 */
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSString *urlString = @"http://120.77.202.153/TaskOverServer/api/web/index.php?r=reference/download-file&fileName=挡土墙工程防护罗潇18-3320180930111317.csv";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    /* 下载地址 */
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    /* 下载路径 */
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [path stringByAppendingPathComponent:@"挡土墙工程防护罗潇18-3320180930111317.csv"];
    
    /* 开始请求下载 */
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"下载进度：%.0f％", downloadProgress.fractionCompleted * 100);
        [self updateDownloadProgress:downloadProgress.fractionCompleted];
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        /* 设定下载到的位置 */
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSLog(@"下载完成");

    }];
    
    [downloadTask resume];
}

- (void)updateDownloadProgress:(CGFloat)progress
{
    if ([NSThread isMainThread]) {
        CGRect frame = self.progressView.frame;
        frame.size.width = self.view.frame.size.width * progress;
        
        self.progressView.frame = frame;
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateDownloadProgress:progress];
        });
    }
}


@end
