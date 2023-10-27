import SwiftUI
import CoreData

struct OurDishes: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var dishesModel = DishesModel()
    @State private var showAlert = false
    @State private var searchText = ""
    
    
    private func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true) // Return true predicate for empty searchText
        } else {
            return NSPredicate(format: "name CONTAINS[c] %@", searchText)
            // 'CONTAINS[c]' performs case-insensitive and diacritic-insensitive search in the 'name' attribute
        }
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
          let sortDescriptor = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
          return [sortDescriptor]
      }
    
    var body: some View {
        VStack {
            LittleLemonLogo()
                .padding(.bottom, 10)
                .padding(.top, 50)
            
            Text("Tap to order")
                .foregroundColor(.black)
                .padding([.leading, .trailing], 40)
                .padding([.top, .bottom], 8)
                .background(Color("approvedYellow"))
                .cornerRadius(20)
            
            NavigationView {
                FetchedObjects(
                    predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                        List {
                            ForEach(dishes, id: \.self) { dish in
                                // Make DisplayDish tappable and toggle showAlert
                                Button(action: {
                                    showAlert.toggle()
                                }) {
                                    DisplayDish(dish)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .searchable(text: $searchText, prompt: "search...")
                    }
            }
            .padding(.top, -10)
            .alert("Order placed, thanks!", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            .scrollContentBackground(.hidden)
            .task {
                await dishesModel.reload(viewContext)
            }
        }
    }
}

struct OurDishes_Previews: PreviewProvider {
    static var previews: some View {
        OurDishes()
    }
}
