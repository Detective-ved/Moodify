import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MoodPage(),
    );
  }
}

class MoodPage extends StatefulWidget {
  @override
  _MoodPageState createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  String mood = "🙂";
  String message = "How are you feeling today?";
  Color bgColor = Colors.white;

  List<Map<String, String>> history = [];

  void setMood(String newMood) {
    setState(() {
      if (newMood == "happy") {
        mood = "😄";
        message = "You're doing great!";
        bgColor = Colors.yellow.shade100;
      } else if (newMood == "sad") {
        mood = "😢";
        message = "It's okay to feel sad.";
        bgColor = Colors.blue.shade100;
      } else if (newMood == "angry") {
        mood = "😡";
        message = "Take a deep breath.";
        bgColor = Colors.red.shade100;
      } else if (newMood == "chill") {
        mood = "😌";
        message = "Stay calm & relaxed.";
        bgColor = Colors.green.shade100;
      }

      history.insert(0, {"emoji": mood, "text": message});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Mood Updated!")),
      );
    });
  }

  void clearHistory() {
    setState(() {
      history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moodify 😎"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: clearHistory,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [bgColor, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),

            Text(mood, style: TextStyle(fontSize: 60)),
            Text(message, style: TextStyle(fontSize: 18)),

            SizedBox(height: 20),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => setMood("happy"),
                  icon: Icon(Icons.sentiment_satisfied),
                  label: Text("Happy"),
                ),
                OutlinedButton(
                  onPressed: () => setMood("sad"),
                  child: Text("Sad"),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.sentiment_very_dissatisfied, size: 30),
                  onPressed: () => setMood("angry"),
                ),
                TextButton(
                  onPressed: () => setMood("chill"),
                  child: Text("Chill 😌"),
                ),
              ],
            ),

            SizedBox(height: 20),

            Text("Mood History", style: TextStyle(fontSize: 20)),

            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      leading: Text(
                        history[index]["emoji"]!,
                        style: TextStyle(fontSize: 30),
                      ),
                      title: Text(history[index]["text"]!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}