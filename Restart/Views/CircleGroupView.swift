//
//  CircleGroupView.swift
//  Restart
//
//  Created by Vladyslav Arseniuk on 6/2/23.
//

import SwiftUI

struct CircleGroupView: View {
	
	@State var shapeColor: Color
	@State var shapeOpaity: Double
	@State private var isAnimating = false
	
	private let circleSize: CGFloat = 260
	
    var body: some View {
		ZStack{
			Circle()
				.stroke(shapeColor.opacity(shapeOpaity), lineWidth: 40)
				.frame(width: circleSize, height: circleSize, alignment: .center)
			Circle()
				.stroke(shapeColor.opacity(shapeOpaity), lineWidth: 80)
				.frame(width: circleSize, height: circleSize, alignment: .center)
		}
		.blur(radius: isAnimating ? 0 : 10)
		.opacity(isAnimating ? 1 : 0)
		.scaleEffect(isAnimating ? 1 : 0.5)
		.animation(.easeOut(duration: 1), value: isAnimating)
		.onAppear {
			isAnimating = true
		}
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
		ZStack {
			Color(.blue)
				.ignoresSafeArea(.all, edges: .all)
			CircleGroupView(shapeColor: .white, shapeOpaity: 0.2)
		}
    }
}
