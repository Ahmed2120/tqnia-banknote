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
    final instancOfCategoriesProvider =
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
          Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 16,
            ),
            Center(child: Image.asset("assets/images/home.png")),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Welcome, ${user!.fName}!",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "You’re ready to go, let’s find you a circlet",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        lang = false;
                      });
                    },
                    child: Text(
                      tr('category'),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
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
            ),
            instancOfCategoriesProvider.isload
                ? Expanded(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 5,
                      child: Center(
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineScalePulseOutRapid,
                          colors: [p7],
                        ),
                      ),
                    ),
                )
                : Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: MediaQuery.of(context).size.height / 80,
                    ),
                    itemCount: instancOfCategoriesProvider
                            .categories?.listCategory?.length ??
                        0,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: (){
                          final isActive = instancOfCategoriesProvider.categories!.listCategory![index].isActive;
                          final hasData = instancOfCategoriesProvider.categories!.listCategory![index].isHasData;

                          if(isActive == 0 || hasData == 0){
                            return;
                          }else if(hasData == 1){
                            Provider.of<CategoriesProvider>(context, listen: false).getSubCategories(instancOfCategoriesProvider
                                .categories!.listCategory![index].id!);

                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => SubCategoryPage(title: instancOfCategoriesProvider
                                    .categories!.listCategory![index].titl??'', catId: instancOfCategoriesProvider
                                    .categories!.listCategory![index].id!,),
                              ),
                            );
                          }else if(hasData == 2){
                            final categoryModel = instancOfCategoriesProvider
                                .categories!.listCategory![index].categoryFormModel;
                            if(categoryModel!.formUsers != null && categoryModel.members != categoryModel.formUsers!.length) {
                                GlobalMethods.navigate(
                                    context,
                                    SubmitFormPage(
                                      categoryForm: instancOfCategoriesProvider
                                          .categories!
                                          .listCategory![index]
                                          .categoryFormModel!,
                                    ));
                              }else{
                              ShowMyDialog.showMsg('sorry! Members are complete', isError: true);
                            }
                            }

                        },
                        child: CategoryWidget(
                          category: instancOfCategoriesProvider
                              .categories!.listCategory![index],
                          iconImage: "assets/icon/Credit card_light.png",
                        ),
                      );
                    }),
                  ),
                )
          ]),
        ],
      ),
    );
  }
}
