// ignore_for_file: library_prefixes

import 'package:mediguard/widgets/custom_toast.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static late IO.Socket _socket;

  static IO.Socket get socket => _socket;

  static void connectSocket() {
    try {
      _socket = IO.io('http://10.0.2.2:3000/', {
        'transports': ['websocket'],
        'autoConnect': false,
        'username': 'Medi'
      });
      _socket.connect();
      _socket.onConnect((data) => print("Connection established"));
      _socket.onConnectError((data) =>
          CustomToast.showFailed(message: "MediGuard Device server error"));
      // _socket.onDisconnect((data) => print("Socket IO server disconnected"));
    } catch (e) {
      print('Error connecting to the socket: $e');
    }
  }
}
