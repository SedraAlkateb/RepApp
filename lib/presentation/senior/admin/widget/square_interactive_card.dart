import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';

class SquareInteractiveCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  const SquareInteractiveCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });

  @override
  State<SquareInteractiveCard> createState() =>
      _SquareInteractiveCardState();
}


class _SquareInteractiveCardState extends State<SquareInteractiveCard>
    with SingleTickerProviderStateMixin {


  late AnimationController controller;
  late Animation<double> scaleAnimation;

  bool pressed = false;


  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );


    scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.96,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
  }



  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {


    final device = AppResponsive.deviceType(context);


    late double height;
    late double iconSize;
    late double iconPadding;
    late double titleSize;
    late double subTitleSize;
    late double radius;
    late bool landscape;



    switch(device){


    // =========================
    // Mobile
    // =========================
      case AppDeviceType.mobilePortrait:

        height = 160.h;
        iconSize = 30.sp;
        iconPadding = 11.w;
        titleSize = 15.sp;
        subTitleSize = 11.sp;
        radius = 24.r;
        landscape = false;

        break;



    // =========================
    // Tablet Portrait
    // =========================
      case AppDeviceType.tabletPortrait:

        height = 175.h;
        iconSize = 32.sp;
        iconPadding = 12.w;
        titleSize = 16.sp;
        subTitleSize = 12.sp;
        radius = 26.r;
        landscape = false;

        break;




    // =========================
    // Tablet Landscape
    // =========================
      case AppDeviceType.tabletLandscape:

        height = 180.h;
        iconSize = 13.sp;
        iconPadding = 8.w;
        titleSize = 13.sp;
        subTitleSize = 11.sp;
        radius = 18.r;
        landscape = true;

        break;
    }



    return GestureDetector(

      onTapDown: (_) {
        controller.forward();
        setState(() {
          pressed = true;
        });
      },


      onTapUp: (_) {

        controller.reverse();

        setState(() {
          pressed = false;
        });

        widget.onTap();
      },


      onTapCancel: (){

        controller.reverse();

        setState(() {
          pressed=false;
        });

      },


      child: ScaleTransition(

        scale: scaleAnimation,


        child: AnimatedContainer(

          duration:
          const Duration(milliseconds:200),


          height: height,


          decoration: BoxDecoration(

            color: Colors.white,


            borderRadius:
            BorderRadius.circular(radius),


            border: Border.all(

              color: pressed
                  ? widget.iconColor
                  : Colors.black12,

              width: 0.8,
            ),


            boxShadow: [

              BoxShadow(

                color: pressed
                    ? widget.iconColor.withOpacity(.15)
                    : Colors.black.withOpacity(.06),

                blurRadius: 12,

                offset:
                const Offset(0,5),

              )
            ],
          ),



          child: ClipRRect(

            borderRadius:
            BorderRadius.circular(radius),


            child: Padding(

              padding:
              EdgeInsets.all(
                landscape ? 12.w : 14.w,
              ),


              child: landscape

                  ? _landscapeLayout(
                iconSize,
                iconPadding,
                titleSize,
                subTitleSize,
              )


                  : _portraitLayout(
                iconSize,
                iconPadding,
                titleSize,
                subTitleSize,
              ),

            ),
          ),
        ),
      ),
    );
  }





  Widget _landscapeLayout(
      double iconSize,
      double padding,
      double titleSize,
      double subTitleSize,
      ){


    return Row(

      crossAxisAlignment:
      CrossAxisAlignment.center,


      children: [


        _icon(
          iconSize,
          padding,
        ),


        SizedBox(
          width:10.w,
        ),



        Expanded(

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.center,


            crossAxisAlignment:
            CrossAxisAlignment.start,


            mainAxisSize:
            MainAxisSize.min,


            children: [


              Text(

                widget.title,

                maxLines:1,

                overflow:
                TextOverflow.ellipsis,


                style: TextStyle(

                  fontSize:titleSize,

                  fontWeight:
                  FontWeight.bold,

                ),
              ),



              SizedBox(
                height:3.h,
              ),



              Text(

                widget.subtitle,

                maxLines:1,

                overflow:
                TextOverflow.ellipsis,


                style: TextStyle(

                  fontSize:
                  subTitleSize,

                  color:
                  Colors.grey,

                ),
              ),

            ],
          ),
        ),



        Icon(

          Icons.arrow_forward_ios_rounded,

          size:12.sp,

          color:Colors.grey,

        )

      ],
    );

  }





  Widget _portraitLayout(
      double iconSize,
      double padding,
      double titleSize,
      double subTitleSize,
      ){


    return Column(

      mainAxisAlignment:
      MainAxisAlignment.center,


      mainAxisSize:
      MainAxisSize.min,


      children: [


        _icon(
          iconSize,
          padding,
        ),


        SizedBox(
          height:10.h,
        ),


        Flexible(

          child: Text(

            widget.title,

            maxLines:1,

            overflow:
            TextOverflow.ellipsis,


            textAlign:
            TextAlign.center,


            style: TextStyle(

              fontSize:titleSize,

              fontWeight:
              FontWeight.bold,

            ),
          ),
        ),



        SizedBox(
          height:4.h,
        ),



        Flexible(

          child: Text(

            widget.subtitle,

            maxLines:1,

            overflow:
            TextOverflow.ellipsis,


            textAlign:
            TextAlign.center,


            style: TextStyle(

              fontSize:
              subTitleSize,

              color:
              Colors.grey,

            ),
          ),
        ),

      ],
    );

  }





  Widget _icon(
      double size,
      double padding,
      ){

    return AnimatedContainer(

      duration:
      const Duration(milliseconds:200),


      padding:
      EdgeInsets.all(padding),


      decoration: BoxDecoration(

        shape:
        BoxShape.circle,


        color: pressed
            ? widget.iconColor
            : widget.iconColor.withOpacity(.1),

      ),


      child: Icon(

        widget.icon,

        size:size,


        color: pressed
            ? Colors.white
            : widget.iconColor,

      ),
    );
  }

}