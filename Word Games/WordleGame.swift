
import Foundation

class WordleGame: ObservableObject {
    @Published var targetWord: String
    @Published var guesses: [String] = []
    @Published var feedback: [[Character?]] = [] // Each Character? can be nil, correct (letter itself), or present but wrong position ('?')
    @Published var solved: Bool = false
    @Published var msg: String = ""

    init(targetWord: String) {
        self.targetWord = targetWord.uppercased()
    }

    func submitGuess(_ guess: String) {
  
        if(guess.count != 5 ){
            msg = "Your Guess must be 5 characters long"
            return
        }
        else{
            msg = ""
        }
        
        var guessFeedback: [Character?] = Array(repeating: nil, count: 5)
        var tempTargetWord = targetWord
        
        // First pass: Check for correct positions
        for (index, char) in guess.enumerated() {
            let targetIndex = targetWord.index(targetWord.startIndex, offsetBy: index)
            if targetWord[targetIndex] == char {
                guessFeedback[index] = char // Correct position
                tempTargetWord.replaceSubrange(targetIndex...targetIndex, with: " ") // Mark as checked
            }
        }
        
        // Second pass: Check for correct letters in the wrong position
        for (index, char) in guess.enumerated() {
            if guessFeedback[index] == nil && tempTargetWord.contains(char) {
                guessFeedback[index] = "?" // Correct letter, wrong position
                if let charIndex = tempTargetWord.firstIndex(of: char) {
                    tempTargetWord.replaceSubrange(charIndex...charIndex, with: " ") // Mark as checked
                }
            }
        }
        
        if(guess == targetWord){
            solved = true
        }
        
        guesses.append(guess)
        feedback.append(guessFeedback)
    }
}
