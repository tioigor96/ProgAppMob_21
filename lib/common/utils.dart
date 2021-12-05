import 'dart:io';

Directory? docsDir;

extension StringExtension on String {
  String capitalize() {
    if(this.length>0) {
      return "${this[0].toUpperCase()}${this.substring(1)}";
    }
    else {
      return this;
    }
  }
}

bool intToBool(int b)
{
  if(b==1)
    return true;
  else
    return false;
}