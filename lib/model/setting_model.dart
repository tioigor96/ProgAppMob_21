import 'package:Kambusapp/DB/DBSetting.dart';

class Setting {
  int notifiche = 1;
  int notificaGialla = 1;
  int notificaRossa = 0;
  String ordinamento = "nome";
  String ascDesc = "asc";

  void aggiorna(dynamic inDatabaseWorker) async {
    await inDatabaseWorker.get().then((result) {
      notifiche = result.notifiche;
      notificaGialla = result.notificaGialla;
      notificaRossa = result.notificaRossa;
      ordinamento = result.ordinamento;
      ascDesc = result.ascDesc;
    });
  }
}

Setting impostazioni = new Setting();
