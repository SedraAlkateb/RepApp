import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InteractiveAdminCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;
  final bool isLandscape;

  const InteractiveAdminCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
    this.isLandscape = false,
  });

  @override
  State<InteractiveAdminCard> createState() =>
      _InteractiveAdminCardState();
}

class _InteractiveAdminCardState extends State<InteractiveAdminCard> {

  bool _isPressed = false;


  @override
  Widget build(BuildContext context) {


    final deviceType =
    AppResponsive.deviceType(context);


    final bool isTabletLandscape =
        deviceType == AppDeviceType.tabletLandscape;



    final double portraitIconSize =
    isTabletLandscape ? 25.sp : 28.sp;



    final double portraitTitleSize =
    isTabletLandscape ? 16.sp : 17.sp;


    final double portraitSubtitleSize =
    isTabletLandscape ? 12.sp : 12.sp;



    final double landscapeIconSize =
    isTabletLandscape ? 19.sp : 20.sp;


    final double landscapeTitleSize =
    isTabletLandscape ? 14.sp : 14.sp;


    final double landscapeSubtitleSize =
    isTabletLandscape ? 11.sp : 10.sp;



    return GestureDetector(

      onTapDown: (_) =>
          setState(() => _isPressed = true),


      onTapUp: (_) {

        setState(() => _isPressed = false);

        widget.onTap();

      },


      onTapCancel: () =>
          setState(() => _isPressed = false),



      child: AnimatedContainer(

        duration:
        const Duration(milliseconds:200),


        margin: widget.isLandscape

            ? EdgeInsets.zero

            : EdgeInsets.symmetric(
            vertical:8.h
        ),


        padding: EdgeInsets.all(
            widget.isLandscape
                ? 16.w
                : 22.w
        ),



        decoration: BoxDecoration(

          color: Colors.white,


          borderRadius:
          BorderRadius.circular(25.r),


          border: Border.all(

            color: _isPressed
                ? widget.iconColor
                : Colors.black.withOpacity(0.05),

            width:1.2,

          ),



          boxShadow: [

            BoxShadow(

              color: _isPressed

                  ? widget.iconColor.withOpacity(0.12)

                  : Colors.black.withOpacity(0.04),


              blurRadius:15,

              offset:
              const Offset(0,8),

            )

          ],

        ),



        child: ClipRRect(

          borderRadius:
          BorderRadius.circular(25.r),



          child: Stack(

            clipBehavior:
            Clip.none,


            children: [


              // الخط العلوي كما هو

              AnimatedPositioned(

                duration:
                const Duration(milliseconds:200),


                top:
                _isPressed ? -22.h : -30.h,


                left:60.w,

                right:60.w,


                child: Container(

                  height:4.h,


                  decoration:BoxDecoration(

                    color:widget.iconColor,


                    borderRadius:
                    BorderRadius.only(

                      bottomLeft:
                      Radius.circular(10.r),

                      bottomRight:
                      Radius.circular(10.r),

                    ),

                  ),

                ),

              ),



              // الخط الجانبي كما هو

              AnimatedPositioned(

                duration:
                const Duration(milliseconds:200),


                right:
                _isPressed ? -22.w : -30.w,


                top:5.h,

                bottom:5.h,


                child:Container(

                  width:5.w,


                  decoration:BoxDecoration(

                    color:widget.iconColor,


                    borderRadius:
                    BorderRadius.circular(10.r),

                  ),

                ),

              ),




              widget.isLandscape

                  ? _buildLandscapeLayout(
                landscapeIconSize,
                landscapeTitleSize,
                landscapeSubtitleSize,
              )

                  : _buildPortraitLayout(
                portraitIconSize,
                portraitTitleSize,
                portraitSubtitleSize,
              ),


            ],

          ),

        ),

      ),

    );

  }






  Widget _buildPortraitLayout(
      double iconSize,
      double titleSize,
      double subtitleSize,
      ) {


    return Row(

      children: [


        AnimatedContainer(

          duration:
          const Duration(milliseconds:200),


          padding:
          EdgeInsets.all(12.w),


          decoration:BoxDecoration(

            color:_isPressed

                ? widget.iconColor

                : widget.iconColor.withOpacity(0.1),


            borderRadius:
            BorderRadius.circular(15.r),

          ),


          child:Icon(

            widget.icon,


            color:_isPressed

                ? Colors.white

                : widget.iconColor,


            size:iconSize,

          ),

        ),




        SizedBox(
          width:15.w,
        ),




        Expanded(

          child:Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,


            children:[


              Text(

                widget.title,


                style:TextStyle(

                  fontSize:titleSize,


                  fontWeight:
                  FontWeight.bold,


                  color:
                  ColorManager.primaryText,

                ),

              ),



              SizedBox(
                height:4.h,
              ),



              Text(

                widget.subtitle,


                style:TextStyle(

                  fontSize:subtitleSize,


                  color:Colors.grey[500],

                ),

              ),

            ],

          ),

        ),




        Icon(

          Icons.arrow_forward_ios,


          color:_isPressed

              ? widget.iconColor

              : Colors.grey[300],


          size:
          isTabletLandscape(context)
              ? 11.sp
              : 16.sp,

        ),

      ],

    );

  }







  Widget _buildLandscapeLayout(
      double iconSize,
      double titleSize,
      double subtitleSize,
      ) {


    return Column(

      crossAxisAlignment:
      CrossAxisAlignment.center,


      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,


      children:[



        Row(

          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,


          children:[


            AnimatedContainer(

              duration:
              const Duration(milliseconds:200),


              padding:
              EdgeInsets.all(2.w),


              decoration:BoxDecoration(

                color:_isPressed

                    ? widget.iconColor

                    : widget.iconColor.withOpacity(0.1),


                borderRadius:
                BorderRadius.circular(14.r),

              ),



              child:Icon(

                widget.icon,


                color:_isPressed

                    ? Colors.white

                    : widget.iconColor,


                size:iconSize,

              ),

            ),



            Icon(

              Icons.arrow_forward_ios,


              color:
              _isPressed
                  ? widget.iconColor
                  : Colors.grey[300],


              size:
              isTabletLandscape(context)
                  ? 10.sp
                  : 14.sp,

            ),


          ],

        ),




        SizedBox(
          height:10.h,
        ),




        Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,


          children:[


            Text(

              widget.title,


              maxLines:2,


              overflow:
              TextOverflow.ellipsis,


              style:TextStyle(

                fontSize:titleSize,


                fontWeight:
                FontWeight.bold,


                color:
                ColorManager.primaryText,


                height:1.2,

              ),

            ),




            SizedBox(
              height:4.h,
            ),




            Text(

              widget.subtitle,


              maxLines:2,


              overflow:
              TextOverflow.ellipsis,


              style:TextStyle(

                fontSize:subtitleSize,


                color:Colors.grey[500],


                height:1.2,

              ),

            ),

          ],

        ),


      ],

    );

  }



  bool isTabletLandscape(BuildContext context){

    return AppResponsive.deviceType(context)
        == AppDeviceType.tabletLandscape;

  }

}