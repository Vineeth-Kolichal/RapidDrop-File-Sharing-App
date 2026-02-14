flutter clean
flutter pub get
# Clean the destination directory to prevent recursive copying
rm -rf android/app/src/main/assets/web/*

flutter build web --release

# Copy the new build to the assets directory
cp -r build/web/* android/app/src/main/assets/web/
cd android
./gradlew assembleRelease
cd ..
