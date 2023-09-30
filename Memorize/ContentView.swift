//
//  ContentView.swift
//  Memorize
//
//  Created by Jo Michael on 9/29/23.
//

import SwiftUI

struct ContentView: View {
    let fruits = ["🌶️", "🍎", "🍓", "🫐", "🍏", "🍇", "🍆" , "🥬", "🥦", "🌽", "🥕", "🍉", "🍐", "🍒", "🍑", "🥝", "🧅", "🥑", "🥒", "🥭", "🍅"]
    
    let cars = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍️", "🛺", "🛴"]
    
    let flags = ["🇨🇩", "🇨🇬", "🇳🇬", "🇿🇦", "🇹🇿", "🇬🇦", "🇮🇪", "🇬🇭", "🇦🇴"]
    
    @State var emojis = [String]()
    
    @State var cardCount = 4
    
    @State var color: Color = .accentColor
    
    var body: some View {
        VStack {
            Text("Memorize")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            cardThemePickerAdjusters
        }
        .padding()
    }
    
    // MARK: - Cards View()
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 0)], spacing: 0) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundStyle(.green)
    }
    
    // MARK: - Adjuster fo button-choosing theme
    var cardThemePickerAdjusters: some View {
        HStack(alignment: .bottom, spacing: 40) {
            fruitCardAdder
            cardThemeAdder
            carFlagsThemeAdder
        }
        .imageScale(.large)
    }
    
    func cardCountAdjuster(with elements: [String], symbol: String, name: String) -> some View {
        Button(action: {
            if elements.count < cardCount {
                emojis = ["?", "?", "?", "?"]
            } else {
                emojis = []
                for index in 0..<elements.count {
                    emojis.append(elements[index])
                    emojis.append(elements[index])
                }
            }
            emojis.shuffle()
        }, label: {
            VStack {
                Image(systemName: symbol)
                Text(name).font(.footnote)
            }
        })
    }
    
    // TODO: - Add Fruits theme
    var fruitCardAdder: some View {
        return cardCountAdjuster(with: fruits, symbol: "tree", name: "Fruits")
    }
    
    // MARK: Remove card action here
    var cardThemeAdder: some View {
        return cardCountAdjuster(with: cars, symbol: "car.rear", name: "Vehicules")
    }
    
    // MARK: Add card action here
    var carFlagsThemeAdder: some View {
        cardCountAdjuster(with: flags, symbol: "flag", name: "Flags")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 16)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}


#Preview {
    ContentView()
}
