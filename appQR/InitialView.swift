import SwiftUI

struct InitialView: View {
    @State private var showLoginView = false
    @State private var showRegisterView = false


    var body: some View {
        NavigationStack {
            ZStack {
                Image("wallpaper")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        NavigationLink{
                            LoginView()
                        } label: {
                            Text("Acceder")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .padding(.horizontal, 30)
                                .background(Color("Button1"))
                                .cornerRadius(10)
                        }
                        NavigationLink{
                            RegisterView()
                        } label: {
                            Text("Registro")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .padding(.horizontal, 30)
                                .background(Color("Button1"))
                                .cornerRadius(10)
                        }
                      
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)


        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
