//
//  SpinsView.swift
//  Fitness Go
//
//  Created by 郭奕婷 on 7/9/2024.
//

import SwiftUI
struct SpinsView: View {
    @State private var rotationAngle: Double = 0
    @State private var showAlert: Bool = false
    @State private var selectedColor: String = ""
    @State private var isshowdetail:Bool = false
    @EnvironmentObject var spinItemsModel: SpinItemsModel
    @State private var selectedItem: BagItem?
    let colors: [String: Color] = ["Green": .green, "Blue": .blue, "Red": .red]
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var globalEnv: GlobalEnvironment
    @State private var isShowAlertBox:Bool = false
    var body: some View {
        ZStack{
            if !isshowdetail{
                           Image("background 6")
                               .resizable()
                               .scaledToFill()
                               .edgesIgnoringSafeArea(.all)
                       }else{
                           Image("background 7")
                               .resizable()
                               .scaledToFill()
                               .edgesIgnoringSafeArea(.all)
                       }
            VStack {
                
                VStack(spacing:30) {
                    ZStack{
                        Image("box")
                            .resizable()
                            .scaledToFill()
                            .padding(EdgeInsets(top: 30, leading: 30, bottom: 50, trailing: 30))
                        
                        if isshowdetail{
                            ShowGiftView(colorName: selectedColor)
                                .padding(.top,140)
                        }else{
                            // Rotating Wheel
                            GeometryReader { geometry in
                                let width = min(geometry.size.width, geometry.size.height)
                                let radius = width / 2
                                
                                HStack(spacing:20){
                                    Image("coin")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30,height: 30)
                                    Text("\(globalEnv.coins) coin")
                                        .bold()
                                        .font(.title)
                                }
                                .position(x:geometry.size.width/2,y:-50)
                                
                                ZStack {
                                    //  // Green Sector
                                    SectorView(startAngle: 0, endAngle: 180, radius: radius, color: Color(red: 133/255, green: 225/255, blue: 153/255))
                                    // Blue Sector
                                    SectorView(startAngle: 180, endAngle: 300, radius: radius, color: Color(red: 125/255, green: 191/255, blue: 251/255))
                                    // Red Sector
                                    SectorView(startAngle: 300, endAngle: 360, radius: radius, color: Color(red: 255/255, green: 131/255, blue: 131/255))
                                    
                                    
                                }
                                .rotationEffect(.degrees(rotationAngle))
                                
                                ArrowView()
                                    .frame(maxWidth: .infinity,alignment: .center)
                                    .padding(.top,-10)
                                
                                
                                
                                
                                
                            }
                            .frame(width: 300, height: 300)
                            .onTapGesture {
                                if globalEnv.coins > 0{
                                    rotateWheel()
                                }else{
                                    isShowAlertBox = true
                                }
                                
                            }
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                    Image("spins")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80,height: 80)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading,10)
                        .padding(.top,-80)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    if isshowdetail{
                                           Button(action: {
                                               if globalEnv.coins > 0{
                                                   globalEnv.subtractCoinspin(1)
                                               }
                                               
                                               isshowdetail = false
                                           }) {
                                               Text("Once again")
                                                   .padding()
                                                   .padding(.leading)
                                                   .padding(.trailing)
                                                   .padding(.leading)
                                                   .padding(.trailing)
                                                   .font(.largeTitle)
                                                   .foregroundColor(.white)
                                                   .background(.gray)
                                                   .cornerRadius(10)
                                           }.padding(.top,-100)
                                               .padding(.leading,50)
                                       }
                                     
                    
                    
                    
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Result"),
                        message: Text("Winner Color is: \(selectedColor)"),
                        dismissButton: .default(Text("OK"), action: {
                            print("OK")
                            self.selectedColor = selectedColor
                            print("yaya \(self.selectedColor)")
                            //go to detail page
                            isshowdetail = true
                        })
                    )
                }
            }
        }
        .alert(isPresented: $isShowAlertBox) {
                      Alert(
                          title: Text("Warning"),
                          message: Text("Insufficient coins, cannot draw."),
                          dismissButton: .default(Text("OK"))
                      )
                  }
    }
    private func rotateWheel() {
        withAnimation(.easeInOut(duration: 3)) {
            rotationAngle += 360 * 3 + Double.random(in: 0..<360)
        }
        print(rotationAngle)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let winningAngle = rotationAngle.truncatingRemainder(dividingBy: 360)
            // Find the actual angle of the sector
            let actualAngle = (360 - (winningAngle.truncatingRemainder(dividingBy: 360)))
            let sector = getWinningSector(angle: actualAngle)
            
            print("actual angle \(actualAngle)")
            selectedColor = sector

            spinItemsModel.addItem(color: selectedColor)
//            print("Added item: \(self.selectedColor). Total items: \(self.$spinItemsModel.spunItems.count)")
//
            showAlert = true
            isshowdetail = true
        }
    }
    private func getWinningSector(angle: Double) -> String {
        switch angle {
        case 277..<353:
            return "Blue" //311，308，321,302,283,341,335,16,340，282,347，349，353，306，291,277
        case 39..<42:
            return "Blue" //16，
        case 0..<24:
            return "Blue" //16，12，9，8，14，24
            
        case 100..<272:
            return "Green" //112，104，，226，191,174,178,231,268,237,122,272,106，102
        default:
            return "Red" //334,42,57,56,76,84,43,63，38，79，50，47，84，93
        }
    }
}
struct SectorView: View {
    let startAngle: Double
    let endAngle: Double
    let radius: CGFloat
    let color: Color
    
    var body: some View {
        Path { path in
            path.addArc(center: CGPoint(x: radius, y: radius),
                        radius: radius,
                        startAngle: .degrees(startAngle),
                        endAngle: .degrees(endAngle),
                        clockwise: false)
            path.addLine(to: CGPoint(x: radius, y: radius))
        }
        .fill(color)
    }
}
struct ArrowView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 15))
            path.addLine(to: CGPoint(x: -10, y: 0))
            path.addLine(to: CGPoint(x: 10, y: 0))
            path.closeSubpath()
        }
        .fill(Color.black)
        .frame(width: 30, height: 30)
    }
}
#Preview{
    SpinsView()
        .environmentObject(SpinItemsModel())
        .environmentObject(GlobalEnvironment())
}
