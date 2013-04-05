// AFHTTPClient+Synchronous.m
//
// Copyright (c) 2013 Paul Melnikow
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFHTTPClient+Synchronous.h"
#import "AFHTTPRequestOperation.h"

NSString * const AFHTTPClientErrorDomain = @"com.alamofire.httpclient";
NSInteger const AFHTTPClientBackgroundTaskExpiredError = -1001;

@implementation AFHTTPClient (Synchronous)

+ (dispatch_queue_t)sharedCallbackQueue {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.alamofire.networking.httpclient_synchronous.callbacks", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return queue;
}

- (id)synchronouslyPerformMethod:(NSString *)method
                            path:(NSString *)path
                      parameters:(NSDictionary *)parameters
                       operation:(AFHTTPRequestOperation *__autoreleasing *)operationPtr
                           error:(NSError *__autoreleasing *)outError
{
    __block id result = nil;
    
    dispatch_group_t group = dispatch_group_create();
    
    NSURLRequest *request = [self requestWithMethod:method path:path parameters:parameters];
    AFHTTPRequestOperation *op = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operationPtr) *operationPtr = operation;
        result = responseObject;
        dispatch_group_leave(group);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (operationPtr) *operationPtr = operation;
        if (outError) *outError = error;
        dispatch_group_leave(group);
    }];
    
    // Since the caller will wait until the callbacks finish executing, we need to deliver
    // these callbacks on a queue which is not the caller's.
    op.successCallbackQueue = op.failureCallbackQueue = [self.class sharedCallbackQueue];
    
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
            dispatch_group_leave(group);
        }];
        // At this point this thread may wake up but probably isn't guaranteed to do so.
    }
#endif
    
    dispatch_group_enter(group);
    [op start];
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
#if !OS_OBJECT_USE_OBJC
    dispatch_release(group);
#endif
    return result;
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
