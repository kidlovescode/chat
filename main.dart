import 'package:chat_list/chat_list.dart';
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

class _MyHomePageState extends State<MyHomePage> {
  String newmessage;
  final ScrollController _scrollController = ScrollController();
   List<MessageWidget> _messageList = [

    MessageWidget(
        content: "สวัสดีค่ะ มาเรียนภาษาไทยกันเถอะ",
        ownerType: OwnerType.receiver,
        ownerName: "Bot"),
    MessageWidget(
        content: "อยากจะเรียนเรื่องอะไรค่ะ 1. สรรพนาม 2. คำนาม",
        ownerType: OwnerType.receiver,
        ownerName: "Bot"),

    MessageWidget(
        content: "ข้อ 2 ดีกว่าครับ",
        ownerType: OwnerType.sender,
        ownerName: "Learner"),
    MessageWidget(
        content: "อะไรคือ คำนาม ระหว่าง 1. จาน กับ 2. กิน",
        ownerType: OwnerType.receiver,
        ownerName: "Bot"),
    MessageWidget(
        content: "ตอบ 1 ครับ",
        ownerType: OwnerType.sender,
        ownerName: "Learner"),
    MessageWidget(
        content: "ถูกต้องค่ะ  คำถามต่อไปเลยนะ",
        ownerType: OwnerType.receiver,
        ownerName: "Bot"),
    MessageWidget(
        content: "คำถามคือ หากน้องอยากทานข้าว  น้องจะเลือกใช้ 1. ช้อนส้อม หรือ 2.ทัพพี ตักข้าว",
        ownerType: OwnerType.receiver,
        ownerName: "Bot"),
    MessageWidget(
        content: "1 ครับ",
        ownerType: OwnerType.sender,
        ownerName: "Learner"),
    MessageWidget(
        content: "ถูกต้องค่ะ  ",
        ownerType: OwnerType.receiver,
        ownerName: "Bot"),
    MessageWidget(
        content: "เก่งมาก  ",
        ownerType: OwnerType.receiver,
        ownerName: "Bot"),
  ];
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
