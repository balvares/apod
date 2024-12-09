import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../providers/apod_provider.dart';

class ApodPage extends StatefulWidget {
  const ApodPage({super.key});

  @override
  State<ApodPage> createState() => _ApodPageState();
}

class _ApodPageState extends State<ApodPage> {
  final globalVars = GetIt.instance<APODProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<APODProvider>(
        builder: (context, provider, child) {
          return provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(provider.apod.url),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(provider.apod.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(provider.apod.explanation),
                      ),
                    ],
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Provider.of<APODProvider>(context, listen: false).fetchAPOD(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
