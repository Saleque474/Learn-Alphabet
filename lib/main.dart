import 'package:flutter/material.dart';
import 'package:learn_alphabet/constants.dart';

void main() {
  runApp(const LearnAlphabetApp());
}

class LearnAlphabetApp extends StatelessWidget {
  const LearnAlphabetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currentAlphabet = "A";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      body: LayoutBuilder(builder: (context, constraints) {
        var height = constraints.maxHeight;
        var width = constraints.maxWidth;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            sentenceHolder(height, width),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                imageHolder(height, width),
                wordHolder(height, width),
              ],
            ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Wrap(
                children: [
                  ...alphabets
                      .map(
                        (e) => textHolder(e),
                      )
                      .toList()
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget wordHolder(double height, double width) {
    return Container(
      height: height * 0.2,
      width: width * 0.35,
      decoration: BoxDecoration(
          color: Colors.blue[200], borderRadius: BorderRadius.circular(15)),
      child: Center(child: Text(collection[currentAlphabet]["word"])),
    );
  }

  Widget imageHolder(double height, double width) {
    return ImageDisplayer(
      height,
      width,
      currentAlphabet: currentAlphabet,
    );
  }

  Widget sentenceHolder(double height, double width) {
    return Container(
      height: height * 0.1,
      width: width * 0.7,
      decoration: BoxDecoration(
          color: Colors.blue[200], borderRadius: BorderRadius.circular(15)),
      child: Center(child: Text(collection[currentAlphabet]["sentence"])),
    );
  }

  Widget textHolder(String alphabet) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: ElevatedButton(
        onPressed: () {
          currentAlphabet = alphabet;
          setState(() {});
        },
        child: Text(alphabet),
      ),
    );
  }
}

class ImageDisplayer extends StatefulWidget {
  const ImageDisplayer(
    this.height,
    this.width, {
    Key? key,
    required this.currentAlphabet,
  }) : super(key: key);
  final double height;
  final double width;
  final String currentAlphabet;

  @override
  State<ImageDisplayer> createState() => _ImageDisplayerState();
}

class _ImageDisplayerState extends State<ImageDisplayer>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.stop();
    animationController.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.reset();
    animationController.forward();
    return FadeTransition(
      opacity: animation,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: widget.height * 0.2,
          width: widget.width * 0.35,
          decoration: BoxDecoration(
              color: Colors.blue[200], borderRadius: BorderRadius.circular(15)),
          child: Image.asset(
            collection[widget.currentAlphabet]["image"],
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
