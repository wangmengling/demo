//
//  Extensions.swift
//  demo
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation

extension String {
    func positionOf(_ sub:String)->Int {
        var pos = -1
        if let range = self.range(of: sub) {
            if !range.isEmpty {
                pos = self.characters.distance(from: self.startIndex, to: range.lowerBound)
            }
        }
        return pos
    }
    
    func subString(_ start:Int, length:Int = -1)->String {
        var len = length
        if len == -1 {
            len = characters.count - start
        }
        let st = characters.index(startIndex, offsetBy: start)
        let en = <#T##String.CharacterView corresponding to `st`##String.CharacterView#>.index(st, offsetBy: len)
        let range = st ..< en
        return substring(with: range)
    }
}
