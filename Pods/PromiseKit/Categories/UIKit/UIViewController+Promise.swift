import Foundation.NSError
import UIKit
#if !COCOAPODS
import PromiseKit
#endif

/**
 To import this `UIViewController` category:

    use_frameworks!
    pod "PromiseKit/UIKit"

 Or `UIKit` is one of the categories imported by the umbrella pod:

    use_frameworks!
    pod "PromiseKit"

 And then in your sources:

    import PromiseKit
*/
extension UIViewController {

    public enum Error: ErrorProtocol {
        case navigationControllerEmpty
        case noImageFound
        case notPromisable
        case notGenericallyPromisable
        case nilPromisable
    }

    public func promiseViewController<T>(_ vc: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) -> Promise<T> {

        let p: Promise<T> = promise(vc)
        if p.pending {
            present(vc, animated: animated, completion: completion)
            p.always {
                self.dismiss(animated: animated, completion: nil)
            }
        }

        return p
    }
    
    public func promiseViewController<T>(_ nc: UINavigationController, animated: Bool = true, completion:(()->Void)? = nil) -> Promise<T> {
        if let vc = nc.viewControllers.first {
            let p: Promise<T> = promise(vc)
            if p.pending {
                present(nc, animated: animated, completion: completion)
                p.always {
                    self.dismiss(animated: animated, completion: nil)
                }
            }
            return p
        } else {
            return Promise(error: Error.navigationControllerEmpty)
        }
    }

    public func promiseViewController(_ vc: UIImagePickerController, animated: Bool = true, completion: (() -> Void)? = nil) -> Promise<UIImage> {
        let proxy = UIImagePickerControllerProxy()
        vc.delegate = proxy
        vc.mediaTypes = ["public.image"]  // this promise can only resolve with a UIImage
        present(vc, animated: animated, completion: completion)
        return proxy.promise.then(on: zalgo) { info -> UIImage in
            if let img = info[UIImagePickerControllerEditedImage] as? UIImage {
                return img
            }
            if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
                return img
            }
            throw Error.noImageFound
        }.always {
            self.dismiss(animated: animated, completion: nil)
        }
    }
}

@objc public protocol Promisable {
    /**
    Provide a promise for promiseViewController here.

    The resulting property must be annotated with @objc.

    Obviously return a Promise<T>. There is an issue with generics and Swift and
    protocols currently so we couldn't specify that.
    */
    var promise: AnyObject! { get }
}

private func promise<T>(_ vc: UIViewController) -> Promise<T> {
    if !vc.conforms(to: Promisable) {
        return Promise(error: UIViewController.Error.notPromisable)
    } else if let promise = vc.value(forKeyPath: "promise") as? Promise<T> {
        return promise
    } else if let _: AnyObject = vc.value(forKeyPath: "promise") {
        return Promise(error: UIViewController.Error.notGenericallyPromisable)
    } else {
        return Promise(error: UIViewController.Error.nilPromisable)
    }
}


// internal scope because used by ALAssetsLibrary extension
@objc class UIImagePickerControllerProxy: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let (promise, fulfill, reject) = Promise<[AnyHashable: Any]>.pendingPromise()
    var retainCycle: AnyObject?

    required override init() {
        super.init()
        retainCycle = self
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        fulfill(info)
        retainCycle = nil
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        reject(UIImagePickerController.Error.Cancelled)
        retainCycle = nil
    }
}


extension UIImagePickerController {
    public enum Error: CancellableErrorType {
        case Cancelled

        public var cancelled: Bool {
            switch self {
                case .Cancelled: return true
            }
        }
    }
}
