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
  DateTime? _startDate;
  DateTime? _endDate;
  String _filterType = 'Date Range';
  

  @override
  Widget build(BuildContext context) {
    return Consumer<APODProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Astronomy Picture of the Day 🪐',
            imageUrl: provider.todayApod?.url ?? '',
            opacity: 0.7,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dropdown para selecionar o tipo de filtro
                    DropdownButton<String>(
                      value: _filterType,
                      items: <String>['Date Range', 'Name'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _filterType = newValue!;
                          _startDate = null;
                          _endDate = null;
                          provider.nameController.clear();
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    // Exibe campos diferentes com base no tipo de filtro selecionado
                    if (_filterType == 'Date Range') ...[
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: _startDate ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (selectedDate != null) {
                                  setState(() {
                                    _startDate = selectedDate;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _startDate == null
                                      ? 'Start Date'
                                      : _startDate!
                                          .toLocal()
                                          .toString()
                                          .split(' ')[0],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _startDate == null
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: _endDate ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (selectedDate != null) {
                                  setState(() {
                                    _endDate = selectedDate;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _endDate == null
                                      ? 'End Date'
                                      : _endDate!
                                          .toLocal()
                                          .toString()
                                          .split(' ')[0],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _endDate == null
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_startDate != null && _endDate != null) {
                            provider.fetchAPODListWithFilter(
                              startDate: _startDate!,
                              endDate: _endDate!,
                            );
                          }
                        },
                        child: const Text('Search'),
                      ),
                    ] else if (_filterType == 'Name') ...[
                      TextField(
                        controller: provider.nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (provider.nameController.text.isNotEmpty) {
                            provider.fetchAPODListByName(
                              name: provider.nameController.text,
                            );
                          }
                        },
                        child: const Text('Search'),
                      ),
                    ],
                  ],
                ),
              ),
              provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : provider.apodList.isEmpty
                      ? const Center(child: Text('No data available'))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: provider.apodList.length,
                            itemBuilder: (context, index) {
                              return ListItem(
                                imageUrl: provider.apodList[index].url,
                                date: DateTime.parse(
                                    provider.apodList[index].date),
                              );
                            },
                          ),
                        ),
            ],
          ),
        );
      },
    );
  }
}
