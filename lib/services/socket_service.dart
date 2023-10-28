// ignore_for_file: library_prefixes

import 'package:mediguard/widgets/custom_toast.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket _socket;

  IO.Socket get socket => _socket;

  void connectSocket() {
    _socket = IO.io('http://10.0.2.2:3000', {
      'transports': ['websocket'],
      'autoConnect': false,
      'username': 'Medi'
    });
    _socket.connect();
    // _socket.onConnect((data) => print("Connection established"));
    _socket.onConnectError((data) =>
        CustomToast.showFailed(message: "MediGuard Device server error"));
    // _socket.onDisconnect((data) => print("Socket IO server disconnected"));
  }
}
