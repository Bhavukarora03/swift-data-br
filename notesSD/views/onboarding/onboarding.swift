
import SwiftUI


struct OnboardingSheet: View {
  @State private var currentPage = 1
    @Environment(\.dismiss) var dismiss

  enum Page {  
    case page1, page2, page3

    var image: String {
      switch self {
      case .page1: return "onboarding_image_1"
      case .page2: return "onboarding_image_2"
      case .page3: return "onboarding_image_3"
      }
    }

    var title: String {
      switch self {
      case .page1: return "Add notes easily"
      case .page2: return "Manage notes"
      case .page3: return "Start exploring"
      }
    }

    var description: String {
      switch self {
      case .page1: return "Tap the '+' button to create a new note."
      case .page2: return "Swipe left on a note to delete it."
      case .page3: return "Personalize your notes."
      }
    }
  }

  var currentpage: Page {
    switch currentPage {
    case 1: return .page1
    case 2: return .page2
    case 3: return .page3
    default: return .page1
    }
  }

  var body: some View {
    NavigationView {
        VStack {
            Image(currentpage.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.bottom, 20)
    
            Text(currentpage.title)
            .font(.title)
            .fontWeight(.bold)
            .padding(.bottom, 10)
    
            Text(currentpage.description)
            .font(.body)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
            
          
            HStack {
              if currentPage > 1 {
                Button("Previous") {
                  currentPage -= 1
                }
                .buttonStyle(.bordered)
                .accentColor(.black)
              
    
               
              }
              Spacer()
              if currentPage < 3 { // Use less than 3 here
                Button("Next") {
                  currentPage += 1
                }
                .buttonStyle(.borderedProminent)
                .accentColor(.black)
                .foregroundColor(.white)
              } else {
                Button("Get Started") {
                  dismiss()
                }
                .buttonStyle(.borderedProminent)
                .accentColor(.black)
                .foregroundColor(.white)
              }
            }.padding(.all, 50)
        }
      
  
    }
  }

 
}

#Preview {
  OnboardingSheet()
}
