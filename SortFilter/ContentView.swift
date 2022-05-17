//
//  ContentView.swift
//  SortFilter
//
//  Created by Alessandre Livramento on 12/05/22.
//

import SwiftUI

struct ContentView: View {
  @State var names : [String] = ["Alessandre", "Silvana", "Bruna", "Mike", "Silvia"]
  
  @State var namesFilter : [String] = []
  
  @State var isFilter = false
  @State var isSorted = false
  
  @State var isAnimatedSort = false
  @State var isAnimatedFilter = false
  @State var isAnimatedList = false
  
  var body: some View {
    VStack {
      List {
        ForEach(namesFilter, id: \.self) {name in
          Text(name)
        }
      }
      .animation(
        .easeInOut
        , value: isAnimatedList  )
      
      HStack {
        Button {
          order()
        } label: {
          HStack{
            Image(systemName: "shuffle")
              .symbolRenderingMode(.palette)
              .foregroundColor(
                isFilter ? .gray :
                  isAnimatedSort ? .red : .blue
              )
              .rotationEffect(.degrees(isAnimatedSort ? 180: 360))
              .animation(
                .easeInOut(duration: 1.0)
                ,value: isAnimatedSort )
            
            Text("Ordenar")
          }
        }
        .disabled(isFilter ? true: false)
        
        Spacer().frame(width: 100).border(.red)
        
        Button {
          filter()
        } label: {
          HStack{
            Image(systemName: "slider.horizontal.3")
              .symbolRenderingMode(.palette)
              .foregroundColor(isAnimatedFilter ? .red : .blue)
              .rotationEffect(.degrees(isAnimatedFilter ? 180: 360))
              .animation(
                .easeInOut(duration: 1.0)
                .repeatCount(1)
                ,value: isAnimatedFilter)
            Text("Filtrar")
          }
        }
      }
    }
    .onAppear(){
      namesFilter = names.sorted{ a, b in return a < b }
    }
  }
  
  func order() {
    isAnimatedList = !isAnimatedList
    isAnimatedSort = !isAnimatedSort
    switch isSorted {
      case true:
        sort()
      case false:
        unSort()
    }
    isSorted.toggle()
  }
  
  func filter(){
    isAnimatedList = !isAnimatedList
    isAnimatedFilter = !isAnimatedFilter
    switch !isFilter {
      case true:
        filtered()
      case false:
        unFiltered()
    }
    isFilter.toggle()
  }
  
  func sort(){
    namesFilter.sort{ a, b in return a < b }
  }
  
  func unSort(){
    namesFilter.sort{ a, b in return a > b }
  }

  func filtered(){
    namesFilter = namesFilter.filter{ name in return name.count < 5 }
  }
  
  func unFiltered(){
    namesFilter = isSorted ? names.sorted{ a, b in return a > b } : names.sorted{ a, b in return a < b }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
