import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InfoContent(),
    );
  }
}

class InfoContent extends StatefulWidget {
  @override
  _InfoContentState createState() => _InfoContentState();
}

class _InfoContentState extends State<InfoContent> {
  int _selectedCategoryIndex = 0;

  // Данные категорий и элементов
  final List<String> _categories = [
    'Общие документы',
    'Рекламные материалы',
    'Прайсы',
  ];

  final List<List<Map<String, String>>> _items = [
    [
      {'Название': 'Документ 1', 'Описание': 'Описание документа 1'},
      {'Название': 'Документ 2', 'Описание': 'Описание документа 2'},
    ],
    [
      {'Название': 'Материал 1', 'Описание': 'Описание материала 1'},
      {'Название': 'Материал 2', 'Описание': 'Описание материала 2'},
    ],
    [
      {'Название': 'Прайс 1', 'Описание': 'Описание прайса 1'},
      {'Название': 'Прайс 2', 'Описание': 'Описание прайса 2'},
    ],
  ];

  // Добавление нового элемента
  void _addItem() {
    setState(() {
      _items[_selectedCategoryIndex].add({
        'Название': 'Новый элемент',
        'Описание': 'Новое описание',
      });
    });
  }

  // Удаление элемента
  void _removeItem(int index) {
    setState(() {
      _items[_selectedCategoryIndex].removeAt(index);
    });
  }

  // Построение таблицы с элементами
  Widget _buildTable() {
    List<DataRow> rows = _items[_selectedCategoryIndex].map((item) {
      int index = _items[_selectedCategoryIndex].indexOf(item);
      return DataRow(
        cells: [
          DataCell(Text(item['Название']!)),
          DataCell(Text(item['Описание']!)),
          DataCell(
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeItem(index),
            ),
          ),
        ],
      );
    }).toList();

    return DataTable(
      columns: const [
        DataColumn(label: Text('Название')),
        DataColumn(label: Text('Описание')),
        DataColumn(label: Text('Действия')),
      ],
      rows: rows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Список категорий
        Container(
          width: 220,
          color: Color(0xFFFFF1E9),
          child: ListView.builder(
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                  color: _selectedCategoryIndex == index
                      ? Colors.orange
                      : Colors.transparent,
                  child: Text(
                    _categories[index],
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Содержимое выбранной категории
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: Colors.brown, thickness: 1.5),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(child: _buildTable()),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addItem,
                  child: Text('Добавить элемент'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}