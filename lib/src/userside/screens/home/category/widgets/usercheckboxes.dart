import 'package:flutter/material.dart';
import 'package:metrogeniusorg/src/userside/screens/home/home.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class UserCheckBoxes extends StatefulWidget {
  const UserCheckBoxes({
    Key? key,
    required this.data,
    required this.onChanged,
  }) : super(key: key);

  final dynamic data;
  final ValueChanged<String?> onChanged;

  @override
  _UserCheckBoxesState createState() => _UserCheckBoxesState();
}

class _UserCheckBoxesState extends State<UserCheckBoxes> {
  late Map<String, bool> checkboxes;
  late List<String> trueCheckboxes;

  @override
  void initState() {
    super.initState();
    // Initialize checkboxes and filter only those that are true
    checkboxes = Map<String, bool>.from(widget.data['Checkboxes']);
    trueCheckboxes = checkboxes.keys.where((key) => checkboxes[key] == true).toList();
    // Reset all checkboxes to false (unchecked)
    for (var key in trueCheckboxes) {
      checkboxes[key] = false;
    }
  }

  void _onCheckboxChanged(String key, bool? value) {
    setState(() {
      checkboxes.updateAll((k, v) => false); 
      checkboxes[key] = value ?? false; 
      widget.onChanged(value == true ? key : null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
            child: ServiceHeadings(title: 'Provided service'),
          ),
          Column(
            children: trueCheckboxes.map((key) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.seconderyColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: checkboxes[key] == false
                          ? AppColors.primaryColor.withOpacity(0.2)
                          : AppColors.thirdColor,
                    ),
                  ),
                  child: Theme(
                    data: ThemeData(
                      unselectedWidgetColor: AppColors.primaryColor,
                      checkboxTheme: CheckboxThemeData(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.selected)) {
                            return AppColors.primaryColor; // Color for checked state
                          }
                          return AppColors.primaryColor.withOpacity(0.5); // Default color
                        }),
                      ),
                    ),
                    child: CheckboxListTile(
                      title: Text(
                        key,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      value: checkboxes[key],
                      onChanged: (bool? value) {
                        _onCheckboxChanged(key, value);
                      },
                      activeColor: AppColors.thirdColor,
                      checkColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
