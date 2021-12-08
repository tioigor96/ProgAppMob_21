//definizione di prodotti

import 'package:stack/stack.dart' as stack;


class Manager {
  stack.Stack<int> page = stack.Stack(); //pagina precedente a cui tornare
  String name = 'Kambusapp';

  int precedente() {
    page.pop();
    print("Torno a "+page.top().toString());
    return page.top();
  }

  void nuovaPagina(int nuova) {
    page.push(nuova);
    setName();
  }

  void setName() {
    int now = page.top();
    switch(now) {
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
      case 4 :
         name = "Impostazioni di visualizzazione";
      break;
      case 4 :
        name = "Elimina";
      break;
    }
  }

  String getAppName()
  {
    return name;
  }

}

Manager manager = Manager();
