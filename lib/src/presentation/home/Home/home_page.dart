import 'package:banknote/src/app/data/dio/exception/dio_error_extention.dart';
import 'package:banknote/src/app/localization/app_localization.dart';
import 'package:banknote/src/app/providers/categories_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/widgets/custom_snackbar.dart';
import 'package:banknote/src/presentation/home/Category/our_category.dart';
import 'package:banknote/src/presentation/home/Category/widget/category_cont.dart';
import 'package:banknote/src/presentation/home/SubmitForm/submit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../app/providers/auth_provider.dart';
import '../../../app/providers/category_provider.dart';
import '../../../app/utils/global_methods.dart';
import '../../../app/widgets/alert_dialog.dart';
import '../subCategory/sub_category.dart';
import 'widget/news_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCategoryData();

      //
    });
  }

  _getCategoryData() async {
    try {
      await context.read<CategoriesProvider>().getCategoryhData();
    } catch (e) {
      showCustomSnackBar(readableError(e), context, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context);
    final user = context.watch<AuthProvider>().currentUser;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 16,
              left: 10,
              child:
          Image.asset("assets/images/logodark.png", width: 40, height: 40,)
          ),
          ListView(
            padding: const EdgeInsets.all(15),
              children: [
            Image.asset("assets/images/home.png", height: 130,),

            Text(
              "Welcome, ${user!.fName}!",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10,),
            const Text(
              "You’re ready to go, let’s find you a circlet",
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),

                Text(
                  tr('news'),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    separatorBuilder: (context, index)=>const SizedBox(width: 20,),
                    itemBuilder: (context, index)=>NewsWidget(
                      newsText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                      onTap: (){
                      ShowMyDialog.showMore("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum");
                    },),
                  ),
                ),

                SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),

                Text(
                  tr('gifts'),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    separatorBuilder: (context, index)=>const SizedBox(width: 20,),
                    itemBuilder: (context, index)=>NewsWidget(
                      newsText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                      onTap: (){
                        ShowMyDialog.showMore("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum");
                      },
                     ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 70,
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr('category'),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const OurCategory(),
                      ),
                    );
                  },
                  child: Text(
                    tr('see_all'),
                    style: TextStyle(fontSize: 15, color: p1),
                  ),
                ),
              ],
            ),
            categoriesProvider.isload
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 5,
                    child: Center(
                      child: LoadingIndicator(
                        indicatorType: Indicator.lineScalePulseOutRapid,
                        colors: [p7],
                      ),
                    ),
                  )
                : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: MediaQuery.of(context).size.height / 80,
                  ),
                  itemCount: categoriesProvider
                          .categories?.listCategory?.length ??
                      0,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: (){
                        final isActive = categoriesProvider.categories!.listCategory![index].isActive;
                        final hasData = categoriesProvider.categories!.listCategory![index].isHasData;

                        if(isActive == 0 || hasData == 0){
                          return;
                        }else if(hasData == 1){
                          Provider.of<CategoriesProvider>(context, listen: false).getSubCategories(categoriesProvider
                              .categories!.listCategory![index].id!);

                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => SubCategoryPage(title: categoriesProvider
                                  .categories!.listCategory![index].titl??'', catId: categoriesProvider
                                  .categories!.listCategory![index].id!,),
                            ),
                          );
                        }else if(hasData == 2){
                          final categoryFormModel = categoriesProvider
                              .categories!.listCategory![index].categoryFormModel;
                          final categoryModel = categoriesProvider
                              .categories!.listCategory![index];
                          if(categoryModel.formUsers != null && categoryFormModel!.members != categoryModel.formUsers!.length) {
                              GlobalMethods.navigate(
                                  context,
                                  SubmitFormPage(
                                    categoryForm: categoriesProvider
                                        .categories!
                                        .listCategory![index]
                                        .categoryFormModel!,
                                    formUsers: categoryModel.formUsers,
                                  ));
                            }else{
                            ShowMyDialog.showMsg('sorry! Members are complete', isError: true);
                          }
                          }

                      },
                      child: CategoryWidget(
                        category: categoriesProvider
                            .categories!.listCategory![index],
                        iconImage: "assets/icon/Credit card_light.png",
                      ),
                    );
                  }),
                )
          ]),
        ],
      ),
    );
  }
}


