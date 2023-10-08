import 'package:banknote/src/app/providers/categories_provider.dart';
import 'package:banknote/src/presentation/auth/widget/arrow_back_cont.dart';
import 'package:banknote/src/presentation/home/Category/widget/category_cont.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class OurCategory extends StatelessWidget {
  const OurCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoriesProvider>(context);
    return Scaffold(
      body: Stack(children: [
        SizedBox(width: double.infinity, child: Image.asset("assets/images/Screen.jpg", fit: BoxFit.fill,)),
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
                Get.back();
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 15, left: 15, bottom: 15),
            child: Text(
              "Category",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                    return CategoryWidget(
                        category:
                            category.categories!.listCategory![index],
                             iconImage: "assets/icon/Credit card_light.png",);
                  }),
                ),
              )
        ]),
      ]),
    );
  }
}
