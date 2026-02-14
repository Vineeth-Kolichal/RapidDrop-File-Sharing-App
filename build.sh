flutter clean
flutter pub get
flutter build web --release
cp -r build/web/* android/app/src/main/assets/web
cd android
./gradlew assembleRelease
cd ..
