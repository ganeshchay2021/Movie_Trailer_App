import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TraillerWidget extends StatefulWidget {
  const TraillerWidget({
    Key? key,
    required this.traillerId,
  }) : super(key: key);
  final String traillerId;

  @override
  State<TraillerWidget> createState() => _TraillerWidgetState();
}

class _TraillerWidgetState extends State<TraillerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoid = YoutubePlayer.convertUrlToId(widget.traillerId);
    _controller = YoutubePlayerController(
      initialVideoId: videoid.toString(),
      flags: const YoutubePlayerFlags(
        loop: true,
        enableCaption: false,
        autoPlay: true,
        mute: false,
        controlsVisibleAtStart: true,
        forceHD: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0.0),
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            thumbnail: Image.network(
              "https://img.youtube.com/vi/${widget.traillerId}/hqdefault.jpg",
              fit: BoxFit.cover,
            ),
            controlsTimeOut: const Duration(milliseconds: 1500),
            aspectRatio: 16 / 9,
            controller: _controller,
            showVideoProgressIndicator: true,
            bufferIndicator: const Center(
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              )),
            ),
            progressIndicatorColor: Colors.amber,
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                  isExpanded: true,
                  colors: const ProgressBarColors(
                    playedColor: Colors.white,
                    handleColor: Colors.amber,
                  )),
              // RemainingDuration(),
            ],
          ),
          builder: (context, player) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Trailer'),
              ),
              body: Center(
                child: player,
              ),
            );
          },
        ));
  }
}
