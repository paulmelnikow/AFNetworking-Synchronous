#import <AFNetworking/AFHTTPSessionManager.h>

/**
 A minimal category which extends AFHTTPSessionManager to support
 synchronous requests.

 **This category is for AFNetworking 3.x.**
*/
@interface AFHTTPSessionManager (Synchronous)

/**
 Creates and runs an NSURLSessionDataTask with a GET request.

 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client
   request serializer.
 @param taskPtr The address at which a pointer to the NSURLSessionDataTask is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The response object created by the client response serializer.
 */
- (id)syncGET:(NSString *)URLString
   parameters:(NSDictionary *)parameters
         task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
        error:(NSError *__autoreleasing *)outError;

/**
 Creates and runs an NSURLSessionDataTask with a POST request.

 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client
    request serializer.
 @param taskPtr The address at which a pointer to the NSURLSessionDataTask is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The response object created by the client response serializer.
 */
- (id)syncPOST:(NSString *)URLString
    parameters:(NSDictionary *)parameters
          task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
         error:(NSError *__autoreleasing *) outError;

/**
 Creates and runs an NSURLSessionDataTask with a PUT request.

 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client
    request serializer.
 @param taskPtr The address at which a pointer to the NSURLSessionDataTask is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The response object created by the client response serializer.
 */
- (id)syncPUT:(NSString *)URLString
   parameters:(NSDictionary *)parameters
         task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
        error:(NSError *__autoreleasing *) outError;
/**
 Creates and runs an NSURLSessionDataTask with a DELETE request.

 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client
    request serializer.
 @param taskPtr The address at which a pointer to the NSURLSessionDataTask is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The response object created by the client response serializer.
 */
- (id)syncDELETE:(NSString *)URLString
      parameters:(NSDictionary *)parameters
            task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
           error:(NSError *__autoreleasing *) outError;

/**
 Creates and runs an NSURLSessionDataTask with a PATCH request.

 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client
    request serializer.
 @param taskPtr The address at which a pointer to the NSURLSessionDataTask is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The response object created by the client response serializer.
 */
- (id)syncPATCH:(NSString *)URLString
     parameters:(NSDictionary *)parameters
           task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
          error:(NSError *__autoreleasing *) outError;

/**
 Enqueue an NSURLSessionDataTask with a request for the given HTTP method.

 @param method The HTTP method.
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded and set in the request HTTP body.
 @param taskPtr The address at which a pointer to the NSURLSessionDataTask is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The object created from the response data of the request.
 */
- (id)synchronouslyPerformMethod:(NSString *)method
                       URLString:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                            task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
                           error:(NSError *__autoreleasing *)outError;

@end
