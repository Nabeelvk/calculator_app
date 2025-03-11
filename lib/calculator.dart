import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  String input="";
  String output="0";
  void pressed(String value){setState(() {
    if (value == "C") {
      input="";
      output="0";
      }else if(value== "DEL"){
        input=input.isNotEmpty ? input.substring(0,input.length - 1):"";
       
      }else if(value== "="){
        try{
          output=_evaluateExpresson(input);
        }
        catch(e){
          output="error";

        }
      }else{
        input+=value;
      }
  });}


  String _evaluateExpresson(String expression){
    try{
      return _calculate(expression).toString();

    }catch(e){
      return "error";
    }
  }

  double _calculate(String expression){
    expression = expression.replaceAll("x", "*").replaceAll("÷", "/");
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    return exp.evaluate(EvaluationType.REAL,cm);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(input,style: TextStyle(color: Colors.grey,fontSize: 25),),
                  Text(output,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),)
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: ["C","%","DEL","/"].map((e) =>buildbutton(e)).toList(),
              ),
              Row(
                children: ["7","8","9","X"].map((e) =>buildbutton(e)).toList(),
              ),
              Row(
                children: ["4","5","6","-"].map((e) =>buildbutton(e)).toList(),
              ),
              Row(
                children: ["1","2","3","+"].map((e) =>buildbutton(e)).toList(),
              ),
              Row(
                children: ["00","0",".","="].map((e) =>buildbutton(e)).toList(),
              ),

            ],
          )
        ],
      ),
    );
  }
  
Widget buildbutton(String text){
  
  return Expanded(child: 
  ElevatedButton(onPressed: ()=> pressed(text),
  style: ElevatedButton.styleFrom(
  padding: EdgeInsets.all(24),
  backgroundColor: text == "=" ? Colors.black : Colors.white,
  foregroundColor: text == "=" ? Colors.white : Colors.black,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

),child: Text(text,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),) ,));}
}