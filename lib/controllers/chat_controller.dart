import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/db_controller.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';

class ChatController extends GetxController {
  getchatnotifi({reciverid}) async {
    var notifi = await DBController().requestpost(
        url: "${InfoBasic.host}${InfoBasic.customquerypath}",
        data: {
          'customquery':
              "select * from chat where reciever_id=$reciverid and readstatus=0;"
        });
    if (notifi != null) {
      return notifi.length;
    } else {
      return;
    }
  }
}
