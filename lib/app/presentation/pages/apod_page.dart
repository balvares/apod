import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/apod_provider.dart';

class ApodPage extends StatefulWidget {
  const ApodPage({super.key, required this.date});

  final DateTime date;

  @override
  State<ApodPage> createState() => _ApodPageState();
}

class _ApodPageState extends State<ApodPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<APODProvider>(context, listen: false).fetchAPOD(widget.date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<APODProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(DateFormat('MMM d, yyyy').format(widget.date)),
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(
                        provider.apod?.url ?? '',
                        errorBuilder: (context, error, stackTrace) {
                          return Container(); // Returns an empty container if there's an error
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(provider.apod?.title ?? '',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(provider.apod?.explanation ?? ''),
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => provider.fetchAPOD(DateTime.now()),
            child: const Icon(Icons.refresh),
          ),
        );
      },
    );
  }
}
