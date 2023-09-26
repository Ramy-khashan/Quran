import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/utils/service_locator.dart';
import 'package:quran_app/core/widgets/loading_item.dart';
import 'package:quran_app/modules/hadiths/controller/hadiths_cubit.dart';

import '../../../core/repository/hadiths/hadiths_repository_impl.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../hadith_details/view/hadiths_details_screen.dart';

class HadithsScreen extends StatelessWidget {
  const HadithsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HadithsCubit(sl.get<HadithsRepositoryImpl>())..getHadiths(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "Hadiths",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: getFont(80),
                letterSpacing: 1.2,
                fontFamily: "Aldhabi"),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<HadithsCubit, HadithsState>(
          builder: (context, state) {
            final controller = HadithsCubit.get(context);
            return controller.isLoading
                ? const LoadingItem()
                : controller.isFaild
                    ? const Center(
                        child: Text("SomeThing went wrong, Try again later."),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(7),
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HadithsDetailsScreen(
                                            name:controller.hadiths[index].name
                                            .toString(),
                                        slug: controller.hadiths[index].slug
                                            .toString(),
                                      ),
                                    ));
                              },
                              title: Text(
                                controller.hadiths[index].name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                              subtitle: Text(
                                  "Hadiths Number : ${controller.hadiths[index].total}"),
                            ),
                          );
                        },
                        itemCount: controller.hadiths.length);
          },
        ),
      ),
    );
  }
}
