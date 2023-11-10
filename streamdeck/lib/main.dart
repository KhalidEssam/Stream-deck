import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draggable Button App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> buttons = [];
  List<Widget> theme = [];
  List<Offset> buttonPositions = []; // Store button positions
  Offset originalButtonPosition = const Offset(20.0, 20.0);
  bool isDarkMode = false;

  // get DesktopWindow => null; // Store the current theme mode
// theme toggle
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode; // Toggle the theme mode
    });
  }

// load state
  @override
  void initState() {
    super.initState();
    theme.add(
      Positioned(
        right: 20.0,
        top: 20.0,
        child: FloatingActionButton(
          onPressed: toggleTheme, // Toggle the theme when the button is pressed
          child: Icon(Icons.brightness_4),
        ),
      ),
    );

    addOriginalButton();
  }

// function for Child-button pressed
  void printbuttonid(int id, String msg) {
    print('button $id is $msg');
  }

  void addOriginalButton() {
    buttonPositions
        .add(originalButtonPosition); // Store original button position
    buttons.add(
      Positioned(
        left: originalButtonPosition.dx,
        top: originalButtonPosition.dy,
        child: Draggable(
          feedback: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {},
          ),
          childWhenDragging: Container(),
          onDragEnd: (details) {
            Size window = retrieveWindowSize();
            print(window);
            _selectImage(buttons.length);
            _pickExecutable(buttons.length);

            setState(() {
              buttonPositions.add(details.offset); // Store new button position
              buttons.add(
                Positioned(
                  left: details.offset.dx,
                  top: details.offset.dy,
                  child: Draggable(
                    feedback: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {},
                    ),
                    childWhenDragging: Container(),
                    onDragEnd: (innerDetails) {
                      // Do nothing for the dragged buttons inside the original button
                    },
                    child: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {},
                    ),
                  ),
                ),
              );
            });
          },
          child: GestureDetector(
            // Wrap child in GestureDetector
            // onTap: () {},
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                // Size window = retrieveWindowSize();
                // print(window);
                printbuttonid(buttons.length, 'clicked');
              },
            ),
          ),
        ),
      ),
    );
  }

//deteremine button position

  Size calculateButtonPositions(
      double clientWidth,
      double clientHeight,
      int numofbuttons,
      double currentX,
      double currentY,
      List<Size> currentRow) {
    const buttonWidth = 60.0;
    const buttonHeight = 60.0;
    const rowSpacing = 20.0;
    const columnSpacing = 20.0;
    const buttonMargin = 10.0;

    // List<List<Offset>> buttonPositions = [];
    // List<Offset> currentRow = [];
    // double currentX = buttonMargin;
    // double currentY = buttonMargin;

    // for (int i = 0; i < numofbuttons; i++) {
    // Change 10 to the number of buttons you want to place
    if (currentX + buttonWidth > clientWidth) {
      // Move to the next row
      // buttonPositions.add(List.from(currentRow));
      currentRow.clear();
      currentX = buttonMargin;
      currentY += buttonHeight + rowSpacing;
    }

    currentRow.add(Size(currentX, currentY));
    currentX += buttonWidth + columnSpacing;
    // }

    // Add the last row
    // buttonPositions.add(List.from(currentRow));

    return Size(currentX, currentY);
  }

//OPEN FILE
  void openFile(String filePath) async {
    try {
      final result = await OpenFile.open(filePath);
      if (result.type == ResultType.noAppToOpen) {
        print('No app to open this type of file.');
      }
    } catch (e) {
      print('Error opening file: $e');
    }
  }

//Open EXE
  void openExecutable(int buttonId, Map<int, String?> buttonPaths) async {
    print('object is gpppppd');
    if (buttonPaths.containsKey(buttonId)) {
      String filePath = buttonPaths[buttonId]!;
      try {
        Process.run(filePath, [], runInShell: true);
        print('Success $filePath');
      } catch (e) {
        print('Error opening executable: $e');
      }
    } else {
      print('No path saved for button: $buttonId');
    }
  }

//sendMessage
  void sendMessage(String message) async {
    // print(message);
    try {
      final socket = await Socket.connect(
          '192.168.0.102', 12345); // Replace with your server IP and port

      socket.writeln(message); // Write the message to the socket
      await socket.flush(); // Ensure the message is sent
      // print('sucess');
      socket.close(); // Close the socket after sending the message
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Size retrieveWindowSize() {
    double clientWidth = MediaQuery.of(context).size.width;
    double clientHeight = MediaQuery.of(context).size.height;

    return Size(clientWidth, clientHeight);
  }

  // CHILD BUTTON exe SELECTION
  Map<int, String> buttonPaths = {};

  Future<void> _pickExecutable(int buttonId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['exe'],
    );

    if (result != null) {
      String filePath = result.files.single.path!;
      setState(() {
        buttonPaths[buttonId] = filePath;
      });
    }
  }

  void printClientSize() async {
    // final terminal = Terminal();

    // final size = await terminal.terminalSize();
    // int consoleWidth = size.columns;
    // int consoleHeight = size.lines;

    // print('Console Width: $consoleWidth');
    // print('Console Height: $consoleHeight');
  }

  // CHILD BUTTON IMAGE SELECTION

  Future<void> _selectImage(int buttonIndex) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      String? imagePath = result.files.single.path;
      if (imagePath != null) {
        setState(() {
          buttons[buttonIndex] = Positioned(
            left: buttonPositions[buttonIndex].dx, // Use stored position
            top: buttonPositions[buttonIndex].dy, // Use stored position
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      style: BorderStyle.solid, color: Colors.blueAccent),
                  image: DecorationImage(
                    image: FileImage(File(imagePath)),
                    fit: BoxFit.cover,
                  ),
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    openFile(imagePath);
                    print('object is pressed');
                    openExecutable(buttonIndex, buttonPaths);
                    sendMessage((buttonPaths[buttonIndex] as String));
                  },
                  // child: Icon(Icons.add),\

                  backgroundColor: const Color.fromARGB(10, 230, 240, 210),
                  hoverColor: const Color.fromARGB(80, 169, 224, 67),
                ),
              ),
            ),
          );
        });
      }
    }

    // print(' is good');

    // print(window.width);
  }

// APP BUILD

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode
          ? ThemeData.dark()
          : ThemeData.light(), // Apply the selected theme
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Draggable Button App'),
        ),
        body: Stack(
          children: buttons + theme,
        ),
      ),
    );
  }
}
