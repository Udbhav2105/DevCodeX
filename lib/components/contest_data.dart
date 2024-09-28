import 'package:flutter/material.dart';

class ContestCard extends StatelessWidget {
  final Map<String, dynamic> contestData;

  ContestCard({super.key, required this.contestData});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.pink,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFf6fed1).withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Card(
        elevation: 0,
        color: const Color(0xFF161616),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Ensures flexible height
            children: <Widget>[
              const Text(
                "Contest",
                style: TextStyle(
                    color: Color(0xFFf6fed1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
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
                            color: const Color(0xFFf6fed1).withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            value,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: const Color(0xFFf6fed1).withOpacity(0.8),
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
