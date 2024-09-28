import 'package:flutter/material.dart';

class Home extends StatelessWidget {
   Home({super.key});

  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    // Safe null check for ModalRoute and its arguments
    final routeData = ModalRoute.of(context)?.settings.arguments;

    if (routeData == null) {
      // Handle the case where there are no arguments (maybe show a loading screen or an error)
      return Scaffold(
        backgroundColor: Color(0xFF161616),
        body: Center(
          child: Text('No data available'),
        ),
      );
    }

    data = routeData as Map<String, dynamic>;
    List<Widget> cfOrLc = [];

    // Fixed size for both LeetCode and Codeforces cards
    const cardWidth = 300.0;
    const cardHeight = 184.0;

    // LeetCode Button with custom logo as a card
    if (data['lcData'] != null && data['lcData'].lcAuth) {
      cfOrLc.add(
        SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              border: Border.all(
                color: Color(0xFFf6fed1).withOpacity(0.5),
              ),
            ),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff161616),
                // Button background color
                foregroundColor: Colors.white,
                // Icon and text color
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                // Padding inside the button
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12), // Button's rounded corners
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/leetcodePage', arguments: data);
              },
              icon: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/1/19/LeetCode_logo_black.png',
                // LeetCode logo URL
                height: 60, // Larger size for card-like appearance
                width: 60,
              ),
              label: Text(
                "Leetcode",
                style: TextStyle(letterSpacing: 1.7, fontSize: 23),
              ),
            ),
          ),
        ),
      );
      cfOrLc.add(SizedBox(height: 30));
    }

    // Codeforces Button with custom logo as a card
    if (data['cfAuth'] != null && data['cfAuth']) {
      cfOrLc.add(
        SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // Rounded corners
              border: Border.all(
                color: Color(0xFFf6fed1).withOpacity(0.5),
              ),
            ),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff161616),
                // Button background color
                foregroundColor: Colors.white,
                // Icon and text color
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                // Padding inside the button
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12), // Button's rounded corners
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/codeforcesPage',
                    arguments: data);
              },
              icon: Image.network(
                'https://sta.codeforces.com/s/13783/images/codeforces-logo-with-telegram.png',
                // Codeforces logo URL
                height: 80, // Larger size for card-like appearance
                width: 80,
              ),
              label: Text(
                "Codeforces",
                style: TextStyle(letterSpacing: 1.7, fontSize: 23),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFF161616),
      body:  SafeArea(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Column(
                children: [...cfOrLc],
              ),
            ),
          ),
      ),
    );
  }
}
