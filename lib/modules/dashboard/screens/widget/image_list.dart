import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mediavault/modules/dashboard/logic/file_finder/file_finder_bloc.dart';

class ImageList extends StatelessWidget {
  const ImageList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileFinderBloc, FileFinderState>(
      builder: (context, state) {
        if (state is FileFinderLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<FileFinderBloc>().add(const LoadFileFinderEvent());
            },
            child: ListView.builder(
              itemCount: state.imagefiles.length,
              padding: const EdgeInsets.all(30),
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: const Icon(Icons.image),
                  title: Text(state.videofiles[index].path.split('/').last),
                  trailing: PopupMenuButton(
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        onTap: () {
                          context.read<FileFinderBloc>().add(
                              OpenFileFinderEvent(state.videofiles[index]));
                        },
                        value: 1,
                        child: const Text('Open'),
                      ),
                      PopupMenuItem(
                        onTap: () {},
                        value: 2,
                        child: const Text('Export'),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          context.read<FileFinderBloc>().add(
                              DeleteFileFinderEvent(
                                  file: state.videofiles[index]));
                        },
                        value: 3,
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90,
                  width: 90,
                  child: Lottie.asset('assets/animations/loding.json',
                      fit: BoxFit.fitHeight),
                ),
                IconButton(
                    onPressed: () {
                      context
                          .read<FileFinderBloc>()
                          .add(const LoadFileFinderEvent());
                    },
                    icon: const Icon(Icons.refresh))
              ],
            ),
          );
        }
      },
    );
  }
}
