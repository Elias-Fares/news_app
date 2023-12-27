import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChangeStateWidget extends StatelessWidget {
  ChangeStateWidget(
      {required this.state,
      this.onLoading,
      required this.onSuccess,
      this.onFailure,
      this.onErrorFunction});

  final String state;
  Widget? onLoading;
  final Widget onSuccess;
  Widget? onFailure;
  Function? onErrorFunction;

  @override
  Widget build(BuildContext context) {
    print(".....................   $state      ...................");
    if (state == 'loading')
      return onLoading ??
          Center(
              child: CircularProgressIndicator(
            color: const Color.fromARGB(255, 31, 90, 139),
          ));
    else if (state == 'done')
      return onSuccess;
    else if (state == 'error')
      return onFailure != null
          ? onFailure!
          : onErrorFunction != null
              ? Center(
                  child: Column(
                    children: [
                      const Text('Error'),
                      TextButton(
                        onPressed: () {
                          print('Retry');
                          onErrorFunction!();
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Center(child: const Text(''));

    return Container();
  }
}
