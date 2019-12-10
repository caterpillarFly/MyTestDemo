//
//  ZSHtmlToRichTextVC.m
//  MyTestDemo
//
//  Created by zhaosheng on 2019/9/16.
//  Copyright © 2019 zs. All rights reserved.
//

#import "ZSHtmlToRichTextVC.h"

@interface ZSHtmlToRichTextVC ()

@property (nonatomic) UILabel *richTextLabel;
@property (nonatomic) UIWebView *webView;

@property (nonatomic) UIButton *button;

@property (nonatomic, copy) NSString *html;

@end

@implementation ZSHtmlToRichTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *html = @"<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /></head><body style=\"margin:0;padding:0;line-height:21px;\"><div style=\"color:#3F3F3F;font-size:17px;\">订购彩铃包月</div><div style=\"color:#7E7E7E;font-size:14px;margin-top:15px\">您已开通视频彩铃基础会员，可享受部分视频彩铃免费更换及视频彩铃DIY无限量免费上传权益。</div><div style=\"color:#7E7E7E;font-size:14px;margin-top:10px;\">订购彩铃包月，可进一步获得：</div><div style=\"font-size:14px;line-height:21px;margin-top:5px;\"><li>全站视频彩铃免费更换</li><li>全站音频彩铃免费更换</li><li>音频彩铃DIY无限上传特权</li></div></body></html>";
    self.html = html;
    NSData *data = [html dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    
    self.richTextLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.richTextLabel];
    self.richTextLabel.numberOfLines = 0;
    self.richTextLabel.attributedText = attributeText;
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSString *tmpHtml = @"正确的追求犹如永远指向光明的<font color = 'red'>指南针</font>，帮助我们加大马力，驶向前方;正确的追求就像我们额上熏黑的矿灯，照亮我们前行的道路;正确的追求就是我们成功的入场卷，<font color = 'red'>越早的订票，就有越好座位</font>。都说我们是花样年华，充满生机和活力，那就赶快行动起来，找到自己人生的追求，共同打开成功的大门吧!";
    //[self.view addSubview:self.webView];
    //[self.webView loadHTMLString:tmpHtml baseURL:nil];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat height = CGRectGetHeight(self.view.bounds);
    self.button.frame = CGRectMake(100, height-80, 88, 44);
    self.button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.button];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)buttonClicked:(UIButton *)sender
{
    if (!self.webView.superview) {
        [self.view addSubview:self.webView];
        [self.webView loadHTMLString:self.html baseURL:nil];
    }
}

@end
