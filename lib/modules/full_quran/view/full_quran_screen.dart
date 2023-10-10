import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_colors.dart';
 
import '../../full_quran_surh/view/sura_screen.dart';
import '../controller/quran_reading_cubit.dart';

class FullQuranScreen extends StatelessWidget {
  const FullQuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FullQuranReadingCubit()..readJson(),
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              backgroundColor: AppColors.primaryColor,
              title: const Text(
                "قرأن",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 70,
                    letterSpacing: 1.2,
                    fontFamily: "Aldhabi"),
              ),
              centerTitle: true,
            ),
            body: BlocBuilder<FullQuranReadingCubit, FullQuranReadingState>(
              builder: (context, state) {
                final controller = FullQuranReadingCubit.get(context);
                return controller.surahList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        itemBuilder: (context, index) => ListTile(
                         
                          leading: Image.asset(
                           controller.surahList[index].revelationPlace ==
                                    "makkah"
                                ? "assets/images/meccan.png"
                                : "assets/images/medinan.png",
                            cacheHeight: 30,
                            cacheWidth: 30,
                          ),

                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                controller.surahList[index].arabicName,
                               
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                    fontSize: 20, fontFamily: "quran"),
                              ),
                              Text(
                                controller.surahList[index].name,
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(
                                    fontSize: 20, fontFamily: "head"),
                              ),
                            ],
                          ),
                          // title: Text(controller.surahList[index].name),
                          // subtitle: Text(controller.surahList[index].versesCount
                          //     .toString()),
                          // trailing: Text(
                          //   controller.surahList[index].arabicName,
                          //   style: const TextStyle(
                          //     fontSize: 18,
                          //   ),
                          // ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      FullQuranSuraScreen(
                                          surah: controller.surahList,
                                          index: index)),
                            );
                          },
                        ),
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                        itemCount: controller.surahList.length,
                      );
              },
            )));
  }
}
