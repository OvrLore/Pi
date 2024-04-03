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
        if let path = Bundle.main.path(forResource: "pi50M", ofType: "txt") {
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
        VStack(spacing: 20) {
            Text("Pi Searcher")
                .font(.title)
                .bold()
            
            TextField("Enter search string", text: $searchString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)
            
            
            
            //Text("Brute force algorithm result: \(indice)")
            //Text("ms: \(ms)")
            Text("Booyer Moore algorithm result: \(indice2)")
            Text("ms: \(ms2)")
            
            Button(action: {
                /*
                ms = executionTime {
                    indice = indexOf(txt: pi1M, search: searchString)
                    //indice = indexOfCompressed(search: searchString)
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

func writePiDataToFile() {
    let fileURL = URL(fileURLWithPath: "/Users/lorenzoovera/Documents/Pi/Pi/pi50.4.bin")
    
    guard let fileData = try? Data(contentsOf: fileURL) else {
        print("Could not read pi file")
        return
    }
    
    let destinationURL = URL(fileURLWithPath: "/Users/lorenzoovera/Documents/FilePi/pi50M.dat")
    
    do {
        try fileData.write(to: destinationURL)
        print("Data successfully written to \(destinationURL)")
    } catch {
        print("Error writing data: \(error)")
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

func indexOfCompressed(search: String) -> Int {
        // Load the compressed file
        //if let compressedURL = Bundle.main.url(forResource: "compressed_numbers", withExtension: "dat") {
    if let compressedURL = Bundle.main.url(forResource: "pi50M", withExtension: "dat") {
            do {
                let compressedData = try Data(contentsOf: compressedURL)
                
                // Process the compressed data
                var compressedNumbers = [Int]()
                for byte in compressedData {
                    let num1 = Int(byte >> 4)
                    let num2 = Int(byte & 0b00001111)
                    compressedNumbers.append(num1)
                    compressedNumbers.append(num2)
                }
                
                // Convert to string for searching
                let compressedString = compressedNumbers.map { String($0) }.joined()
                
                // Perform the search
                if let range = compressedString.range(of: search) {
                    return range.lowerBound.utf16Offset(in: compressedString)
                }
            } catch {
                print("Error loading compressed file:", error)
            }
        }
        
        // Return -1 if not found or error occurred
        return -1
    }

func saveAndReadCompressedNumbers(input: String) {
    let numbers = input.map { Int(String($0)) ?? 0 }
    

    var compressedNumbers: [UInt8] = []
    for i in stride(from: 0, to: numbers.count, by: 2) {
        let num1 = UInt8(numbers[i])
        let num2 = UInt8(numbers[i + 1])
        let compressedNumber = (num1 << 4) | num2
        compressedNumbers.append(compressedNumber)
    }
    

    let compressedData = Data(compressedNumbers)
    
/*
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("compressed_numbers.dat")
*/
    let fileURL = URL(fileURLWithPath: "/Users/lorenzoovera/Documents/FilePi/pi50M.dat")

    do {
        try compressedData.write(to: fileURL)
        print("Compressed numbers saved successfully at \(fileURL).")
        

        if let restoredNumbers = readCompressedNumbers(from: fileURL) {

            var originalNumbers: [Int] = []
            for number in restoredNumbers {
                let num1 = Int(number >> 4)
                let num2 = Int(number & 0b00001111)
                originalNumbers.append(num1)
                originalNumbers.append(num2)
            }
            
            // Print the original and restored numbers
            //print("Original numbers:", numbers)
            print("Restored numbers:", originalNumbers)
        } else {
            print("Error reading compressed numbers from the file.")
        }
    } catch {
        print("Error saving compressed numbers:", error)
    }
}

func readCompressedNumbers(from fileURL: URL) -> [UInt8]? {
    do {
        // Read the compressed data from the file
        let restoredData = try Data(contentsOf: fileURL)
        
        // Convert the restored data back to the compressed numbers
        let restoredNumbers = Array(restoredData)
        
        return restoredNumbers
    } catch {
        print("Error reading compressed numbers:", error)
        return nil
    }
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


func convertDatToTxt(datFilePath: String, txtFilePath: String) {
    // Read data from .dat file as raw bytes
    if let data = FileManager.default.contents(atPath: datFilePath) {
        // Write the raw data to a new .txt file
        do {
            try data.write(to: URL(fileURLWithPath: txtFilePath))
            print("Conversion completed successfully.")
        } catch {
            print("Error writing to file:", error.localizedDescription)
        }
    } else {
        print("Failed to read data from .dat file.")
    }
}



#Preview {
    ContentView()
}
