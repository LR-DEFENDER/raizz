import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController dateController = TextEditingController();
    String? name;
    DateTime? date;
    double? amount;
    String? category;
    String? description;
    final List<String> categories = ['Hair', 'Other'];

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        setState(() {
          dateController.text = "${picked.toLocal()}".split(' ')[0];
        });
      }
    }

    return Column(
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
              const Text(
                'Raizz',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none))
            ]),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 10,
              height: 30,
              color: const Color(0xff00AEAD),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Add Expense',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
            ),
          ],
        ),
        SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
              child: Column(
                children: <Widget>[
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Name', style: TextStyle(fontSize: 16))),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      fillColor: const Color(0xff00AEAD).withOpacity(0.08),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      name = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Date', style: TextStyle(fontSize: 16))),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'dd-mm-yyyy',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => selectDate(context),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      fillColor: const Color(0xff00AEAD).withOpacity(0.08),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          date = pickedDate;
                        });
                      }
                    },
                    validator: (value) {
                      if (date == null) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                      text: date != null ? date.toString().split(' ')[0] : '',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Amount', style: TextStyle(fontSize: 16))),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter amount',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      fillColor: const Color(0xff00AEAD).withOpacity(0.08),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the amount';
                      }
                      try {
                        amount = double.parse(value);
                      } catch (e) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      amount = double.tryParse(value!);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child:
                          Text('Category', style: TextStyle(fontSize: 16))),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Choose Category',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      fillColor: const Color(0xff00AEAD).withOpacity(0.08),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        category = value;
                      });
                    },
                    onSaved: (value) {
                      category = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Description (Optional)',
                          style: TextStyle(fontSize: 16))),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter description',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      fillColor: const Color(0xff00AEAD).withOpacity(0.08),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 3,
                    onSaved: (value) {
                      description = value;
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
          child: SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff00AEAD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Border radius
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
