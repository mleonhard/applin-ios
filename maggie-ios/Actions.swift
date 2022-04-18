import Foundation

enum MaggieAction: Equatable {
    case CopyToClipboard(String)
    case LaunchUrl(URL)
    case Push(String)
    case Rpc(String)
    case Pop
    case Refresh
    
    init(_ string: String) throws {
        switch string {
        case "":
            throw MaggieError.deserializeError("action is empty")
        case "pop":
            self = .Pop
            return
        case "refresh":
            self = .Refresh
            return
        default:
            break
        }
        let parts = string.split(separator: ":", maxSplits: 1)
        if parts.count != 2 || parts[1].isEmpty {
            throw MaggieError.deserializeError("invalid action: \(string)")
        }
        let part1 = String(parts[1])
        switch parts[0] {
        case "copy-to-clipboard":
            self = .CopyToClipboard(part1)
        case "launch-url":
            if let url = URL(string: part1) {
                self = .LaunchUrl(url)
            } else {
                throw MaggieError.deserializeError("failed parsing url: \(part1)")
            }
        case "push":
            self = .Push(part1)
        case "rpc":
            self = .Rpc(part1)
        default:
            throw MaggieError.deserializeError("unknown action: \(string)")
        }
    }
    
    func perform() {
        print("unimplemented")
    }
}