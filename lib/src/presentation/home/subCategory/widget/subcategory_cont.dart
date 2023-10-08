
import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/presentation/home/SubmitForm/submit_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubCategoryWidget extends StatefulWidget {
  const SubCategoryWidget({super.key,});


  @override
  State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => const SubmitFormPage(),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 45,
          right: MediaQuery.of(context).size.width / 45,
          bottom: MediaQuery.of(context).size.height / 45,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height / 9,
          width: MediaQuery.of(context).size.width / 0.6,
          decoration:
              BoxDecoration(color: p3, borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Container(
                height: MediaQuery.of(context).size.height / 16.5,
                width: MediaQuery.of(context).size.width / 7.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), color: p7),
                child: Image.asset(
                  "assets/icon/Credit card_light.png",
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 18,
                  width: MediaQuery.of(context).size.width / 8,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                       'widget.subcategory.titl ?? ',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '  widget.subcategory.desc ??',
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                      color: p7, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '  widget.subcategory.date ??',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'widget.subcategory.price ??  ',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      )
                    ],
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
