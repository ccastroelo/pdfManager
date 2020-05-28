import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:pdfManager/libs/SaveNetFileLocally.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller;
  SaveNetFileLocally netFile = SaveNetFileLocally();
  String fileName = "teste.pdf";

  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = "http://nematoides.com.br/Content/Fotos/exemplo-de-pdf.pdf";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(child: Container(),),
            TextField(
              controller: _controller,
            ),
            RaisedButton(
            child: Text("Save PDF"),
            onPressed: () async => await netFile.saveFileFromNetwork(_controller.text, fileName)
            ),
            RaisedButton(
            child: Text("Abre PDF"),
            onPressed: () async {
              String file = await netFile.localFile(fileName);
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PDFScreen(file))
              );
            }),
                      Expanded(child: Container(),),

          ],
        ),
      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        path: pathPDF);
  }
}
