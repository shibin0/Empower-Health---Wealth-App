import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  // TODO: Replace with your actual Supabase URL and anon key
  static const String supabaseUrl = 'https://jqmixqegdtpgimhvovmy.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpxbWl4cWVnZHRwZ2ltaHZvdm15Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMwOTIyOTIsImV4cCI6MjA2ODY2ODI5Mn0.VhFIfpsW-w_IQA2gI8yUV9xWyc3j-oWyv0ECbZ9eGsc';
  
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      debug: true, // Set to false in production
    );
  }
  
  static SupabaseClient get client => Supabase.instance.client;
  static GoTrueClient get auth => Supabase.instance.client.auth;
}

// Global Supabase client instance
final supabase = SupabaseConfig.client;