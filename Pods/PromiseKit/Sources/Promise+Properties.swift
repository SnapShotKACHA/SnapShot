extension Promise {
    /**
     - Returns: The error with which this promise was rejected; `nil` if this promise is not rejected.
    */
    public var error: ErrorProtocol? {
        switch state.get() {
        case .none:
            return nil
        case .some(.fulfilled):
            return nil
        case .some(.rejected(let error, _)):
            return error
        }
    }

    /**
     - Returns: `true` if the promise has not yet resolved.
    */
    public var pending: Bool {
        return state.get() == nil
    }

    /**
     - Returns: `true` if the promise has resolved.
    */
    public var resolved: Bool {
        return !pending
    }

    /**
     - Returns: `true` if the promise was fulfilled.
    */
    public var fulfilled: Bool {
        return value != nil
    }

    /**
     - Returns: `true` if the promise was rejected.
    */
    public var rejected: Bool {
        return error != nil
    }

    /**
     - Returns: The value with which this promise was fulfilled or `nil` if this promise is pending or rejected.
    */
    public var value: T? {
        switch state.get() {
        case .none:
            return nil
        case .some(.fulfilled(let value)):
            return value
        case .some(.rejected):
            return nil
        }
    }
}
