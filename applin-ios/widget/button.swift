import Foundation
import UIKit

// TODO: Display disabled button with disabled mode.
struct ButtonData: Equatable, Hashable, WidgetDataProto {
    static let TYP = "button"
    let actions: [ActionData]
    let text: String

    init(_ actions: [ActionData], text: String) {
        self.actions = actions
        self.text = text
    }

    init(_ item: JsonItem) throws {
        self.actions = try item.optActions() ?? []
        self.text = try item.requireText()
    }

    func toJsonItem() -> JsonItem {
        let item = JsonItem(ButtonData.TYP)
        item.actions = self.actions.map({ action in action.toString() })
        item.text = self.text
        return item
    }

    func keys() -> [String] {
        ["button:\(self.actions)", "button:\(self.text)"]
    }

    func getTapActions() -> [ActionData]? {
        self.actions
    }

    func getView(_ session: ApplinSession, _ widgetCache: WidgetCache) -> UIView {
        let widget = widgetCache.remove(self.keys()) as? ButtonWidget ?? ButtonWidget(self)
        widget.data = self
        widgetCache.putNext(widget)
        return widget.getView(session, widgetCache)
    }
}

class ButtonWidget: WidgetProto {
    var data: ButtonData
    var button: UIButton!
    weak var session: ApplinSession?

    init(_ data: ButtonData) {
        print("ButtonWidget.init(\(data))")
        self.data = data
        let action = UIAction(title: "uninitialized", handler: { [weak self] _ in
            print("button UIAction")
            self?.doActions()
        })
        self.button = UIButton(type: .system, primaryAction: action)
        self.button.translatesAutoresizingMaskIntoConstraints = false
    }

    func keys() -> [String] {
        self.data.keys()
    }

    func doActions() {
        print("button actions")
        self.session?.doActions(self.data.actions)
    }

    func getView(_ session: ApplinSession, _ widgetCache: WidgetCache) -> UIView {
        self.session = session
        self.button.setTitle(self.data.text, for: .normal)
        return self.button
    }

//    func buttonRole() -> ButtonRole? {
//        if self.isDestructive {
//            return .destructive
//        } else if self.isCancel {
//            return .cancel
//        } else {
//            return nil
//        }
//    }
//
//    func keyboardShortcut() -> KeyboardShortcut? {
//        if self.isDefault {
//            return .defaultAction
//        } else if self.isCancel {
//            return .cancelAction
//        } else {
//            return nil
//        }
//    }
//
//    func addKeyboardShortcut<V: View>(_ view: V) -> AnyView {
//        if #available(iOS 15.4, *) {
//            return AnyView(view.keyboardShortcut(self.keyboardShortcut()))
//        } else {
//            return AnyView(view)
//        }
//    }
//
//    var body: some View {
//        Button(
//                self.text,
//                role: self.buttonRole(),
//                action: { () in
//                    print("Button(\(self.text)) action")
//                    self.session?.doActions(self.actions)
//                }
//        )
//                .disabled(self.actions.isEmpty)
//                .buttonStyle(.bordered)
//    }
}
