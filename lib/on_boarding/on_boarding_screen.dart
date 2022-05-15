import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:xai_pneumonia_detect/modules/login_or_register/login_register_screen.dart';

import '../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import '../shared/components/components.dart';
import '../shared/style/colors.dart';

class BoardingModel{

  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body'),
  ];
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if(value){
        navigateAndFinish(context,  const LRScreen());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions: [
          defaultTextButton(
            function: submit,
            text: 'SKIP',
          ),
        ],
      ) ,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                itemBuilder: (context , index)=> buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index){
                  if(index == boarding.length-1){
                    setState(() {
                      isLast = true;
                    });

                  }
                  else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },

              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children:  [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,

                  ),
                ),
                const Spacer(),//take all space in between
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }
                    else{
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,);
                    }

                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            )

          ],
        ),
      ) ,
    );

  }

  Widget buildBoardingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(
        child: Image(
          image: AssetImage(model.image),
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 24.0,
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 14.0,
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),


    ],
  );
}