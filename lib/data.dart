import 'package:flutter/material.dart';
import 'add.dart';
import 'package:supabase/supabase.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final supabase = SupabaseClient(
    'https://xyzcompany.supabase.co',
    'public-anon-key',
  );

  List<DataItem> dataItems = [
    DataItem(
      image: 'assets/burger_icon.jpg',
      title: 'Burger King Medium',
      price: 'Rp. 50.000,00',
      category: 'Food',
    ),
    DataItem(
      image: 'assets/teh_botol.jpg',
      title: 'Teh Botol',
      price: 'Rp. 4.000,00',
      category: 'Drink',
    ),
    DataItem(
      image: 'assets/burger_icon.jpg',
      title: 'Burger King Small',
      price: 'Rp. 35.000,00',
      category: 'Food',
    ),
  ];

  void _removeItem(int index) {
    setState(() {
      dataItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Data'),
      ),
      body: Column(
        children: [
          // Align Add Data Button to the Left
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddDataPage()),
                    );

                    if (result != null && result is DataItem) {
                      setState(() {
                        dataItems.add(result);
                      });
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Data'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: DataItemWidget(
                    item: dataItems[index],
                    onDelete: () => _removeItem(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DataItem {
  final String image;
  final String title;
  final String price;
  final String category;

  DataItem({
    required this.image,
    required this.title,
    required this.price,
    required this.category,
  });
}

class DataItemWidget extends StatelessWidget {
  final DataItem item;
  final VoidCallback onDelete;

  const DataItemWidget({
    Key? key,
    required this.item,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              item.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.price,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
