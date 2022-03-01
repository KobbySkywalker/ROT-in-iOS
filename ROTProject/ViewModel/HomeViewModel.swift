//
//  HomeViewModel.swift
//  ROTProject
//
//  Created by Hackman Adu Gyamfi on 01/03/2022.
//

import Foundation


class HomeViewModel{
    
    static public var initialROT:String{
        ROTValues.getValues[0]
    }
    
   static public var rotValues:[String]{
        return ROTValues.getValues
    }
    
    static func calculate(text:String,ROTType:String) -> String {
       var textCharArray:[Character] = Array( text )
        let shift = ROTType.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard let shift = Int(shift)else {return ""}
        print(shift)
        let alphabet = Array("abcdefghijklmnopqrstuvwxyz");
       let offset = alphabet.count
        for i in 0..<text.count {
           let oldChar = textCharArray[ i ]
           if oldChar == " "{
               textCharArray.append(oldChar)
               continue
           }
           let oldCharIdx = alphabet.firstIndex( of:oldChar ) ?? 0
           let oldCharIdxUnwrapped = oldCharIdx
           let newCharIdx = ( oldCharIdxUnwrapped + shift + offset ) % offset
           let newChar = alphabet[ newCharIdx ]
           textCharArray[ i ] = newChar
       }
       return String( textCharArray )
    }
}
