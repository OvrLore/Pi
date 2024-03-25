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
    @State var ms = 0
    @State var ms2 = 0
    
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
    /*
    let pi50M: [Int8] = {
        if let path = Bundle.main.path(forResource: "pi50.4", ofType: "bin") {
            do {
                // Read binary data from the file
                let data = try Data(contentsOf: URL(fileURLWithPath: path))

                // Process the binary data into an array of Int8
                var piDigits = [Int8](repeating: 0, count: data.count)
                data.copyBytes(to: &piDigits, count: data.count)

                return piDigits
            } catch {
                print("Failed to load file:", error)
            }
        }
        return []
    }()
    */
    var body: some View {
        VStack(spacing: 20) {
            Text("Pi Searcher")
                .font(.title)
                .bold()
            
            TextField("Enter search string", text: $searchString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)
            
            
            
            Text("Brute force algorithm result: \(indice)")
            Text("ms: \(ms)")
            Text("Booyer Moore algorithm result: \(indice2)")
            Text("ms: \(ms2)")
            
            Button(action: {
                ms = executionTime {
                    indice = indexOf(txt: pi1M, search: searchString)
                }
                /*
                msInt8 = executionTime {
                    indiceInt8 = indexInt8(of: pi50M)!
                }
                */
                
                ms2 = executionTime {
                    indice2 = String(pi1M.distance(from: pi1M.startIndex, to: pi1M.index(of: searchString)!))
                }
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
        }
        
        .padding()
    }
    
}
/*
func readPiDigits(from fileURL: URL) -> [Int8]? {
    do {
        // Open the binary file
        let data = try Data(contentsOf: fileURL)

        // Process the binary data
        // Assuming each digit is stored as a single byte in the binary file
        let piDigits = data.map { Int8($0) }

        return piDigits
    } catch {
        print("Error reading binary file:", error)
        return nil
    }
}
*/

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
