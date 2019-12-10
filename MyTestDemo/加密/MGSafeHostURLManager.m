//
//  MGSafeHostURLManager.m
//  MGMobileMusic
//
//  Created by zhaosheng on 2018/10/10.
//  Copyright © 2018年 migu. All rights reserved.
//

#import "MGSafeHostURLManager.h"
#import "MGDesEncrypt.h"
#import "NSString+YPKit.h"

static NSString *const MG_DES_KEY = @"jbXGHTytBAxFqleSbJ";

@interface MGSafeHostURLManager ()

@property (nonatomic, copy) NSArray *keys;
@property (nonatomic) NSMutableDictionary *urlsDic;
@property (nonatomic) NSMutableDictionary *encryptDic;

@end

@implementation MGSafeHostURLManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    MGSafeHostURLManager *manager;
//    dispatch_once(&onceToken, ^{
//        manager = [[MGSafeHostURLManager alloc] init];
//    });

    manager = [[MGSafeHostURLManager alloc] init];
    
    [manager encryptUrl];
    NSLog(@"%@", manager.urlsDic);
    
    for (int i = 0; i < [manager.keys count]; ++i) {
        NSString *key = manager.keys[i];
        NSString *obj = manager.urlsDic[key];
        
        NSLog(@"@\"%@\": @\"%@\",", key, obj);
    }
    
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.urlsDic = [@{@"kContentServerHost_D" : @"http://218.200.227.207:18089/",
                          @"kH5ServerHost_D" : @"http://218.200.227.207:8080/",
                          
                          @"kContentServerHost_S" : @"http://app.c.nf.migu.cn/",
                          @"kProductServerHost_S" : @"http://app.pd.nf.migu.cn/",
                          @"kUserServerHost_S" : @"http://app.u.nf.migu.cn/",
                          @"kBarrageServerHost_S" : @"http://app.b.nf.migu.cn/",
                          @"kResourceServerHost_S" : @"http://app.d.nf.migu.cn/",
                          @"kH5ServerHost_S" : @"http://218.200.227.207:8080/",
                          
                          @"kContentServerHost_F" : @"http://218.200.229.178/",
                          @"kH5ServerHost_F" : @"http://218.200.227.207:8080/",
                          
                          @"kContentServerHost_R": @"http://app.c.nf.migu.cn/",
                          @"kProductServerHost_R": @"https://app.pd.nf.migu.cn/",
                          @"kUserServerHost_R" : @"http://app.u.nf.migu.cn/",
                          @"kBarrageServerHost_R" : @"http://app.b.nf.migu.cn/",
                          @"kResourceServerHost_R" : @"http://app.d.nf.migu.cn/",
                          @"kH5ServerHost_R" : @"http://218.200.227.207:8080/",
                          
                          @"kH5NfMiguCN" : @"http://h5.nf.migu.cn/",
                          @"kAMllMiguCN" : @"http://a.mll.migu.cn/",
                          @"MGHTML5DebugNet": @"http://218.205.244.254",
                          @"MGGetWeiCodeDao": @"http://www.cmpassport.com/",
                          @"SINAWEIBO_REDIRECT_URI": @"http://music.10086.cn",
                          @"SINAWEIBO_REVOKEOAUTH_URL": @"https://api.weibo.com/2/",
                          @"kM10086CN": @"http://m.10086.cn/",
                          @"kDmusicappMiguCNs": @"https://d.musicapp.migu.cn/",
                          @"kDmusicappMiguCN" : @"http://d.musicapp.migu.cn/",
                          @"kKfMiguCN" : @"http://kf.migu.cn/",
                          @"kPdMusicappMiguCN" : @"http://pd.musicapp.migu.cn/",
                          @"kMigumusicMikecrmCom": @"http://migumusic.mikecrm.com/",
                          @"MGHeaderImageGif": @"http://tvax2.sinaimg.cn/default/images/default_avatar_male_180.gif",
                          @"kZaZhiMiguCN": @"http://zazhi.migu.cn"
                          } mutableCopy];
        //self.encryptDic = [NSMutableDictionary dictionary];
        
        NSArray *keys = @[@"kContentServerHost_D",
                          @"kH5ServerHost_D",
                          @"kContentServerHost_S",
                          @"kProductServerHost_S",
                          @"kUserServerHost_S",
                          @"kBarrageServerHost_S",
                          @"kResourceServerHost_S",
                          @"kH5ServerHost_S",
                          @"kContentServerHost_F",
                          @"kH5ServerHost_F",
                          @"kContentServerHost_R",
                          @"kProductServerHost_R",
                          @"kUserServerHost_R",
                          @"kBarrageServerHost_R",
                          @"kResourceServerHost_R",
                          @"kH5NfMiguCN",
                          @"kAMllMiguCN",
                          @"MGHTML5DebugNet",
                          @"MGGetWeiCodeDao",
                          @"SINAWEIBO_REDIRECT_URI",
                          @"SINAWEIBO_REVOKEOAUTH_URL",
                          @"kM10086CN",
                          @"kDmusicappMiguCNs",
                          @"kDmusicappMiguCN",
                          @"kKfMiguCN",
                          @"kPdMusicappMiguCN",
                          @"kMigumusicMikecrmCom",
                          @"MGHeaderImageGif",
                          @"kZaZhiMiguCN"];
        self.keys = keys;
    }
    return self;
}

- (void)decryptUrl
{
    [self.urlsDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
        //obj = [MGDesEncrypt decryptUseDES:obj key:MG_DES_KEY];
        obj = [NSString stringWithBase64EncodedString:obj];
        self.urlsDic[key] = obj;
    }];
}

- (void)encryptUrl
{
    [self.urlsDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
        //obj = [MGDesEncrypt encryptUseDES:obj key:MG_DES_KEY];
        obj = [obj base64EncodedString];
        //NSLog(@"encrypt_%@:%@", key, obj);
        self.urlsDic[key] = obj;
        self.encryptDic[key] = obj;
    }];
}

@end
