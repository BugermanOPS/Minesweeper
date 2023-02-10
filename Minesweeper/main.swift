//
//  main.swift
//  Minesweeper
//
//  Created by andrei on 30.01.2023.
//

import Foundation


var board = Array(repeating: Array(repeating: 0, count: 10), count: 10)
// vopros po vvodu parametra?
var VisibleB = Array(repeating: Array(repeating: "*", count: 10), count: 10)

//---------------------------TEST------------------------------
//for element in board.enumerated() {
//    print(element)
//}

//func print (desk: [[String]]){
//    for (_, row) in desk.enumerated(){
//        for (_,element) in row.enumerated(){
//            print(element, terminator: " ")
//        }
//        print()
//    }
//}
//---------------------------TEST------------------------------

// Izmenenin parametro func -> ?
func print (desk: [[String]]){
    for i in 0...desk.count-1{
        for j in 0...desk.count-1{
            print(desk[i][j], terminator: "  ")
        }
        print()
    }
}

func cleanSpace(x: Int, y:Int, sizeMap: Int){
    if (board[x][y] == 0){
        board[x][y] = 7
        VisibleB[x][y] = "-"
        for i in x-1...x+1{
            for j in y-1...y+1{
                if (i>=0 && i<=sizeMap) && (j>=0 && j<=sizeMap){
                    if (board[i][j] == 0){
                        cleanSpace(x: i, y: j, sizeMap: board.count-1)
                    }
                }
            }
        }
    }
}

func Shoot (i: Int, j: Int){
    if (board[i][j] == 9){
        print("GAME OVER")
    }
    else{
        cleanSpace(x: i, y: j, sizeMap: board.count-1)
//      print("recurcia")
        }
}

func checkMine (sizeMap: Int) {
    for i in 0...sizeMap{
        for j in 0...sizeMap{
            if (board[i][j] == 9){
                for x in i-1...i+1{
                    for y in j-1...j+1{
                        if (y>=0 && y<=sizeMap) && (x>=0 && x<=sizeMap){
                            if (board[x][y] != 9){
                                board[x][y] = board[x][y]+1
                                VisibleB[x][y] = String(board[x][y])
                            }
                        }
                    }
                }
            }
        }
    }
}

func minesOnBoard (amount: Int, sizeMap: Int){
    var k = 1
    while 1...amount ~= k {
        let i = Int.random(in: 0...sizeMap)
        let j = Int.random(in: 0...sizeMap)
        if (board[i][j] != 9){
            board[i][j] = 9
//          VisibleB[i][j] = "0"
            k = k + 1
            }
    } // Chek, how many mines we are put on board.
}
  

minesOnBoard(amount: 10, sizeMap: board.count-1)
checkMine (sizeMap: board.count-1)

print(desk: VisibleB)

var flag = true

repeat {
    print("Please enter your cordinate x and y: ", terminator: " ")
    
    let input = readLine()!
    let pointXY = input.split(separator: " ")
  
    var x = Int()
    x = Int(pointXY[0])!
    
    var y = Int()
    y = Int(pointXY[1])!
    
    Shoot(i: x, j: y)
    
    print()
    print(desk: VisibleB)
    print()
    
   if (board[x][y] == 9){
      flag = false
    }
} while flag

//print("\u{001B}[2J") // where "\u{001B} IS ESCAPE and [2J is clear screen
    
