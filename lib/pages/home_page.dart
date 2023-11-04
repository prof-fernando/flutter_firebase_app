import 'package:firebase_app/core/firestore_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Firebase'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirestoreService().listar().snapshots(),
              builder: (context, snapshot) {
                //if(snapshot.connectionState == ConnectionState.waiting)
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                // pega os itens da colecao
                final dados = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: dados.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(dados[index]['nome']),
                    );
                  },
                );
              },
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  FirestoreService().gravar();
                },
                child: const Text('testar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
