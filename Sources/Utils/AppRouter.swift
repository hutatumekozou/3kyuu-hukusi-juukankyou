import SwiftUI

enum AppRouter {

    /// UINavigationController があれば popToRoot、無ければ Root を差し替え
    static func backToHome<Home: View>(_ home: @autoclosure @escaping () -> Home) {
        DispatchQueue.main.async {
            if let nav = findNav(from: topMost()) {
                nav.popToRootViewController(animated: true)
                return
            }
            guard let window = UIApplication.shared.connectedScenes
                    .compactMap({ $0 as? UIWindowScene })
                    .flatMap({ $0.windows })
                    .first(where: { $0.isKeyWindow })
            else { return }
            window.rootViewController = UIHostingController(rootView: home())
            window.makeKeyAndVisible()
        }
    }

    // MARK: helpers
    private static func topMost(base: UIViewController? = UIApplication.shared
        .connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first?.rootViewController) -> UIViewController {
        if let nav = base as? UINavigationController { return topMost(base: nav.visibleViewController) }
        if let tab = base as? UITabBarController, let sel = tab.selectedViewController { return topMost(base: sel) }
        if let presented = base?.presentedViewController { return topMost(base: presented) }
        return base ?? UIViewController()
    }
    private static func findNav(from vc: UIViewController?) -> UINavigationController? {
        if let nav = vc as? UINavigationController { return nav }
        return vc?.navigationController
    }
}