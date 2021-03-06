@import Foundation;

#import "BTErrors.h"

extern NSString *const BTClientTokenKeyAuthorizationFingerprint;
extern NSString *const BTClientTokenKeyClientApiURL;
extern NSString *const BTClientTokenKeyAnalytics;
extern NSString *const BTClientTokenKeyURL;
extern NSString *const BTClientTokenKeyMerchantId;

@interface BTClientToken : NSObject <NSCoding, NSCopying>

@property (nonatomic, readonly, copy) NSString *authorizationFingerprint;
@property (nonatomic, readonly, copy) NSString *merchantId;
@property (nonatomic, readonly, strong) NSURL *clientApiURL;
@property (nonatomic, readonly, strong) NSSet *challenges;
@property (nonatomic, readonly, strong) NSSet *paymentAppSchemes;
@property (nonatomic, readonly, assign, getter = isAnalyticsEnabled) BOOL analyticsEnabled;
@property (nonatomic, readonly, strong) NSURL *analyticsURL;

// Configuration attributes parsed from the client token (equivalent to [JWT claims](http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html)).
@property (nonatomic, readonly, strong) NSDictionary *claims;

// Initialize a client token with JSON generated by a server-side client library.
// This is the designated initializer
- (instancetype)initWithClientTokenString:(NSString *)JSONString error:(NSError **)error;

// Initialize a client token with a dictionary of claims parsed from the client token string.
- (instancetype)initWithClaims:(NSDictionary *)claims
                         error:(NSError * __autoreleasing *)error;

@end
