import 'dart:io';

Directory? docsDir;
//int numeroAperture = 0;
int numeroAdd = 0;
int flag = 1;

extension StringExtension on String {
  String capitalize() {
    if (length > 0) {
      return "${this[0].toUpperCase()}${substring(1)}";
    } else {
      return this;
    }
  }
}

int BoolToInt(bool b) {
  if (b) {
    return 1;
  } else {
    return 0;
  }
}

bool intToBool(int i) {
  if (i == 1) {
    return true;
  } else {
    return false;
  }
}
