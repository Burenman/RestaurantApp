//
// DisplayDish.swift



import SwiftUI


struct DisplayDish: View {
    @ObservedObject private var dish:Dish
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {
            HStack {
                Text(dish.name ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(String(format: "$%.2f", dish.price))
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .frame(alignment: .trailing)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.horizontal, 10) // Optional: Add padding between name and price
            }
            .contentShape(Rectangle())
        }
    }

    struct DisplayDish_Previews: PreviewProvider {
        static let context = PersistenceController.shared.container.viewContext

        static var previews: some View {
            let dish = Dish(context: context)
            dish.name = "Hummus"
            dish.price = 10
            dish.size = "Extra Large"

            return DisplayDish(dish)
        }
    }





