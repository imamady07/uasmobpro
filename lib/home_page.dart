import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final int totalOrders = 5; // Contoh jumlah total order
  final int completedOrders = 3; // Contoh jumlah order yang selesai
  final int totalHistory = 20; // Contoh jumlah total riwayat

  // Contoh data histori pesanan terbaru
  final List<Map<String, String>> recentHistory = [
    {
      'orderId': '003',
      'customer': 'klompok3',
      'date': '2025-01-22',
      'status': 'Selesai',
    },
    {
      'orderId': '002',
      'customer': 'Jamaika',
      'date': '2025-01-21',
      'status': 'batal',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Home Page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildSummaryCard(
              title: 'Orders',
              subtitle: 'Total: $totalOrders | Completed: $completedOrders',
              icon: Icons.list_alt,
              color: Colors.blue,
              onTap: () {
                Navigator.pushNamed(context, '/orders');
              },
            ),
            SizedBox(height: 16),
            _buildSummaryCard(
              title: 'History',
              subtitle: '$totalHistory entries',
              icon: Icons.history,
              color: Colors.green,
              onTap: () {
                Navigator.pushNamed(context, '/history');
              },
            ),
            SizedBox(height: 20),
            Text(
              'Recent History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: recentHistory.length,
                itemBuilder: (context, index) {
                  final history = recentHistory[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('Order ID: ${history['orderId']}'),
                      subtitle: Text(
                        'Customer: ${history['customer']}\nDate: ${history['date']}\nStatus: ${history['status']}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: Icon(icon, color: Colors.white),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
