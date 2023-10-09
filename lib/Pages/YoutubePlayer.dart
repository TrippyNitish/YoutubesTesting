import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerHomeScreen extends StatefulWidget {
  const YoutubePlayerHomeScreen({Key? key}) : super(key: key);

  @override
  State<YoutubePlayerHomeScreen> createState() =>
      _YoutubePlayerHomeScreenState();
}

class _YoutubePlayerHomeScreenState extends State<YoutubePlayerHomeScreen> {
  final TextEditingController urlController = TextEditingController();
  late YoutubePlayerController _controller;
  Duration? _previousPosition;

void initState() {

    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: 'Itntw6h2yEA', // Default video ID
      flags: YoutubePlayerFlags(autoPlay: false),
    );

    // Set up callbacks for play and pause actions
    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        print("Video is playing");
      } else {
        print("Video is paused");
      }
    });
    }

  void handleSearchUrl() {
    final videoId = YoutubePlayer.convertUrlToId(urlController.text.trim());
    print("Search clicked");
    if (videoId != null) {
      setState(() {
        _controller.load(videoId); // Load the new video using the existing controller
        _controller.play(); // Play the new video
      });
    }
  }

  void playPausecontroller(){
      isPlaying:_controller.value.isPlaying;
      setState(() {
        if(_controller.value.isPlaying){
          _controller.pause();
        }else{
          _controller.play();
        }
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Youtube Video Player"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: urlController),
          ),
          ElevatedButton(
            onPressed: handleSearchUrl,
            child: Text("Search"),
          ),
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () => debugPrint('Ready'),
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: const ProgressBarColors(
                  playedColor: Color.fromARGB(255, 212, 195, 2),
                  handleColor: Color.fromARGB(55, 34, 252, 1),
                ),
              ),
              PlayPauseButton(), // Play/Pause button
              FullScreenButton(), // Fullscreen button
            ],
          ),
          ElevatedButton(onPressed: playPausecontroller, child: Text("Play/Pause"))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
