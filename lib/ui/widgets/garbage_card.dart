import 'package:flutter/material.dart';

import '../../../shared/color.dart';
import '../../../shared/font.dart';
import '../../../shared/size.dart';

class GarbageCard extends StatelessWidget {
  final String title;
  final Color textColor;

  const GarbageCard({
    this.title = "", 
    this.textColor = blackPure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context),
      decoration: BoxDecoration(
        color: whitePure,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 18,
            ),
            child: Image(
              height: 72,
              fit: BoxFit.cover,
              image: AssetImage("assets/image/bg_jual_sampah.png"),
            ),
          ),
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: whitePure.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 18,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: whitePure,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2.5,
                          color: textColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      title,
                      style: mediumRobotoFont.copyWith(
                        color: textColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                generatePriceCard("Plastik", "1500"),
                generatePriceCard("Kertas", "1500"),
                generatePriceCard("Logam", "1500"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget generatePriceCard(String type, String price) {
    return Column(
      children: [
        Text(
          type,
          style: boldRobotoFont.copyWith(
            color: textColor,
            fontSize: 13,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Padding(
          padding: EdgeInsets.only(
            right: 16,
          ),
          child: Text(
            "Rp",
            textAlign: TextAlign.start,
            style: regularRobotoFont.copyWith(
              color: grayPure,
              fontSize: 12,
            ),
          ),
        ),
        Text(
          price,
          style: boldRobotoFont.copyWith(
            color: blackPure,
            fontSize: 15,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 16,
          ),
          child: Text(
            "Kg",
            textAlign: TextAlign.start,
            style: regularRobotoFont.copyWith(
              color: grayPure,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
