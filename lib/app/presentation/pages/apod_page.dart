import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/apod_provider.dart';

class ApodPage extends StatefulWidget {
  const ApodPage({super.key});

  @override
  State<ApodPage> createState() => _ApodPageState();
}

class _ApodPageState extends State<ApodPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<APODProvider>(context, listen: false).fetchAPOD();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Astronomy Picture of the Day 🪐")),
      body: Consumer<APODProvider>(
        builder: (context, provider, child) {
          return provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(provider.apod!.url),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(provider.apod!.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(provider.apod!.explanation),
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
