import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/constants/color.dart';
import 'package:frontend/constants/shadow.dart';

class MainBottomAppBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const MainBottomAppBar(
      {Key? key, required this.selectedIndex, required this.onItemSelected})
      : super(key: key);

  Widget _buildSvgIcon(String assetPath, {required int index}) {
    return SvgPicture.asset(
      assetPath,
      height: 32,
      width: 32,
      color:
          index == selectedIndex ? ConstantsColors.primaryColor : Colors.white,
    );
  }

  Widget _buildActiveText(int index, String text) {
    return SizedBox(
      width: 100, // Fixed width for the text container
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis, // Use ellipsis for overflowing text
          style: TextStyle(
            color: index == selectedIndex
                ? ConstantsColors.primaryText
                : Colors.transparent,
            fontFamily: 'Gilroy',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context)!;

    return Container(
        color: Colors.transparent,
        child: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: ConstantsColors.blackText.withOpacity(0.9),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70))),
            height: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int index = 0; index < 3; index++)
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 18),
                      child: InkWell(
                        onTap: () => onItemSelected(index),
                        child: Padding(
                          padding: EdgeInsets.only(top: index == 1 ? 0 : 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: IconShadow(
                                  child: index == 0
                                      ? _buildSvgIcon(
                                          'assets/icons/home.svg',
                                          index: index,
                                        )
                                      : index == 1
                                          ? _buildSvgIcon(
                                              'assets/icons/map.svg',
                                              index: index,
                                            )
                                          : _buildSvgIcon(
                                              'assets/icons/events.svg',
                                              index: index,
                                            ),
                                ),
                              ),
                              _buildActiveText(
                                index,
                                index == 0
                                    ? translation.home
                                    : index == 1
                                        ? translation.map
                                        : translation.events,
                              ),
                            ],
                          ),
                        ),
                      ))
              ],
            ),
          )
        ]));
  }
}
