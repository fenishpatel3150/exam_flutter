import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewExpenseScreen extends StatelessWidget {
  const NewExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff6e24b),
        title: Text('New Expense', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Field
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter your Food Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Amount Field
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter the amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Date Field
            TextFormField(
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Select date',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                // Date Picker
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  dateController.text = pickedDate.toLocal().toString().split(' ')[0];
                }
              },
            ),
            SizedBox(height: 16.h),

            TextFormField(
              controller: categoryController,
              decoration: InputDecoration(
                hintText: 'Enter category (e.g., Food, Transport)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            SizedBox(height: 32.h), // Spacing before the button

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String title = titleController.text;
                  String amount = amountController.text;
                  String date = dateController.text;
                  String category = categoryController.text;

                  if (title.isNotEmpty && amount.isNotEmpty && date.isNotEmpty && category.isNotEmpty) {
                    Get.back(); // Close the screen after saving
                  } else {
                    Get.snackbar('Error', 'Please fill all fields', snackPosition: SnackPosition.BOTTOM);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xfff6e24b),
                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Text('Add Expense', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
