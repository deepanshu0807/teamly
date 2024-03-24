import 'package:flutter/material.dart';
import 'package:flutter_utility/constant_utility.dart';
import 'package:my_team/utils/utility.dart';
import 'package:my_team/utils/variables.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

class CallScreenGetStream extends StatefulWidget {
  final Call call;

  const CallScreenGetStream({
    Key? key,
    required this.call,
  }) : super(key: key);

  @override
  State<CallScreenGetStream> createState() => _CallScreenGetStreamState();
}

class _CallScreenGetStreamState extends State<CallScreenGetStream> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamCallContainer(
        call: widget.call,
        callContentBuilder: (
          BuildContext context,
          Call call,
          CallState callState,
        ) {
          return StreamCallContent(
            call: call,
            callState: callState,
            callAppBarBuilder: (context, call, callState) {
              return PreferredSize(
                preferredSize: Size.fromHeight(screenHeight(context) / 10),
                child: Container(
                  height: screenHeight(context) / 8,
                  width: screenWidth(context),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: borderR20,
                  ),
                  padding: padding20.copyWith(top: 50.h),
                  child: Row(
                    mainAxisAlignment: mainSB,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Call ID",
                            style: text14.copyWith(color: Colors.white54),
                          ),
                          horizontalSpaceSmall,
                          Text(
                            callState.callId,
                            style: text14.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: padding5,
                          backgroundColor: Colors.black,
                          shape: shape15,
                        ),
                        onPressed: () async {
                          await Share.share(
                              'Hey, join me on Teamly meeting with this call ID - ${callState.callId}  \n\n Download Teamly: $appLink');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.share,
                              color: Colors.white70,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Participants",
                            style: text14.copyWith(color: Colors.white54),
                          ),
                          horizontalSpaceSmall,
                          Text(
                            callState.callParticipants.length.toString(),
                            style: text14.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            callControlsBuilder: (
              BuildContext context,
              Call call,
              CallState callState,
            ) {
              final localParticipant = callState.localParticipant!;
              return StreamCallControls(
                backgroundColor: Colors.black,
                borderRadius: borderR20,
                padding: padding15,
                options: [
                  FlipCameraOption(
                    call: call,
                    localParticipant: localParticipant,
                  ),
                  AddReactionOption(
                    call: call,
                    localParticipant: localParticipant,
                  ),
                  ToggleMicrophoneOption(
                    call: call,
                    localParticipant: localParticipant,
                    enabledMicrophoneIconColor: Colors.green,
                    disabledMicrophoneIconColor: Colors.red,
                  ),
                  ToggleCameraOption(
                    call: call,
                    localParticipant: localParticipant,
                    enabledCameraIconColor: Colors.green,
                    disabledCameraIconColor: Colors.red,
                  ),
                  LeaveCallOption(
                    call: call,
                    onLeaveCallTap: () {
                      call.leave();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
