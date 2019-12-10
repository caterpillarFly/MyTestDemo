//Des对称加密算法

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface MGDesEncrypt : NSObject

+ (NSString *)encryptUseDES:(NSString *)clearText key:(NSString *)key;
+ (NSString *)decryptUseDES:(NSString *)plainText key:(NSString *)key;

@end
