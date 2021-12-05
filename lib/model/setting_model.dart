import 'package:Kambusapp/DB/DBSetting.dart';

class Setting {
  bool notifiche = true;
  int notificaGialla = 1;
  int notificaRossa = 0;

  void aggiorna(dynamic inDatabaseWorker) async {
    await inDatabaseWorker.get().then((result) {
      notifiche = result.notifiche;
      notificaGialla = result.notificaGialla;
      notificaRossa = result.notificaRossa;
    });
  }
}

Setting impostazioni = new Setting();
