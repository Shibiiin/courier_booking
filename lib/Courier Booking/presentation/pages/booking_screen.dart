import 'package:courier_booking/Courier%20Booking/presentation/manager/dashboard_controller.dart';
import 'package:courier_booking/Courier%20Booking/presentation/theme/appColors.dart';
import 'package:courier_booking/Courier%20Booking/presentation/widgets/common/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/common/custom_textfield.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final DashBoardController controller = DashBoardController();
  @override
  void dispose() {
    controller.clearBookingDetails();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DashBoardController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back, color: AppColors.white),
        ),
        centerTitle: true,
        title: Text('Book Courier', style: TextStyle(color: AppColors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              const Text(
                'Sender Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              LabelCustomTextField(
                controller: controller.senderNameController,
                hintText: 'Enter sender name',
                textFieldLabel: 'Sender Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter sender name';
                  }
                  return null;
                },
              ),
              LabelCustomTextField(
                controller: controller.senderPhoneController,
                hintText: 'Enter sender phone',
                textFieldLabel: 'Sender Phone',
                inputType: TextInputType.phone,
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter sender phone';
                  }
                  return null;
                },
              ),
              LabelCustomTextField(
                controller: controller.senderAddressController,
                hintText: 'Enter sender address',
                textFieldLabel: 'Sender Address',
                lines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter sender address';
                  }
                  return null;
                },
              ),
              20.height,
              const Text(
                'Receiver Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              LabelCustomTextField(
                controller: controller.receiverNameController,
                hintText: 'Enter receiver name',
                textFieldLabel: 'Receiver Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter receiver name';
                  }
                  return null;
                },
              ),
              LabelCustomTextField(
                controller: controller.receiverPhoneController,
                hintText: 'Enter receiver phone',
                textFieldLabel: 'Receiver Phone',
                inputType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter receiver phone';
                  }
                  if (!RegExp(
                    r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              LabelCustomTextField(
                controller: controller.receiverAddressController,
                hintText: 'Enter receiver address',
                textFieldLabel: 'Receiver Address',
                lines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter receiver address';
                  }
                  return null;
                },
              ),
              20.height,
              const Text(
                'Package Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Consumer<DashBoardController>(
                builder: (context, value, child) => LabelCustomTextField(
                  controller: controller.packageWeightController,
                  hintText: 'e.g., 5.5',
                  textFieldLabel: 'Package Weight (kg)',
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter package weight';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onchanged: () {},
                ),
              ),
              if (controller.packageWeightController.text.isNotEmpty)
                Consumer(
                  builder: (context, value, child) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Estimated Price: \$${controller.estimatedPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              TextFormField(
                controller: controller.pickupDateController,
                decoration: const InputDecoration(
                  labelText: 'Pickup Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => controller.selectDate(controller, context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a pickup date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.pickupTimeController,
                decoration: const InputDecoration(
                  labelText: 'Pickup Time',
                  suffixIcon: Icon(Icons.access_time),
                ),
                readOnly: true,
                onTap: () => controller.selectTime(controller, context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a pickup time';
                  }
                  return null;
                },
              ),
              20.height,
              ElevatedButton(
                onPressed: () => controller.submitForm(controller, context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Book Courier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
