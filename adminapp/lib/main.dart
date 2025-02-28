import 'package:adminapp/dashboard.dart';
import 'package:flutter/material.dart';


import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://nnmmmvjxrhkdxyfgpdqw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ubW1tdmp4cmhrZHh5ZmdwZHF3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY5MTMxNTMsImV4cCI6MjA1MjQ4OTE1M30.QGczvfcYHRygeAun7oX67lv7DKI0kLwUjT_GO3cm_cw',
  );
  runApp(MainApp());
}


final supabase=Supabase.instance.client;
        
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:DashBoard()
    );
  }
}
