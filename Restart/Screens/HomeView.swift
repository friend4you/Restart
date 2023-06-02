//
//  HomeView.swift
//  Restart
//
//  Created by Vladyslav Arseniuk on 6/2/23.
//

import SwiftUI

struct HomeView: View {
	
	@AppStorage("onboarding") var isOnboardingViewActive = false
	
	@State private var isAnimating = false
	private let haptic = UINotificationFeedbackGenerator()
	
    var body: some View {
		VStack(spacing: 20) {
			
			// MARK: Header
			
			Spacer()
			
			ZStack {
				CircleGroupView(shapeColor: .gray, shapeOpaity: 0.1)
				Image("character-2")
					.resizable()
					.scaledToFit()
					.padding()
					.offset(y: isAnimating ? 20 : -20)
					.animation(
						.easeInOut(duration: 4)
						.repeatForever(),
						value: isAnimating
					)
			}
			
			// MARK: Center
			
			Text("The time that leads to mastery is dependent on the intensity of our focus.")
				.font(.title3)
				.fontWeight(.light)
				.foregroundColor(.secondary)
				.multilineTextAlignment(.center)
				.padding()
			
			// MARK: Footer
			
			Spacer()
			
			Button {
				withAnimation {
					playSound(sound: "success", type: "m4a")
					haptic.notificationOccurred(.success)
					isOnboardingViewActive = true
				}
			} label: {
				Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
					.imageScale(.large)
				Text("Restart")
					.font(.system(.title3, design: .rounded))
					.fontWeight(.bold)
			}
			.buttonStyle(.borderedProminent)
			.buttonBorderShape(.capsule)
			.controlSize(.large)
			

		}
		.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
				isAnimating = true
			})
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
