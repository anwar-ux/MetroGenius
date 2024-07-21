import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/admin/screens/home/application/applications_page.dart';
import 'package:metrogeniusorg/src/admin/screens/home/application/bloc/button_click/accept_reject_bloc.dart';
import 'package:metrogeniusorg/src/admin/screens/home/application/deatilspage_widgets/top_left_container.dart';
import 'package:metrogeniusorg/src/admin/screens/home/application/deatilspage_widgets/top_right_container.dart';
import 'package:metrogeniusorg/src/widgets/alertdialog_custom.dart';
import 'package:metrogeniusorg/src/widgets/snak_bar.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class ApplicantDeatilsPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const ApplicantDeatilsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcceptRejectBloc, AcceptRejectState>(
      listener: (context, state) {
        if (state.acceptStatus == FormStatusAccept.pending) {
          const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state.acceptStatus == FormStatusAccept.success) {
          showCustomSnackbar(
              context, 'Success', 'Employee adding Successfull', Colors.green);
        }
        if (state.rejectStatus == FormStatusReject.pending) {
          const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        if (state.rejectStatus == FormStatusReject.success) {
          showCustomSnackbar(
              context, 'Deleted', 'Deletion Successfull', Colors.green);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              Row(
                children: [
                  MainTopLeftContainer(
                    image: data['Image'],
                    name: data['Name'],
                    delete: () {
                      alertDialogCustom(
                        firstButtonText: 'Cancel',
                        secondButtonText: 'Delete',
                        firstButtonAction: () => Navigator.pop(context),
                        secondButtonAction: () {
                          context
                              .read<AcceptRejectBloc>()
                              .add(RejectClicked(data['Id']));
                          Navigator.of(context).pushReplacement(
                              createRoute(const ApplicationsPage()));
                        },
                        context: context,
                        title: 'Delete',
                        message: 'Are you sure about delete this ?',
                      );
                    },
                    accept: () {
                      alertDialogCustom(
                        firstButtonText: 'Cancel',
                        secondButtonText: 'Add',
                        firstButtonAction: () => Navigator.pop(context),
                        secondButtonAction: () {
                          context
                              .read<AcceptRejectBloc>()
                              .add(AcceptClicked(data));
                          Navigator.of(context).pushReplacement(
                              createRoute(const ApplicationsPage()));
                        },
                        context: context,
                        title: 'Add to Workers',
                        message: 'Are you sure about add this worker?',
                      );
                    },
                  ),
                  MainTopRightContainer(
                    email: data['Email'],
                    number: data['Phone'],
                    work: data['Work'],
                    experience: data['Experience'],
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.9,
                    color: AppColors.thirdColor,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.1,
                    color: AppColors.seconderyColor,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
