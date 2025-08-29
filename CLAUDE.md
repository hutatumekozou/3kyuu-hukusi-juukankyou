# プロジェクト作業ルール（福祉住環境コーディネーター3級）

- **Repository**: https://github.com/hutatumekozou/3kyuu-hukusi-juukankyou.git
- **Bundle ID** : net.jp.apps.tatsuyakawaguchi.3kyuu-hukusi-juukankyou
- **Xcodeproj** : /Users/kukkiiboy/Desktop/Claudecode/0829福祉3級/hukusijuukankyou2kyuu/福祉住環境コーディネーター3級.xcodeproj
- **Default branch**: main

## 原則
- 2級のフォルダ/リポジトリは変更しない。作業は「このワークスペースのみ」。
- Git操作前に `git remote -v` で origin を確認。誤って2級に push しない。
- 機密（AdMob/Firebase/署名関連）は `.xcconfig` や Secrets系に分離し、`.gitignore` で除外。

## 変更時チェックリスト（3級向け）
1) **Target名 / Scheme名** を3級名に統一  
2) **Bundle Identifier** を `net.jp.apps.tatsuyakawaguchi.3kyuu-hukusi-juukankyou` に  
3) **Signing**: Team/Provisioning を3級用  
4) **表示名**: CFBundleDisplayName を3級名に  
5) **ID類差し替え**: AdMob / Firebase / URL Schemes 等  
6) CocoaPods: `pod deintegrate && pod install`（必要時）  
7) Build → Archive → App Store Connect は **新規アプリ** として登録

## よく使う確認コマンド
```bash
git remote -v
/usr/libexec/PlistBuddy -c "Print :CFBundleDisplayName" $(find . -name Info.plist | head -n 1)
grep -R --line-number -E 'ca-app-pub-[0-9]{16}[~/][0-9]{10}|GADApplicationIdentifier' .
```

## 禁止事項
- 2級のoriginに push する操作
- 2級フォルダの直接編集
- 本番ビルドにテスト広告IDの混在