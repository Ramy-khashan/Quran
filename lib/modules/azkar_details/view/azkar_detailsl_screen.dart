import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../core/repository/azkar/azkar_repository_impl.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/service_locator.dart';
import '../../../core/utils/size_config.dart';
import '../controller/azkar_detailsl_cubit.dart';

class AzkarDetailsScreen extends StatelessWidget {
  const AzkarDetailsScreen({super.key, required this.id, required this.title});
  final int id;
  final String title;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarDetailsCubit(sl.get<AzkarRepositoryImpl>()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.white,
              )),
          backgroundColor: AppColors.primaryColor,
          title: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: getFont(32),
                letterSpacing: 1.2,
                fontFamily: "Kitab"),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<AzkarDetailsCubit, AzkarDetailslState>(
          builder: (context, state) {
            final controller = AzkarDetailsCubit.get(context);
            return
                //  controller.isLoading
                //     ? const LoadingItem():controller.isFaild?const Center(
                //             child: Text("SomeThing went wrong, Try again later."),
                //           )
                //     :
                ValueListenableBuilder(
                    valueListenable: controller.hiveBox.listenable(),
                    builder: (context, box, child) {
                      var azkar = box.getAt(id - 1);

                      return ListView.builder(
                        padding: const EdgeInsets.all(3),
                        itemCount: List.from(azkar).length,
                        itemBuilder: (context, index) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: controller.selectedOne == index
                                      ? () async {
                                          controller.stop();
                                        }
                                      : () async {
                                          await controller.play(
                                              List.from(azkar)[index].aUDIO,
                                              index);
                                        },
                                  icon: CircleAvatar(
                                    child: Icon(controller.selectedOne == index
                                        ? FontAwesomeIcons.pause
                                        : FontAwesomeIcons.play),
                                  ),
                                ),
                                SelectableText(
                                  List.from(azkar)[index]
                                              .aRABICTEXT
                                              .toString() ==
                                          "null"
                                      ? List.from(azkar)[index].text.toString()
                                      : List.from(azkar)[index]
                                          .aRABICTEXT
                                          .toString()
                                          .toString(),
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                      fontSize: 22, fontFamily: "quran"),
                                ),
                                const SizedBox(
                                  height: 13,
                                ),
                                SelectableText(
                                  List.from(azkar)[index]
                                      .tRANSLATEDTEXT
                                      .toString(),
                                  textAlign: TextAlign.left,
                                  textDirection: TextDirection.ltr,
                                  style: const TextStyle(
                                      fontSize: 22, fontFamily: "head"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
          },
        ),
      ),
    );
  }
}
