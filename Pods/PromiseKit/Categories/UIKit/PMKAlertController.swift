import UIKit
#if !COCOAPODS
import PromiseKit
#endif

//TODO tests
//TODO NSCoding

/**
 A “promisable” UIAlertController.

 UIAlertController is not a suitable API for an extension; it has closure
 handlers on its main API for each button and an extension would have to
 either replace all these when the controller is presented or force you to
 use an extended addAction method, which would be easy to forget part of
 the time. Hence we provide a facade pattern that can be promised.

    let alert = PMKAlertController("OHAI")
    let sup = alert.addActionWithTitle("SUP")
    let bye = alert.addActionWithTitle("BYE")
    promiseViewController(alert).then { action in
        switch action {
        case is sup:
            //…
        case is bye:
            //…
        }
    }
*/
open class PMKAlertController {
    open var title: String? { return UIAlertController.title }
    open var message: String? { return UIAlertController.message }
    open var preferredStyle: UIAlertControllerStyle { return UIAlertController.preferredStyle }
    open var actions: [UIAlertAction] { return UIAlertController.actions }
    open var textFields: [UITextField]? { return UIAlertController.textFields }

    public required init(title: String?, message: String?  = nil, preferredStyle: UIAlertControllerStyle = .alert) {
        UIAlertController = UIKit.UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
    }

    open func addActionWithTitle(_ title: String, style: UIAlertActionStyle = .default) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style) { action in
            if style == UIAlertActionStyle.cancel {
                self.fulfill(action)
            } else {
                self.reject(Error.cancelled)
            }
        }
        UIAlertController.addAction(action)
        return action
    }

    open func addTextFieldWithConfigurationHandler(_ configurationHandler: ((UITextField) -> Void)?) {
        UIAlertController.addTextField(configurationHandler: configurationHandler)
    }

    fileprivate let UIAlertController: UIKit.UIAlertController
    fileprivate let (promise, fulfill, reject) = Promise<UIAlertAction>.pendingPromise()
    fileprivate var retainCycle: PMKAlertController?

    public enum Error: ErrorProtocol {
        case cancelled
    }
}

extension UIViewController {
    public func promiseViewController(_ vc: PMKAlertController, animated: Bool = true, completion: (() -> Void)? = nil) -> Promise<UIAlertAction> {
        vc.retainCycle = vc
        present(vc.UIAlertController, animated: true, completion: nil)
        vc.promise.always { _ -> Void in
            vc.retainCycle = nil
        }
        return vc.promise
    }
}
