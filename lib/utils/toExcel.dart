import 'dart:io';

import 'package:cathacks/models/quiz.dart';
import 'package:excel/excel.dart';

Future<Excel> toExcel(List<Quiz> quiz){
  print(quiz[0].answer);
  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Generated Q&A'];
  var cell1 = sheetObject.cell(CellIndex.indexByColumnRow(columnIndex:1,rowIndex:0));
  var cell2 = sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 2,rowIndex: 0));
  cell1.value="Questions";
  cell2.value="Answers";
  for(int i = 0;i<quiz.length;i++){
    var cellQ = sheetObject.cell(CellIndex.indexByColumnRow(columnIndex:1,rowIndex: i+1));  
    var cellA = sheetObject.cell(CellIndex.indexByColumnRow(columnIndex:2,rowIndex:i+1));
    cellQ.value=quiz[i].question;
    cellA.value=quiz[i].answer;
  }
   excel.encode().then((onValue) {
        File("C:/Users/Mithilesh Chellappan/Desktop/excel.xlsx")
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });

  

}