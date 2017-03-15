#import "AFHTTPClient+Synchronous.h"
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
#import <UIKit/UIKit.h>
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
#import <Cocoa/Cocoa.h>
#endif
#import "AFHTTPRequestOperation+ResponseObject.h"

NSString * const AFHTTPClientErrorDomain = @"com.alamofire.httpclient";
NSInteger const AFHTTPClientBackgroundTaskExpiredError = -1001;

@implementation AFHTTPClient (Synchronous)

- (id)synchronouslyPerformMethod:(NSString *)method
                            path:(NSString *)path
                      parameters:(NSDictionary *)parameters
                       operation:(AFHTTPRequestOperation *__autoreleasing *)operationPtr
                           error:(NSError *__autoreleasing *)outError
{
    NSURLRequest *request = [self requestWithMethod:method path:path parameters:parameters];
    AFHTTPRequestOperation *op = [self HTTPRequestOperationWithRequest:request success:nil failure:nil];

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
    // By registering the operation as a long-running background task, if the app enters
    // background, it is more likely to complete. However, it does not guarantee that the
    // method will return.
    //
    // When a background task is about to run out of time, the expiration handler is run
    // on the main queue.
    //
    // Using this feature while blocking the main thread causes a deadlock. Then the
    // operation never gets to call `endBackgroundTask:` and the system terminates the
    // app. Refer to the docs for
    // `-[AFURLConnectionOperation setShouldExecuteAsBackgroundTaskWithExpirationHandler:`
    // and `-[NSOperation beginBackgroundTaskWithExpirationHandler:]`

    if (![NSThread isMainThread]) {
        [op setShouldExecuteAsBackgroundTaskWithExpirationHandler:^(void) {
            if (outError) *outError =
                [NSError errorWithDomain:AFHTTPClientErrorDomain
                                    code:AFHTTPClientBackgroundTaskExpiredError
                                userInfo:@{ NSLocalizedDescriptionKey: @"Background operation time expired" }];
        }];
        // At this point this thread may wake up but probably isn't guaranteed to do so.
    }
#endif

    [op start];
    [op waitUntilFinished];

    if (operationPtr != nil) *operationPtr = op;
    if (outError != nil) *outError = [op error];
    return [op responseObject];
}

- (id)synchronouslyGetPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                 operation:(AFHTTPRequestOperation *__autoreleasing *)operationPtr
                     error:(NSError *__autoreleasing *)outError
{
    return [self synchronouslyPerformMethod:@"GET" path:path parameters:parameters operation:operationPtr error:outError];
}

- (id)synchronouslyPostPath:(NSString *)path
                 parameters:(NSDictionary *)parameters
                  operation:(AFHTTPRequestOperation *__autoreleasing *) operationPtr
                      error:(NSError *__autoreleasing *) outError
{
    return [self synchronouslyPerformMethod:@"POST" path:path parameters:parameters operation:operationPtr error:outError];
}

- (id)synchronouslyPutPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                 operation:(AFHTTPRequestOperation *__autoreleasing *) operationPtr
                     error:(NSError *__autoreleasing *) outError
{
    return [self synchronouslyPerformMethod:@"PUT" path:path parameters:parameters operation:operationPtr error:outError];
}

- (id)synchronouslyDeletePath:(NSString *)path
                   parameters:(NSDictionary *)parameters
                    operation:(AFHTTPRequestOperation *__autoreleasing *) operationPtr
                        error:(NSError *__autoreleasing *) outError
{
    return [self synchronouslyPerformMethod:@"DELETE" path:path parameters:parameters operation:operationPtr error:outError];
}

- (id)synchronouslyPatchPath:(NSString *)path
                  parameters:(NSDictionary *)parameters
                   operation:(AFHTTPRequestOperation *__autoreleasing *) operationPtr
                       error:(NSError *__autoreleasing *) outError
{
    return [self synchronouslyPerformMethod:@"PATCH" path:path parameters:parameters operation:operationPtr error:outError];
}

@end
