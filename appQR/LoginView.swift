import SwiftUI

struct StoredUserCredentials {
    var email: String
    var password: String
    
    static func verify(email: String, password: String) -> Bool {
        let defaults = UserDefaults.standard
        if let storedEmail = defaults.string(forKey: "userEmail"),
           let storedPassword = defaults.string(forKey: "userPassword") {
            return email == storedEmail && password == storedPassword
        }
        return false
    }
}

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showInvalidCredentialsAlert = false
    @State private var showQRCode = false
    @State private var qrCodeString = ""

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

                    NavigationLink(destination: QRCodeView(qrCodeString: qrCodeString), isActive: $showQRCode) {
                        EmptyView()
                    }
                    .hidden() 

                    Button(action: {
                        if StoredUserCredentials.verify(email: email, password: password) {
                            qrCodeString = "Cadena para el código QR"
                            showQRCode = true
                            print("Inicio de sesión exitoso")
                        } else {
                            showInvalidCredentialsAlert = true
                            print("Credenciales incorrectas")
                        }
                    }) {
                        Text("Iniciar")
                            .padding(.horizontal, 50)
                            .padding(.vertical)
                            .foregroundColor(.white)
                            .background(Color("Button1"))
                            .cornerRadius(10)
                    }
                    .padding(.top,30)
                    .padding()
                }
                .padding()
            }
            .alert(isPresented: $showInvalidCredentialsAlert) {
                Alert(title: Text("Credenciales incorrectas"), message: Text("El correo electrónico o la contraseña son incorrectos. Por favor, inténtalo de nuevo."), dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarTitle("", displayMode: .inline) // Para ocultar el título de navegación
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
