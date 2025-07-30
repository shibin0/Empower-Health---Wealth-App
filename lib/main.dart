import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/app_providers.dart';
import 'core/storage/hive_service.dart';
import 'utils/app_theme.dart';
import 'config/supabase_config.dart';
import 'widgets/simple_auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await HiveService.init();
  
  // Initialize Supabase
  await SupabaseConfig.initialize();
  
  runApp(const ProviderScope(child: EmpowerApp()));
}

class EmpowerApp extends ConsumerWidget {
  const EmpowerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    
    return MaterialApp(
      title: 'Empower',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const SimpleAuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}