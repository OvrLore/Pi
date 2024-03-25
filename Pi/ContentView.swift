//
//  ContentView.swift
//  Pi
//
//  Created by Lorenzo Overa on 24/03/24.
//

import SwiftUI

struct ContentView: View {
    @State var indice = 0
    @State var indice2 = ""
    @State var searchString = ""
    
    
    let pi1M: String = {
        if let path = Bundle.main.path(forResource: "pi1M", ofType: "rtf") {
            do {
                let attributedString = try NSAttributedString(url: URL(fileURLWithPath: path), options: [:], documentAttributes: nil)
                return attributedString.string
            } catch {
                print("Failed to load file:", error)
            }
        }
        return ""
    }()
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Pi Searcher")
                .font(.title)
                .bold()
            
            TextField("Enter search string", text: $searchString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)
            
            Button(action: {
                indice = indexOf(txt: pi1M, search: searchString)
                //BM(Array(pi1M), pi1M.count, Array(searchString), //searchString.count)
                indice2 = String(pi1M.distance(from: pi1M.startIndex, to: pi1M.index(of: searchString)!))
               // print(pi1M.index(of: "2345")!)
                //indice2 = pi1M.index(of: "\(searchString)")!
            }) {
                Text("Search")
                    .fontWeight(.semibold)
                    .font(.title2)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(25)
            }
            
            Text("Number found at index:")
            Text("\(indice)")
            Text("\(indice2)")
        }
        .padding()
    }
    
}



func indexOf(txt: String, search: String) -> Int {
    let start = search.first!
    let txtChars = Array(txt)
    let searchChars = Array(search)
    
    for i in 0..<1_000_000 {
        if txtChars[i] == start {
            var found = true
            for j in 1..<searchChars.count {
                if txtChars[i + j] != searchChars[j] {
                    found = false
                    break
                }
            }
            if found {
                return i
            }
        }
    }
    return -1
}
/*
 extension String {
 func boyerMooreSearch(for pattern: String) -> [Int] {
 let patternLength = pattern.count
 let textLength = count
 guard patternLength > 0 && patternLength <= textLength else {
 return []
 }
 
 var lastIndexes = [Character: Int]()
 for (index, char) in pattern.enumerated() {
 lastIndexes[char] = index
 }
 
 var indices: [Int] = []
 var textIndex = patternLength - 1
 var patternIndex = patternLength - 1
 
 while textIndex < textLength {
 var matched = true
 patternIndex = patternLength - 1
 while matched && patternIndex >= 0 {
 let textCharIndex = index(startIndex, offsetBy: textIndex)
 let patternCharIndex = pattern.index(pattern.startIndex, offsetBy: patternIndex)
 if self[textCharIndex] != pattern[patternCharIndex] {
 matched = false
 if let skip = lastIndexes[self[textCharIndex]] {
 textIndex += max(1, patternIndex - skip)
 } else {
 textIndex += patternIndex + 1
 }
 } else {
 textIndex -= 1
 patternIndex -= 1
 }
 }
 if patternIndex < 0 {
 indices.append(textIndex + 1)
 textIndex += patternLength * 2 - 1
 }
 }
 
 return indices
 }
 }
 
 
 let text = pi10
 let pattern = "1307"
 let indices = text.boyerMooreSearch(for: pattern)
 
 
 
 */
#Preview {
    ContentView()
}
