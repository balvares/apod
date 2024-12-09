import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/apod_provider.dart';

class ApodListPage extends StatefulWidget {
  const ApodListPage({super.key});

  @override
  State<ApodListPage> createState() => _ApodListPageState();
}

class _ApodListPageState extends State<ApodListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<APODProvider>(context, listen: false).fetchAPODList();
    });
  }

  final List<String> imageUrls = [
    'https://picsum.photos/id/1018/1000/600',
    'https://picsum.photos/id/1015/1000/600',
    'https://picsum.photos/id/1019/1000/600',
    // Add more image URLs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView Example'),
      ),
      body: ListView.builder(
        itemCount:
            imageUrls.length, // Change this to the desired number of items
        itemBuilder: (context, index) {
          return ListItem(
            imageUrl: imageUrls[index % imageUrls.length],
            date: DateTime.now().add(Duration(days: index)),
          );
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String imageUrl;
  final DateTime date;

  const ListItem({
    super.key,
    required this.imageUrl,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                DateFormat('MMM d, yyyy').format(date),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: ElevatedButton(
              onPressed: () {
                // Add button functionality here
                print(
                    'Button pressed for date: ${DateFormat('MMM d, yyyy').format(date)}');
              },
              child: const Text('Details'),
            ),
          ),
        ],
      ),
    );
  }
}