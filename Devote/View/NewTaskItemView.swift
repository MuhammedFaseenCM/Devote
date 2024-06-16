//
//  NewTaskItemView.swift
//  Devote
//
//  Created by bosctech on 15/06/24.
//

import SwiftUI

struct NewTaskItemView: View {
    
    //MARK: - PROPERTIES
    @AppStorage("isDarkMode") private var isdarkMode: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var task: String = ""
    private var isButtonDisabled: Bool  {
        task.isEmpty
    }
    @Binding var isShowing: Bool
    //MARK: - FUNCTIONS
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
    var body: some View {
        VStack{
            Spacer()
            VStack(spacing: 16){
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 24,weight: .bold,design: .rounded))
                    .padding()
                    .background(isdarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                Button(action: {
                    addItem()
                    playSound(sound: "sound-ding", type: "mp3")
                    feedback.notificationOccurred(.success)
                }, label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24,weight: .bold,design: .rounded))
                    Spacer()
                })
                .disabled(isButtonDisabled)
                .onTapGesture {
                    if isButtonDisabled {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .background(isButtonDisabled ? Color.blue : Color.pink)
                .cornerRadius(10)
            }//: VSTACK
            .padding(.horizontal)
            .padding(.vertical,20)
            .background(isdarkMode ? Color(UIColor.secondarySystemBackground) : Color.white)
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0,opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
        }//: VSTACK
        .padding()
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
