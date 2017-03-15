#import "AFHTTPSessionManager+Synchronous.h"

@interface AFHTTPSessionManager (Private)
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end

@implementation AFHTTPSessionManager (Synchronous)

- (id)synchronouslyPerformMethod:(NSString *)method
                       URLString:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                            task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
                           error:(NSError *__autoreleasing *)outError {
    
    // Prevent the most common deadlock. When this method is invoked from the main
    // thread, and the session manager's completion queue is the main queue, the
    // semaphore will not be released. This method will never return.
    //
    // You really should not perform a synchronous network request on the main
    // thread on iOS, as it's likely to cause a crash when run outside the debugger.
    // You probably should not on OS X either, as it's likely to cause lags in the
    // UI.
    //
    // If you must dispatch from the main queue, create a new queue for the
    // completion handler:
    //
    // manager.completionQueue = dispatch_queue_create("AFNetworking+Synchronous", NULL);
    //
    if ([NSThread isMainThread]) {
        if (self.completionQueue == nil || self.completionQueue == dispatch_get_main_queue()) {
            @throw
            [NSException exceptionWithName:NSInvalidArgumentException
                                    reason:@"Can't make a synchronous request on the same queue as the completion handler"
                                  userInfo:nil];
        }
    }

    __block id responseObject = nil;
    __block NSError *error = nil;
    
    // Thanks @tewha for this suggestion.
    // https://github.com/AFNetworking/AFNetworking/issues/1804#issuecomment-100396741
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURLSessionDataTask *task =
    [self dataTaskWithHTTPMethod:method
                       URLString:URLString
                      parameters:parameters
                  uploadProgress:nil
                downloadProgress:nil
                         success:
     ^(NSURLSessionDataTask *unusedTask, id resp) {
         responseObject = resp;
         dispatch_semaphore_signal(semaphore);
     }
                         failure:
     ^(NSURLSessionDataTask *unusedTask, NSError *err) {
         error = err;
         dispatch_semaphore_signal(semaphore);
     }];
    
    [task resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    if (taskPtr != nil) *taskPtr = task;
    if (outError != nil) *outError = error;

    return responseObject;
}

- (id)syncGET:(NSString *)URLString
   parameters:(NSDictionary *)parameters
         task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
        error:(NSError *__autoreleasing *)outError
{
    return [self synchronouslyPerformMethod:@"GET"
                                  URLString:URLString
                                 parameters:parameters
                                       task:taskPtr
                                      error:outError];
}

- (id)syncPOST:(NSString *)URLString
    parameters:(NSDictionary *)parameters
          task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
         error:(NSError *__autoreleasing *) outError
{
    return [self synchronouslyPerformMethod:@"POST"
                                  URLString:URLString
                                 parameters:parameters
                                       task:taskPtr
                                      error:outError];
}

- (id)syncPUT:(NSString *)URLString
   parameters:(NSDictionary *)parameters
         task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
        error:(NSError *__autoreleasing *) outError
{
    return [self synchronouslyPerformMethod:@"PUT"
                                  URLString:URLString
                                 parameters:parameters
                                       task:taskPtr
                                      error:outError];
}

- (id)syncDELETE:(NSString *)URLString
      parameters:(NSDictionary *)parameters
            task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
           error:(NSError *__autoreleasing *) outError
{
    return [self synchronouslyPerformMethod:@"DELETE"
                                  URLString:URLString
                                 parameters:parameters
                                       task:taskPtr
                                      error:outError];
}

- (id)syncPATCH:(NSString *)URLString
     parameters:(NSDictionary *)parameters
           task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
          error:(NSError *__autoreleasing *) outError
{
    return [self synchronouslyPerformMethod:@"PATCH"
                                  URLString:URLString
                                 parameters:parameters
                                       task:taskPtr
                                      error:outError];
}

@end
