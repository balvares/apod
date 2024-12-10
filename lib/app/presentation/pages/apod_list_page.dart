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
          floatingActionButton: ElevatedButton.icon(
            onPressed: () {
              provider.toggleFilters();
            },
            icon: const Icon(Icons.filter_list_alt),
            label: const Text('Show/hide filters'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          body: Column(
            children: [
              provider.showFilterSection
                  ? _filterSection(provider)
                  : const SizedBox(),
              _listSection(provider),
            ],
          ),
        );
      },
    );
  }

  Widget _filterSection(APODProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dropdown(provider),
          const SizedBox(height: 16),
          if (_filterType == 'Date Range')
            ..._dateRangeSection(provider)
          else
            ..._nameSection(provider),
        ],
      ),
    );
  }

  Widget _dropdown(APODProvider provider) {
    return Row(
      children: [
        const Text('Filter by:'),
        const SizedBox(width: 16),
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
      ],
    );
  }

  List<Widget> _dateRangeSection(APODProvider provider) {
    return [
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _startDate == null
                      ? 'Start Date'
                      : _startDate!.toLocal().toString().split(' ')[0],
                  style: TextStyle(
                    fontSize: 16,
                    color: _startDate == null ? Colors.grey : Colors.black,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _endDate == null
                      ? 'End Date'
                      : _endDate!.toLocal().toString().split(' ')[0],
                  style: TextStyle(
                    fontSize: 16,
                    color: _endDate == null ? Colors.grey : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _searchButton(provider),
          const SizedBox(width: 16),
          _clearFiltersButton(provider),
        ],
      ),
    ];
  }

  List<Widget> _nameSection(APODProvider provider) {
    return [
      TextField(
        controller: provider.nameController,
        decoration: const InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 8),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _searchButton(provider),
          const SizedBox(width: 16),
          _clearFiltersButton(provider),
        ],
      ),
    ];
  }

  Widget _searchButton(APODProvider provider) {
    return ElevatedButton.icon(
      onPressed: () {
        if (provider.nameController.text.isNotEmpty) {
          provider.fetchAPODListByName(
            name: provider.nameController.text,
          );
        } else if (_startDate != null && _endDate != null) {
          provider.fetchAPODListWithFilter(
            startDate: _startDate ?? DateTime.now(),
            endDate: _endDate ?? DateTime.now(),
          );
        } else {
          provider.fetchAPODList();
        }
      },
      icon: const Icon(Icons.search),
      label: const Text('Search'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _clearFiltersButton(APODProvider provider) {
    return ElevatedButton.icon(
      onPressed: () {
        provider.nameController.text = "";
        _startDate = null;
        _endDate = null;
        provider.fetchAPODList();
      },
      icon: const Icon(Icons.clear),
      label: const Text('Reset filters'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _listSection(APODProvider provider) {
    return provider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : provider.apodList.isEmpty
            ? const Center(child: Text('No data available'))
            : Expanded(
                child: ListView.builder(
                  itemCount: provider.apodList.length,
                  itemBuilder: (context, index) {
                    return ListItem(
                      imageUrl: provider.apodList[index].url,
                      date: DateTime.parse(provider.apodList[index].date),
                      name: provider.apodList[index].title,
                    );
                  },
                ),
              );
  }
}
