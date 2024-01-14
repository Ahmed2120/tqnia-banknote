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

import '../../app/utils/global_methods.dart';
import '../../app/widgets/alert_dialog.dart';
import '../../app/widgets/pages_background.dart';
import '../home/SubmitForm/submit_form.dart';


class SubSubCategoryPage extends StatefulWidget {
  SubSubCategoryPage({required this.title, required this.catId, super.key});

  String title;
  int catId;

  @override
  State<SubSubCategoryPage> createState() => _SubSubCategoryPageState();
}

class _SubSubCategoryPageState extends State<SubSubCategoryPage> {

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
                  Consumer<CategoryProvider>(
                      builder: (context, categoryProvider, _) {
                        return categoryProvider.isload ? Expanded(
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
                            itemCount: categoryProvider
                                .category!.listCategory?.length ??
                                0,
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () {
                                  final isActive = categoryProvider.category!.listCategory![index].isActive;
                                  final hasData = categoryProvider.category!.listCategory![index].isHasData;

                                  if(isActive == 0 || hasData == 0){
                                    return;
                                  }
                                  else if(hasData == 2){
                                    final categoryFormModel = categoryProvider
                                        .category!.listCategory![index].categoryFormModel;
                                    final categoryModel = categoryProvider
                                        .category!.listCategory![index];
                                    if(categoryModel!.formUsers != null && categoryFormModel!.members != categoryModel.formUsers!.length) {
                                        GlobalMethods.navigate(
                                            context,
                                            SubmitFormPage(
                                                categoryForm: categoryFormModel,
                                            formUsers: categoryModel.formUsers,));
                                      }else{
                                      ShowMyDialog.showMsg('sorry! Members are complete', isError: true);
                                    }
                                    }
                                },
                                child: CategoryWidget(
                                  category: categoryProvider
                                      .category!.listCategory![index],
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
