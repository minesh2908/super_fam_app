import 'package:flutter/material.dart';

class TextHeadingController extends StatelessWidget {
  const TextHeadingController({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontWeight: FontWeight.w400),
    );
  }
}

class TextContentUI extends StatelessWidget {
  const TextContentUI({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}

class TextTitle extends StatelessWidget {
  const TextTitle({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class TextPosterName extends StatelessWidget {
  const TextPosterName({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(fontWeight: FontWeight.bold)
          .copyWith(color: Colors.white),
    );
  }
}

class TextPosterDesignation extends StatelessWidget {
  const TextPosterDesignation({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Colors.yellowAccent),
    );
  }
}
