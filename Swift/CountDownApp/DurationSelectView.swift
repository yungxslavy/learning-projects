import SwiftUI

struct DurationSelectView: View {
    @Binding var selectedMinute: Int
    @Binding var selectedSecond: Int
    
    let title: String
    
    var body: some View {
        VStack {
            // Title
            Text("\(title)")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 0)
                .padding([.top, .leading, .trailing])

            HStack (spacing: 0){
                // Minute Picker
                Picker(selection: $selectedMinute, label: Text("Minutes")){
                    ForEach(0..<60){mins in
                        Text("\(mins)").tag(mins)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 60, height: 100)
                .clipped()
                Text("Min")
                    .bold()
                
                // Seconds Picker
                Picker(selection: $selectedSecond, label: Text("Seconds")){
                    ForEach(0..<24){sec in
                        Text("\(sec)").tag(sec)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 60, height: 100)
                .clipped()
                Text("Sec")
                    .bold()
            }
        }
    }
}


struct DurationSelectViewContainer: View {
    @State private var selectedMinute = 0
    @State private var selectedSecond = 0
    
    var body: some View {
        DurationSelectView(selectedMinute: $selectedMinute, selectedSecond: $selectedSecond, title: "Select Duration:")
    }
}

struct DurationSelectView_Previews: PreviewProvider {
    static var previews: some View {
        // Use a stateful container view for previewing
        DurationSelectViewContainer()
    }
}
