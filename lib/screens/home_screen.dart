import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_procrew/business_logic/auth/authentication_bloc.dart';
import 'package:flutter_procrew/business_logic/send_voice/voice_message_cubit.dart';
import 'package:flutter_procrew/dependencies/dependency_init.dart';
import 'package:flutter_procrew/widgets/record_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

import '../business_logic/notes_list_bloc/note_list_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
      builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<VoiceMessageCubit>()),
              BlocProvider(create: (_) => getIt<NoteListBloc>()),
            ],
            child: HomeScreen(),
          ));

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    return BlocProvider(
      lazy: false,
      create: (context) =>
          getIt<NoteListBloc>()..add(NotesListFetched(user.id)),
      child: BlocListener<VoiceMessageCubit, VoiceMessageState>(
        listener: (context, state) {
          if (state is VoiceMessageRecorded) {
            buildShowDialog(context);
          }
        },
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () => context.read<AuthenticationBloc>()
                      ..add(AppLogoutRequested()),
                    icon: Icon(Icons.logout))
              ],
              title: Text('Home'),
              centerTitle: true,
            ),
            body: Container(
                color: Colors.white,
                child: BlocBuilder<NoteListBloc, NoteListState>(
                  builder: (context, state) {
                    if (state is NoteListLoaded) {
                      final list = state.noteList;
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final note = list[index].data();
                          return ListTile(
                            title:
                                VoiceMessageWidget(voiceUrl: '${note.noteUrl}'),
                            // title: Text('${list[index].data().noteUrl}'),
                          );
                        },
                      );
                    } else if (state is NoteListLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return const SizedBox();
                  },
                )),
            floatingActionButton: const _VoiceButtonWidget(),
          ),
        ),
      ),
    );
  }
}

class _VoiceButtonWidget extends StatelessWidget {
  const _VoiceButtonWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final state = context.watch<VoiceMessageCubit>().state;
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          primary: state is VoiceMessageRecording ? Colors.white : Colors.grey,
          fixedSize: Size(80.r, 80.r),
        ),
        onPressed: () async {
          if (state is VoiceMessageRecording) {
            context.read<VoiceMessageCubit>().stopRecording();
          } else {
            context.read<VoiceMessageCubit>().startRecording();
          }
        },
        child: Icon(
          state is VoiceMessageRecording ? Icons.stop : Icons.mic,
          color: state is VoiceMessageRecording ? Colors.red : Colors.white,
          size: 24.sp,
        ),
      );
    });
  }
}

Future<dynamic> buildShowDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        elevation: 25.0,
        insetPadding: EdgeInsets.all(12.r),
        insetAnimationDuration: Duration(milliseconds: 1000),
        insetAnimationCurve: Curves.bounceInOut,
        child: Container(
          width: 0.70.sw,
          height: 0.30.sh,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Icon(
                Icons.sentiment_satisfied_alt,
                size: 40.sp,
                color: Colors.blue,
              ),
              const Spacer(),
              Text(
                'Save This Record',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, color: Colors.blue),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(20.r),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        shape: const StadiumBorder(),
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        primary: Colors.blue,
                      ),
                      onPressed: () {
                        context.read<VoiceMessageCubit>().sendVoice();

                        Navigator.pop(context, true);
                      },
                      child: const Text('Yes'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        shape: const StadiumBorder(),
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        primary: Colors.blue,
                      ),
                      onPressed: () {
                        context.read<VoiceMessageCubit>().cancelSendVoice();
                        Navigator.pop(context, true);
                      },
                      child: const Text('No'),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    },
  );
}
