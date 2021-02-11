import 'package:connectivity/connectivity.dart';

class Internet{
  String _connection = "";
  final Connectivity _connectivity = Connectivity();

  verificar_conexao()
  {
    return _connectivity.checkConnectivity().then((connectivityResult){
      updateStatus(connectivityResult);
    });
  }

  Future<String> updateStatus(ConnectivityResult connectivityResult) async{
    if (connectivityResult == ConnectivityResult.mobile) {
      return ("3G/4G");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      String wifiName = await _connectivity.getWifiName();
      String wifiSsid = await _connectivity.getWifiBSSID();
      String wifiIp = await _connectivity.getWifiIP();
      return("Wi-Fi\n$wifiName\n$wifiSsid\n$wifiIp");
    }else{
      return("Não Conectado!");
    }
  }

}