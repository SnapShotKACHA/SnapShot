import Foundation
import OMGHTTPURLRQ
#if !COCOAPODS
import PromiseKit
#endif

/**
 To import the `NSURLConnection` category:

    use_frameworks!
    pod "PromiseKit/Foundation"

 Or `NSURLConnection` is one of the categories imported by the umbrella pod:

    use_frameworks!
    pod "PromiseKit"

 And then in your sources:

    import PromiseKit
*/
extension NSURLConnection {
    public class func GET(_ URL: String, query: [AnyHashable: Any]? = nil) -> URLDataPromise {
        return go(try OMGHTTPURLRQ.get(URL, query))
    }

    public class func POST(_ URL: String, formData: [AnyHashable: Any]? = nil) -> URLDataPromise {
        return go(try OMGHTTPURLRQ.post(URL, formData))
    }

    public class func POST(_ URL: String, JSON: [AnyHashable: Any]) -> URLDataPromise {
        return go(try OMGHTTPURLRQ.post(URL, json: JSON))
    }

    public class func POST(_ URL: String, multipartFormData: OMGMultipartFormData) -> URLDataPromise {
        return go(try OMGHTTPURLRQ.post(URL, multipartFormData))
    }

    public class func PUT(_ URL: String, formData: [AnyHashable: Any]? = nil) -> URLDataPromise {
        return go(try OMGHTTPURLRQ.put(URL, formData))
    }

    public class func PUT(_ URL: String, JSON: [AnyHashable: Any]) -> URLDataPromise {
        return go(try OMGHTTPURLRQ.put(URL, json: JSON))
    }

    public class func DELETE(_ URL: String) -> URLDataPromise {
        return go(try OMGHTTPURLRQ.delete(URL, nil))
    }

    public class func promise(_ request: URLRequest) -> URLDataPromise {
        return go(request)
    }
}

private func go(@autoclosure _ body: () throws -> URLRequest) -> URLDataPromise {
    do {
        var request = try body()

        if request.value(forHTTPHeaderField: "User-Agent") == nil {
            let rq = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
            rq.setValue(OMGUserAgent(), forHTTPHeaderField: "User-Agent")
            request = rq
        }

        return URLDataPromise.go(request) { completionHandler in
            NSURLConnection.sendAsynchronousRequest(request, queue: Q, completionHandler: { completionHandler($1, $0, $2) })
        }
    } catch {
        return URLDataPromise(error: error)
    }
}

private let Q = OperationQueue()
