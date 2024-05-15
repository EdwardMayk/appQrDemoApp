import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("wallpaper")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    NavigationLink{
                        InitialView()
                            .navigationBarBackButtonHidden()
                    }label: {
                        Text("Iniciar")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal, 80)
                            .background(Color("Button1"))
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
      

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
