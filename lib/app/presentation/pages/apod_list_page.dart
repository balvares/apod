import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/apod_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/list_item.dart';

class ApodListPage extends StatefulWidget {
  const ApodListPage({super.key});

  @override
  State<ApodListPage> createState() => _ApodListPageState();
}

class _ApodListPageState extends State<ApodListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<APODProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Astronomy Picture of the Day 🪐',
            imageUrl: provider.apod?.url ?? '',
            opacity: 0.7,
          ),
          body: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : provider.apodList.isEmpty
                  ? const Center(child: Text('No data available'))
                  : ListView.builder(
                      itemCount: provider.apodList.length,
                      itemBuilder: (context, index) {
                        return ListItem(
                          imageUrl: provider.apodList[index].url,
                          date: DateTime.parse(provider.apodList[index].date),
                        );
                      },
                    ),
        );
      },
    );
  }
}
