import 'package:flutter/material.dart';
import 'package:DevCodeX/services/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  Home({super.key});

  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    final routeData = ModalRoute.of(context)?.settings.arguments;

    if (routeData == null) {
      return Scaffold(
        appBar: AppBar(backgroundColor: AppColors.backgroundColor,iconTheme: const IconThemeData(color: Colors.white),),
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

    if (data['lcData'] != null && data['lcData'].lcAuth) {
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
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/leetcodePage', arguments: data);
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

    if (data['gfgData'] != null && data['gfgData'].gfgAuth) {
      cfOrLc.add(
        SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.secondaryColor.withOpacity(0.5),
              ),
            ),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.backgroundColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/geeksforgeeksPage',
                    arguments: data);
              },
              icon: SvgPicture.network(
                'https://upload.wikimedia.org/wikipedia/commons/4/43/GeeksforGeeks.svg',
                height: 60,
                width: 60,
              ),
              label: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "GFG",
                  style: TextStyle(letterSpacing: 1.7, fontSize: 23),
                ),
              ),
            ),
          ),
        ),
      );
      cfOrLc.add(const SizedBox(height: 30));
    }

    if (data['cfData'] != null && data['cfData'].cfAuth) {
      cfOrLc.add(
        SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.secondaryColor.withOpacity(0.5),
              ),
            ),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.backgroundColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/codeforcesPage',
                    arguments: data);
              },
              icon: Image.network(
                'https://sta.codeforces.com/s/13783/images/codeforces-logo-with-telegram.png',
                height: 60,
                width: 60,
              ),
              label: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Codeforces",
                  style: TextStyle(letterSpacing: 1.7, fontSize: 23),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.backgroundColor,iconTheme: const IconThemeData(color: Colors.white),),
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
