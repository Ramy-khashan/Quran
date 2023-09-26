import 'package:flutter/material.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../sura/view/sura_screen.dart';

import '../controller/quran_reading_cubit.dart'; 

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => QuranReadingCubit()..readJson(),
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
              title: Text(
                "Quran",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: getFont(80),
                    letterSpacing: 1.2,
                    fontFamily: "Aldhabi"),
              ),
              centerTitle: true,
            ),
            body: BlocBuilder<QuranReadingCubit, QuranReadingState>(
              builder: (context, state) {
                final controller = QuranReadingCubit.get(context);
                return controller.surahList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            child:
                                Text(controller.surahList[index].id.toString()),
                          ),
                          title: Text(controller.surahList[index].name),
                          subtitle: Text(controller.surahList[index].versesCount
                              .toString()),
                          trailing: Text(
                            controller.surahList[index].arabicName,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) => SuraScreen(
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
