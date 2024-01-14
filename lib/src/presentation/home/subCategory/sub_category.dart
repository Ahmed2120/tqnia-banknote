import 'package:banknote/src/app/data/dio/exception/dio_error_extention.dart';
import 'package:banknote/src/app/providers/categories_provider.dart';
import 'package:banknote/src/app/providers/category_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/app/widgets/custom_snackbar.dart';
import 'package:banknote/src/presentation/auth/widget/arrow_back_cont.dart';
import 'package:banknote/src/presentation/home/Category/widget/category_cont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../app/utils/global_methods.dart';
import '../../../app/widgets/alert_dialog.dart';
import '../../../app/widgets/pages_background.dart';
import '../../subSubCategory/subSubCategory.dart';
import '../SubmitForm/submit_form.dart';

class SubCategoryPage extends StatefulWidget {
  SubCategoryPage({required this.title, required this.catId, super.key});

  String title;
  int catId;

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    print('121111111');
    // _getData();
    // });
  }

  _getData() async {
    try {
      Provider.of<CategoryProvider>(context).getCategoryDetails(widget.catId);
    } catch (e) {
      // showCustomSnackBar(readableError(e), context, isError: true);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final instancOfCategoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      body: PagesBackground(
        child: Stack(children: [
          // SizedBox(width: double.infinity,
          //     child: Image.asset("assets/images/Screen.jpg", fit: BoxFit.fill,)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 15,
                  ),
                  Align(alignment: Alignment.center,child: Image.asset('assets/images/logo.png'),),
                  const SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ArrowBackContainer(
                      onpress: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(right: 15, left: 15, bottom: 15),
                    child: Text(
                      widget.title,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Consumer<CategoriesProvider>(
                      builder: (context, categoriesProvider, _) {
                        return categoriesProvider.subCatLoad ? Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 5,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 5,
                              child: Center(
                                child: LoadingIndicator(
                                  indicatorType: Indicator.lineScalePulseOutRapid,
                                  colors: [p7],
                                ),
                              ),
                            ),
                          ),
                        ) : Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            separatorBuilder: (context, index) =>
                                SizedBox(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 50,
                                ),
                            itemCount: categoriesProvider
                                .subCategories!.listCategory?.length ??
                                0,
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () {
                                  final isActive = categoriesProvider.subCategories!.listCategory![index].isActive;
                                  final hasData = categoriesProvider.subCategories!.listCategory![index].isHasData;

                                  if(isActive == 0 || hasData == 0){
                                    return;
                                  }else if(hasData == 1){
                                    Provider.of<CategoryProvider>(context, listen: false).getCategoryDetails(categoriesProvider
                                        .subCategories!.listCategory![index].id!);

                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (_) => SubSubCategoryPage(title: categoriesProvider
                                            .subCategories!.listCategory![index].titl??'', catId: categoriesProvider
                                            .subCategories!.listCategory![index].id!,),
                                      ),
                                    );
                                  }else if(hasData == 2){
                                    final categoryFormModel = categoriesProvider
                                        .subCategories!.listCategory![index].categoryFormModel;
                                    final categoryModel = categoriesProvider
                                        .subCategories!.listCategory![index];
                                    if(categoryModel.formUsers != null && categoryFormModel!.members != categoryModel.formUsers!.length) {
                                        GlobalMethods.navigate(
                                            context,
                                            SubmitFormPage(
                                              categoryForm: categoriesProvider
                                                  .subCategories!
                                                  .listCategory![index]
                                                  .categoryFormModel!,
                                              formUsers: categoryModel.formUsers,
                                            ));
                                      }else{
                                      ShowMyDialog.showMsg('sorry! Members are complete', isError: true);
                                    }
                                    }


                                  // GlobalMethods.navigate(context, const SubmitFormPage());
                                },
                                child: CategoryWidget(
                                  category: categoriesProvider
                                      .subCategories!.listCategory![index],
                                  iconImage: "assets/icon/category-icon.png",),
                              );
                            }),
                          ),
                        );
                      }
                  ),
                ]),
          ),

        ]),
      ),
    );
  }
}
