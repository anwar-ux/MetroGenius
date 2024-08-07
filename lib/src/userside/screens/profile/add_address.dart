import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/profile/bloc/add_addres/add_address_bloc.dart';
import 'package:metrogeniusorg/src/widgets/circular.dart';
import 'package:metrogeniusorg/src/widgets/custom_button.dart';
import 'package:metrogeniusorg/src/widgets/custom_textfield.dart';
import 'package:metrogeniusorg/src/widgets/snak_bar.dart';
import 'package:metrogeniusorg/utils/constants.dart';
import 'package:metrogeniusorg/utils/validations.dart';

class AddAddress extends StatelessWidget {
  AddAddress({super.key});
  final usernameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final areaFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final pincodeFocusNode = FocusNode();
  final houseFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            usernameFocusNode.unfocus();
            phoneFocusNode.unfocus();
            areaFocusNode.unfocus();
            cityFocusNode.unfocus();
            pincodeFocusNode.unfocus();
            houseFocusNode.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: BlocConsumer<AddAddressBloc, AddAddressState>(
              listener: (context, state) {
               
                if (state.status == FormStatus.success) {
                  showCustomSnackbar(context, 'Success', 'Address added succesfully', Colors.green);
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextfield(
                        hint: 'Name',
                        head: 'Name',
                        white: true,
                        onChanged: (value) => context.read<AddAddressBloc>().add(NameChanged(value)),
                        validator: Validations.name,
                      ),
                      Constants.spaceHight10,
                      CustomTextfield(
                        hint: 'Phone',
                        head: 'Phone',
                        white: true,
                        onChanged: (value) => context.read<AddAddressBloc>().add(PhoneChanged(int.parse(value))),
                        validator: Validations.phone,
                      ),
                      Constants.spaceHight10,
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextfield(
                              hint: 'City',
                              head: 'City',
                              white: true,
                              onChanged: (value) => context.read<AddAddressBloc>().add(CityChanged(value)),
                              validator: Validations.common,
                            ),
                          ),
                          Constants.spaceWidth10,
                          Expanded(
                            child: CustomTextfield(
                              hint: 'Area',
                              head: 'Area',
                              white: true,
                              onChanged: (value) => context.read<AddAddressBloc>().add(AreaChanged(value)),
                              validator: Validations.common,
                            ),
                          ),
                        ],
                      ),
                      Constants.spaceHight10,
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextfield(
                              hint: 'Pincode',
                              head: 'Pincode',
                              white: true,
                              onChanged: (value) => context.read<AddAddressBloc>().add(PincodeChanged(int.parse(value))),
                              validator: Validations.pincode,
                            ),
                          ),
                          Constants.spaceWidth10,
                          Expanded(
                            child: CustomTextfield(
                              hint: 'House/Flat No.',
                              head: 'House/Flat No.',
                              white: true,
                              onChanged: (value) => context.read<AddAddressBloc>().add(HouseChanged(value)),
                              validator: Validations.common,
                            ),
                          ),
                        ],
                      ),
                      Constants.spaceHight20,
                      CustomButton(
                        title: 'Add',
                        width: double.infinity,
                        action: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AddAddressBloc>().add(PendingFrom());
                            context.read<AddAddressBloc>().add(FormSubmit());
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
