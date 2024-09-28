import 'package:flutter/material.dart';

class ContestCard extends StatelessWidget {
  const ContestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        child: Card(
          elevation: 100,
          color: const Color(0xFF161616),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Contest",
                  style: TextStyle(
                      color: Color(0xFFf6fed1),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  "Contest Attended",
                  style: TextStyle(
                      color: Color(0xFFf6fed1),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
