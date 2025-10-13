import 'package:flutter/material.dart';

const KTextField1Decoration = InputDecoration(
  filled: true,

  fillColor: Color(0xFFE6E9E6),
  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFE6E9E6), width: 0.4),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFE6E9E6), width: 0.7),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);
