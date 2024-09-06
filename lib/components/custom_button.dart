import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.buttonTitle,
    required this.onPress,
    super.key,
    this.otpLength = 6,
  });
  final String buttonTitle;
  final VoidCallback onPress;
  final int otpLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: otpLength == 6 ? onPress : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey,
          child: Text(
            buttonTitle,
            style: const TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }
}

class PosterButton extends StatelessWidget {
  const PosterButton({
    required this.title,
    required this.color,
    required this.icon,
    this.onTap,
    super.key,
  });
  final VoidCallback? onTap;
  final String title;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),
          child: Row(
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
              SizedBox(
                width: 5.w,
              ),
              Icon(
                icon,
                size: 20.h,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
