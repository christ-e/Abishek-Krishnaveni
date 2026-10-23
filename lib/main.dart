import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:abi_veni_wedding_card/app/data/wedding_data.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "${WeddingData.groomName} & ${WeddingData.brideName}",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
