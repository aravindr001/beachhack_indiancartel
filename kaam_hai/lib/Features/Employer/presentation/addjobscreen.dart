import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _jobNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _wageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _otherWorkTypeController =
      TextEditingController();

  DateTime? _selectedDate;
  String _selectedWorkType = 'Construction';
  bool _showOtherWorkType = false;

  final List<String> _workTypes = [
    'Construction',
    'Farming',
    'Domestic Work',
    'Driving',
    'Electrician',
    'Other',
  ];

  // Color Scheme
  final Color _primaryColor = Colors.black;
  final Color _backgroundColor = Colors.white;
  final Color _textColor = Colors.black;
  final Color _borderColor = const Color(0xFFD1D1D6);

  Future<void> _submitJob() async {
  if (_formKey.currentState!.validate()) {
    try {
      final workType = _selectedWorkType == 'Other'
          ? _otherWorkTypeController.text
          : _selectedWorkType;

      final response = await http.post(
        Uri.parse('https://sms-new.onrender.com/addJob'), // Replace with your server URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'jobName': _jobNameController.text,
          'phone': _phoneController.text,
          'address': _addressController.text,
          'pincode': _pincodeController.text,
          'wage': _wageController.text,
          'workType': workType,
          'description': _descriptionController.text,
        }),
      );
      print('database updated');
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job posted successfully!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error posting job: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error posting job: $e')),
      );
    }
  }
}

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      filled: true,
      fillColor: _backgroundColor,
      labelText: label,
      labelStyle: TextStyle(color: _textColor.withOpacity(0.6)),
      floatingLabelStyle: TextStyle(color: _primaryColor),
      prefixIcon: Icon(icon, color: _textColor.withOpacity(0.6)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: _borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: _borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: _primaryColor, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Post New Job',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: _backgroundColor,
        elevation: 0.5,
        iconTheme: IconThemeData(color: _textColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Job Name Field
              TextFormField(
                controller: _jobNameController,
                style: TextStyle(color: _textColor),
                decoration: _buildInputDecoration('Job Title', Icons.title),
                validator:
                    (value) => value!.isEmpty ? 'Please enter job title' : null,
              ),
              const SizedBox(height: 20),

              // Phone Number
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: _textColor),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: _buildInputDecoration(
                  'Phone Number',
                  Icons.phone,
                ).copyWith(hintText: '10-digit mobile number'),
                validator:
                    (value) =>
                        value!.length != 10 ? 'Enter valid phone number' : null,
              ),
              const SizedBox(height: 20),

              // Address
              TextFormField(
                controller: _addressController,
                maxLines: 2,
                style: TextStyle(color: _textColor),
                decoration: _buildInputDecoration(
                  'Full Address',
                  Icons.location_on,
                ),
                validator:
                    (value) => value!.isEmpty ? 'Address required' : null,
              ),
              const SizedBox(height: 20),

              // Pincode
              TextFormField(
                controller: _pincodeController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: _textColor),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: _buildInputDecoration('Pincode', Icons.map),
                validator:
                    (value) => value!.isEmpty ? 'Pincode required' : null,
              ),
              const SizedBox(height: 20),

              // Work Type Dropdown
              InputDecorator(
                decoration: _buildInputDecoration(
                  'Job Type',
                  Icons.work,
                ).copyWith(prefixIcon: null),
                child: DropdownButtonFormField<String>(
                  value: _selectedWorkType,
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down, color: _textColor),
                  style: TextStyle(color: _textColor, fontSize: 16),
                  dropdownColor: _backgroundColor,
                  items:
                      _workTypes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: _textColor),
                          ),
                        );
                      }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedWorkType = newValue!;
                      _showOtherWorkType = newValue == 'Other';
                      if (!_showOtherWorkType) {
                        _otherWorkTypeController.clear();
                      }
                    });
                  },
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              if (_showOtherWorkType) ...[
                const SizedBox(height: 10),
                TextFormField(
                  controller: _otherWorkTypeController,
                  style: TextStyle(color: _textColor),
                  decoration: _buildInputDecoration(
                    'Specify Job Type',
                    Icons.edit,
                  ),
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Please specify job type' : null,
                ),
                const SizedBox(height: 10),
              ],
              const SizedBox(height: 20),

              // Date Picker
              GestureDetector(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: _buildInputDecoration(
                    'Select Date',
                    Icons.calendar_today,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.calendar_today,
                      color: _textColor.withOpacity(0.6),
                    ),
                    title: Text(
                      _selectedDate == null
                          ? 'Choose date'
                          : DateFormat('dd MMM yyyy').format(_selectedDate!),
                      style: TextStyle(
                        color:
                            _selectedDate == null
                                ? _textColor.withOpacity(0.6)
                                : _textColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Daily Wage
              TextFormField(
                controller: _wageController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: _textColor),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: _buildInputDecoration(
                  'Daily Wage (₹)',
                  Icons.currency_rupee,
                ),
                validator:
                    (value) => value!.isEmpty ? 'Enter daily wage' : null,
              ),
              const SizedBox(height: 20),

              // Job Description
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                style: TextStyle(color: _textColor),
                decoration: _buildInputDecoration(
                  'Job Description',
                  Icons.description,
                ),
              ),
              const SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: _submitJob,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'POST JOB',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
