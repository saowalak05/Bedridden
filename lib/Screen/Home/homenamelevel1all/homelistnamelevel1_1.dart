import 'package:flutter/material.dart';

class homelistnamelevel1_1 extends StatelessWidget {
  const homelistnamelevel1_1({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Container(
          height: 300,
          width: 185,
          decoration: BoxDecoration(
            // color: Colors.blue,
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(3, 5),
              ),
              BoxShadow(
                blurRadius: 10,
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(-3, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: 'imageHero',
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          'https://www.sacsteelwork.com/wp-content/uploads/2017/06/%E0%B8%AA%E0%B8%B5%E0%B9%80%E0%B8%97%E0%B8%B2.jpg',
                        ),
                      ),
                    ),
                    // Hero(
                    //   tag: Hero,
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(24),
                    //     child: Image(
                    //       fit: BoxFit.cover,
                    //       image: AssetImage('assets\images\patient.jpg'),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'ชื่อ-นามสุกุล',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'ที่อยู่',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.black45,
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