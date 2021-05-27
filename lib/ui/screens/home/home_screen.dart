import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/auth/login_screen.dart';
import '../../widgets/garbage_card.dart';
import '../../../bloc/user_bloc.dart';
import '../../../services/auth_services.dart';
import '../../../services/social_services.dart';
import '../../../shared/color.dart';
import '../../../shared/font.dart';
import '../../../shared/size.dart';
import '../../../utils/storage_util.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double width = 24;
  final List<Color> leftBarColor = [
    whitePure, 
    whitePure,
  ];

  bool showAvg = false;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  @override
  void initState() {
    super.initState();

    final barGroup1 = makeGroupData(0, 65000);
    final barGroup2 = makeGroupData(1, 10000);
    final barGroup3 = makeGroupData(2, 45000);
    final barGroup4 = makeGroupData(3, 30000);
    final barGroup5 = makeGroupData(4, 50000);
    final barGroup6 = makeGroupData(5, 60000);
    final barGroup7 = makeGroupData(6, 75000);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          /// SECTION: HEADER PROFILE
          Padding(
            padding: EdgeInsets.fromLTRB(defaultMargin, defaultMargin, defaultMargin, 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hai, Petugas",
                      style: lightRobotoFont.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (_, state) {
                        if (state is UserLoaded) {
                          return Text(
                            state.user.name ?? "-",
                            style: boldRobotoFont.copyWith(
                              fontSize: 24,
                            ),
                          );

                        } else {
                          return Text(
                            "Memuat...",
                            style: boldRobotoFont.copyWith(
                              fontSize: 24,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                GestureDetector(
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/icon_toggle.png"),
                  ),
                  onTap: () async {
                    onLogoutPressed(context);
                  },
                ),
              ],
            ),
          ),
          /// SECTION: TRANSACTION RECORD
          Padding(
            padding: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Record Transaksi",
                  style: regularRobotoFont.copyWith(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                /// WIDGET: GRAPHIC BAR
                Container(
                  width: defaultWidth(context),
                  height: 160,
                  padding: EdgeInsets.only(
                    left: 12,
                    right: 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: BarChart(
                          BarChartData(
                            maxY: 100,
                            barGroups: showingBarGroups,
                            borderData: FlBorderData(
                              show: false,
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: SideTitles(
                                showTitles: true,
                                getTitles: (double value) => getTitles(value),
                                getTextStyles: (_) => regularRobotoFont.copyWith(
                                  color: whitePure,
                                  fontSize: 12,
                                ),
                              ),
                              leftTitles: SideTitles(
                                showTitles: true,
                                margin: 20,
                                interval: 25,
                                reservedSize: 10,
                                getTitles: (value) => value.toInt().toString(),
                                getTextStyles: (_) => regularRobotoFont.copyWith(
                                  color: whitePure,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Friday, 15 Januari 2021",
                      style: mediumRobotoFont,
                    ),
                  ],
                )
              ],
            ),
          ),
          /// SECTION: GARBAGE PRICE
          Padding(
            padding: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Harga Sampah",
                  style: regularRobotoFont.copyWith(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                GarbageCard(
                  title: "Harga Jual",
                  textColor: yellowPure,
                ),
                SizedBox(
                  height: 16,
                ),
                GarbageCard(
                  title: "Harga Jual",
                  textColor: blueSky,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 92,
          ),
        ],
      ),
    );
  }

  String getTitles(double value) {
    switch (value.toInt()) {
      case 0:
        return 'Min';
      case 1:
        return 'Sen';
      case 2:
        return 'Sel';
      case 3:
        return 'Rab';
      case 4:
        return 'Kam';
      case 5:
        return 'Jum';
      case 6:
        return 'Sab';
      default:
        return '';
    }
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          y: y1 / 1000,
          colors: leftBarColor,
          width: width,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ],
    );
  }

  Future<void> onLogoutPressed(BuildContext context) async {
    String socialProvider = StorageUtil.readStorage("social_provider");

    if (socialProvider == "google") {
      await SocialServices.signOutGoogle().then((_) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
          (route) => false,
        );
      });
    } else if (socialProvider == "facebook") {
      await SocialServices.logoutFacebook().then((_) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
          (route) => false,
        );
      });
    } else {
      await AuthServices.logOut().then((_) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
          (route) => false,
        );
      });
    }
  }
}