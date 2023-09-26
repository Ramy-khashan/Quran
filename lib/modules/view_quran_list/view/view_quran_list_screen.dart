import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/loading_item.dart';
import '../../play_quran_sound/view/play_quran_sound.dart';

import '../../quran_sound/model/quran_audio_model.dart';
import '../controller/view_quran_list_cubit.dart';

class ViewQuranList extends StatelessWidget {
  const ViewQuranList(
      {super.key, required this.quranAudioModel, required this.moshafIndex});

  final QuranAudioModel quranAudioModel;
  final int moshafIndex;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewQuranListCubit()..readJson(),
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: getHeight(80),
            title: Text.rich(TextSpan(children: [
              TextSpan(text: '${quranAudioModel.name}\n'),
              TextSpan(
                  text: "( ${quranAudioModel.moshaf![moshafIndex].name} )",
                  style: TextStyle(fontSize: getFont(16))),
            ]),textAlign: TextAlign.center,),
          centerTitle: true,
          ),
          body: BlocBuilder<ViewQuranListCubit, ViewQuranListState>(
            builder: (context, state) {
              final controller = ViewQuranListCubit.get(context);
              return controller.surah.isEmpty
                  ? const LoadingItem()
                  : ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PlayQuranSoundScreen(
                                            index: index,
                                            serverLink: quranAudioModel
                                                .moshaf![moshafIndex].server!,
                                            surahs: controller.surah,
                                          )));
                            },
                            leading: const CircleAvatar(
                              child: Icon(Icons.play_arrow_rounded),
                            ),
                            trailing: Text(
                              controller.surah[index].name,
                              style: TextStyle(
                                  fontSize: getFont(27),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "quran"),
                            ),
                          ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: controller.surah.length);
            },
          )),
    );
  }
}
