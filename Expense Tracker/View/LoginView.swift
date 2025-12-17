internal import SwiftUI


struct LoginView: View {
    @StateObject private var vm = LoginViewModel()
    
    @State private var showFields = false
    @State private var animateButton = false
    
    var body: some View {
        ZStack {
            // For Blue Screen
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                // App Title
                Text(AppConstants.title)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 2, y: 2)
                    .opacity(showFields ? 1 : 0)
                    .offset(y: showFields ? 0 : -50)
                    .animation(.easeOut(duration: 0.8).delay(0.2), value: showFields)
                
                //UserName and Password Stack
                VStack(spacing: 20) {
                    TextField(AppConstants.usernamePlaceholder, text: $vm.email)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .opacity(showFields ? 1 : 0)
                        .offset(x: showFields ? 0 : -200)
                        .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.3), value: showFields)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField(AppConstants.passwordPlaceholder, text: $vm.password)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .opacity(showFields ? 1 : 0)
                        .offset(x: showFields ? 0 : 200)
                        .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.4), value: showFields)
                }
                .padding(.horizontal, 32)
                
                // Error message
                if let error = vm.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .transition(.opacity)
                }
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        animateButton.toggle()
                        vm.login()
                    }
                }) {
                    Text(AppConstants.login)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(animateButton ? 0.3 : 0.8))
                        )
                        .shadow(radius: 5)
                        .scaleEffect(animateButton ? 1.05 : 1.0)
                }
                .padding(.horizontal, 32)
                .opacity(showFields ? 1 : 0)
                .offset(y: showFields ? 0 : 50)
                .animation(.easeOut(duration: 0.6).delay(0.5), value: showFields)
                
                Spacer()
            }
        }
        .onAppear { showFields = true }
        .fullScreenCover(isPresented: $vm.isLoggedIn) {
            ExpenseListView()
        }
    }
}
