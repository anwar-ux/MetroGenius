// ignore_for_file: void_checks, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/functions/image_convertion.dart';
import 'package:metrogeniusorg/functions/image_picker.dart';
import 'package:metrogeniusorg/src/userside/screens/profile/bloc/add_user_details/add_user_details_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/profile/profile.dart';
import 'package:metrogeniusorg/src/widgets/circular.dart';
import 'package:metrogeniusorg/src/widgets/custom_button.dart';
import 'package:metrogeniusorg/src/widgets/custom_textfield.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class UserDetailss extends StatelessWidget {
  UserDetailss({super.key});

  TextEditingController nameController = TextEditingController();
  String? img;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddUserDetailsBloc, AddUserDetailsState>(
      listener: (context, state) {
        if (state.status == FormStatus.pending) {
          return buildShowDialog(context);
        }
        if (state.status == FormStatus.success) {
          Navigator.of(context).pushReplacement(createRoute(const Profile()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add category'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    final image = await imagePicker();
                    if (image != null) {
                      context.read<AddUserDetailsBloc>().add(PhotoChanged(image.path));
                      img = image.path;
                    }
                  },
                  child: CircleAvatar(
                    backgroundImage: img != null ? FileImage(File(img.toString())) : null,
                    radius: 60,
                    child: img == null
                        ? const Center(
                            child: Icon(Icons.image),
                          )
                        : null,
                  ),
                ),
                Constants.spaceHight20,
                CustomTextfield(
                  hint: 'name',
                  controller: nameController,
                  onChanged: (value) => context.read<AddUserDetailsBloc>().add(NameChanged(value)),
                ),
                Constants.spaceHight35,
                CustomButton(
                  width: double.infinity,
                  title: 'Upload',
                  action: () async {
                    context.read<AddUserDetailsBloc>().add(PendingFrom());
                    if (img != null) {
                      final downloadLink = await ImageConvertion.uploadImageToFirebase(File(img!));
                      if (downloadLink != null) {
                        context.read<AddUserDetailsBloc>().add(PhotoChanged(downloadLink));
                      }
                      context.read<AddUserDetailsBloc>().add(FormSubmit());
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
