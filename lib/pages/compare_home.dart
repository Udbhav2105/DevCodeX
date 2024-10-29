import 'package:flutter/material.dart';
import 'package:DevCodeX/services/app_color.dart';

class CompareHome extends StatelessWidget {
  const CompareHome({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {};

    final routeData = ModalRoute.of(context)?.settings.arguments;

    if (routeData == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: const Center(
          child: Text('No data available'),
        ),
      );
    }
    data = routeData as Map<String, dynamic>;
    List<Widget> cfOrLc = [];

    const cardWidth = 300.0;
    const cardHeight = 184.0;
    print(data.keys);
    if ((data['lcDataUser1'] != null || data['lcDataUser2'] != null) && (data['lcDataUser1'].lcAuth || data['lcDataUser2'].lcAuth)) {
      cfOrLc.add(
        SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.secondaryColor.withOpacity(0.5),
              ),
            ),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.backgroundColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/compareLeetcode',
                    arguments: data);
              },
              icon: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/1/19/LeetCode_logo_black.png',
                height: 60,
                width: 60,
              ),
              label: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Leetcode",
                  style: TextStyle(letterSpacing: 1.7, fontSize: 23),
                ),
              ),
            ),
          ),
        ),
      );
      cfOrLc.add(const SizedBox(height: 30));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Column(
                children: [...cfOrLc],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
