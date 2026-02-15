'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "4e21058c5f6f652991c546eb7cc51b51",
"version.json": "f9b43ffb5f5675b1581f9bc170e11a6e",
"index.html": "90fd6344643ca83d77771c482a74afe7",
"/": "90fd6344643ca83d77771c482a74afe7",
"main.dart.js": "067c06c6d016c26cb0868ca4cca8e723",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "bc496b6adc25e9f74624b5cb7e162986",
"assets/NOTICES": "4daa9b459839d03ff4a9da4f4cb0ba99",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "a8146a013d4ddf1aa45d00a98abf13d3",
"assets/android/app/src/main/assets/web/flutter_bootstrap.js": "219085ea19a447249b4622dfdbe9eb2b",
"assets/android/app/src/main/assets/web/version.json": "f9b43ffb5f5675b1581f9bc170e11a6e",
"assets/android/app/src/main/assets/web/index.html": "90fd6344643ca83d77771c482a74afe7",
"assets/android/app/src/main/assets/web/main.dart.js": "3c1223b65bec8e459fb87b2f816402c5",
"assets/android/app/src/main/assets/web/flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"assets/android/app/src/main/assets/web/favicon.png": "ee582fa5284d571017496ab28dba07e5",
"assets/android/app/src/main/assets/web/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"assets/android/app/src/main/assets/web/icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"assets/android/app/src/main/assets/web/icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"assets/android/app/src/main/assets/web/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"assets/android/app/src/main/assets/web/manifest.json": "bc496b6adc25e9f74624b5cb7e162986",
"assets/android/app/src/main/assets/web/assets/NOTICES": "4daa9b459839d03ff4a9da4f4cb0ba99",
"assets/android/app/src/main/assets/web/assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/android/app/src/main/assets/web/assets/AssetManifest.bin.json": "a8146a013d4ddf1aa45d00a98abf13d3",
"assets/android/app/src/main/assets/web/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/android/app/src/main/assets/web/assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/android/app/src/main/assets/web/assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/android/app/src/main/assets/web/assets/AssetManifest.bin": "fecf62c17437acfccb6e99f7c64fb40f",
"assets/android/app/src/main/assets/web/assets/fonts/MaterialIcons-Regular.otf": "7581bf85508573e4cf67cc685ca0d501",
"assets/android/app/src/main/assets/web/canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"assets/android/app/src/main/assets/web/canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"assets/android/app/src/main/assets/web/canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"assets/android/app/src/main/assets/web/canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"assets/android/app/src/main/assets/web/canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"assets/android/app/src/main/assets/web/canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"assets/android/app/src/main/assets/web/canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"assets/android/app/src/main/assets/web/canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"assets/android/app/src/main/assets/web/canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"assets/android/app/src/main/assets/web/canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"assets/android/app/src/main/assets/web/canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"assets/android/app/src/main/assets/web/canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin": "fecf62c17437acfccb6e99f7c64fb40f",
"assets/fonts/MaterialIcons-Regular.otf": "7581bf85508573e4cf67cc685ca0d501",
"assets/assets/app_icon.png": "93d81d74fcf2643be954d274ec662ee3",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
