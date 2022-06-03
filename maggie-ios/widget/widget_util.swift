import UIKit

let pastelYellow = UIColor(hue: 48.0 / 360.0, saturation: 0.56, brightness: 0.96, alpha: 1.0)
let pastelPeach = UIColor(hue: 19.0 / 360.0, saturation: 0.28, brightness: 1.0, alpha: 1.0)
let pastelPink = UIColor(hue: 0.0, saturation: 0.2, brightness: 1.0, alpha: 1.0)
let pastelLavender = UIColor(hue: 299.0 / 360.0, saturation: 0.23, brightness: 1.0, alpha: 1.0)
let pastelBlue = UIColor(hue: 210.0 / 360.0, saturation: 0.25, brightness: 1.0, alpha: 1.0)
let pastelMint = UIColor(hue: 171.0 / 360.0, saturation: 0.36, brightness: 0.93, alpha: 1.0)
let pastelGreen = UIColor(hue: 144.0 / 360.0, saturation: 0.41, brightness: 0.96, alpha: 1.0)
let pastelYellowGreen = UIColor(hue: 66.0 / 360.0, saturation: 0.66, brightness: 0.91, alpha: 1.0)

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}