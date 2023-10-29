import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart' as intl;

import '../../../core/utils/app_colors.dart';
import '../../../main.dart';
import '../controller/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) => SettingsCubit()..getIsActiveNotification(),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              title: const Text(
                "الأعدادات",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 70,
                    letterSpacing: 1.2,
                    fontFamily: "Aldhabi"),
              ),
              centerTitle: true,
            ),
            body: BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                final controller = SettingsCubit.getInstance(context);
                return Column(
                  children: [
                    ListTile(
                      title: const Text(
                        "إرسال أذكار بإستمرار",
                        style: TextStyle(fontSize: 22, fontFamily: "quran"),
                      ),
                      trailing: Switch.adaptive(
                          value: controller.isAzkar,
                          onChanged: (value) {
                            if (value) {
                              controller.setAzkar(
                                uniqueKey: azkar,
                                taskTitle: azkar,
                              );
                            } else {
                              controller.cancelAzan(uniqueKey: azkar);
                            }
                          }),
                    ),
                    ListTile(
                      title: const Text(
                        "إرسال أذكار يوم الجمعة",
                        style: TextStyle(fontSize: 22, fontFamily: "quran"),
                      ),
                      trailing: Switch.adaptive(
                          value: controller.isFridayAzkar,
                          onChanged: (value) {
                            if (value) {
                              controller.setFridayAzkar(
                                  taskTitleFri: fridayAzkarRemider,
                                  uniqueKeyFri: fridayAzkarRemider);
                            } else {
                              controller.cancelAzan(
                                  uniqueKey: fridayAzkarRemider);
                            }
                          }),
                    ),
                    // ListTile(
                    //   title: const Text(
                    //     "تذكير صلاة الفجر",
                    //     style: TextStyle(fontSize: 22, fontFamily: "quran"),
                    //   ),
                    //   trailing: Switch.adaptive(
                    //       value: controller.isFajr,
                    //       onChanged: (value) {
                    //         if (value) {
                    //           controller.setAzan(
                    //               uniqueKey: taskAzanFajr,
                    //               taskTitle: taskAzanFajr);
                    //         } else {
                    //           controller.cancelAzan(uniqueKey: taskAzanFajr);
                    //         }
                    //       }),
                    // ),
                    // ListTile(
                    //   title: const Text(
                    //     "تذكير صلاة الضهر",
                    //     style: TextStyle(fontSize: 22, fontFamily: "quran"),
                    //   ),
                    //   trailing: Switch.adaptive(
                    //       value: controller.isDhuhr,
                    //       onChanged: (value) {
                    //         if (value) {
                    //           controller.setAzan(
                    //               uniqueKey: taskAzanDhuhr,
                    //               taskTitle: taskAzanDhuhr);
                    //         } else {
                    //           controller.cancelAzan(uniqueKey: taskAzanDhuhr);
                    //         }
                    //       }),
                    // ),
                    // ListTile(
                    //   title: const Text(
                    //     "تذكير صلاة العصر",
                    //     style: TextStyle(fontSize: 22, fontFamily: "quran"),
                    //   ),
                    //   trailing: Switch.adaptive(
                    //       value: controller.isAsr,
                    //       onChanged: (value) {
                    //         if (value) {
                    //           controller.setAzan(
                    //               uniqueKey: taskAzanAsr,
                    //               taskTitle: taskAzanAsr);
                    //         } else {
                    //           controller.cancelAzan(uniqueKey: taskAzanAsr);
                    //         }
                    //       }),
                    // ),
                    // ListTile(
                    //   title: const Text(
                    //     "تذكير صلاة المغرب",
                    //     style: TextStyle(fontSize: 22, fontFamily: "quran"),
                    //   ),
                    //   trailing: Switch.adaptive(
                    //       value: controller.isMaghrib,
                    //       onChanged: (value) {
                    //         if (value) {
                    //           controller.setAzan(
                    //               uniqueKey: taskAzanMaghrib,
                    //               taskTitle: taskAzanMaghrib);
                    //         } else {
                    //           controller.cancelAzan(uniqueKey: taskAzanMaghrib);
                    //         }
                    //       }),
                    // ),
                    // ListTile(
                    //   title: const Text(
                    //     "تذكير صلاة العشاء",
                    //     style: TextStyle(fontSize: 22, fontFamily: "quran"),
                    //   ),
                    //   trailing: Switch.adaptive(
                    //       value: controller.isIsha,
                    //       onChanged: (value) {
                    //         if (value) {
                    //           controller.setAzan(
                    //               uniqueKey: taskAzanIsha,
                    //               taskTitle: taskAzanIsha);
                    //         } else {
                    //           controller.cancelAzan(uniqueKey: taskAzanIsha);
                    //         }
                    //       }),
                    // ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       controller.setAlarm(
                    //           alarmId: 15,
                    //           alarmTime: DateTime.now(),
                    //           assetsAudio: 'assets/azan.mp3',
                    //           alarmBody: "test id 15");
                    //     },
                    //     child: const Text("Lollllll")),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       print(intl.DateFormat.E().format(DateTime.now()));

                    //       // NotificationService().initNotification();
                    //       // NotificationService().showNotification(12222, "Quran",
                    //       //     " اللَّهمَّ صلِّ على محمَّدٍ وعلى آلِ محمَّدٍ كما صلَّيتَ علَى إبراهيمَ وعلَى آلِ إبراهيمَ، وبارِكْ على محمَّدٍ وعلى آلِ محمَّدٍ كما بارَكْتَ على إبراهيمَ وعلى آلِ إبراهيمَ في العالَمينَ إنَّكَ حميدٌ مجيدٌ ");

                    //       // NotificationService().showNotification(
                    //       //     4422,
                    //       //     "Quran",
                    //       //     "لا تنسي قرأه سورة الكهف فضل قراءة سورة الكهف يوم الجمعة قول النبي -صلى الله عليه وسلم-: (مَن قرأَ سورةَ الكَهْفِ في يومِ الجمعةِ سَطعَ لَهُ نورٌ مِن تحتِ قدمِهِ إلى عَنانِ السَّماءِ، يضيءُ"
                    //       //         " لَهُ يومَ القيامةِ، وغُفِرَ لَهُ ما بينَ الجمعتينِ).");

                    //       // controller.setAlarm(
                    //       //     alarmId: 16,
                    //       //     alarmTime:
                    //       //         DateTime.now().add(const Duration(minutes: 5)),
                    //       //     assetsAudio: 'assets/azan.mp3',
                    //       //     alarmBody: "test id 16");
                    //     },
                    //     child: const Text("Lollllll"))

                    // ElevatedButton(
                    //     onPressed: () async {
                    //       try {
                    //         await [
                    //           Permission.notification,
                    //         ].request();
                    //         String uniqueKey = DateTime.now().toString();

                    //         // await Workmanager().registerPeriodicTask(
                    //         //     'azan', taskTitle,
                    //         //     frequency: const Duration(minutes: 15),
                    //         //     initialDelay: const Duration(seconds: 5));
                    //         setState(() {});
                    //         // await Workmanager().registerOneOffTask(
                    //         //   uniqueKey.toString(),
                    //         //   taskTitle,
                    //         //   initialDelay: const Duration(minutes: 1)
                    //         // );
                    //       } catch (e) {
                    //         debugPrint("lollllll $e");
                    //       }
                    //     },
                    //     child: const Text("Active")),
                    // ElevatedButton(
                    //     onPressed: () async {
                    //       // try {
                    //       //   await Workmanager().cancelByUniqueName(
                    //       //     uniqueKey,
                    //       //     taskTitle,
                    //       //     initialDelay: const Duration(seconds: 10),
                    //       //     constraints: Constraints(
                    //       //       networkType: NetworkType.connected, // Optional
                    //       //     ),
                    //       //     frequency: const Duration(days: 1),
                    //       //   );
                    //       //   // await Workmanager().registerPeriodicTask(
                    //       //   //     'azan', taskTitle,
                    //       //   //     frequency: const Duration(minutes: 15),
                    //       //   //     initialDelay: const Duration(seconds: 5));
                    //       //   setState(() {});
                    //       //   // await Workmanager().registerOneOffTask(
                    //       //   //   uniqueKey.toString(),
                    //       //   //   taskTitle,
                    //       //   //   initialDelay: const Duration(minutes: 1)
                    //       //   // );
                    //       // } catch (e) {
                    //       //   debugPrint("lollllll $e");
                    //       // }
                    //     },
                    //     child: const Text("Cancel"))
                  ],
                );
              },
            ),
          ),
        ));
  }
}
