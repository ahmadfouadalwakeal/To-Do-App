import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_app/core/commons/commons.dart';
import 'package:to_do_app/core/database/cache_helper.dart';
import 'package:to_do_app/core/services/service_locator.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';
import 'package:to_do_app/core/widgets/custom_text_button.dart';
import 'package:to_do_app/features/auth/data/model/on_boarding_model.dart';
import 'package:to_do_app/features/tasks/presentation/screens/home_screen/home_screen.dart';

class OnBoardingScreens extends StatelessWidget {
  OnBoardingScreens({super.key});
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: PageView.builder(
            controller: controller,
            itemCount: OnBoardingModel.onBoardingSceens.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  //text skip
                  index != 2
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: CustomTextButton(
                            text: AppStrings.skip,
                            onPressed: () {
                              controller.jumpToPage(2);
                            },
                          ),
                        )
                      : const SizedBox(
                          height: 54,
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  //onBoarding1 image
                  SvgPicture.asset(
                      OnBoardingModel.onBoardingSceens[index].imgPath),
                  const SizedBox(
                    height: 16,
                  ),
                  //dots
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: AppColors.primary,
                      spacing: 8,
                      dotHeight: 8,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  //title
                  Text(
                    OnBoardingModel.onBoardingSceens[index].title,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 42,
                  ),

                  //subTitle
                  Text(
                    OnBoardingModel.onBoardingSceens[index].subTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 107,
                  ),
                  //buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //back buttons
                      index != 0
                          ? CustomTextButton(
                              text: AppStrings.back,
                              onPressed: () {
                                controller.previousPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.fastEaseInToSlowEaseOut);
                              },
                            )
                          : Container(),
                      //next button
                      index != 2
                          ? CustomButton(
                              onPressed: () {
                                controller.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.fastEaseInToSlowEaseOut);
                              },
                              text: AppStrings.next)
                          : CustomButton(
                              onPressed: () async {
                                // navigate to home screen
                                await sl<CacheHelper>()
                                    .saveData(
                                        key: AppStrings.onBoardingKey,
                                        value: true)
                                    .then(
                                  (value) {
                                    navigate(
                                        context: context,
                                        screen: const HomeScreen());
                                  },
                                ).catchError((e) {
                                  print(e.toString());
                                });
                              },
                              text: AppStrings.getStarted),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
