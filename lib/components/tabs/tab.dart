import 'package:eva_design_flutter/eva_design_flutter.dart';
import 'package:flutter/material.dart';

class EqTabData {
  final IconData icon;
  final String title;
  final bool disabled;

  EqTabData({this.icon, this.title, this.disabled = false});
}

class EqTab extends StatefulWidget {
  final EqTabData data;
  final bool active;
  final VoidCallback onTap;

  const EqTab({
    Key key,
    this.data,
    this.active = false,
    this.onTap,
  }) : super(key: key);

  @override
  _EqTabState createState() => _EqTabState();
}

class _EqTabState extends State<EqTab> {
  bool tapping = false;
  Color getColor(EqThemeData theme) {
    if (widget.onTap == null) return theme.textDisabledColor;
    return widget.active ? theme.primary.shade500 : theme.textHintColor;
  }

  Color getContainerColor(EqThemeData theme) {
    if (widget.onTap == null) return Colors.transparent;
    if (widget.active) return theme.primary.shade500;
    if (tapping) return theme.primary.shade400;
    return theme.borderBasicColors.color3;
  }

  @override
  Widget build(BuildContext context) {
    var theme = EqTheme.of(context);
    var color = getColor(theme);
    var containerColor = getContainerColor(theme);

    return OutlinedGestureDetector(
      onOutlineChange: (v) => setState(() => tapping = v),
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.data.icon != null)
                    Icon(
                      widget.data.icon,
                      size: 18.0,
                      color: color,
                    ),
                  if (widget.data.icon != null && widget.data.title != null)
                    SizedBox(height: 2.0),
                  if (widget.data.title != null)
                    Text(
                      widget.data.title.toUpperCase(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style:
                          theme.buttonMedium.textStyle.copyWith(color: color),
                    ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: theme.minorAnimationDuration,
                curve: theme.minorAnimationCurve,
                width: double.infinity,
                height: 4.0,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}