import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/services/employee/getemployee/employee.dart';
import 'package:metrogeniusorg/src/employee/screens/login/bloc/bloc/employee_login_bloc.dart';
import 'package:metrogeniusorg/src/employee/screens/profile/getemployee/get_emplyeee_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/getstart/common_login_page.dart';
import 'package:metrogeniusorg/src/userside/screens/profile/widgets/profil_small_widget.dart';
import 'package:metrogeniusorg/src/userside/screens/profile/widgets/profile_main_widget.dart';
import 'package:metrogeniusorg/src/widgets/alertdialog_custom.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class EmployeeProfile extends StatelessWidget {
  const EmployeeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GetEmployeeBloc()..add(FetchEmployeeData()),
        child: BlocConsumer<GetEmployeeBloc, GetEmployeeState>(
          listener: (context, state) {
            if (state is GetEmployeeLoading) {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          builder: (context, state) {
            if (state is GetEmployeeLoading) {
              const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetEmplyeeLoaded) {
              final data = state.data;
              return Stack(
                children: [
                  ProfileContainer(
                    image: data['Image'],
                    name: data['Name'],
                    position: data['Work'],
                  ),
                  ProfileSmallWidget(
                    positionTop: 0.30,
                     title: 'Worker details',
                    sub: '${data['Email']}, ${data['Phone']}',
                    icon: Icons.edit_document,
                    
                  ),
                  Constants.spaceHight10,
                  ProfileSmallWidget(
                    positionTop: 0.425,
                        title: 'Address',
                   sub: 'chundattu(H),cheruvattoor,kothamang....',
                    icon: Icons.edit_location_alt,
                  ),
                  Constants.spaceHight10,
                  ProfileSmallWidget(
                    positionTop: 0.55,
                    title: 'Setting',
                    sub: 'App settings',
                    icon: Icons.settings,
                  ),
                  Constants.spaceHight10,
                  ProfileSmallWidget(
                    action: () {
                      customAlertDialog(
                        context: context,
                        title: 'Logout',
                        message: 'Are you sure, you want to log out?',
                        firstButtonText: 'Cancel',
                        secondButtonText: 'Logout',
                        firstButtonAction: () {
                          Navigator.of(context).pop();
                        },
                        secondButtonAction: () {
                          EmployeeService.employeeLogout();
                          
                        context.read<EmployeeLoginBloc>().add(UserLoggedOut());
                          Navigator.of(context).pushReplacement(createRoute(const CommonLoginPage()));
                        },
                      );
                    },
                    positionTop: 0.675,
                    title: 'Log out',
                    sub: 'Logout from this account',
                    icon: Icons.logout,
                  ),
                  Constants.spaceHight40,
                  if(state is GetEmployeeLoading)
                  const Center(child: CircularProgressIndicator(),),
                ],
              );
            }
            return const Text('');
          },
        ),
      ),
    );
  }
}
