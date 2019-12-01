import Foundation

/// NSURL stores its absoluteString in the database.
extension NSURL: DatabaseValueConvertible {
    
    /// Returns a value that can be stored in the database.
    /// (the URL's absoluteString).
    public var databaseValue: DatabaseValue {
#if os(Linux)
        return absoluteString.databaseValue
#else
        return absoluteString?.databaseValue ?? .null
#endif
    }
    
    /// Returns an NSURL initialized from *dbValue*, if possible.
    public static func fromDatabaseValue(_ dbValue: DatabaseValue) -> Self? {
        guard let string = String.fromDatabaseValue(dbValue) else {
            return nil
        }
        return cast(URL(string: string))
    }
}

/// URL stores its absoluteString in the database.
extension URL: DatabaseValueConvertible { }
