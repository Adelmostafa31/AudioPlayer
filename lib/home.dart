import 'package:audio_player/Bloc/bloc.dart';
import 'package:audio_player/Bloc/states.dart';
import 'package:audio_player/core/constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => audioBloc(),
      child: BlocConsumer<audioBloc, audioStates>(
        listener: (context, state) {
          if (state is STARecord) {
            toast(
              context: context,
              message: 'Recording Started',
              color: Colors.green,
            );
          }
          if (state is STPRecord) {
            toast(
              context: context,
              message: 'Recording Stoped',
              color: Colors.red,
            );
          }
          if (state is STRPlay) {
            toast(
              context: context,
              message: 'Play Record Started',
              color: Colors.green,
            );
          }
          if (state is STPPlay) {
            toast(
              context: context,
              message: 'Play Record Stoped',
              color: Colors.red,
            );
          }
        },
        builder: (context, state) {
          var cubit = audioBloc.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.amber,
              title: const Text(
                'Audio Player',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 80),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(
                      children: [
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            cubit.playRecord();
                          },
                          icon: const Icon(
                            Icons.play_arrow_rounded,
                            size: 70,
                            color: Colors.amber,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            cubit.stopPlayRecord();
                          },
                          icon: const Icon(
                            Icons.stop,
                            size: 50,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          cubit.stopRecord();
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 60,
                          color: Colors.red,
                        ),
                      ),
                      InkWell(
                        onLongPress: () {
                          cubit.startRecord();
                        },
                        child: Lottie.asset('assets/image/mic.json',
                            width: 100, height: 100),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
