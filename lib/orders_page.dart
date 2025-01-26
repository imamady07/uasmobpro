import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final List<Map<String, dynamic>> _orders = [
    {
      'orderId': '001',
      'customerName': 'ali',
      'date': '2025-01-23',
      'status': 'proses',
    },
    {
      'orderId': '002',
      'customerName': 'jamaika',
      'date': '2025-01-24',
      'status': 'menunggu',
    },
    {
      'orderId': '003',
      'customerName': 'imron',
      'date': '2025-01-25',
      'status': 'selesai',
    },
  ];

  final List<String> _statusOptions = ['menunggu', 'proses', 'selesai'];

  void _updateStatus(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Order Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _statusOptions.map((status) {
              return ListTile(
                title: Text(status),
                onTap: () {
                  setState(() {
                    _orders[index]['status'] = status;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _addOrder() {
    setState(() {
      _orders.add({
        'orderId': (int.parse(_orders.last['orderId']) + 1).toString().padLeft(3, '0'),
        'customerName': 'New Customer',
        'date': DateTime.now().toString().split(' ')[0],
        'status': 'menunggu',
      });
    });
  }

  void _editOrder(int index) {
    TextEditingController customerController =
    TextEditingController(text: _orders[index]['customerName']);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Order'),
          content: TextField(
            controller: customerController,
            decoration: InputDecoration(labelText: 'Customer Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _orders[index]['customerName'] = customerController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteOrder(int index) {
    setState(() {
      _orders.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addOrder,
          ),
        ],
      ),
      body: _orders.isEmpty
          ? Center(
        child: Text(
          'No orders available',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: order['status'] == 'selesai'
                    ? Colors.green
                    : order['status'] == 'proses'
                    ? Colors.orange
                    : Colors.red,
                child: Icon(
                  Icons.assignment,
                  color: Colors.white,
                ),
              ),
              title: Text('Order ID: ${order['orderId']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer: ${order['customerName']}'),
                  Text('Date: ${order['date']}'),
                  Text('Status: ${order['status']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editOrder(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteOrder(index),
                  ),
                ],
              ),
              onTap: () => _updateStatus(index),
            ),
          );
        },
      ),
    );
  }
}
