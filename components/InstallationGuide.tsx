import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Button } from './ui/button';
import { 
  Smartphone, 
  Share, 
  Plus, 
  Home,
  ArrowRight,
  CheckCircle,
  Download
} from 'lucide-react';

interface InstallationGuideProps {
  onClose?: () => void;
}

export function InstallationGuide({ onClose }: InstallationGuideProps) {
  const isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent);
  const isStandalone = window.matchMedia('(display-mode: standalone)').matches || 
                      (window.navigator as any).standalone === true;

  if (isStandalone) {
    return (
      <Card className="w-full max-w-md mx-auto">
        <CardContent className="p-6 text-center">
          <CheckCircle className="h-16 w-16 text-green-500 mx-auto mb-4" />
          <h3 className="text-lg font-semibold mb-2">App Installed Successfully!</h3>
          <p className="text-muted-foreground">
            Empower is now installed on your device. You can access it from your home screen anytime.
          </p>
          {onClose && (
            <Button onClick={onClose} className="mt-4">
              Continue to App
            </Button>
          )}
        </CardContent>
      </Card>
    );
  }

  return (
    <Card className="w-full max-w-md mx-auto">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Smartphone className="h-5 w-5" />
          Install Empower on {isIOS ? 'iPhone' : 'Your Device'}
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-6">
        {isIOS ? (
          <>
            <div className="text-center">
              <p className="text-sm text-muted-foreground mb-4">
                Install Empower as a native app on your iPhone for the best experience!
              </p>
            </div>

            <div className="space-y-4">
              <div className="flex items-start gap-3 p-3 bg-blue-50 rounded-lg">
                <div className="w-6 h-6 bg-blue-500 text-white rounded-full flex items-center justify-center text-xs font-semibold flex-shrink-0">
                  1
                </div>
                <div className="flex-1">
                  <p className="text-sm font-medium">Tap the Share Button</p>
                  <p className="text-xs text-muted-foreground mt-1">
                    Look for the <Share className="inline w-3 h-3" /> share icon at the bottom of Safari
                  </p>
                </div>
                <Share className="h-5 w-5 text-blue-500 flex-shrink-0" />
              </div>

              <div className="flex items-start gap-3 p-3 bg-purple-50 rounded-lg">
                <div className="w-6 h-6 bg-purple-500 text-white rounded-full flex items-center justify-center text-xs font-semibold flex-shrink-0">
                  2
                </div>
                <div className="flex-1">
                  <p className="text-sm font-medium">Find "Add to Home Screen"</p>
                  <p className="text-xs text-muted-foreground mt-1">
                    Scroll down in the share menu to find this option
                  </p>
                </div>
                <Plus className="h-5 w-5 text-purple-500 flex-shrink-0" />
              </div>

              <div className="flex items-start gap-3 p-3 bg-green-50 rounded-lg">
                <div className="w-6 h-6 bg-green-500 text-white rounded-full flex items-center justify-center text-xs font-semibold flex-shrink-0">
                  3
                </div>
                <div className="flex-1">
                  <p className="text-sm font-medium">Tap "Add"</p>
                  <p className="text-xs text-muted-foreground mt-1">
                    Confirm installation and Empower will appear on your home screen
                  </p>
                </div>
                <Home className="h-5 w-5 text-green-500 flex-shrink-0" />
              </div>
            </div>

            <div className="bg-gradient-to-r from-blue-50 to-purple-50 p-4 rounded-lg">
              <h4 className="text-sm font-semibold mb-2">✨ Benefits of Installing:</h4>
              <ul className="text-xs text-muted-foreground space-y-1">
                <li>• Works offline - access content without internet</li>
                <li>• Faster loading times and smoother performance</li>
                <li>• Push notifications for achievements and reminders</li>
                <li>• Native app experience with fullscreen display</li>
                <li>• Quick access from your home screen</li>
              </ul>
            </div>
          </>
        ) : (
          <>
            <div className="text-center">
              <p className="text-sm text-muted-foreground mb-4">
                Install Empower for offline access and native app experience!
              </p>
            </div>

            <div className="space-y-4">
              <div className="flex items-start gap-3 p-3 bg-blue-50 rounded-lg">
                <Download className="h-5 w-5 text-blue-500 flex-shrink-0 mt-0.5" />
                <div className="flex-1">
                  <p className="text-sm font-medium">Look for Install Prompt</p>
                  <p className="text-xs text-muted-foreground mt-1">
                    Your browser may show an install prompt. Click "Install" when it appears.
                  </p>
                </div>
              </div>

              <div className="flex items-start gap-3 p-3 bg-purple-50 rounded-lg">
                <ArrowRight className="h-5 w-5 text-purple-500 flex-shrink-0 mt-0.5" />
                <div className="flex-1">
                  <p className="text-sm font-medium">Alternative Method</p>
                  <p className="text-xs text-muted-foreground mt-1">
                    Look for three dots (⋮) or browser menu → "Install Empower" or "Add to Home Screen"
                  </p>
                </div>
              </div>
            </div>

            <div className="bg-gradient-to-r from-blue-50 to-purple-50 p-4 rounded-lg">
              <h4 className="text-sm font-semibold mb-2">🚀 Why Install?</h4>
              <ul className="text-xs text-muted-foreground space-y-1">
                <li>• Offline access to all your progress and content</li>
                <li>• Faster performance and loading times</li>
                <li>• Desktop shortcut for quick access</li>
                <li>• Background sync when you're back online</li>
              </ul>
            </div>
          </>
        )}

        <div className="flex gap-2">
          <Button
            variant="outline"
            className="flex-1"
            onClick={() => {
              // Copy installation URL
              navigator.clipboard.writeText(window.location.href);
              // Show toast would be nice here
            }}
          >
            Copy Link
          </Button>
          {onClose && (
            <Button onClick={onClose} className="flex-1">
              Continue Using Web App
            </Button>
          )}
        </div>

        <div className="text-center">
          <p className="text-xs text-muted-foreground">
            <strong>Note:</strong> Make sure you're using Safari on iOS or Chrome/Edge on Android for the best installation experience.
          </p>
        </div>
      </CardContent>
    </Card>
  );
}