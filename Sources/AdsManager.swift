import GoogleMobileAds
import UIKit

final class AdsManager: NSObject, GADFullScreenContentDelegate {
    static let shared = AdsManager()
    private var interstitial: GADInterstitialAd?
    private var onClosed: (() -> Void)?

    func preload() {
        #if DEBUG
        let unitID = "ca-app-pub-3940256099942544/4411468910"
        #else
        let unitID = "ca-app-pub-8365176591962448/3970919969"
        #endif
        GADInterstitialAd.load(withAdUnitID: unitID, request: GADRequest()) { [weak self] ad, err in
            DispatchQueue.main.async {
                if let err = err {
                    print("[Ads] preload failed:", err.localizedDescription)
                    self?.interstitial = nil
                    return
                }
                self?.interstitial = ad
                ad?.fullScreenContentDelegate = self
                print("[Ads] interstitial loaded.")
            }
        }
    }

    /// 表示できなくても必ず onClosed を MAIN で呼ぶ
    func show(from vc: UIViewController, onClosed: @escaping () -> Void) {
        self.onClosed = onClosed
        guard let ad = interstitial else {
            print("[Ads] not ready; fallback close")
            DispatchQueue.main.async { onClosed() }
            return
        }
        ad.present(fromRootViewController: vc)
    }

    // MARK: - GADFullScreenContentDelegate
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("[Ads] dismissed")
        interstitial = nil
        DispatchQueue.main.async { [weak self] in
            self?.preload()
            self?.onClosed?(); self?.onClosed = nil
        }
    }

    func ad(_ ad: GADFullScreenPresentingAd,
            didFailToPresentFullScreenContentWithError error: Error) {
        print("[Ads] present failed:", error.localizedDescription)
        interstitial = nil
        DispatchQueue.main.async { [weak self] in
            self?.preload()
            self?.onClosed?(); self?.onClosed = nil
        }
    }
}

