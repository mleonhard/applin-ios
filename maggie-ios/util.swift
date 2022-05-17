import Foundation
import SwiftUI

func documentDirPath() -> String {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return urls[0].path
}

func fileExists(path: String) async -> Bool {
    let task: Task<Bool, Never> = Task {
        FileManager.default.fileExists(atPath: path)
    }
    return await task.value
}

func readFile(path: String) async throws -> Data {
    let task = Task {
        try Data(contentsOf: URL(fileURLWithPath: path))
    }
    return try await task.value
}

func writeFile(data: Data, path: String) async throws {
    let task = Task {
        try data.write(to: URL(fileURLWithPath: path))
    }
    try await task.value
}

func moveFile(atPath: String, toPath: String) async throws {
    let task = Task {
        try FileManager.default.moveItem(atPath: atPath, toPath: toPath)
    }
    try await task.value
}

func deleteFile(path: String) async throws {
    let task = Task {
        // Apple's docs don't say what happens when the file doesn't exist.
        // https://developer.apple.com/documentation/foundation/filemanager/1408573-removeitem
        // Here's what I get from iOS 15 in Simulator:
        // Error Domain=NSCocoaErrorDomain Code=4 "'cache.json.tmp' couldn't be removed."
        // UserInfo={
        //   NSUserStringVariant=(Remove),
        //   NSFilePath=/Users/user/Library/Developer/CoreSimulator/Devices/61ED91D5-4782-4D6C-B943-74774C383CEC/data/
        //     Containers/Data/Application/CDF87840-5B50-4217-A2AC-5CC345A52A9B/Documents/cache.json.tmp,
        //   NSUnderlyingError=0x600000d541e0 {Error Domain=NSPOSIXErrorDomain Code=2 "No such file or directory"}
        // }
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch let error as NSError where error.code == 2 /* No such file or directory */ {
            // Do nothing.
        }
    }
    try await task.value
}

func readBundleFile(filename: String) async throws -> Data {
    let task: Task<Data, Error> = Task {
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            throw MaggieError.deserializeError("bundle file not found: \(filename)")
        }
        do {
            return try Data(contentsOf: file)
        } catch {
            throw MaggieError.deserializeError("error reading bundle file \(filename): \(error)")
        }
    }
    return try await task.value
}

// swiftlint:disable identifier_name
func sleep(ms: Int) async {
    do {
        try await Task.sleep(nanoseconds: UInt64(ms) * 1_000_000)
    } catch {
    }
}

func decodeBundleJsonFile<T: Decodable>(_ filename: String) async throws -> T {
    let data = try await readBundleFile(filename: filename)
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        throw MaggieError.deserializeError("error parsing JSON \(filename) as \(T.self): \(error)")
    }
}

func decodeJson<T: Decodable>(_ data: Data) throws -> T {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
}

func encodeJson<T: Encodable>(_ item: T) throws -> Data {
    let encoder = JSONEncoder()
    return try encoder.encode(item)
}

extension CGFloat {
    func toDouble() -> Double {
        Double(self)
    }
}

extension HTTPURLResponse {
    func contentTypeBase() -> String? {
        if let mimeType = self.mimeType {
            return mimeType
                    .split(separator: ";", maxSplits: 1, omittingEmptySubsequences: false)[0]
                    .lowercased()
        } else {
            return nil
        }
    }
}

extension Alignment: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .topLeading:
            hasher.combine(0)
        case .top:
            hasher.combine(1)
        case .topTrailing:
            hasher.combine(2)
        case .leading:
            hasher.combine(3)
        case .center:
            hasher.combine(4)
        case .trailing:
            hasher.combine(5)
        case .bottomLeading:
            hasher.combine(6)
        case .bottom:
            hasher.combine(7)
        case .bottomTrailing:
            hasher.combine(8)
        default:
            preconditionFailure("unreachable")
        }
    }
}

extension HorizontalAlignment {
    func toAlignment() -> Alignment {
        switch self {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        default:
            preconditionFailure("unreachable")
        }
    }
}

extension HorizontalAlignment: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .leading:
            hasher.combine(0)
        case .center:
            hasher.combine(1)
        case .trailing:
            hasher.combine(2)
        default:
            preconditionFailure("unreachable")
        }
    }
}

extension VerticalAlignment {
    func toAlignment() -> Alignment {
        switch self {
        case .top:
            return .top
        case .center:
            return .center
        case .bottom:
            return .bottom
        default:
            preconditionFailure("unreachable")
        }
    }
}

extension VerticalAlignment: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .top:
            hasher.combine(0)
        case .center:
            hasher.combine(1)
        case .bottom:
            hasher.combine(2)
        default:
            preconditionFailure("unreachable")
        }
    }
}

// Swift does not allow `throw ()` or `throw Error()` and
// does not document an alternative.
struct EmptyError: Error {
}
