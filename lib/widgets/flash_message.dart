import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FlashMessage extends StatelessWidget{
  late String message;
  FlashMessage({required this.message});
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            height: 90,
            decoration: const BoxDecoration(
              color: Color(0xFFC72C41),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 48,),
                Expanded(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Oh snap!!",
                      style: TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: "ubuntu",),
                      ),
                      const Spacer(),
                      Text(
                        message,
                        style: const TextStyle(fontSize: 12.0, color: Colors.white, fontFamily: "ubuntu"),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
              child: SvgPicture.asset("assets/icons/bubbles.svg",
                height: 48,
                width: 40,
                color: const Color(0xFF801336),
              ),
            ),
          ),
          Positioned(
            top: -20,
            left: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/fail.svg",
                  height: 40,
                ),
                Positioned(
                  top: 10,
                  child: SvgPicture.asset(
                    "assets/icons/close.svg",
                    height: 16,
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}