import SwiftUI

struct UserCredentials {
    var email: String
    var password: String
}

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var registrationSuccess = false
    @State private var navigateToLogin = false
    @State private var showLoginView = false // Step 2
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("wallpaper")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    TextField("", text: $email)
                        .frame(height: 51)
                        .frame(width: 300)
                        .foregroundColor(.white)
                        .background(Color("Input1"))
                        .cornerRadius(10)
                        .padding()
                        .overlay(
                            Text(email.isEmpty ? "Email" : "")
                                .foregroundColor(email.isEmpty ? .white : .gray)
                                .padding(.leading, 8)
                                .allowsHitTesting(false)
                        )
                    
                    SecureField("", text: $password)
                        .frame(height: 51)
                        .frame(width: 300)
                        .foregroundColor(.white)
                        .background(Color("Input1"))
                        .cornerRadius(10)
                        .padding()
                        .overlay(
                            Text(password.isEmpty ? "Contraseña" : "")
                                .foregroundColor(password.isEmpty ? .white : .gray)
                                .padding(.leading, 8)
                                .allowsHitTesting(false)
                        )
                    
                    Button(action: registerUser) {
                        Text("Registrarse")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("Button1"))
                            .cornerRadius(10)
                    }
                    .padding(.top,30)
                    .padding()
                }
                .padding()
            }
            .navigationTitle("")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Registro Exitoso"), message: Text("Tu cuenta ha sido creada."), dismissButton: .default(Text("OK")) {
                    navigateToLogin = true
                })
            }
            .background(
                NavigationLink(
                    destination: LoginView(),
                    isActive: $navigateToLogin,
                    label: { EmptyView() }
                )
            )
        }
    }
    
    func registerUser() {
        let user = UserCredentials(email: email, password: password)
        saveUserCredentials(user)
        showAlert = true
    }
    
    func saveUserCredentials(_ user: UserCredentials) {
        let defaults = UserDefaults.standard
        defaults.set(user.email, forKey: "userEmail")
        defaults.set(user.password, forKey: "userPassword")
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
