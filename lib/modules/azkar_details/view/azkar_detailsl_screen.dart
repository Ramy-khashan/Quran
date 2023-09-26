import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_app/core/widgets/loading_item.dart';

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
      create: (context) => AzkarDetailsCubit(sl.get<AzkarRepositoryImpl>())
        ..getAzkarDetails(id: id, lang: "en"),
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
            return controller.isLoading
                ? const LoadingItem():controller.isFaild?const Center(
                        child: Text("SomeThing went wrong, Try again later."),
                      )
                : ListView.builder(
                  padding: const EdgeInsets.all(3),
                    itemCount: controller.azkar.length,
                    itemBuilder: (context, index) => Card(
                       
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                           
                            IconButton(
                              onPressed:controller.selectedOne==index?()async{
                                controller.stop();
                              }: () async {
                                await controller
                                    .play(controller.azkar[index].aUDIO,index);
                              },
                              icon:   CircleAvatar(
                                child: Icon(controller.selectedOne==index?FontAwesomeIcons.pause:FontAwesomeIcons.play),
                              ),
                            ),
                         
                            SelectableText(
                              controller.azkar[index].aRABICTEXT.toString()=="null"?controller.azkar[index].text.toString():controller.azkar[index].aRABICTEXT.toString(),
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                  fontSize: 22, fontFamily: "quran"),
                            ),   const SizedBox(
                               height: 13,
                            ), SelectableText(
                              controller.azkar[index].tRANSLATEDTEXT.toString(),
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
          },
        ),
      ),
    );
  }
}
