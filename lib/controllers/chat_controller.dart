import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/db_controller.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/bottomnavbar.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';

class ChatController extends GetxController {
  getchatnotifi({reciver_id}) async {
    var notifi = await DBController().requestpost(
        url: "${InfoBasic.host}${InfoBasic.customquerypath}",
        data: {
          'customquery':
              "select * from chat where reciever_id=$reciver_id and readstatus=0;"
        });
    if (notifi != null) {
      return notifi.length;
    } else {
      return;
    }
  }
}
