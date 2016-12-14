import Foundation

public enum Encoding {
    case json(JSONSerialization.ReadingOptions)
}

open class URLDataPromise: Promise<Data> {
    open func asDataAndResponse() -> Promise<(Data, Foundation.URLResponse)> {
        return then(on: zalgo) { ($0, self.URLResponse) }
    }

    open func asString() -> Promise<String> {
        return then(on: waldo) { data -> String in
            guard let str = NSString(data: data, encoding: self.URLResponse.stringEncoding ?? String.Encoding.utf8) else {
                throw URLError.stringEncoding(self.URLRequest, data, self.URLResponse)
            }
            return str as String
        }
    }

    open func asArray(_ encoding: Encoding = .json(.allowFragments)) -> Promise<NSArray> {
        return then(on: waldo) { data -> NSArray in
            switch encoding {
            case .json(let options):
                guard !data.b0rkedEmptyRailsResponse else { return NSArray() }
                let json = try JSONSerialization.jsonObject(with: data, options: options)
                guard let array = json as? NSArray else { throw JSONError.unexpectedRootNode(json) }
                return array
            }
        }
    }

    open func asDictionary(_ encoding: Encoding = .json(.allowFragments)) -> Promise<NSDictionary> {
        return then(on: waldo) { data -> NSDictionary in
            switch encoding {
            case .json(let options):
                guard !data.b0rkedEmptyRailsResponse else { return NSDictionary() }
                let json = try JSONSerialization.jsonObject(with: data, options: options)
                guard let dict = json as? NSDictionary else { throw JSONError.unexpectedRootNode(json) }
                return dict
            }
        }
    }

    fileprivate override init(@noescape resolvers: (fulfill: (Data) -> Void, reject: (ErrorProtocol) -> Void) throws -> Void) {
        super.init(resolvers: resolvers)
    }

    public override init(error: ErrorProtocol) {
        super.init(error: error)
    }

    fileprivate var URLRequest: Foundation.URLRequest!
    fileprivate var URLResponse: Foundation.URLResponse!

    open class func go(_ request: Foundation.URLRequest, @noescape body: ((Data?, Foundation.URLResponse?, NSError?) -> Void) -> Void) -> URLDataPromise {
        var promise: URLDataPromise!
        promise = URLDataPromise { fulfill, reject in
            body { data, rsp, error in
                promise.URLRequest = request
                promise.URLResponse = rsp

                if let error = error {
                    reject(URLError.underlyingCocoaError(request, data, rsp, error))
                } else if let data = data, rsp = rsp as? HTTPURLResponse where rsp.statusCode >= 200 && rsp.statusCode < 300 {
                    fulfill(data)
                } else if let data = data where !(rsp is NSHTTPURLResponse) {
                    fulfill(data)
                } else {
                    reject(URLError.badResponse(request, data, rsp))
                }
            }
        }
        return promise
    }
}

#if os(iOS)
    import UIKit.UIImage

    extension URLDataPromise {
        public func asImage() -> Promise<UIImage> {
            return then(on: waldo) { data -> UIImage in
                guard let img = UIImage(data: data), cgimg = img.cgImage else {
                    throw URLError.invalidImageData(self.URLRequest, data)
                }
                return UIImage(cgImage: cgimg, scale: img.scale, orientation: img.imageOrientation)
            }
        }
    }
#endif

extension URLResponse {
    fileprivate var stringEncoding: UInt? {
        guard let encodingName = textEncodingName else { return nil }
        let encoding = CFStringConvertIANACharSetNameToEncoding(encodingName)
        guard encoding != kCFStringEncodingInvalidId else { return nil }
        return CFStringConvertEncodingToNSStringEncoding(encoding)
    }
}

extension Data {
    fileprivate var b0rkedEmptyRailsResponse: Bool {
        return self == Data(bytes: UnsafePointer<UInt8>(" "), count: 1)
    }
}
