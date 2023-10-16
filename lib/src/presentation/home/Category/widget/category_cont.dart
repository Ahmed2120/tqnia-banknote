import 'package:banknote/src/app/data/models/category_model.dart';
import 'package:banknote/src/app/providers/category_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:banknote/src/presentation/home/subCategory/sub_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({super.key, required this.category,required this.iconImage});
  final Category category;
  String iconImage ;
  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        // height: MediaQuery.of(context).size.height / 9,
        width: MediaQuery.of(context).size.width / 0.6,
        decoration:
            BoxDecoration(color: p3, borderRadius: BorderRadius.circular(30)),
        child: ListTile(
           leading: CircleAvatar(
            backgroundColor: p7,
          radius: 25,
            backgroundImage:  AssetImage(
              widget.iconImage,
            ),
          ),
          title: Text(
            widget.category.titl ?? ' ',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          subtitle: Text(
            widget.category.desc ?? ' ',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
         trailing: Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 4,
              decoration: BoxDecoration(
                  color: p7, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.category.date ?? ' ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    widget.category.price ?? ' ',
                    style:
                        const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  // const SizedBox(height: 10,),
                  if(widget.category.isActive == 0) Text(
                    tr('soon'),
                    style:
                        TextStyle(color: Color(0x6F4D566B), fontSize: 11),
                  ),
                ],
              )),
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.symmetric(horizontal: 7),),
      ),
    );
  }
}
