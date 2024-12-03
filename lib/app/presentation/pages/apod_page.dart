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
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<APODProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Astronomy Picture of the Day 🪐")),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
              ? Center(child: Text(provider.error!))
              : provider.apod != null
                  ? SingleChildScrollView(
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
                    )
                  : const SizedBox.shrink(),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.fetchAPOD,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
