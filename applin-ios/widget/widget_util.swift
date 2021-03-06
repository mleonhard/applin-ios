import UIKit

let pastelYellow = UIColor(hue: 48.0 / 360.0, saturation: 0.56, brightness: 0.96, alpha: 1.0)
let pastelPeach = UIColor(hue: 19.0 / 360.0, saturation: 0.28, brightness: 1.0, alpha: 1.0)
let pastelPink = UIColor(hue: 0.0, saturation: 0.2, brightness: 1.0, alpha: 1.0)
let pastelLavender = UIColor(hue: 299.0 / 360.0, saturation: 0.23, brightness: 1.0, alpha: 1.0)
let pastelBlue = UIColor(hue: 210.0 / 360.0, saturation: 0.25, brightness: 1.0, alpha: 1.0)
let pastelMint = UIColor(hue: 171.0 / 360.0, saturation: 0.36, brightness: 0.93, alpha: 1.0)
let pastelGreen = UIColor(hue: 144.0 / 360.0, saturation: 0.41, brightness: 0.96, alpha: 1.0)
let pastelYellowGreen = UIColor(hue: 66.0 / 360.0, saturation: 0.66, brightness: 0.91, alpha: 1.0)

class SuperviewHelper {
    private var constraints: [NSLayoutConstraint] = []

    init() {
    }

    init(constraints: [NSLayoutConstraint]) {
        self.setConstraints(constraints)
    }

    func deactivateConstraints() {
        NSLayoutConstraint.deactivate(self.constraints)
    }

    func removeSubviewsAndConstraints(_ view: UIView) {
        self.deactivateConstraints()
        for subView in view.subviews {
            subView.removeFromSuperview()
        }
    }

    func setConstraints(_ constraints: [NSLayoutConstraint]) {
        self.constraints = constraints
        NSLayoutConstraint.activate(self.constraints)
    }
}

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

// From https://www.biteinteractive.com/control-target-and-action-in-ios-14/
extension UIControl {
    func addAction(for event: UIControl.Event, handler: @escaping UIActionHandler) {
        self.addAction(UIAction(handler: handler), for: event)
    }
}

extension UIViewController {
    func dismissAsync(animated: Bool) async {
        await withCheckedContinuation() { continuation in
            self.dismiss(animated: animated) {
                continuation.resume()
            }
        }
    }
}
