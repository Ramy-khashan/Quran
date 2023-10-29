import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/utils/app_assets.dart';
import '../../view_quran_list/model/surah_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../cntroller/play_quran_sound_cubit.dart'; 
import '../model/page_manager.dart';

class PlayQuranSoundScreen extends StatelessWidget {
  const PlayQuranSoundScreen({
    super.key,
    required this.index,
    required this.serverLink,
    required this.surahs,
  });
  final int index;
  final String serverLink;
  final List<SurahModel> surahs;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayQuranSoundCubit()
        ..init(serverLink: serverLink, index: index, surahs: surahs),
      child: BlocBuilder<PlayQuranSoundCubit, PlayQuranSoundState>(
        builder: (context, state) {
          final controller = PlayQuranSoundCubit.get(context);
          return Scaffold(
            appBar: AppBar( 
              toolbarHeight: getHeight(100),
              leading: IconButton(
                  onPressed: () {
                     controller.audioPlayer!.pause();
                     controller.audioPlayer!.stop();
                    Navigator.pop(context);
                    
                  },
                  icon: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.white,
                  )),
              backgroundColor: AppColors.primaryColor,
              title: Text(
               "سورة ${surahs[controller.index].name}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: getFont(40),
                    letterSpacing: 1.2,
                    fontFamily: "quran"),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidth(10), vertical: getHeight(20)),
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(AppAssets.logo),
                  const Spacer(),
                  ValueListenableBuilder<ProgressBarState>(
                    valueListenable: controller.progressNotifier,
                    builder: (_, value, __) {
                      return ProgressBar(
                        progress: value.current,
                        buffered: value.buffered,
                        total: value.total,
                        baseBarColor: Colors.grey,
                        thumbColor: AppColors.primaryColor,
                        progressBarColor: AppColors.primaryColor,
                        onSeek: controller.seek,
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: getWidth(10)),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: ValueListenableBuilder<ButtonState>(
                          valueListenable: controller.buttonNotifier,
                          builder: (_, value, __) {
                            switch (value) {
                              case ButtonState.loading:
                                return Container(
                                  margin: const EdgeInsets.all(8.0),
                                  width: 32.0,
                                  height: 32.0,
                                  child: const CircularProgressIndicator(),
                                );
                              case ButtonState.paused:
                                return IconButton(
                                  icon: const Icon(FontAwesomeIcons.play),
                                  iconSize: getWidth(32),
                                  onPressed: controller.play,
                                );
                              case ButtonState.playing:
                                return IconButton(
                                  icon: const Icon(FontAwesomeIcons.pause),
                                  iconSize: getWidth(32),
                                  onPressed: controller.pause,
                                );
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: getWidth(10)),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: IconButton(
                            onPressed: () {
                              controller.changeSurah(false);
                            },
                            icon: const Icon(FontAwesomeIcons.backward)),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: getWidth(10)),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: IconButton(
                            onPressed: () {
                              controller.changeSurah(true);
                            },
                            icon: const Icon(FontAwesomeIcons.forward)),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: getWidth(10)),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: controller.volume == 0
                            ? IconButton(
                                onPressed: () {
                                  controller.volume = 100;
                                  controller.changeVolume();
                                },
                                icon: const Icon(FontAwesomeIcons.volumeOff))
                            : IconButton(
                                onPressed: () {
                                  controller.volume = 0;
                                  controller.changeVolume();
                                },
                                icon: const Icon(FontAwesomeIcons.volumeHigh),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
