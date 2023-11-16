import 'package:banknote/src/app/providers/categories_provider.dart';
import 'package:banknote/src/presentation/auth/widget/arrow_back_cont.dart';
import 'package:banknote/src/presentation/home/Category/widget/category_cont.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../app/utils/global_methods.dart';
import '../../../app/widgets/alert_dialog.dart';
import '../../../app/widgets/pages_background.dart';
import '../SubmitForm/submit_form.dart';
import '../subCategory/sub_category.dart';

class OurCategory extends StatelessWidget {
  const OurCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoriesProvider>(context);
    return Scaffold(
      body:  PagesBackground(
        child: Stack(children: [
          // SizedBox(width: double.infinity, child: Image.asset("assets/images/Screen.jpg", fit: BoxFit.fill,)),
          Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
            Center(child: Image.asset("assets/images/logodark.png")),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ArrowBackContainer(
                onpress: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: Text(
                tr('category'),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            category.isload
                ? Center(
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballScale,
                      colors: [Theme.of(context).primaryColor],
                    ),
                  )
                : Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: MediaQuery.of(context).size.height / 80,
                    ),
                    itemCount:
                        category.categories?.listCategory?.length ?? 0,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: (){
                          final isActive = category.categories!.listCategory![index].isActive;
                          final hasData = category.categories!.listCategory![index].isHasData;

                          if(isActive == 0 || hasData == 0){
                            return;
                          }else if(hasData == 1){
                            Provider.of<CategoriesProvider>(context, listen: false).getSubCategories(category
                                .categories!.listCategory![index].id!);

                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => SubCategoryPage(title: category
                                    .categories!.listCategory![index].titl??'', catId: category
                                    .categories!.listCategory![index].id!,),
                              ),
                            );
                          }else if(hasData == 2){
                            final categoryFormModel = category
                                .categories!.listCategory![index].categoryFormModel;
                            final categoryModel = category
                                .categories!.listCategory![index];
                            if(categoryModel.formUsers != null && categoryFormModel!.members != categoryModel.formUsers!.length)
                            {
                                    GlobalMethods.navigate(
                                        context,
                                        SubmitFormPage(
                                          categoryForm: categoryFormModel,
                                          formUsers: categoryModel.formUsers,
                                        ));
                                  }else{
                              ShowMyDialog.showMsg('sorry! Members are complete', isError: true);
                            }
                                }

                        },
                        child: CategoryWidget(
                            category:
                                category.categories!.listCategory![index],
                                 iconImage: "assets/icon/Credit card_light.png",),
                      );
                    }),
                  ),
                )
          ]),
        ]),
      ),
    );
  }
}
