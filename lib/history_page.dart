import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  // Contoh data histori pesanan
  final List<Map<String, String>> _orderHistory = [
    {
      'orderId': '001',
      'customer': 'ali',
      'date': '2025-01-20',
      'status': 'Completed',
    },
    {
      'orderId': '002',
      'customer': 'Jamaika',
      'date': '2025-01-21',
      'status': 'Cancelled',
    },
    {
      'orderId': '003',
      'customer': 'imron',
      'date': '2025-01-22',
      'status': 'Completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order History')),
      body: _orderHistory.isEmpty
          ? Center(
        child: Text('No history available.'),
      )
          : ListView.builder(
        itemCount: _orderHistory.length,
        itemBuilder: (context, index) {
          final order = _orderHistory[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text('Order ID: ${order['orderId']}'),
              subtitle: Text(
                'Customer: ${order['customer']}\nDate: ${order['date']}\nStatus: ${order['status']}',
              ),
            ),
          );
        },
      ),
    );
  }
}
