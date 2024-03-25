//
//  BoyerMooreAlgorithm.swift
//  Pi
//
//  Created by Lorenzo Overa on 25/03/24.
//
/*
import Foundation

//Constants
let ASIZE = 256
let XSIZE = 1000

//Preprocessing functions
func preBmBc(_ x: [Character], _ m: Int, _ bmBc: inout [Int]) {
    for i in 0..<ASIZE {
        bmBc[i] = m
    }
    for i in 0..<m - 1 {
        bmBc[Int(x[i].asciiValue!)] = m - i - 1
    }
}

func suffixes(_ x: [Character], _ m: Int, _ suff: inout [Int]) {
    var f = 0
    suff[m - 1] = m
    var g = m - 1
    
    for i in (0..<m - 1).reversed() {
        if i > g && suff[i + m - 1 - f] < i - g {
            suff[i] = suff[i + m - 1 - f]
        }
        else {
            if i < g {
                g = i
            }
            var f = i
            while (g >= 0 && x[g] == x[g + m - 1 - f]) {
                g -= 1
            }
            suff[i] = f - g
        }
    }
}

func preBmGs(_ x: [Character], _ m: Int, _ bmGs: inout [Int]) {
    var suff: [Int] = Array(repeating: 0, count: XSIZE)
    suffixes(x, m, &suff)
    bmGs[0] = m
    for i in 1..<m {
        bmGs[i] = m
    }
    var j = 0
    for i in (0..<m - 1).reversed() {
        if suff[i] == i + 1 {
            for k in 0..<m - 1 - i {
                if bmGs[k] == m {
                    bmGs[k] = m - 1 - i
                }
            }
        }
        bmGs[m - 1 - suff[i]] = m - 1 - i
    }
}

//Boyer-Moore search function
func BM(_ x: [Character], _ m: Int, _ y: [Character], _ n: Int) {
    var bmGs: [Int] = Array(repeating: 0, count: XSIZE)
    var bmBc: [Int] = Array(repeating: 0, count: ASIZE)

    /* Preprocessing */
    preBmGs(Array(x), m, &bmGs)
    preBmBc(Array(x), m, &bmBc)

    /* Searching */
    var j = 0
    while (j <= n - m) {
        var i = m - 1
        while (i >= 0 && x[i] == y[i + j]) {
            i -= 1
        }
        if i < 0 {
            print("Pattern occurs at shift \(j)")
            j += bmGs[0]
        }
        else {
            j += max(bmGs[i], bmBc[Int(y[i + j].asciiValue!)] - m + 1 + i)
        }
    }
}
*/

