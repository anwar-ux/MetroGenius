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
import 'package:metrogeniusorg/src/employee/widgets/background_container.dart';
import 'package:metrogeniusorg/src/employee/widgets/register_photo_container.dart';
import 'package:metrogeniusorg/src/employee/widgets/work_selection_widget.dart';
import 'package:metrogeniusorg/src/userside/screens/getstart/common_login_page.dart';
import 'package:metrogeniusorg/src/widgets/custom_button.dart';
import 'package:metrogeniusorg/src/widgets/custom_textfield.dart';
import 'package:metrogeniusorg/src/widgets/snak_bar.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';
import 'package:metrogeniusorg/utils/validations.dart';

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
  String? idproof;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeJobApplicationBloc, EmployeeJobApplicationState>(
      bloc: context.read<EmployeeJobApplicationBloc>(),
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          showCustomSnackbar(context, 'Success', 'Application submitted successfully, We will contact you soon ${state.name}', Colors.green);
          Navigator.of(context).pushReplacement(createRoute(const CommonLoginPage()));
          context.read<EmployeeJobApplicationBloc>().add(FormClear());
        } else if (state.status == FormStatus.error) {
          showCustomSnackbar(context, 'Failed', state.errorMsg!, Colors.red);
        }
      },
      builder: (context, state) {
        if (state.status == FormStatus.success) {
          return const Center(child: Text('Application submitted successfully!'));
        } else if (state.status == FormStatus.error) {
          return Center(child: Text('Error: ${state.errorMsg}'));
        } else {
          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: const BackButton(
                  color: AppColors.seconderyColor,
                ),
                title: const Text('Become a worker'),
                titleTextStyle: GoogleFonts.urbanist(color: AppColors.seconderyColor, fontSize: 22),
                centerTitle: true,
              ),
              body: Stack(
                children: [
                  const BackGroundContainer(),
                  Container(
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.75),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18, top: 70),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Constants.spaceHight35,
                                RegisterPhotoContainer(
                                  action: () async {
                                    try {
                                      final pickedImage = await imagePicker();
                                      if (pickedImage != null) {
                                        context.read<EmployeeJobApplicationBloc>().add(PhotoChanged(pickedImage.path));
                                        img = pickedImage.path;
                                      }
                                    } catch (e) {
                                      throw e.toString();
                                    }
                                  },
                                  image: img,
                                ),
                                Constants.spaceHight10,
                                CustomTextfield(
                                  onChanged: (value) => context.read<EmployeeJobApplicationBloc>().add(NameChanged(value)),
                                  controller: nameController,
                                  head: 'Full name',
                                  hint: 'Enter your name',
                                  validator: Validations.name,
                                ),
                                Constants.spaceHight10,
                                CustomTextfield(
                                    onChanged: (value) => context.read<EmployeeJobApplicationBloc>().add(PhoneChanged(int.parse(value))),
                                    controller: phoneController,
                                    head: 'Phone number',
                                    hint: 'Enter phone number',
                                    validator: Validations.phone),
                                Constants.spaceHight10,
                                CustomTextfield(
                                    onChanged: (value) => context.read<EmployeeJobApplicationBloc>().add(EmailChanged(value)),
                                    controller: emailController,
                                    head: 'Email address',
                                    hint: 'Enter email address',
                                    validator: Validations.email),
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
                                    workSelection(context, workController);
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
                                    onChanged: (value) => context.read<EmployeeJobApplicationBloc>().add(ExperienceChanged(int.parse(value))),
                                    controller: experienceController,
                                    head: 'Years of experience',
                                    hint: 'Enter years of experience',
                                    validator: Validations.workExperience),
                                Constants.spaceHight10,
                                Constants.spaceHight10,
                                GestureDetector(
                                  onTap: () async {
                                    try {
                                      final pickedImage = await imagePicker();

                                      if (pickedImage != null) {
                                        context.read<EmployeeJobApplicationBloc>().add(IdproofChanged(pickedImage.path));

                                        idproof = pickedImage.path;
                                      }
                                    } catch (e) {
                                      throw e.toString();
                                    }
                                  },
                                  child: Container(
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.lightGrey,
                                    ),
                                    child: idproof != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.file(
                                              File(idproof!),
                                              fit: BoxFit.cover,
                                            ))
                                        : const Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.insert_drive_file_outlined,
                                                size: 20,
                                              ),
                                              Constants.spaceHight10,
                                              Text('Select ID Proof')
                                            ],
                                          ),
                                  ),
                                ),
                                Constants.spaceHight20,
                                Constants.spaceHight10,
                                CustomButton(
                                  title: 'Submit',
                                  action: () async {
                                    if (_formKey.currentState!.validate()) {
                                 

                                      if (img != null) {
                                        try {
                                         final photoUrl = await ImageConvertion.uploadImageToFirebase(File(img!));
                                          if (photoUrl != null) {
                                            context.read<EmployeeJobApplicationBloc>().add(PhotoChanged(photoUrl));

                                            if (idproof != null) {
                                            final  idProofUrl = await ImageConvertion.uploadImageToFirebase(File(idproof!));

                                              if (idProofUrl != null) {
                                                context.read<EmployeeJobApplicationBloc>().add(IdproofChanged(idProofUrl));
                                              }
                                            }
                                          
                                            context.read<EmployeeJobApplicationBloc>().add(FormSubmit());

                                            _formKey.currentState?.reset();
                                          } else {
                                            showCustomSnackbar(context, 'Failed', 'Failed to upload photo', Colors.red);
                                          }
                                        } catch (e) {
                                          showCustomSnackbar(context, 'Failed', 'Error uploading images: $e', Colors.red);
                                        }
                                      } else {
                                        showCustomSnackbar(context, 'Failed', 'Please select a photo', Colors.red);
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state.status == FormStatus.pending)
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )),
                    )
                ],
              ));
        }
      },
    );
  }
}
