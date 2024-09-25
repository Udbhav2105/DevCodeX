import 'package:flutter/material.dart';

class BadgesCard extends StatelessWidget {
  final List<String> badges;

  BadgesCard(this.badges, {super.key});

  @override
  Widget build(BuildContext context) {
    int len = badges.length; // Get the length of badges
    return SizedBox(
      width: double.infinity,
      child: Container(
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
                Text(
                  'Total Badges: $len',
                  style: const TextStyle(
                    color: Color(0xFFf6fed1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                // Use Expanded to ensure proper height management
                SizedBox(height: 20,),
                SizedBox(
                  height: 80, // Set a specific height for the ListView
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // Set horizontal scroll
                    itemCount: badges.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.network(
                          badges[index],
                          height: 100,
                          width: 100,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
