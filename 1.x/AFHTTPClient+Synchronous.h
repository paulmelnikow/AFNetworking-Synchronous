#import "AFHTTPClient.h"

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
FOUNDATION_EXPORT NSString * const AFHTTPClientErrorDomain;
FOUNDATION_EXPORT NSInteger const AFHTTPClientBackgroundTaskExpiredError;
#endif

/**
 A minimal category which extends AFHTTPClient to support synchronous requests.

 Custom subclasses of `AFHTTPRequestOperation` must override `-responseObject`.

 If a custom subclass does asynchronous processing in its completion blocks, you
 may need to use the using-completion-blocks branch.
*/
@interface AFHTTPClient (Synchronous)

/**
 Enqueue an `AFHTTPRequestOperation` with a `GET` request.

 @param path The path to be appended to the HTTP client's base URL and used as the
    request URL.
 @param parameters The parameters to be encoded and appended as the query string for
    the request URL.
 @param operationPtr The address at which a pointer to the
    `AFHTTPRequestOperation` is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The object created from the response data of the request.
 */
- (id)synchronouslyGetPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                 operation:(AFHTTPRequestOperation *__autoreleasing *)operationPtr
                     error:(NSError *__autoreleasing *)outError;

/**
 Enqueue an `AFHTTPRequestOperation` with a `POST` request.

 @param path The path to be appended to the HTTP client's base URL and used as the
    request URL.
 @param parameters The parameters to be encoded and set in the request HTTP body.
 @param operationPtr The address at which a pointer to the
    `AFHTTPRequestOperation` is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The object created from the response data of the request.
 */
- (id)synchronouslyPostPath:(NSString *)path
                 parameters:(NSDictionary *)parameters
                  operation:(AFHTTPRequestOperation *__autoreleasing *)operationPtr
                      error:(NSError *__autoreleasing *)outError;

/**
 Enqueue an `AFHTTPRequestOperation` with a `PUT` request.

 @param path The path to be appended to the HTTP client's base URL and used as the
    request URL.
 @param parameters The parameters to be encoded and set in the request HTTP body.
 @param operationPtr The address at which a pointer to the
    `AFHTTPRequestOperation` is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The object created from the response data of the request.
 */
- (id)synchronouslyPutPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                 operation:(AFHTTPRequestOperation *__autoreleasing *)operationPtr
                     error:(NSError *__autoreleasing *)outError;

/**
 Enqueue an `AFHTTPRequestOperation` with a `DELETE` request.

 @param path The path to be appended to the HTTP client's base URL and used as the
    request URL.
 @param parameters The parameters to be encoded and appended as the query string for
    the request URL.
 @param operationPtr The address at which a pointer to the
    `AFHTTPRequestOperation` is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The object created from the response data of the request.
 */
- (id)synchronouslyDeletePath:(NSString *)path
                   parameters:(NSDictionary *)parameters
                    operation:(AFHTTPRequestOperation *__autoreleasing *)operationPtr
                        error:(NSError *__autoreleasing *)outError;

/**
 Enqueue an `AFHTTPRequestOperation` with a `PATCH` request.

 @param path The path to be appended to the HTTP client's base URL and used as the
    request URL.
 @param parameters The parameters to be encoded and set in the request HTTP body.
 @param operationPtr The address at which a pointer to the
    `AFHTTPRequestOperation` is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The object created from the response data of the request.
 */
- (id)synchronouslyPatchPath:(NSString *)path
                  parameters:(NSDictionary *)parameters
                   operation:(AFHTTPRequestOperation *__autoreleasing *)operationPtr
                       error:(NSError *__autoreleasing *)outError;

/**
 Enqueue an `AFHTTPRequestOperation` with a request for the given HTTP method.

 @param method The HTTP method.
 @param path The path to be appended to the HTTP client's base URL and used as the
    request URL.
 @param parameters The parameters to be encoded and set in the request HTTP body.
 @param operationPtr The address at which a pointer to the
    `AFHTTPRequestOperation` is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The object created from the response data of the request.
 */
- (id)synchronouslyPerformMethod:(NSString *)method
                            path:(NSString *)path
                      parameters:(NSDictionary *)parameters
                       operation:(AFHTTPRequestOperation *__autoreleasing *)operationPtr
                           error:(NSError *__autoreleasing *)outError;

@end
