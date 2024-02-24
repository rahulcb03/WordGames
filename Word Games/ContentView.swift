import SwiftUI

struct ContentView: View {
    @StateObject private var game = WordleGame(targetWord: "apart")
    @State private var currentGuess = ""
    @State private var errorMsg = ""

    var body: some View {
        VStack {
            
            
            Text("Guess the Word")
                .font(.title)
                .bold()
                
            // Display the board
            ForEach(0..<5, id: \.self) { row in
                HStack {
                    ForEach(0..<5, id: \.self) { column in
                        CellView(letter: row < game.guesses.count ? String(game.guesses[row][game.guesses[row].index(game.guesses[row].startIndex, offsetBy: column)]) : "",
                                 status: row < game.feedback.count ? game.feedback[row][column] : nil)
                    }
                }
            }
            
            TextField("Enter Guess", text: $currentGuess)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onSubmit {
                    game.submitGuess(currentGuess.uppercased())
                    currentGuess = ""
                }
                .disabled(game.guesses.count >= 5  || game.solved) // Max 5 guesses, each 5 letters
            
            Text(game.msg)
                .font(.subheadline)
            if(game.solved){
                Text("Congrats You Solved It!")
                    .font(.subheadline)
            }
            

            
        }
    }
}

struct CellView: View {
    let letter: String
    var status: Character?

    var body: some View {
        Text(letter)
            .frame(width: 50, height: 50)
            .background(colorForStatus(status))
            .foregroundColor(.white)
            .font(.title)
            .cornerRadius(5)
    }

    func colorForStatus(_ status: Character?) -> Color {
        guard let status = status else { return .gray }
        return status == "?" ? .yellow : .green
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
