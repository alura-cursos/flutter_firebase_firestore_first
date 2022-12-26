import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreAnalytics {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  incrementarAcessosTotais() {
    _incrementar("acessos_totais");
  }

  incrementarListasAdicionadas() {
    _incrementar("listas_adicionadas");
  }

  incrementarAtualizacoesManuais() {
    _incrementar("atualizacoes_manuais");
  }

  _incrementar(String field) async {
    // Pedir ao firestore a versão atual do documento "geral" na coleção "analytics"
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("analytics").doc("geral").get();

    // Inicializar um documento que representa nosso documento "geral"
    Map<String, dynamic> document = {};

    // Preencher nosso documento com os dados existentes (se eles existirem)
    if (snapshot.data() != null) {
      document = snapshot.data()!;
    }

    // Caso o campo que queremos somar tenha dados, somamos, se não inicializamos com o valor 1
    if (document[field] != null) {
      document[field] = document[field] + 1;
    } else {
      document[field] = 1;
    }

    // Atualizamos no Firestore
    firestore.collection("analytics").doc("geral").set(document);
  }
}
