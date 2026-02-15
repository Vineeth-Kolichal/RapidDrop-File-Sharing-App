flutter clean
flutter pub get
# Clean the destination directory to prevent recursive copying
# rm -rf android/app/src/main/assets/web/*

flutter build web --release

# Copy the new build to the assets directory
cp -r build/web/* android/app/src/main/assets/web/
# Copy custom favicon
cp assets/favicon.png android/app/src/main/assets/web/favicon.png
# cd android
# ./gradlew assembleRelease
# cd ..
flutter run --release
flutter build apk --release

