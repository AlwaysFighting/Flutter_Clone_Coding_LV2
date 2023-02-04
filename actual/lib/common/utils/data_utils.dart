import '../const/data.dart';

class DataUtils {
  // thumbUrl 변경하기 - 단 무조건 static 으로 선언해야함
  static String pathToUrl(String value){
    return 'http://$ip$value';
  }
}