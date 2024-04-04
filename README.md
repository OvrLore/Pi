
# Pi Searcher

Welcome to the Pi Searcher GitHub repository! This Swift application utilizes the Boyer-Moore algorithm to efficiently search for numbers within the first 50 million digits of pi. Whether you're curious about where your birthday falls in the digits of pi or want to explore patterns within this mathematical constant, Pi Searcher has got you covered!

## Features

#### Customizable Input:
Input _any numbers_ and let Pi Searcher find its first occurrence within the first _50 million_ digits of pi.

#### Efficient Searching:
Utilizes the _Boyer-Moore algorithm_ for fast and effective search operations within the extensive digits of pi.
But let's see how the algorithm works:

```swift
 
func index(of pattern: String, usingHorspoolImprovement: Bool = false) -> Index? {
        // Cache the length of the search pattern because we're going to
        // use it a few times and it's expensive to calculate.
        let patternLength = pattern.count
        guard patternLength > 0, patternLength <= self.count else { return nil }

        // Make the skip table. This table determines how far we skip ahead
        // when a character from the pattern is found.
        var skipTable = [Character: Int]()
        for (i, c) in pattern.enumerated() {
            skipTable[c] = patternLength - i - 1
        }

        // This points at the last character in the pattern.
        let p = pattern.index(before: pattern.endIndex)
        let lastChar = pattern[p]

        // The pattern is scanned right-to-left, so skip ahead in the string by
        // the length of the pattern. (Minus 1 because startIndex already points
        // at the first character in the source string.)
        var i = index(startIndex, offsetBy: patternLength - 1)

        // This is a helper function that steps backwards through both strings
        // until we find a character that doesn’t match, or until we’ve reached
        // the beginning of the pattern.
        func backwards() -> Index? {
            var q = p
            var j = i
            while q > pattern.startIndex {
                j = index(before: j)
                q = index(before: q)
                if self[j] != pattern[q] { return nil }
            }
            return j
        }

        // The main loop. Keep going until the end of the string is reached.
        while i < endIndex {
            let c = self[i]

            // Does the current character match the last character from the pattern?
            if c == lastChar {

                // There is a possible match. Do a brute-force search backwards.
                if let k = backwards() { return k }

                if !usingHorspoolImprovement {
                    // If no match, we can only safely skip one character ahead.
                    i = index(after: i)
                } else {
                    // Ensure to jump at least one character (this is needed because the first
                    // character is in the skipTable, and `skipTable[lastChar] = 0`)
                    let jumpOffset = max(skipTable[c] ?? patternLength, 1)
                    i = index(i, offsetBy: jumpOffset, limitedBy: endIndex) ?? endIndex
                }
            } else {
                // The characters are not equal, so skip ahead. The amount to skip is
                // determined by the skip table. If the character is not present in the
                // pattern, we can skip ahead by the full pattern length. However, if
                // the character *is* present in the pattern, there may be a match up
                // ahead and we can't skip as far.
                i = index(i, offsetBy: skipTable[c] ?? patternLength, limitedBy: endIndex) ?? endIndex
            }
        }
        return nil
    }
```

## How to Use

Clone this repository to your local machine.
Open the project in Xcode or your preferred Swift development environment.
Build and run the application.
Input the number you want to search within the digits of pi.
Hit the search button and let Pi Searcher do the rest!

## Contributing

Contributions are welcome! Whether you want to add new features, improve existing functionality, or fix bugs, feel free to submit a pull request. For major changes, please open an issue first to discuss the proposed changes.

## Acknowledgements

This application was developed by Lorenzo Overa as a project to explore algorithms and data structures.
Special thanks to all the people that helped me and to the creators of the Boyer-Moore algorithm for providing an efficient solution to string searching.

## Contact

For any questions, suggestions, or feedback, feel free to reach out to lorenzoovera@gmail.com.

## Happy Searching! 🔍

