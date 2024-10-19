import 'package:flutter/material.dart';
import 'package:DevCodeX/services/app_color.dart';
class ContestCard extends StatelessWidget {
  final Map<String, dynamic> contestData;

  const ContestCard({super.key, required this.contestData});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.pink,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.secondaryColor.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Card(
        elevation: 0,
        color:  AppColors.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Ensures flexible height
            children: <Widget>[
              const Text(
                "Contest",
                style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: contestData.length,
                itemBuilder: (context, index) {
                  String key = contestData.keys.elementAt(index);
                  String value = contestData[key].toString();

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          key,
                          style: TextStyle(
                            color:  AppColors.secondaryColor.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            value,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color:  AppColors.secondaryColor.withOpacity(0.8),
                              fontSize: 14,
                              letterSpacing: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
