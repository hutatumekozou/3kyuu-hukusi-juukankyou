import UIKit

enum TopViewController {
    static func topMost(base: UIViewController? = UIApplication.shared
        .connectedScenes
        .compactMap { ($0 as? UIWindowScene)?.keyWindow }
        .first?.rootViewController) -> UIViewController {
        if let nav = base as? UINavigationController {
            return topMost(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topMost(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topMost(base: presented)
        }
        return base ?? UIViewController()
    }

    static func popToRoot(animated: Bool = true) {
        guard let nav = topMost().navigationController ??
                (UIApplication.shared.connectedScenes
                    .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                    .first?.rootViewController as? UINavigationController)
        else { return }
        nav.popToRootViewController(animated: animated)
    }
}