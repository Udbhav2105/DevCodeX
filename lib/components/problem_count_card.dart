import 'package:flutter/material.dart';
import 'package:ripoff/components/radial_bargraph.dart';

class ProblemCountCard extends StatefulWidget {
  final int totalProblems;
  final int easyCount;
  final int mediumCount;
  final int hardCount;
  String? extremeCountOneName;
  String? extremeCountTwoName;
  int? extremeCount1;
  int? extremeCount2;

  ProblemCountCard(
      {required this.totalProblems,
      required this.easyCount,
      required this.mediumCount,
      required this.hardCount,
      this.extremeCountOneName,
      this.extremeCount1,
      this.extremeCountTwoName,
      this.extremeCount2,
      super.key});

  @override
  State<ProblemCountCard> createState() => _ProblemCountCardState();
}

class _ProblemCountCardState extends State<ProblemCountCard> {
  @override
  Widget build(BuildContext context) {
    List<Widget> extremeText = [];
    if (widget.extremeCount1 != null) {
      extremeText.add(SizedBox(
        height: 30,
      ));
      extremeText.add(
        Text(
          '${widget.extremeCountOneName?.toUpperCase()}  ${widget.extremeCount1}',
          style: TextStyle(
            color: Colors.purple,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    if (widget.extremeCount2 != null) {
      extremeText.add(SizedBox(
        height: 30,
      ));
      extremeText.add(
        Text(
          '${widget.extremeCountTwoName?.toUpperCase()} ${widget.extremeCount2}',
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      extremeText.add(SizedBox(
        height: 30,
      ));
    }
    return
      SizedBox(
      width: double.infinity,
      child: Container(
        // color: Colors.pink,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFf6fed1),
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
        child:
        Card(
          elevation: 100,
          color: const Color(0xFF161616),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Problem Count",
                  style: TextStyle(
                      color:  Color(0xFFf6fed1),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  'Total Solved: ${widget.totalProblems}',
                  style: TextStyle(
                      color: Color(0xFff6fed1).withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    RadialBarChart(widget.easyCount,widget.mediumCount,widget.hardCount),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Easy ${widget.easyCount}",
                          style: TextStyle(
                            color: Colors.green[300],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Medium ${widget.mediumCount}",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Hard ${widget.hardCount}",
                          style: TextStyle(
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
