//
//  OnboardingView.swift
//  Restart
//
//  Created by Vladyslav Arseniuk on 6/2/23.
//

import SwiftUI

struct OnboardingView: View {
	
	@AppStorage("onboarding") var isOnboardingViewActive = true
	
	@State private var buttonWidth = UIScreen.main.bounds.width - 80
	@State private var buttonOffset: CGFloat = 0
	@State private var circleRadius: Double = 80
	@State private var isAnimating = false
	@State private var imageOffset: CGSize = .zero
	@State private var indicatorOpacity = 1.0
	@State private var textTitle = "Share"

	private let hapticFeedback = UINotificationFeedbackGenerator()
	
    var body: some View {
		ZStack {
			Color(UIColor.systemBlue)
				.ignoresSafeArea(.all, edges: .all)
			VStack(spacing: 20) {
				Spacer()
				
				
				// MARK: -HEADER
				VStack(spacing: 0) {
					Text(textTitle)
						.font(.system(size: 60))
						.fontWeight(.heavy)
						.foregroundColor(.white)
						.transition(.opacity)
					Text("It's not how much we give but\nhow much love we put into giving.")
					.font(.title3)
					.fontWeight(.light)
					.foregroundColor(.white)
					.multilineTextAlignment(.center)
					.padding(.horizontal, 10)
				} //: HEADER
				.opacity(isAnimating ? 1 : 0)
				.offset(y: isAnimating ? 0 : -40)
				.animation(.easeOut(duration: 1), value: isAnimating)
				
				// MARK: -CENTER
				
				ZStack {
					CircleGroupView(shapeColor: .white, shapeOpaity: 0.2)
						.offset(x: imageOffset.width * -0.5)
						.blur(radius: abs(imageOffset.width / 5))
						.animation(.easeOut(duration: 1), value: imageOffset)
					
					Image("character-1")
						.resizable()
						.scaledToFit()
						.opacity(isAnimating ? 1 : 0)
						.animation(.easeOut(duration: 0.5), value: isAnimating)
						.offset(x: imageOffset.width * 1.2, y: 0)
						.rotationEffect(.degrees(Double(imageOffset.width / 20)))
						.gesture(
							DragGesture()
								.onChanged({ gesture in
									if abs(imageOffset.width) <= 150 {
										imageOffset = gesture.translation
										withAnimation {
											indicatorOpacity = 0
											textTitle = "Give"
										}
										
									}
								})
								.onEnded({ _ in
									imageOffset = .zero
									withAnimation {
										indicatorOpacity = 1
										textTitle = "Share"
									}
								})
						)
						.animation(.easeOut(duration: 1), value: imageOffset)
				} //: CENTER
				.overlay(
					Image(systemName: "arrow.left.and.right.circle")
						.font(.system(size: 44, weight: .ultraLight))
						.foregroundColor(.white)
						.offset(y: 20)
						.opacity(isAnimating ? 1 : 0)
						.animation(.easeOut(duration: 1).delay(2), value: isAnimating)
						.opacity(indicatorOpacity)
					, alignment: .bottom
				)
				
				Spacer()
				
				// MARK: -FOOTER
				
				ZStack {
					Capsule()
						.fill(Color.white.opacity(0.2))
					Capsule()
						.fill(Color.white.opacity(0.2))
						.padding(8)
					
					Text("Get Started")
						.font(.system(.title3, design: .rounded))
						.fontWeight(.bold)
						.foregroundColor(.white)
						.offset(x: 20)
					
					HStack {
						Capsule()
							.fill(.red)
							.frame(width: buttonOffset + circleRadius)
						Spacer()
					}
					
					HStack {
						ZStack {
							Circle()
								.fill(Color.red.opacity(0.7))
							Circle()
								.fill(.black.opacity(0.15))
								.padding(8)
							Image(systemName: "chevron.right.2")
								.font(.system(size: 24, weight: .bold))
						}
						.foregroundColor(.white)
						.frame(width: circleRadius, height: circleRadius, alignment: .center)
						.offset(x: buttonOffset)
						.gesture(
							DragGesture()
								.onChanged({ gesture in
									if gesture.translation.width > 0 && buttonOffset <= buttonWidth - circleRadius {
										buttonOffset = gesture.translation.width
									}
								})
								.onEnded({ _ in
									withAnimation(.easeOut(duration: 0.5)) {
										hapticFeedback.notificationOccurred(.success)
										if buttonOffset >= buttonWidth - circleRadius {
											isOnboardingViewActive = false
											playSound(sound: "chimeup", type: "mp3")
										} else {
											hapticFeedback.notificationOccurred(.warning)
											buttonOffset = 0
										}
									}
								})
						)
						
						Spacer()
					} //
				} //: FOOTER
				.frame(width: buttonWidth, height: circleRadius, alignment: .center)
				.padding()
				.opacity(isAnimating ? 1 : 0)
				.offset(y: isAnimating ? 0 : 40)
				.animation(.easeOut(duration: 1), value: isAnimating)
			}//: VStack
		}//: ZStack
		.onAppear {
			isAnimating = true
		}
		.preferredColorScheme(.dark)
	}
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
