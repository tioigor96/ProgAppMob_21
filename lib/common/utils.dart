import 'dart:io';

Directory? docsDir;

//TODO sarà da modificare quando aggiungeremo schermata per impostazioni
int notificaRossa = 3;
int notificaGialla = 5;

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