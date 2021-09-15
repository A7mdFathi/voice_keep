import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_procrew/business_logic/auth/authentication_bloc.dart';
import 'package:flutter_procrew/business_logic/send_voice/voice_message_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

import '../business_logic/notes_list_bloc/note_list_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => context.read<AuthenticationBloc>()
                  ..add(AuthenticationLogout()),
                icon: Icon(Icons.logout))
          ],
          title: Text('Home'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: BlocBuilder<NoteListBloc, NoteListState>(
            builder: (context, state) {
              return ListView.builder(
                itemBuilder: (context, index) => ListTile(),
              );
            },
          ),
        ),
        floatingActionButton: _VoiceButtonWidget(),
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
