'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/AUTO_MERGE": "6c1caf86021544007e6fdccaf66a1a8a",
".git/COMMIT_EDITMSG": "777095890e6df83f9f979f22a4fc2f0e",
".git/config": "51c86f66102c00b0a3a33f8c841215c8",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/FETCH_HEAD": "1b51cbac290e3137e1a9e350c6131f36",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "d60986e0009c39c3adbcce9d054be944",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "98efdfb72ba3eb4560c77ec9062eb95f",
".git/logs/refs/heads/main": "df771ba849a1e356b8d8bd367823c507",
".git/logs/refs/remotes/origin/main": "db3e992fe1b6f383aa01c6b4c671b6ca",
".git/MERGE_HEAD": "6181046bcaa0ca8a17f72d4fae13f908",
".git/MERGE_MODE": "d41d8cd98f00b204e9800998ecf8427e",
".git/MERGE_MSG": "24c78d4b31fddf44190687135713a290",
".git/objects/09/25078d9541cd16fc8fed17bee908b11ed29f74": "5c827a257300723368151736ba0ae5cc",
".git/objects/0b/fa1412281e179943fdc47378c66d4faa4651a7": "9aa1345b482e7691dcbb7d7699a03403",
".git/objects/11/b49a47eba3c7e305a0b900fe3716e43fa6544e": "d72eb54d5814f7adcd68b56483bf2182",
".git/objects/15/f55af7780f0c8e57f17477afb1548b93ba9b74": "848f26b5a87e35a5ba7b68a3ac8ba6e1",
".git/objects/16/7d35d3455a688294f98de39c48a4ea21b38594": "d00cc68902ca63614fba6891bf38d906",
".git/objects/17/b1d988e40e36f502ade0855d6f00e7be786979": "fe55c74555bb5cc949c7af992bb0f78f",
".git/objects/18/86151c5cb1dbe06bebd615c40f4a2455590a34": "95d7b1e647bd3cf54a27fc559df0463a",
".git/objects/1a/22a4fcff9bc4a26e5dd7cdc33f3157a7e1aaac": "10cd1dc34e63c7840b4c41898bb57bd0",
".git/objects/1a/d7683b343914430a62157ebf451b9b2aa95cac": "dee38288e294701bf8f665ae546a43e3",
".git/objects/1d/9e86eb3778955c6112586c2195631c26c56184": "01caec3028205cc723e00268d94c989f",
".git/objects/2d/bb904c9b28e1fcdafffd9d1fe7678b7e263ad0": "77412401206ecc4e8fea4c71062f7534",
".git/objects/30/17b4eb405a2dc353fb78b014c9d1c8acc0a4b1": "625c4196cd15a706add475b34a3f43b2",
".git/objects/36/bbddc71fc088636aaed72249463fe4dd146886": "089215f284a453e430b4becdf89c9f58",
".git/objects/3e/bb07b32b75af40f88195d40fcbcb478c5e333f": "286b6de5a8197fe9fec8a6bf107926ab",
".git/objects/40/c736fdd15fe2099ee6e1495d17d98219acfeff": "f72a2fc6024ba2f2993f735bc7be9434",
".git/objects/4c/51fb2d35630595c50f37c2bf5e1ceaf14c1a1e": "338245ef1a85e95987f94776d0669c97",
".git/objects/53/18a6956a86af56edbf5d2c8fdd654bcc943e88": "23e8f7ce2c2856c1943e6cb51334416e",
".git/objects/53/3d2508cc1abb665366c7c8368963561d8c24e0": "6d57e2d4816384a5236f4a52d9f1014b",
".git/objects/5e/ab5b6ad5561ac79a3e066a02c7f3b2eef6b1e7": "998dcc42861c961073e7d8f9c3f0d088",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "9524d053d0586a5f9416552b0602a196",
".git/objects/70/a234a3df0f8c93b4c4742536b997bf04980585": "6dc767ec6498faa598b6dd7d00386498",
".git/objects/73/c63bcf89a317ff882ba74ecb132b01c374a66f": "e14aa589bb7e68e3a524c297a802bde9",
".git/objects/81/101b57a62c0620b37c20f7e6676854f9adc82b": "9c7f4bd2dfde8c2a906ac8842146f313",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e35fdc55764d9ed14315f6ff50093ab3",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "b25b26893b8f92a4f583677ba27f0a7f",
".git/objects/8e/3c7d6bbbef6e7cefcdd4df877e7ed0ee4af46e": "5d4a29a9a87b890bf4925183f1d2e3f7",
".git/objects/96/7ebc83e5901c58463b9be79ec8dece19ede2a8": "6641899794c4987c4cbbe79241c622d9",
".git/objects/99/2cb2bed0f87f49de445ecee8802e5e992a9943": "f32b0be964f30d1d84b2736b6905d7ac",
".git/objects/9b/d3accc7e6a1485f4b1ddfbeeaae04e67e121d8": "dc1d3b6ac68817e26c52a2b7aca98a10",
".git/objects/a0/fe99eaddf76ebfd35b597de8469c1d9f570148": "fbff32aa04d14abe637332c7e84b6491",
".git/objects/aa/1bee732ea3cad6120f730f483ff6db4318a3e2": "bffb186f65b082fffee4c06ec4a765a5",
".git/objects/af/6a712181d220d415228f31007625522b7b39b6": "249553c3aa029b65b74911fb9a821822",
".git/objects/b4/9b9bedc5311350de70126650e584ac424f2d1e": "dfad7cb60aa9baddc867ebf873274516",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "b0c549c0aed479932cf26d094f76630e",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "9de9f2c6fa0aea6ee34b79162e9fc361",
".git/objects/b9/6a5236065a6c0fb7193cb2bb2f538b2d7b4788": "a488dd5b768f3e95bb3ded676201c413",
".git/objects/bd/3d106179f8b5c8c28bcfdf834ecfe736dc1465": "e4fc9c6b42b24e85662f1a90630db1e0",
".git/objects/c3/5b4ac09e77d8ee04a35ea7de6b1d90b0797f28": "2e04f9e95c08b752a7c1e3b90d3ac955",
".git/objects/c8/08fb85f7e1f0bf2055866aed144791a1409207": "0c4bbf647e92f25144f535178c7f7f15",
".git/objects/cc/a01995f15a50b1bbc1e98d9104c5faa36be0de": "2d17320bae31ea1bdebdde7bec3bf83c",
".git/objects/cd/3d23a7d5f8deb7cbf35880da961dab25c0c9f0": "3e4ee44b0f58002bdb6e4f95d4c3d91c",
".git/objects/cf/f28bc8a9ad3d2f2b793a9299127bd936a8be98": "d992cfd4fe07275302c5d5b0eab14bd3",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "9dbf5b01e391c548c8343be8d1d4b04e",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "5a9f3522bf38ba5dd54f15a0f75cb0d7",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "1a4ee0c85a695a5f8ce1f75dac7efc0c",
".git/objects/dc/11fdb45a686de35a7f8c24f3ac5f134761b8a9": "6a4baf0ee5d7f24d01892e880c87e9b5",
".git/objects/e0/7ac7b837115a3d31ed52874a73bd277791e6bf": "eaf69ee68e07ccd33759fba4b5e36d4e",
".git/objects/e7/e0c288d0bf9a1c543124dca08ba32780535ce2": "33bb7137a0cfc643c0bf9a2cdc7d25c9",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "c3694958e54483a81b3e32ab9f84ece2",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "01d8a507be49f15714be4d17b6947e52",
".git/objects/f0/05945ab874b994598f7f8dbe13628d44b7ac81": "b42227b8560f6839e8f90963e84aa69c",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "aa30b45014e5ab878c26ecce9ea89743",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "fb2ee964a7fc17b8cba79171cb799fa3",
".git/ORIG_HEAD": "c14cf6e5836dc1ef8e673ec6dc7abf5b",
".git/refs/heads/main": "c14cf6e5836dc1ef8e673ec6dc7abf5b",
".git/refs/remotes/origin/main": "6181046bcaa0ca8a17f72d4fae13f908",
"assets/AssetManifest.bin": "7dfaa232ec6ebbd2b660afe5dcf38b51",
"assets/AssetManifest.bin.json": "f70e074375c31a79120474930e588349",
"assets/AssetManifest.json": "be1ee6799364d0d9704b82e43757fe38",
"assets/assets/audio/East_Duo.mp3": "c8cd96da5fb656a9ea3c364dc5d5d436",
"assets/assets/flowers1.png": "549fbb4f7953b250b692c616f6ab7dd1",
"assets/assets/frame.png": "3cce7663e3fb0eb5cb531043b1f10fe7",
"assets/assets/parrots.png": "ab8b8d54362551e5c8803e40030fc71d",
"assets/assets/rr.png": "015ce125665393fdd4923bc3c56b2fa3",
"assets/FontManifest.json": "d0df0120e1c96c93c669ac705a8abf05",
"assets/fonts/Gnocchi.ttf": "899cddbd59c6a9b995ea7b926cec9f4c",
"assets/fonts/MaterialIcons-Regular.otf": "f5ca1546d59e01dffb82a6c25ec6b7d8",
"assets/NOTICES": "015f43eb2720affbf533fdfd31584aed",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "c762e20e64cfb698acecbc58e68b3457",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "2e6ab7257bdc9b7302ea96e1e1a39b83",
"/": "2e6ab7257bdc9b7302ea96e1e1a39b83",
"main.dart.js": "5d87afde425e988d7e5777007c2899c5",
"manifest.json": "a7b3de0ff4368eff4fa1b36ef9555702",
"README.md": "c3e5857d17a47de32c3aac6809d7c3c7",
"version.json": "fa62a0f385fd246e09c15612da75b2b8"};
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
