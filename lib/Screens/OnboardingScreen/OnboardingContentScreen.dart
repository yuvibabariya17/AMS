import 'package:booking_app/core/constants/assets.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Track Your work and get the result",
    image: Asset.introscreen_one,
    desc: "Remember to keep track of your professional accomplishments.",
  ),
  OnboardingContents(
    title: "Stay organized with team",
    image: Asset.introscreen_two,
    desc:
        "But understanding the contributions our colleagues make to our teams and companies.",
  ),
  OnboardingContents(
    title: "Get notified when work happens",
    image: Asset.introscreen_three,
    desc:
        "Take control of notifications, collaborate live or on your own time.",
  ),
];
