import { useState, useEffect } from 'react';
import { Button } from './ui/button';
import { Card, CardContent } from './ui/card';
import { Download, X, Smartphone, Share } from 'lucide-react';
import { toast } from 'sonner@2.0.3';

interface BeforeInstallPromptEvent extends Event {
  prompt(): Promise<void>;
  userChoice: Promise<{ outcome: 'accepted' | 'dismissed' }>;
}

export function PWAInstaller() {
  const [deferredPrompt, setDeferredPrompt] = useState<BeforeInstallPromptEvent | null>(null);
  const [showInstallPrompt, setShowInstallPrompt] = useState(false);
  const [isIOS, setIsIOS] = useState(false);
  const [isStandalone, setIsStandalone] = useState(false);

  useEffect(() => {
    // Add PWA meta tags to document head
    addPWAMetaTags();

    // Detect iOS
    const iOS = /iPad|iPhone|iPod/.test(navigator.userAgent);
    setIsIOS(iOS);

    // Check if app is already installed (standalone mode)
    const standalone = window.matchMedia('(display-mode: standalone)').matches || 
                     (window.navigator as any).standalone === true;
    setIsStandalone(standalone);

    // Listen for beforeinstallprompt event (Android)
    const handleBeforeInstallPrompt = (e: Event) => {
      e.preventDefault();
      setDeferredPrompt(e as BeforeInstallPromptEvent);
      
      // Show install prompt after user has been using the app for a bit
      setTimeout(() => {
        setShowInstallPrompt(true);
      }, 10000); // Show after 10 seconds
    };

    window.addEventListener('beforeinstallprompt', handleBeforeInstallPrompt);

    // Initialize basic PWA features without service worker
    initializePWAFeatures();

    return () => {
      window.removeEventListener('beforeinstallprompt', handleBeforeInstallPrompt);
    };
  }, []);

  const initializePWAFeatures = () => {
    // Add basic PWA functionality without service worker
    console.log('PWA: Initializing basic PWA features');
    
    // Handle URL shortcuts from PWA
    const urlParams = new URLSearchParams(window.location.search);
    const shortcut = urlParams.get('shortcut');
    
    if (shortcut) {
      console.log('PWA: Handling shortcut:', shortcut);
      // Dispatch custom event for shortcut handling
      window.dispatchEvent(new CustomEvent('pwaShortcut', { 
        detail: { shortcut } 
      }));
    }

    // Listen for visibility changes to handle app focus
    document.addEventListener('visibilitychange', () => {
      if (!document.hidden) {
        console.log('PWA: App became visible');
        // App is now visible - could trigger sync or notifications here
      }
    });

    console.log('PWA: Basic PWA features initialized successfully');
  };

  const addPWAMetaTags = () => {
    // Only add if not already present
    if (!document.querySelector('link[rel="manifest"]')) {
      // Create and add manifest
      const manifestData = {
        "name": "Empower - Health & Wealth Literacy",
        "short_name": "Empower",
        "description": "Your personal health and wealth literacy companion for urban Indian youth",
        "start_url": "/",
        "display": "standalone",
        "background_color": "#ffffff",
        "theme_color": "#030213",
        "orientation": "portrait",
        "scope": "/",
        "lang": "en",
        "icons": [
          {
            "src": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTkyIiBoZWlnaHQ9IjE5MiIgdmlld0JveD0iMCAwIDE5MiAxOTIiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIxOTIiIGhlaWdodD0iMTkyIiByeD0iNDgiIGZpbGw9InVybCgjZ3JhZGllbnQwX2xpbmVhcl8xXzEpIi8+CjxwYXRoIGQ9Ik05NiA2NEMxMDQuODM3IDY0IDExMiA3MS4xNjMgMTEyIDgwVjExMkMxMTIgMTIwLjgzNyAxMDQuODM3IDEyOCA5NiAxMjhDODcuMTYzIDEyOCA4MCA1MC44MzcgODAgMTEyVjgwQzgwIDcxLjE2MyA4Ny4xNjMgNjQgOTYgNjRaIiBmaWxsPSJ3aGl0ZSIvPgo8cGF0aCBkPSJNNjQgOTZDNjQgODcuMTYzIDcxLjE2MyA4MCA4MCA4MEgxMTJDMTIwLjgzNyA4MCAxMjggODcuMTYzIDEyOCA5NkMxMjggMTA0LjgzNyAxMjAuODM3IDExMiAxMTIgMTEySDgwQzcxLjE2MyAxMTIgNjQgMTA0LjgzNyA2NCA5NloiIGZpbGw9IndoaXRlIiBmaWxsLW9wYWNpdHk9IjAuOCIvPgo8ZGVmcz4KPGxpbmVhckdyYWRpZW50IGlkPSJncmFkaWVudDBfbGluZWFyXzFfMSIgeDE9IjAiIHkxPSIwIiB4Mj0iMTkyIiB5Mj0iMTkyIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+CjxzdG9wIHN0b3AtY29sb3I9IiMzQjgyRjYiLz4KPHN0b3Agb2Zmc2V0PSIxIiBzdG9wLWNvbG9yPSIjOUMzNUY2Ii8+CjwvbGluZWFyR3JhZGllbnQ+CjwvZGVmcz4KPC9zdmc+",
            "sizes": "192x192",
            "type": "image/svg+xml",
            "purpose": "any maskable"
          },
          {
            "src": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgdmlld0JveD0iMCAwIDUxMiA1MTIiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSI1MTIiIGhlaWdodD0iNTEyIiByeD0iMTI4IiBmaWxsPSJ1cmwoI2dyYWRpZW50MF9saW5lYXJfMV8xKSIvPgo8cGF0aCBkPSJNMjU2IDE3MkMyODEuNDA1IDE3MiAzMDIgMTkyLjU5NSAzMDIgMjE4VjI5NEMzMDIgMzE5LjQwNSAyODEuNDA1IDM0MCAyNTYgMzQwQzIzMC41OTUgMzQwIDIxMCAzMTkuNDA1IDIxMCAyOTRWMjE4QzIxMCAxOTIuNTk1IDIzMC41OTUgMTcyIDI1NiAxNzJaIiBmaWxsPSJ3aGl0ZSIvPgo8cGF0aCBkPSJNMTcyIDI1NkMxNzIgMjMwLjU5NSAxOTIuNTk1IDIxMCAyMTggMjEwSDI5NEMzMTkuNDA1IDIxMCAzNDAgMjMwLjU5NSAzNDAgMjU2QzM0MCAyODEuNDA1IDMxOS40MDUgMzAyIDI5NCAzMDJIMjE4QzE5Mi41OTUgMzAyIDE3MiAyODEuNDA1IDE3MiAyNTZaIiBmaWxsPSJ3aGl0ZSIgZmlsbC1vcGFjaXR5PSIwLjgiLz4KPGRlZnM+CjxsaW5lYXJHcmFkaWVudCBpZD0iZ3JhZGllbnQwX2xpbmVhcl8xXzEiIHgxPSIwIiB5MT0iMCIgeDI9IjUxMiIgeTI9IjUxMiIgZ3JhZGllbnRVbml0cz0idXNlclNwYWNlT25Vc2UiPgo8c3RvcCBzdG9wLWNvbG9yPSIjM0I4MkY2Ii8+CjxzdG9wIG9mZnNldD0iMSIgc3RvcC1jb2xvcj0iIzlDMzVGNiIvPgo8L2xpbmVhckdyYWRpZW50Pgo8L2RlZnM+Cjwvc3ZnPg==",
            "sizes": "512x512",
            "type": "image/svg+xml",
            "purpose": "any maskable"
          }
        ],
        "categories": ["health", "finance", "education", "lifestyle"],
        "shortcuts": [
          {
            "name": "Daily Tasks",
            "short_name": "Tasks",
            "description": "View your daily health and wealth tasks",
            "url": "/?shortcut=tasks"
          },
          {
            "name": "Take Quiz",
            "short_name": "Quiz",  
            "description": "Test your knowledge with interactive quizzes",
            "url": "/?shortcut=quiz"
          }
        ],
        "prefer_related_applications": false
      };

      const manifestBlob = new Blob([JSON.stringify(manifestData)], { type: 'application/json' });
      const manifestUrl = URL.createObjectURL(manifestBlob);
      
      const manifest = document.createElement('link');
      manifest.rel = 'manifest';
      manifest.href = manifestUrl;
      document.head.appendChild(manifest);

      // Theme color
      const themeColor = document.createElement('meta');
      themeColor.name = 'theme-color';
      themeColor.content = '#030213';
      document.head.appendChild(themeColor);

      // iOS specific meta tags
      if (isIOS) {
        // Apple touch icon
        const appleTouchIcon = document.createElement('link');
        appleTouchIcon.rel = 'apple-touch-icon';
        appleTouchIcon.href = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTkyIiBoZWlnaHQ9IjE5MiIgdmlld0JveD0iMCAwIDE5MiAxOTIiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIxOTIiIGhlaWdodD0iMTkyIiByeD0iNDgiIGZpbGw9InVybCgjZ3JhZGllbnQwX2xpbmVhcl8xXzEpIi8+CjxwYXRoIGQ9Ik05NiA2NEMxMDQuODM3IDY0IDExMiA3MS4xNjMgMTEyIDgwVjExMkMxMTIgMTIwLjgzNyAxMDQuODM3IDEyOCA5NiAxMjhDODcuMTYzIDEyOCA4MCA1MC44MzcgODAgMTEyVjgwQzgwIDcxLjE2MyA4Ny4xNjMgNjQgOTYgNjRaIiBmaWxsPSJ3aGl0ZSIvPgo8cGF0aCBkPSJNNjQgOTZDNjQgODcuMTYzIDcxLjE2MyA4MCA4MCA4MEgxMTJDMTIwLjgzNyA4MCAxMjggODcuMTYzIDEyOCA5NkMxMjggMTA0LjgzNyAxMjAuODM3IDExMiAxMTIgMTEySDgwQzcxLjE2MyAxMTIgNjQgMTA0LjgzNyA2NCA5NloiIGZpbGw9IndoaXRlIiBmaWxsLW9wYWNpdHk9IjAuOCIvPgo8ZGVmcz4KPGxpbmVhckdyYWRpZW50IGlkPSJncmFkaWVudDBfbGluZWFyXzFfMSIgeDE9IjAiIHkxPSIwIiB4Mj0iMTkyIiB5Mj0iMTkyIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+CjxzdG9wIHN0b3AtY29sb3I9IiMzQjgyRjYiLz4KPHN0b3Agb2Zmc2V0PSIxIiBzdG9wLWNvbG9yPSIjOUMzNUY2Ci8+PC9saW5lYXJHcmFkaWVudD4KPC9kZWZzPgo8L3N2Zz4=';
        document.head.appendChild(appleTouchIcon);

        // Apple mobile web app capable
        const webAppCapable = document.createElement('meta');
        webAppCapable.name = 'apple-mobile-web-app-capable';
        webAppCapable.content = 'yes';
        document.head.appendChild(webAppCapable);

        // Apple mobile web app status bar style
        const statusBarStyle = document.createElement('meta');
        statusBarStyle.name = 'apple-mobile-web-app-status-bar-style';
        statusBarStyle.content = 'black-translucent';
        document.head.appendChild(statusBarStyle);

        // Apple mobile web app title
        const webAppTitle = document.createElement('meta');
        webAppTitle.name = 'apple-mobile-web-app-title';
        webAppTitle.content = 'Empower';
        document.head.appendChild(webAppTitle);
      }

      // Viewport meta tag for mobile (only if not present)
      if (!document.querySelector('meta[name="viewport"]')) {
        const viewport = document.createElement('meta');
        viewport.name = 'viewport';
        viewport.content = 'width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, viewport-fit=cover';
        document.head.appendChild(viewport);
      }

      console.log('PWA: Meta tags and manifest added successfully');
    }
  };

  const handleInstallClick = async () => {
    if (deferredPrompt) {
      try {
        deferredPrompt.prompt();
        const choiceResult = await deferredPrompt.userChoice;
        
        if (choiceResult.outcome === 'accepted') {
          toast.success('Thanks for installing Empower! 🎉');
        }
        
        setDeferredPrompt(null);
        setShowInstallPrompt(false);
      } catch (error) {
        console.error('PWA: Install prompt failed', error);
        toast.error('Installation failed. Try using browser menu instead.');
      }
    }
  };

  const handleIOSInstall = () => {
    toast.info(
      'To install Empower on your iPhone:\n1. Tap the Share button (⬆️) at the bottom\n2. Scroll down and tap "Add to Home Screen"\n3. Tap "Add" to install',
      { duration: 8000 }
    );
  };

  // Don't show if already installed
  if (isStandalone) {
    return null;
  }

  // Android install prompt
  if (showInstallPrompt && deferredPrompt && !isIOS) {
    return (
      <Card className="fixed bottom-20 left-4 right-4 z-50 border-2 border-primary bg-gradient-to-r from-blue-50 to-purple-50">
        <CardContent className="p-4">
          <div className="flex items-start gap-3">
            <div className="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-600 rounded-lg flex items-center justify-center flex-shrink-0">
              <Download className="h-5 w-5 text-white" />
            </div>
            <div className="flex-1 min-w-0">
              <h4 className="font-semibold text-sm mb-1">Install Empower App</h4>
              <p className="text-xs text-muted-foreground mb-3">
                Install Empower for quick access and better performance!
              </p>
              <div className="flex gap-2">
                <Button
                  size="sm"
                  onClick={handleInstallClick}
                  className="text-xs px-4 py-2"
                >
                  <Download className="h-3 w-3 mr-1" />
                  Install
                </Button>
                <Button
                  size="sm"
                  variant="outline"
                  onClick={() => setShowInstallPrompt(false)}
                  className="text-xs px-3 py-2"
                >
                  <X className="h-3 w-3" />
                </Button>
              </div>
            </div>
          </div>
        </CardContent>
      </Card>
    );
  }

  // iOS install prompt
  if (isIOS && showInstallPrompt) {
    return (
      <Card className="fixed bottom-20 left-4 right-4 z-50 border-2 border-primary bg-gradient-to-r from-blue-50 to-purple-50">
        <CardContent className="p-4">
          <div className="flex items-start gap-3">
            <div className="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-600 rounded-lg flex items-center justify-center flex-shrink-0">
              <Smartphone className="h-5 w-5 text-white" />
            </div>
            <div className="flex-1 min-w-0">
              <h4 className="font-semibold text-sm mb-1">Install Empower on iPhone</h4>
              <p className="text-xs text-muted-foreground mb-3">
                Add Empower to your home screen for the best experience!
              </p>
              <div className="flex gap-2">
                <Button
                  size="sm"
                  onClick={handleIOSInstall}
                  className="text-xs px-4 py-2"
                >
                  <Share className="h-3 w-3 mr-1" />
                  Show Instructions
                </Button>
                <Button
                  size="sm"
                  variant="outline"
                  onClick={() => setShowInstallPrompt(false)}
                  className="text-xs px-3 py-2"
                >
                  <X className="h-3 w-3" />
                </Button>
              </div>
            </div>
          </div>
        </CardContent>
      </Card>
    );
  }

  return null;
}

// Hook to trigger install prompt manually
export function usePWAInstall() {
  const [canInstall, setCanInstall] = useState(false);
  const [isIOS, setIsIOS] = useState(false);

  useEffect(() => {
    const iOS = /iPad|iPhone|iPod/.test(navigator.userAgent);
    setIsIOS(iOS);

    const handleBeforeInstallPrompt = (e: Event) => {
      e.preventDefault();
      setCanInstall(true);
    };

    window.addEventListener('beforeinstallprompt', handleBeforeInstallPrompt);

    return () => {
      window.removeEventListener('beforeinstallprompt', handleBeforeInstallPrompt);
    };
  }, []);

  const triggerInstall = () => {
    if (isIOS) {
      toast.info(
        'To install:\n1. Tap Share (⬆️)\n2. "Add to Home Screen"\n3. Tap "Add"',
        { duration: 6000 }
      );
    } else if (canInstall) {
      // Trigger the deferred prompt if available
      window.dispatchEvent(new Event('show-install-prompt'));
    }
  };

  return {
    canInstall: canInstall || isIOS,
    isIOS,
    triggerInstall
  };
}