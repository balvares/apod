import 'package:flutter/material.dart';

import 'presentation/pages/apod_page.dart';

class APODApp extends StatelessWidget {
  const APODApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ApodPage(),
    );
  }
}
