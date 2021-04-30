import 'package:chat/chatlist.dart';
import 'package:chat/MessageWidget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Chatbot Learn Thai'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class Question{
  final String qtitle;
  final String choice1;
  final String choice2;
  final String choice3;
  final String choice4;
  Question({this.qtitle,this.choice1,this.choice2,this.choice3,this.choice4});
}
class _MyHomePageState extends State<MyHomePage> {
  String newmessage;
  List<Question> botquess = ["","",""];  //This part should read from JSON
  final ScrollController _scrollController = ScrollController();
  List<MessageWidget> _messageList = [];
  final _txtcontroller = TextEditingController();
  bool _focused = true, _sendMsg = false;
  FocusNode  _node;
  FocusAttachment _nodeAttachment;
  @override
  void initState() {
    super.initState();
    _node = FocusNode(debugLabel: 'TextFormField');
    _node.addListener(_handleFocusChange);
    //_nodeAttachment = _node.attach(context, onKey: );
  }
  void _handleFocusChange() {
    if (_node.hasFocus == _focused && _sendMsg ==true) {
      setState(() {
        _node.unfocus();
      });
    }else if (_sendMsg == false){
      _node.hasFocus;


    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(child:SingleChildScrollView(
            controller:  _scrollController ,
            child:
            Container(child:Column(
              children: [
                Container(
                  height:MediaQuery.of(context).size.height *.80,
                  color:Colors.orange[200],
                  child:ChatList(children: _messageList,
                      scrollController: _scrollController),
                ),
                Container(
                    height: MediaQuery.of(context).size.height *.10,
                    color: Colors.white,
                    child: Row(children: [
                      Container(
                          child:IconButton(icon:Icon(Icons.image))),
                      Expanded(child:Container(
                          padding: EdgeInsets.only( bottom: 5),
                          child:     TextField(
                            controller: _txtcontroller,
                            onSubmitted: (String inputText) {
                              setState(() {

                                _messageList.add(MessageWidget(
                                    content: inputText,
                                    ownerType: OwnerType.sender,
                                    ownerName: "Learner"
                                ));
                                _onNewMessage();
                              });

                              _txtcontroller.clear();
                            },
                            decoration: InputDecoration(

                              fillColor: Colors.grey,
                              border: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(15),
                              ),

                            ),
                          ))),

                      Container(
                          child: IconButton(icon:Icon(Icons.send),
                            onPressed: (){
                              setState(){
                                _sendMsg=true;
                                _handleFocusChange();
                                _txtcontroller.clear();
                                _onNewMessage();
                                _sendMsg=false;
                              };
                            },
                          )),
                    ],)),
              ],
            )
            )),
        ));
  }
  void _onNewMessage() {

    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

}

getGreetingMessage(var  greetingMsg){
  switch(greetingMsg){
    case 0: return  "Hi I am Kiddee ka. What can I help you to practice learning Thai?";
    case 1: return  "Hi I am Kiddee. Today is a good day. What topic do you want to practise? ";
    case 2: return  "Hi I am Tamdee krub. What can I help you to practice learning Thai?";
    case 3: return  "Hi I am Tamdee krub. Today is a good day. What topic do you want to practise? ";

  }
}

getWhichTopicLearn(){
  return  "The topics in the lesson are\n"+
      "1. Noun (คำนาม : kham-nam) \n"+
      "2. Pronoun (คำสรรพนาม : kham-sab-pa-nam) \n"+
      "3. Verb (ตำกิริยา: kham-ki-ri-ya) \n What the topic do you want to study? "
  ;
}
getNextQuestion(){

}