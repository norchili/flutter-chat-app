import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuarios = [
    Usuario(
        online: true, email: 'norber@gmail.com', name: 'norberto', uid: '1'),
    Usuario(online: false, email: 'isa@yahoo.com', name: 'isabel', uid: '2'),
    Usuario(online: false, email: 'nrbrt@hotmail.com', name: 'NRBRT', uid: '3'),
    Usuario(
        online: true, email: 'gordo33@outlock.com', name: 'Gordo', uid: '4'),
    Usuario(online: true, email: 'house.iam@yahoo.com', name: 'House', uid: '5')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mi Nombre',
            style: TextStyle(color: Colors.black87),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
          ),
          actions: <Widget>[
            Container(
                margin: const EdgeInsets.only(right: 10.0),
                //child: Icon(Icons.check_circle, color: Colors.blue[400],),
                child: const Icon(
                  Icons.offline_bolt,
                  color: Colors.red,
                ))
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          child: _usuariosListView(),
          enablePullDown: true,
          onRefresh: _loadUsers,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.blue[400],
            ),
            waterDropColor: Colors.blue.shade400,
          ),
        ));
  }

  ListView _usuariosListView() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => _usuariosListTile(usuarios[index]),
        separatorBuilder: (_, index) => const Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuariosListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.name),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.name.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _loadUsers() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
