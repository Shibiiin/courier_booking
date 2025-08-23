import 'package:courier_booking/Courier%20Booking/presentation/manager/dashboard_controller.dart';
import 'package:courier_booking/Courier%20Booking/presentation/theme/appColors.dart';
import 'package:courier_booking/Courier%20Booking/presentation/widgets/common/custom_toast.dart';
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
  late final FocusNode _senderNameFocusNode;
  late final FocusNode _senderPhoneFocusNode;
  late final FocusNode _senderAddressFocusNode;
  late final FocusNode _receiverNameFocusNode;
  late final FocusNode _receiverPhoneFocusNode;
  late final FocusNode _receiverAddressFocusNode;
  late final FocusNode _packageWeightFocusNode;

  @override
  void initState() {
    super.initState();

    _senderNameFocusNode = FocusNode();
    _senderPhoneFocusNode = FocusNode();
    _senderAddressFocusNode = FocusNode();
    _receiverNameFocusNode = FocusNode();
    _receiverPhoneFocusNode = FocusNode();
    _receiverAddressFocusNode = FocusNode();
    _packageWeightFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // 3. Dispose of the Focus Nodes to prevent memory leaks
    _senderNameFocusNode.dispose();
    _senderPhoneFocusNode.dispose();
    _senderAddressFocusNode.dispose();
    _receiverNameFocusNode.dispose();
    _receiverPhoneFocusNode.dispose();
    _receiverAddressFocusNode.dispose();
    _packageWeightFocusNode.dispose();
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
            controller.clearBookingDetails();
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
              10.height,
              LabelCustomTextField(
                controller: controller.senderNameController,
                hintText: 'Enter sender name',
                textFieldLabel: 'Sender Name',
                focusNode: _senderNameFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmit: (_) {
                  FocusScope.of(context).requestFocus(_senderPhoneFocusNode);
                },
              ),
              LabelCustomTextField(
                controller: controller.senderPhoneController,
                hintText: 'Enter sender phone',
                textFieldLabel: 'Sender Phone',
                inputType: TextInputType.phone,
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                focusNode: _senderPhoneFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmit: (_) {
                  FocusScope.of(context).requestFocus(_senderAddressFocusNode);
                },
              ),
              LabelCustomTextField(
                controller: controller.senderAddressController,
                hintText: 'Enter sender address',
                textFieldLabel: 'Sender Address',
                lines: 2,
                focusNode: _senderAddressFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmit: (_) {
                  FocusScope.of(context).requestFocus(_receiverNameFocusNode);
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
                focusNode: _receiverNameFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmit: (_) {
                  FocusScope.of(context).requestFocus(_receiverPhoneFocusNode);
                },
              ),
              LabelCustomTextField(
                controller: controller.receiverPhoneController,
                hintText: 'Enter receiver phone',
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                textFieldLabel: 'Receiver Phone',
                inputType: TextInputType.phone,
                focusNode: _receiverPhoneFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmit: (_) {
                  FocusScope.of(
                    context,
                  ).requestFocus(_receiverAddressFocusNode);
                },
              ),
              LabelCustomTextField(
                controller: controller.receiverAddressController,
                hintText: 'Enter receiver address',
                textFieldLabel: 'Receiver Address',
                lines: 2,
                focusNode: _receiverAddressFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmit: (_) {
                  FocusScope.of(context).requestFocus(_packageWeightFocusNode);
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
                  focusNode: _packageWeightFocusNode,
                  textInputAction: TextInputAction.done,
                  onFieldSubmit: (_) {
                    FocusScope.of(context).unfocus();
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
              ),
              TextFormField(
                controller: controller.pickupTimeController,
                decoration: const InputDecoration(
                  labelText: 'Pickup Time',
                  suffixIcon: Icon(Icons.access_time),
                ),
                readOnly: true,
                onTap: () => controller.selectTime(controller, context),
              ),
              20.height,
              ElevatedButton(
                onPressed: () {
                  if (controller.senderNameController.text.isEmpty) {
                    showCustomToast("Please enter the Sender Name");
                  } else if (controller.senderPhoneController.text.isEmpty) {
                    showCustomToast("Please enter the Sender Phone");
                  } else if (controller.senderAddressController.text.isEmpty) {
                    showCustomToast("Please enter the Sender Address");
                  } else if (controller.receiverNameController.text.isEmpty) {
                    showCustomToast("Please enter the Receiver Name");
                  } else if (controller.receiverPhoneController.text.isEmpty) {
                    showCustomToast("Please enter the Receiver Phone");
                  } else if (!RegExp(
                    r'^\d{10}$', // Simple 10-digit phone regex
                  ).hasMatch(controller.receiverPhoneController.text)) {
                    showCustomToast(
                      'Please enter a valid 10-digit phone number',
                    );
                  } else if (controller
                      .receiverAddressController
                      .text
                      .isEmpty) {
                    showCustomToast("Please enter the Receiver Address");
                  } else if (controller.packageWeightController.text.isEmpty) {
                    showCustomToast("Please enter the Package Weight");
                  } else if (double.tryParse(
                        controller.packageWeightController.text,
                      ) ==
                      null) {
                    showCustomToast('Please enter a valid number for weight');
                  } else if (controller.pickupDateController.text.isEmpty) {
                    showCustomToast("Please select a pickup date");
                  } else if (controller.pickupTimeController.text.isEmpty) {
                    showCustomToast("Please select a pickup time");
                  } else {
                    controller.submitForm(controller, context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Book Courier',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
              10.height,
            ],
          ),
        ),
      ),
    );
  }
}
