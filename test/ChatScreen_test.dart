import 'package:flutter_test/flutter_test.dart';
import 'package:grapedoc_test/screens/ChatScreen.dart';

void main () {
  test("reply of the chatBot", (){
    String textTest1 = "";
    final testMessage = chatBotInvalidInput();
    testMessage.invalidInput(textTest1);
    expect(testMessage.inputMsg1,"Please enter message");
  });
}
