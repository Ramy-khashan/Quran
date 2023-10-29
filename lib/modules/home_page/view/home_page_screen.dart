import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart' as intl;
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../controller/homepage_cubit.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: BlocBuilder<HomepageCubit, HomepageState>(
          builder: (context, state) {
            final controllere = HomepageCubit.get(context);
            return Column(
              children: [
                Expanded(
                    flex: 5,
                    child: SafeArea(
                      child: Stack(
                        children: [
                          Positioned(
                              bottom: 0,
                              child: Image.asset(
                                AppAssets.mosqueImage,
                                color: Colors.black54,
                                height: getHeight(150),
                                width: 400,
                                fit: BoxFit.fill,
                              )),
                          Padding(
                            padding: EdgeInsets.all(getWidth(14)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      HijriCalendar.setLocal("ar").format(
                                          HijriCalendar.now().hYear,
                                          HijriCalendar.now().hMonth,
                                          HijriCalendar.now().hDay,
                                          "dd MMMM yyyy")
                                      // .hDate(
                                      //     HijriCalendar.now().hYear,
                                      //     HijriCalendar.now().hMonth,
                                      //     HijriCalendar.now().hDay),
                                      // .toFormat("dd MMMM yyyy H"),
                                      ,
                                      style: TextStyle(
                                          fontSize: getFont(27),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      intl.DateFormat.jm("ar")
                                          .format(controllere.dateTime)
                                          .trim(),
                                      style: TextStyle(
                                          fontSize: getFont(50),
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                controllere.prayTime != null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                              child: IconButton(
                                                  onPressed: () async {
                                                    await controllere
                                                        .updateLoation();
                                                  },
                                                  icon: const Icon(
                                                      Icons.update))),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: List.generate(
                                                controllere.prayTimeList.length,
                                                (index) => Column(
                                                      children: [
                                                        Text(
                                                          controllere
                                                              .prayTimeList[
                                                                  index]
                                                              .prayTitle,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        Image.asset(
                                                          controllere
                                                              .prayTimeList[
                                                                  index]
                                                              .img,
                                                          color: Colors.white,
                                                          width: 30,
                                                          height: 30,
                                                        ),
                                                        Text(
                                                          controllere
                                                              .prayTimeList[
                                                                  index]
                                                              .time,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ],
                                                    )),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            Text(
                                              "إظهار أوقات الصلاه",
                                              style: TextStyle(
                                                  fontSize: getFont(23),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: getWidth(10),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  controllere
                                                      .getLocationAndPrayTime();
                                                },
                                                child: const Text("تفعيل"))
                                          ])
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 8,
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.black.withOpacity(.5),
                                  spreadRadius: 3)
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(13),
                              child: Text(
                                "الميزات",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: getFont(30)),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(10),
                            ),
                            Expanded(
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(13),
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          mainAxisExtent: 200,
                                          childAspectRatio: 3 / 2,
                                          crossAxisSpacing: 17,
                                          mainAxisSpacing: 20),
                                  itemCount: controllere.feature.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    controllere
                                                        .feature[index].page));
                                      },
                                      child: Material(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        borderRadius: BorderRadius.circular(15),
                                        elevation: 10,
                                        color: Colors.grey.shade200,
                                        child: GridTile(
                                          footer: GridTileBar(
                                            backgroundColor: AppColors
                                                .primaryColor
                                                .withOpacity(.5),
                                            title: Center(
                                              child: Text(
                                                controllere.feature[index].name,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          child: Image.asset(
                                            "assets/images/${controllere.feature[index].image}",
                                            fit: index == 2
                                                ? BoxFit.fill
                                                : BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )))
              ],
            );
          },
        ),
      ),
    );
  }
}
