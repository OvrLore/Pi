//
//  Provissima.swift
//  Pi
//
//  Created by Lorenzo Overa on 26/03/24.
//

import SwiftUI

struct Provissima: View {
    var pi5 = "1415766767"

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            
        }
        .padding()
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

        let FILE_SIZE = 25_000_000 // twenty five million bytes = 50M digits of pi

        

        

        
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
                print("Original numbers:", numbers)
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
}
#Preview {
    Provissima()
}
