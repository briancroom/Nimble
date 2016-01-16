import Foundation


internal func identityAsString(value: AnyObject?) -> String {
    if let value = value {
        return NSString(format: "<%p>", unsafeBitCast(value, Int.self)).description
    } else {
        return "nil"
    }
}

internal func classAsString(cls: AnyClass) -> String {
#if os(Linux)
    return String(cls)
#else
    return NSStringFromClass(cls)
#endif
}

internal func arrayAsString<T>(items: [T], joiner: String = ", ") -> String {
    return items.reduce("") { accum, item in
        let prefix = (accum.isEmpty ? "" : joiner)
        return accum + prefix + "\(stringify(item))"
    }
}

#if !os(Linux)
@objc internal protocol NMBStringer {
    func NMB_stringify() -> String
}

extension NSArray : NMBStringer {
    func NMB_stringify() -> String {
        let str = self.componentsJoinedByString(", ")
        return "[\(str)]"
    }
}
#endif

internal func stringify<S: SequenceType>(value: S) -> String {
    var generator = value.generate()
    var strings = [String]()
    var value: S.Generator.Element?
    repeat {
        value = generator.next()
        if value != nil {
            strings.append(stringify(value))
        }
    } while value != nil
    let str = strings.joinWithSeparator(", ")
    return "[\(str)]"
}

internal func stringify<T>(value: T) -> String {
    if let value = value as? Double {
        return NSString(format: "%.4f", (value)).description
    }
    return String(value)
}

internal func stringify(value: NMBDoubleConvertible) -> String {
    if let value = value as? Double {
        return NSString(format: "%.4f", (value)).description
    }
    return value.stringRepresentation
}

internal func stringify<T>(value: T?) -> String {
    if let unboxed = value {
       return stringify(unboxed)
    }
    return "nil"
}
