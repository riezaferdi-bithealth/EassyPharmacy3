import 'package:flutter_eassypharmacy/core/core.dart';

const double kToastBottomMargin = 80.0;
const double kToastHorizontalMargin = 16.0;
const int kToastMaxLines = 6;
const EdgeInsets kToastPadding =
    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
Color kToastColor = systemBlackColor;
const int kToastDuration = 2000;
const int kToastAnimationDuration = 200;

class Toast {
  static void showToast(BuildContext context, String message,
      {Duration? duration}) {
    Completer toastFinished = Completer();
    OverlayEntry toastOverlay =
        _createToastOverlay(message, toastFinished, duration: duration!);

    OverlayState overlay = Overlay.of(context);

    // if (overlay == null) return;
    overlay.insert(toastOverlay);

    toastFinished.future.then((_) {
      toastOverlay.remove();
    });
  }
}

OverlayEntry _createToastOverlay(String message, Completer c,
    {Duration? duration}) {
  return OverlayEntry(
      builder: (context) => Positioned(
            bottom: kToastBottomMargin,
            left: kToastHorizontalMargin,
            right: kToastHorizontalMargin,
            child: _Toast(message, c, duration: duration),
          ));
}

class _Toast extends StatefulWidget {
  final String message;
  final Completer finished;
  final Duration duration;

  const _Toast(this.message, this.finished, {Duration? duration})
      : duration = duration ?? const Duration(milliseconds: kToastDuration);

  @override
  State<StatefulWidget> createState() => _ToastState();
}

class _ToastState extends State<_Toast> with SingleTickerProviderStateMixin {
  AnimationController? animCtrl;

  @override
  void initState() {
    super.initState();

    animCtrl = AnimationController(
        duration: const Duration(milliseconds: kToastAnimationDuration),
        vsync: this);
  }

  @override
  void dispose() {
    animCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) animCtrl?.forward();

      Future.delayed(widget.duration).then((_) {
        if (mounted) animCtrl?.reverse();

        Future.delayed(const Duration(milliseconds: kToastAnimationDuration))
            .then((_) {
          if (!widget.finished.isCompleted) widget.finished.complete();
        });
      });
    });

    return Material(
      color: Colors.transparent,
      child: FadeTransition(
          opacity: animCtrl!,
          child: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: kToastColor,
                    borderRadius: BorderRadius.circular(4.0)),
                padding: kToastPadding,
                child: Text(
                  widget.message,
                  style: TextStyle(color: systemWhiteColor),
                  maxLines: kToastMaxLines,
                  overflow: TextOverflow.ellipsis,
                )),
          )),
    );
  }
}
