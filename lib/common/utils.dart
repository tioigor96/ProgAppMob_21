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

int BoolToInt(bool b)
{
  if(b)
    return 1;
  else
    return 0;
}

bool intToBool(int i)
{
  if(i==1)
    return true;
  else
    return false;
}