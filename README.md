## create keytool
- create file key.properties
  storePassword=U4qsgyFEnRWlaTHSaDXg
  keyPassword=U4qsgyFEnRWlaTHSaDXg
  keyAlias=upload
  storeFile=../app/upload-keystore.jks

- run cmd (add path java)
keytool -genkey -v -keystore ./android/app/upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload

## create logo android
- https://romannurik.github.io/AndroidAssetStudio/index.html

## build android
- flutter build appbundle

## build ios
- flutter clean
- delet Podfile, Podfile.lock
- flutter pub get
- pod install
- flutter build ios --no-tree-shake-icons
- Open xcode, product -> archive (Open list archive: Window -> Organizer)