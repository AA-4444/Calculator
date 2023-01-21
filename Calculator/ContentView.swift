//
//  ContentView.swift
//  Calculator
//
//  Created by Алексей Зарицький on 21.01.2023.
//

import SwiftUI


// MARK: calculator case (functions)....
enum CalcButton: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "*"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
            case .add, .subtract, .multiply, .divide , .equal:
                return Color("Orange")
            case .clear, .negative, .percent:
                return Color(.gray)
            default:
                return Color(.white)
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide,  none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        ZStack {
            Color("BG").edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                // Text display
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.black)
                }
                .padding()
                
                // Our buttons...
            ForEach(buttons, id: \.self) {row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { item in
                        Button(action: {
                            self.didTap(button: item)
                        }, label: {
                            Text(item.rawValue)
                                .font(.system(size: 32))
                                .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                                .background(item.buttonColor)
                                .foregroundColor(.black)
                                .cornerRadius(35)
                                .shadow(color: .black.opacity(0.2),radius: 5, x: 10, y: 10)
                        })
                    }
                }
                .padding(.bottom, 3)
                }
            }
        }
    }
    
    
    //MARK: Calcutor backand....
    
    func didTap(button: CalcButton) {
        switch button {
            case .add, .subtract, .multiply, .divide, .equal:
                if button == .add {
                    self.currentOperation = .add
                    self.runningNumber = Int(self.value) ?? 0
                }
                else if button == .subtract {
                    self.currentOperation = .subtract
                    self.runningNumber = Int(self.value) ?? 0
                }
                else if button == .multiply {
                    self.currentOperation = .multiply
                    self.runningNumber = Int(self.value) ?? 0
                }
                else if button == .divide {
                    self.currentOperation = .divide
                    self.runningNumber = Int(self.value) ?? 0
                }
                else if button == .equal {
                    let runningValue = self.runningNumber
                    let currentValue = Int(self.value) ?? 0
                    switch self.currentOperation {
                        case .add: self.value = "\(runningValue + currentValue)"
                        case .subtract: self.value = "\(runningValue - currentValue)"
                        case .multiply: self.value = "\(runningValue * currentValue)"
                        case .divide: self.value = "\(runningValue / currentValue)"
                        case .none:
                            break
                    }
                }
                
                if button != .equal {
                    self.value = "0"
                }
            case .clear:
                self.value = "0"
            case .decimal, .negative, .percent:
                break
            default:
                let number = button.rawValue
                if self.value == "0" {
                    value = number
                }
                else {
                    self.value = "\(self.value)\(number)"
                }
            }
        }
    
    func buttonWidth(item: CalcButton) ->CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) *  2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight()-> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
