import 'package:DevCodeX/services/app_color.dart';
import 'package:flutter/material.dart';

class BadgesCard extends StatelessWidget {
  final List<String> badges;

  BadgesCard(this.badges, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> data = [];
    int len = badges.length; // Get the length of badges
    if (len != 0){
      data.add(
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection:
              Axis.horizontal,
              itemCount: badges.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(6),
                  child: Image.network(
                    badges[index],
                    height: 80,
                    width: 80,
                  ),
                );
              },
            ),
          ));
    }
    else{
      data.add(
      Text('--No Badge--',
      style: TextStyle(
        // fontSize: 5,
        color: AppColors.secondaryColor.withOpacity(0.7),
      ),));
    }
    print(len);
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.secondaryColor.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Card(
          elevation: 100,
          color:  AppColors.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Total Badges: $len',
                  style: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                // Use Expanded to ensure proper height management
                SizedBox(height: 20,),
                ...data,
      ],
      )
          ),
        ),
      ),
    );
  }
}
