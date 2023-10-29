import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../../../core/utils/app_colors.dart'; 
import '../../../core/utils/size_config.dart';
 import '../../view_quran_list/view/view_quran_list_screen.dart';
import '../controller/quran_sound_cubit.dart';

class QuranSoundScreen extends StatelessWidget {
  const QuranSoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
      create: (context) => QuranSoundCubit( ) ,
      child: BlocBuilder<QuranSoundCubit, QuranSoundState>(
        builder: (context, state) {
          final controller = QuranSoundCubit.get(context);
          return Scaffold(
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
                    fontSize:70,
                    letterSpacing: 1.2,
                    fontFamily: "Aldhabi"),
              ),
              centerTitle: true,
            ),
            body:  ListView.separated(
                    padding: EdgeInsets.all(getWidth(6)),
                    itemBuilder: (context, index) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              margin: EdgeInsets.zero,
                              color: Colors.white,
                              child: ListTile(
                                leading: IconButton(
                                    onPressed: () {
                                      controller.showMazhap(index);
                                    },
                                    icon: Icon(
                                      controller.selectedMazhap == index
                                          ? Icons.keyboard_arrow_up_rounded
                                          : Icons.keyboard_arrow_down_rounded,
                                      color: Colors.black,
                                      size: getWidth(30),
                                    )),
                                trailing: Text(
                                  controller.reciters[index].name!,
                                  style: TextStyle(
                                      fontSize: getFont(24),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "quran"),
                                ),
                              ),
                            ),
                            controller.selectedMazhap == index
                                ? Container(
                                    margin: EdgeInsets.only(top: getHeight(10)),
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemBuilder: (context, i) => InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewQuranList(
                                                              moshafIndex: i,
                                                              quranAudioModel:
                                                                  controller
                                                                          .reciters[
                                                                      index]),
                                                    ));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const Icon(Icons
                                                        .play_circle_filled_rounded),
                                                    const Spacer(),
                                                    Text(
                                                      controller.reciters[index]
                                                          .moshaf![i].name!,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize:
                                                              getFont(20)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                        itemCount: controller
                                            .reciters[index].moshaf!.length),
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: getHeight(12),
                        ),
                    itemCount: controller.reciters.length),
          );
        },
      ),
    );
  }
}
