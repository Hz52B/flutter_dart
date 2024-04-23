import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tap Hoa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SampleItemListView(),
    );
  }
}

class SampleItem {
  String id;
  ValueNotifier<String> name;
  double price;
  String description;
  DateTime createdAt;

  SampleItem({
    String? id,
    required String name,
    required this.price,
    required this.description,
    DateTime? createdAt
  }) : id = id ?? generateluid(),
      name = ValueNotifier(name),
      createdAt = createdAt ?? DateTime.now();

  static String generateluid() {
    return "${Random().nextInt(1000000000)}";
  }
}

class SampleItemViewModel extends ChangeNotifier {
  static final _instance = SampleItemViewModel._();
  factory SampleItemViewModel() => _instance;
  SampleItemViewModel._();
  final List<SampleItem> items = [];

  void addItem(String name, double price, String description) {
    items.add(SampleItem(name: name, price: price, description: description));
    notifyListeners();
  }

  void removeItem(String id) {
    items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateItem(String id, String newName, double newPrice, String newDescription) {
  try {
    final item = items.firstWhere((item) => item.id == id);
    item.name.value = newName;
    item.price = newPrice;
    item.description = newDescription;
    notifyListeners();
  } catch (e) {
    debugPrint("Không tìm thấy mục với ID $id");
  }
}
}

class SampleItemUpdate extends StatefulWidget {
  final String? initialName;
  final double? initialPrice;
  final String? initialDescription;
  
  const SampleItemUpdate({
    super.key, 
    this.initialName, 
    this.initialPrice, 
    this.initialDescription
  });

  @override
  State<SampleItemUpdate> createState() => _SampleItemUpdateState();
}

class _SampleItemUpdateState extends State<SampleItemUpdate> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName ?? '');
    priceController = TextEditingController(text: widget.initialPrice?.toString() ?? '');
    descriptionController = TextEditingController(text: widget.initialDescription ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialName != null ? 'Chỉnh sửa' : 'Thêm mới'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (nameController.text.isNotEmpty && priceController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                final name = nameController.text;
                final price = double.tryParse(priceController.text) ?? 0.0;
                final description = descriptionController.text;
                Navigator.pop(context, [name, price, description]);
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Tên sản phẩm'),
          ),
          TextFormField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Giá'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Mô tả'),
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class SampleItemListView extends StatefulWidget {
  const SampleItemListView({super.key});

  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  final viewModel = SampleItemViewModel();
  late TextEditingController searchController;
  List<SampleItem> filteredItems = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredItems.addAll(viewModel.items);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _addItem(String name, double price, String description) {
    viewModel.addItem(name, price, description);
    setState(() {
      filteredItems = viewModel.items;
    });
  }

  void _toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        searchController.clear();
        filteredItems = viewModel.items;
      }
    });
  }

  Future<void> _showDeleteConfirmationDialog(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có chắc muốn xóa sản phẩm này không?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Xóa'),
              onPressed: () {
                Navigator.of(context).pop();
                viewModel.removeItem(id);
                setState(() {
                  filteredItems = viewModel.items;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    filteredItems = viewModel.items
                        .where((item) =>
                            item.name.value
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                        .toList();
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Nhập tên sản phẩm bạn muốn tìm kiếm',
                  border: InputBorder.none,
                ),
              )
            : const Text('Tạp hóa'),
        actions: [
          IconButton(
            icon: isSearching ? const Icon(Icons.close) : const Icon(Icons.search),
            onPressed: () {
              _toggleSearch();
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet<List<dynamic>?>(
                context: context,
                builder: (context) => const SampleItemUpdate(),
              ).then((value) {
                if (value != null) {
                  _addItem(value[0], value[1], value[2]);
                }
              });
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, _) {
          return ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              return ListTile(
                leading: const Icon(Icons.image), 
                title: Text('Tên: ${item.name.value}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Giá: ${item.price}'),
                    Text('Mô tả: ${item.description}'),
                  ],
                ),
                onTap: () {
                  showModalBottomSheet<List<dynamic>?>(
                    context: context,
                    builder: (context) => SampleItemUpdate(
                      initialName: item.name.value,
                      initialPrice: item.price,
                      initialDescription: item.description,
                    ),
                  ).then((value) {
                    if (value != null) {
                      viewModel.updateItem(item.id, value[0], value[1] as double, value[2] as String);
                    }
                  });
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _showDeleteConfirmationDialog(item.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
