import { useState } from 'react';
import { Button } from './ui/button';
import { Alert, AlertDescription } from './ui/alert';
import { Chrome, Facebook, Loader } from 'lucide-react';
import { supabase } from '../utils/supabase/client';
import { toast } from 'sonner@2.0.3';

interface SocialLoginProps {
  onSuccess: (user: any, profile: any) => void;
  onError: (error: string) => void;
}

export function SocialLogin({ onSuccess, onError }: SocialLoginProps) {
  const [loading, setLoading] = useState<string | null>(null);

  const handleSocialLogin = async (provider: 'google' | 'facebook') => {
    setLoading(provider);

    try {
      const { data, error } = await supabase.auth.signInWithOAuth({
        provider,
        options: {
          redirectTo: window.location.origin,
          queryParams: {
            access_type: 'offline',
            prompt: 'consent',
          }
        }
      });

      if (error) {
        throw error;
      }

      // The actual authentication will happen in the redirect
      // We'll handle the session in the main app component
      toast.success(`Redirecting to ${provider} authentication...`);
      
    } catch (error: any) {
      console.error(`${provider} login error:`, error);
      setLoading(null);
      
      if (error.message?.includes('provider is not enabled')) {
        onError(`${provider} login is not configured. Please contact support or use email signup.`);
      } else {
        onError(error.message || `Failed to sign in with ${provider}`);
      }
    }
  };

  return (
    <div className="space-y-3">
      <div className="relative">
        <div className="absolute inset-0 flex items-center">
          <span className="w-full border-t" />
        </div>
        <div className="relative flex justify-center text-xs uppercase">
          <span className="bg-background px-2 text-muted-foreground">
            Or continue with
          </span>
        </div>
      </div>

      <div className="grid grid-cols-2 gap-3">
        <Button
          variant="outline"
          onClick={() => handleSocialLogin('google')}
          disabled={!!loading}
          className="h-10"
        >
          {loading === 'google' ? (
            <Loader className="h-4 w-4 animate-spin" />
          ) : (
            <Chrome className="h-4 w-4" />
          )}
          <span className="ml-2">Google</span>
        </Button>

        <Button
          variant="outline"
          onClick={() => handleSocialLogin('facebook')}
          disabled={!!loading}
          className="h-10"
        >
          {loading === 'facebook' ? (
            <Loader className="h-4 w-4 animate-spin" />
          ) : (
            <Facebook className="h-4 w-4" />
          )}
          <span className="ml-2">Facebook</span>
        </Button>
      </div>

      <Alert>
        <AlertDescription className="text-xs">
          <strong>Note:</strong> Social login requires additional setup in Supabase. 
          Follow the guides at{' '}
          <a 
            href="https://supabase.com/docs/guides/auth/social-login" 
            target="_blank" 
            rel="noopener noreferrer"
            className="text-primary hover:underline"
          >
            supabase.com/docs/guides/auth/social-login
          </a>
          {' '}to enable Google and Facebook authentication.
        </AlertDescription>
      </Alert>
    </div>
  );
}