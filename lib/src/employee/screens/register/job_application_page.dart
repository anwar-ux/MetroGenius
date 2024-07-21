// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/functions/image_convertion.dart';
import 'package:metrogeniusorg/functions/image_picker.dart';
import 'package:metrogeniusorg/src/employee/screens/register/bloc/employee_job_application_bloc.dart';
import 'package:metrogeniusorg/src/employee/screens/register/register_details_page.dart';
import 'package:metrogeniusorg/src/employee/widgets/background_container.dart';
import 'package:metrogeniusorg/src/employee/widgets/register_photo_container.dart';
import 'package:metrogeniusorg/src/userside/screens/getstart/common_login_page.dart';
import 'package:metrogeniusorg/src/widgets/custom_button.dart';
import 'package:metrogeniusorg/src/widgets/custom_textfield.dart';
import 'package:metrogeniusorg/src/widgets/snak_bar.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

// ignore: must_be_immutable
class JobApplicationPage extends StatelessWidget {
  JobApplicationPage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController workController = TextEditingController();
  final usernameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final conPasswordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  String? img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: AppColors.seconderyColor,
        ),
        title: const Text('Become a worker'),
        titleTextStyle:
            GoogleFonts.urbanist(color: AppColors.seconderyColor, fontSize: 22),
        centerTitle: true,
      ),
      body:
          BlocConsumer<EmployeeJobApplicationBloc, EmployeeJobApplicationState>(
        listener: (context, state) {
          if (state.status == FormStatus.success) {
            showCustomSnackbar(
                context,
                'Success',
                'Applicaton submietd succesfully, We will contact you soon ${state.name}',
                Colors.green);
            Navigator.of(context)
                .pushReplacement(createRoute(const CommonLoginPage()));
            context.read<EmployeeJobApplicationBloc>().add(FormClear());
          }
          if (state.status == FormStatus.error) {
            showCustomSnackbar(context, 'Failed', state.errorMsg!, Colors.red);
          }
          if (state.status == FormStatus.pending) {
            const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              const BackGroundContainer(),
              Container(
                height: double.infinity,
                color: Colors.black.withOpacity(0.75),
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 18, right: 18, bottom: 18, top: 70),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Constants.spaceHight10,
                            RegisterPhotoContainer(
                              action: () async {
                                try {
                                  final pickedImage = await imagePicker();
                                  if (pickedImage != null) {
                                    context
                                        .read<EmployeeJobApplicationBloc>()
                                        .add(PhotoChanged(pickedImage.path));

                                    img = pickedImage.path;
                                  }
                                } catch (e) {
                                  print('Error selecting image: $e');
                                }
                              },
                              image: img,
                            ),
                            Constants.spaceHight10,
                            CustomTextfield(
                              onChanged: (value) => context
                                  .read<EmployeeJobApplicationBloc>()
                                  .add(NameChanged(value)),
                              controller: nameController,
                              head: 'Full name',
                              hint: 'Enter your name',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your name';
                                }

                                return null;
                              },
                            ),
                            Constants.spaceHight10,
                            CustomTextfield(
                              onChanged: (value) => context
                                  .read<EmployeeJobApplicationBloc>()
                                  .add(PhoneChanged(int.parse(value))),
                              controller: phoneController,
                              head: 'Phone number',
                              hint: 'Enter phone number',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your phone number';
                                }
                                final phoneRegex = RegExp(r'^[0-9]{10}$');
                                if (!phoneRegex.hasMatch(value)) {
                                  return 'Enter a valid phone number';
                                }
                                return null;
                              },
                            ),
                            Constants.spaceHight10,
                            CustomTextfield(
                              onChanged: (value) => context
                                  .read<EmployeeJobApplicationBloc>()
                                  .add(EmailChanged(value)),
                              controller: emailController,
                              head: 'Email address',
                              hint: 'Enter email address',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your email';
                                }
                                final emailRegex = RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            Constants.spaceHight10,
                            CustomTextfield(
                              controller: workController,
                              head: 'Work type',
                              hint: 'e.g. Plumber, Electrician etc',
                              readOnly: true,
                              suffix: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                                size: 20,
                              ),
                              onTapSuffix: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      child: ListView(
                                        children: [
                                          ListTile(
                                            title: Text('Plumber'),
                                            onTap: () {
                                              workController.text = 'Plumber';
                                              context
                                                  .read<
                                                      EmployeeJobApplicationBloc>()
                                                  .add(WorkChanged(
                                                      workController.text));
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            title: Text('Electrician'),
                                            onTap: () {
                                              workController.text =
                                                  'Electrician';
                                              context
                                                  .read<
                                                      EmployeeJobApplicationBloc>()
                                                  .add(WorkChanged(
                                                      workController.text));
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select a work type';
                                }
                                return null;
                              },
                            ),
                            Constants.spaceHight10,
                            CustomTextfield(
                              onChanged: (value) => context
                                  .read<EmployeeJobApplicationBloc>()
                                  .add(ExperienceChanged(int.parse(value))),
                              controller: experienceController,
                              head: 'Years of experience',
                              hint: 'Enter years of experience',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your years of experience';
                                }
                                if (int.tryParse(value) == null) {
                                  return 'Enter a valid number';
                                }
                                return null;
                              },
                            ),
                            Constants.spaceHight10,
                            CustomTextfield(
                              controller: idController,
                              readOnly: true,
                              head: 'ID proof',
                              hint: 'Attach your ID proof',
                              suffix:
                                  const Icon(Icons.photo_camera_back_outlined),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select id proof';
                                }
                                return null;
                              },
                              onTapSuffix: () async {
                                final idProof = await imagePicker();

                                if (idProof != null) {
                                  final File iDproofFile = File(idProof.path);
                                  idController.text = iDproofFile.path;
                                }
                              },
                            ),
                            Constants.spaceHight20,
                            Constants.spaceHight10,
                            CustomButton(
                                title: 'Submit',
                                action: () async {
                                  if (_formKey.currentState!.validate()) {
                                    String? photoUrl;
                                    String? idProofUrl;

                                    if (img != null) {
                                      try {
                                        final imageFile = File(img!);
                                        photoUrl = await uploadImageToFirebase(
                                            imageFile);
                                        if (photoUrl != null) {
                                          context
                                              .read<
                                                  EmployeeJobApplicationBloc>()
                                              .add(PhotoChanged(photoUrl));

                                          if (idController.text.isNotEmpty) {
                                            final idProofFile =
                                                File(idController.text);
                                            idProofUrl =
                                                await uploadImageToFirebase(
                                                    idProofFile);

                                            if (idProofUrl != null) {
                                              context
                                                  .read<
                                                      EmployeeJobApplicationBloc>()
                                                  .add(
                                                    IdproofChanged(idProofUrl),
                                                  );
                                            }
                                          }
                                          context
                                              .read<
                                                  EmployeeJobApplicationBloc>()
                                              .add(FormSubmit());
                                          _formKey.currentState?.reset();
                                        } else {
                                          showCustomSnackbar(
                                              context,
                                              'Failed',
                                              'Failed to upload photo',
                                              Colors.red);
                                        }
                                      } catch (e) {
                                        showCustomSnackbar(
                                            context,
                                            'Failed',
                                            'Error uploading images: $e',
                                            Colors.red);
                                      }
                                    } else {
                                      showCustomSnackbar(context, 'Failed',
                                          'Please select a photo', Colors.red);
                                    }
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
