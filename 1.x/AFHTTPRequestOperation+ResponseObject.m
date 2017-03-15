#import "AFHTTPRequestOperation+ResponseObject.h"
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
#import <UIKit/UIKit.h>
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
#import <Cocoa/Cocoa.h>
#endif

@implementation AFHTTPRequestOperation (ResponseObject)

- (id) responseObject { return [self responseData]; }

@end

@implementation AFJSONRequestOperation (ResponseObject)

- (id) responseObject { return [self responseJSON]; }

@end

@implementation AFXMLRequestOperation (ResponseObject)

- (NSXMLParser *) responseObject { return [self responseXMLParser]; }

@end

@implementation AFImageRequestOperation (ResponseObject)

- (id) responseObject { return [self responseImage]; }

@end
