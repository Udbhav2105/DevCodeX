import 'package:flutter/material.dart';
import 'package:DevCodeX/services/app_color.dart';

class ProblemCountCard extends StatelessWidget {
  final int totalProblems;
  final int easyCount;
  final int mediumCount;
  final int hardCount;
  String? extremeCountOneName;
  String? extremeCountTwoName;
  int? extremeCount1;
  int? extremeCount2;
  final Widget chart;

  ProblemCountCard(
      {required this.totalProblems,
      required this.easyCount,
      required this.mediumCount,
      required this.hardCount,
      this.extremeCountOneName,
      this.extremeCount1,
      this.extremeCountTwoName,
      this.extremeCount2,
      required this.chart,
      super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> extremeText = [];
    if (extremeCount1 != null) {
      extremeText.add(const SizedBox(
        height: 20,
      ));
      extremeText.add(
        Text(
          '$extremeCountOneName: $extremeCount1',
          style: const TextStyle(
            color: Colors.purple,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    if (extremeCount2 != null) {
      extremeText.add(const SizedBox(
        height: 20,
      ));
      extremeText.add(
        Text(
          '$extremeCountTwoName: $extremeCount2',
          style: const TextStyle(
            color: Colors.deepPurple,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      extremeText.add(const SizedBox(
        height: 20,
      ));
    }
    return
      SizedBox(
      width: double.infinity,
      child: Container(
        // color: Colors.pink,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.secondaryColor.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child:
        Card(
          elevation: 100,
          color:  AppColors.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Problem Count",
                  style: TextStyle(
                      color:  AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  'Total Solved: $totalProblems',
                  style: TextStyle(
                      color: AppColors.secondaryColor.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    // RadialBarChart(widget.easyCount,widget.mediumCount,widget.hardCount),
                    chart,
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Easy: $easyCount",
                          style: TextStyle(
                            color: Colors.green[300],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Medium: $mediumCount",
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Hard: $hardCount",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...extremeText,
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
