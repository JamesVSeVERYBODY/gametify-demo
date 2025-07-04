import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 138, 60, 55),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 25),

            // Shop name
            Text(
              "GAMETIFY",
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 28,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 25),

            // Icon
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.asset('lib/images/board-game.png'),
            ),

            const SizedBox(height: 25),

            // Title
            Text(
              "Game Site",
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 44,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 25),

            // Subtitle
            Text(
              "Beli game ya di Gametify",
              style: TextStyle(
                color: Colors.grey[300],
                height: 2,
              ),
            ),

            const SizedBox(height: 25),

            // Get started button
            ElevatedButton(
              onPressed: () {
                // Add your onPressed logic here
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
