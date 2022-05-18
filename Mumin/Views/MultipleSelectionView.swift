//
//  MultipleSelectionView.swift
//  Mumin
//
//  Created by OS on 3.05.2022.
//

import SwiftUI

struct MultipleSelectionRow: View {
    @ObservedObject var selections = Selections()
    
  var daysOfWeek: [DaysOfWeek] = [.monday, .tuesday, .wednesday, .thursday,.friday,.saturday,.sunday, .everyday]
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct MultipleSelectionView: View {
  @ObservedObject var selections = Selections()
  var daysOfWeek: [DaysOfWeek] = [.monday, .tuesday, .wednesday, .thursday,.friday,.saturday,.sunday, .everyday]

  
    var body: some View {
            List {
                ForEach(self.daysOfWeek, id: \.self) { item in
                  MultipleSelectionRow(title: item.rawValue, isSelected: self.selections.selections.contains(item)) {
                    if self.selections.selections.contains(item) {
                      self.selections.selections.removeAll(where: { $0 == item })
                        }
                        else {
                          self.selections.selections.append(item)
                          
                        }
                    }
                }.foregroundColor(Color.black)
            }
        }
  }

class Selections: ObservableObject {
  @Published var selections: [DaysOfWeek] = []
  
  func selectItem(selection: DaysOfWeek) {
    selections.append(selection)
  }
}

struct MultipleSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSelectionView()
    }
}
