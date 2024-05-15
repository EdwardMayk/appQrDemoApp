import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let qrCodeString: String
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    @State private var isSharing = false

    var body: some View {
        VStack {
            Image(uiImage: generateQRCodeImage())
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .overlay(
                    Image("header")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 200)
                        .offset(x: 0, y: -200)
                )

            Spacer().frame(height: 200)
            
            Button(action: shareQRCode) {
                Text("Compartir")
                    .padding()
                    .background(Color("ButtonShare"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }

    func generateQRCodeImage() -> UIImage {
        let data = Data(qrCodeString.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        } else {
            return UIImage(systemName: "xmark.circle") ?? UIImage()
        }
    }

    func shareQRCode() {
        let image = generateQRCodeImage()
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            window.rootViewController?.present(activityViewController, animated: true, completion: nil)
        }
    }

}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView(qrCodeString: "dasdasd")
    }
}
