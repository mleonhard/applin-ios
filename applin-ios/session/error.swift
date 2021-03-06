import Foundation

enum ApplinError: Error {
    case deserializeError(String)
    case networkError(String)
    case serverError(String)
    case userError(String)
}
