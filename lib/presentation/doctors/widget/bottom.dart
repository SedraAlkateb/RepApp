import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildBottomButtonsDoctor(int id) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      padding: EdgeInsets.all(
        20.w.clamp(16.0, 24.0),
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: BlocBuilder<DoctorsBloc, DoctorsState>(
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: state is CheckRecipesLoadingState
                      ? null
                      : () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      BlocProvider.of<DoctorsBloc>(context).add(
                        CheckReciEvent(id, 1),
                      );
                    });
                  },
                  icon: Icon(
                    Icons.refresh,
                    size: 20.sp.clamp(18.0, 22.0),
                  ),
                  label: Text(
                    "تكرار وصفة",
                    style: TextStyle(
                      fontSize: 14.sp.clamp(13.0, 16.0),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0D47A1),
                    side: const BorderSide(
                      color: Color(0xFF0D47A1),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h.clamp(11.0, 15.0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15.r.clamp(13.0, 17.0),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 15.w.clamp(10.0, 18.0),
              ),

              Expanded(
                child: ElevatedButton.icon(
                  onPressed: state is CheckRecipesLoadingState
                      ? null
                      : () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      BlocProvider.of<DoctorsBloc>(context).add(
                        CheckReciEvent(id, 0),
                      );
                    });
                  },
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: Colors.white,
                    size: 20.sp.clamp(18.0, 22.0),
                  ),
                  label: Text(
                    "إنشاء وصفة",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp.clamp(13.0, 16.0),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D47A1),
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h.clamp(11.0, 15.0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15.r.clamp(13.0, 17.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

Widget buildBottomButtons(int hospitalId) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      padding: EdgeInsets.all(
        20.w.clamp(16.0, 24.0),
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: BlocBuilder<DoctorsBloc, DoctorsState>(
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: state is CheckRecipesLoadingState
                      ? null
                      : () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      BlocProvider.of<DoctorsBloc>(context).add(
                        CheckReciEvent(hospitalId, 1),
                      );
                    });
                  },
                  icon: Icon(
                    Icons.refresh,
                    size: 20.sp.clamp(18.0, 22.0),
                  ),
                  label: Text(
                    "تكرار وصفة",
                    style: TextStyle(
                      fontSize: 14.sp.clamp(13.0, 16.0),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0D47A1),
                    side: const BorderSide(
                      color: Color(0xFF0D47A1),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h.clamp(11.0, 15.0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15.r.clamp(13.0, 17.0),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 15.w.clamp(10.0, 18.0),
              ),

              Expanded(
                child: ElevatedButton.icon(
                  onPressed: state is CheckRecipesLoadingState
                      ? null
                      : () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      BlocProvider.of<DoctorsBloc>(context).add(
                        CheckReciEvent(hospitalId, 0),
                      );
                    });
                  },
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: Colors.white,
                    size: 20.sp.clamp(18.0, 22.0),
                  ),
                  label: Text(
                    "إنشاء وصفة",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp.clamp(13.0, 16.0),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D47A1),
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h.clamp(11.0, 15.0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15.r.clamp(13.0, 17.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}