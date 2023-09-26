import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/utils/camil_case.dart';
import 'package:quran_app/core/widgets/loading_item.dart';

import '../../../core/repository/hadiths_details/hadiths_details_repository_impl.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/service_locator.dart';
import '../../../core/utils/size_config.dart';
import '../controller/hadith_details_cubit.dart';

class HadithsDetailsScreen extends StatelessWidget {
  const HadithsDetailsScreen(
      {super.key, required this.slug, required this.name});
  final String slug;
  final String name;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HadithDetailsCubit(sl.get<HadithsDetailsRepositoryImpl>())
            ..getHadithsDetails(slug: slug),
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
            camilCaseMethod(name),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: getFont(80),
                letterSpacing: 1.2,
                fontFamily: "Aldhabi"),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<HadithDetailsCubit, HadithDetailsState>(
          builder: (context, state) {
            final controller = HadithDetailsCubit.get(context);
            return controller.isLoading
                ? const LoadingItem()
                : controller.isFaild
                    ? const Center(
                        child: Text("SomeThing went wrong, Try again later."),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(10),
                              controller: controller.scroll,
                              separatorBuilder: (context, index) => SizedBox(
                                height: getHeight(20),
                              ),
                              itemBuilder: (context, index) => Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 0.5,
                                          blurRadius: 6)
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColors.primaryColor,
                                      child: Text(
                                        controller.hadiths[index].number
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    SelectableText(
                                      controller.hadiths[index].arab.toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(fontSize: getFont(21)),
                                    ),
                                  ],
                                ),
                              ),
                              itemCount: controller.hadiths.length,
                            ),
                          ),
                          controller.isLaodingForMore
                              ? LoadingItem()
                              : SizedBox()
                        ],
                      );
          },
        ),
      ),
    );
  }
}
