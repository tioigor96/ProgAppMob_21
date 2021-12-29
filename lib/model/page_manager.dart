//definizione di prodotti

import 'package:stack/stack.dart' as stack;

class Manager {
  stack.Stack<int> page = stack.Stack(); //pagina precedente a cui tornare
  String name = 'Kambusapp';

  int precedente() {
    page.pop();
    print("Torno a " + page.top().toString());
    setName();
    return page.top();
  }

  void nuovaPagina(int nuova) {
    page.push(nuova);
    setName();
  }

  void setName() {
    int now = page.top();
    switch (now) {
      case 0:
        name = "Kambusapp";
        break;
      case 1:
        name = "Aggiungi alimento";
        break;
      case 2:
        name = "Cerca";
        break;
      case 3:
        name = "Impostazioni notifiche";
        break;
      case 4:
        name = "Impostazioni visualizzazione";
        break;
      case 5:
        name = "Elimina";
        break;
      case 6:
        name = "Impostazioni di backup";
        break;
    }
  }

  void changeName(String s) {
    name = s;
  }

  String getAppName() {
    return name;
  }
}

Manager manager = Manager();
