import 'package:exam_flutter/firebase/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../second/NewExpenseScreen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final List<Map<String, String>> expenses = [
    {'name': 'Groceries', 'amount': '20.00'},
    {'name': 'Transport', 'amount': '10.50'},
    {'name': 'Dining Out', 'amount': '30.00'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff6e24b),
        automaticallyImplyLeading: false,
        title: Text('Expense Tracker', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Implement settings functionality
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xfff6e24b),
        onPressed: () {
          Get.to(() => NewExpenseScreen());
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.h),
        child: expenses.isEmpty
            ? Center(
          child: Text(
            'No expenses added yet.',
            style: TextStyle(fontSize: 18.h, color: Colors.grey),
          ),
        )
            : ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            final expense = expenses[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0.h),
              child: ListTile(
                title: Text(expense['name']!),
                subtitle: Text('\$${expense['amount']}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, index);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Expense'),
          content: Text('Are you sure you want to delete this expense?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
                Get.snackbar('Deleted', 'Expense deleted successfully',
                    snackPosition: SnackPosition.BOTTOM);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
