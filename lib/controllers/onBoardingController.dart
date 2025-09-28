import 'package:flutter_clinic_app/models/onBoard.dart';
import 'package:flutter_clinic_app/utils/constants/image_strings.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController{
  RxInt currentPage = 0.obs;

  final List<onBoard> onBoardData = [
    onBoard(
        image: AppImages.onBoardingImage1,
        title: "Accurate specialist search made simple"),

    onBoard(
        image: AppImages.onBoardingImage2,
        title: "Book appointments effortlessly"),

    onBoard(
        image: AppImages.onBoardingImage3,
        title: "Expert advice & chat at your fingertips"),
  ];
}