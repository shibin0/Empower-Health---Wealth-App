// Empower PWA Service Worker
const CACHE_NAME = 'empower-v1.0.0';
const STATIC_CACHE_NAME = 'empower-static-v1.0.0';

// Files to cache for offline functionality
const STATIC_FILES = [
  '/',
  '/manifest.json',
  '/App.tsx',
  // Add other critical files as needed
];

// API endpoints to cache
const API_CACHE_PATTERNS = [
  /^https:\/\/.*\.supabase\.co\/functions\/v1\/make-server-b724bdf3\//,
];

// Install event - cache static files
self.addEventListener('install', event => {
  console.log('Service Worker: Installing...');
  
  event.waitUntil(
    caches.open(STATIC_CACHE_NAME)
      .then(cache => {
        console.log('Service Worker: Caching static files');
        return cache.addAll(STATIC_FILES);
      })
      .then(() => {
        console.log('Service Worker: Installation complete');
        return self.skipWaiting();
      })
      .catch(error => {
        console.error('Service Worker: Installation failed', error);
      })
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', event => {
  console.log('Service Worker: Activating...');
  
  event.waitUntil(
    caches.keys()
      .then(cacheNames => {
        return Promise.all(
          cacheNames.map(cacheName => {
            if (cacheName !== CACHE_NAME && cacheName !== STATIC_CACHE_NAME) {
              console.log('Service Worker: Deleting old cache', cacheName);
              return caches.delete(cacheName);
            }
          })
        );
      })
      .then(() => {
        console.log('Service Worker: Activation complete');
        return self.clients.claim();
      })
  );
});

// Fetch event - serve from cache when offline
self.addEventListener('fetch', event => {
  const { request } = event;
  const url = new URL(request.url);

  // Handle navigation requests
  if (request.mode === 'navigate') {
    event.respondWith(
      fetch(request)
        .catch(() => caches.match('/'))
    );
    return;
  }

  // Handle API requests
  if (API_CACHE_PATTERNS.some(pattern => pattern.test(request.url))) {
    event.respondWith(
      caches.open(CACHE_NAME)
        .then(cache => {
          return fetch(request)
            .then(response => {
              // Only cache successful responses
              if (response.status === 200) {
                cache.put(request, response.clone());
              }
              return response;
            })
            .catch(() => {
              // Return cached version if available
              return cache.match(request);
            });
        })
    );
    return;
  }

  // Handle other requests with cache-first strategy
  event.respondWith(
    caches.match(request)
      .then(response => {
        return response || fetch(request);
      })
  );
});

// Push notification event
self.addEventListener('push', event => {
  console.log('Service Worker: Push notification received', event);
  
  let notificationData = {
    title: 'Empower',
    body: 'You have a new notification!',
    icon: '/manifest.json', // Will use the icon from manifest
    badge: '/manifest.json',
    vibrate: [200, 100, 200],
    data: {
      url: '/'
    },
    actions: [
      {
        action: 'open',
        title: 'Open App',
        icon: '/manifest.json'
      },
      {
        action: 'dismiss',
        title: 'Dismiss',
        icon: '/manifest.json'
      }
    ]
  };

  // Parse notification data if provided
  if (event.data) {
    try {
      const data = event.data.json();
      notificationData = { ...notificationData, ...data };
    } catch (error) {
      console.error('Service Worker: Error parsing push data', error);
    }
  }

  event.waitUntil(
    self.registration.showNotification(notificationData.title, notificationData)
  );
});

// Notification click event
self.addEventListener('notificationclick', event => {
  console.log('Service Worker: Notification clicked', event);
  
  event.notification.close();

  const action = event.action;
  const notificationData = event.notification.data || {};

  if (action === 'dismiss') {
    return;
  }

  // Handle notification click
  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true })
      .then(clientList => {
        // If app is already open, focus it
        for (const client of clientList) {
          if (client.url.includes(self.location.origin)) {
            client.focus();
            // Send message to client about the notification click
            client.postMessage({
              type: 'NOTIFICATION_CLICK',
              action: action,
              data: notificationData
            });
            return;
          }
        }
        
        // If app is not open, open it
        const urlToOpen = notificationData.url || '/';
        return clients.openWindow(urlToOpen);
      })
  );
});

// Background sync event (for offline actions)
self.addEventListener('sync', event => {
  console.log('Service Worker: Background sync triggered', event.tag);
  
  if (event.tag === 'sync-user-data') {
    event.waitUntil(syncUserData());
  }
});

// Sync user data when back online
async function syncUserData() {
  try {
    // Get pending sync data from IndexedDB or localStorage
    const pendingData = await getPendingData();
    
    if (pendingData.length > 0) {
      for (const data of pendingData) {
        try {
          await fetch(data.url, {
            method: data.method,
            headers: data.headers,
            body: data.body
          });
          
          // Remove from pending data after successful sync
          await removePendingData(data.id);
        } catch (error) {
          console.error('Service Worker: Failed to sync data', error);
        }
      }
    }
  } catch (error) {
    console.error('Service Worker: Sync failed', error);
  }
}

// Helper functions for offline sync
async function getPendingData() {
  // This would typically use IndexedDB
  // For now, return empty array
  return [];
}

async function removePendingData(id) {
  // This would typically remove from IndexedDB
  console.log('Service Worker: Removing pending data', id);
}

// PWA installation prompt handling
self.addEventListener('message', event => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});