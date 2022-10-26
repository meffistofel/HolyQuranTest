//
//  ProgressViewWithStep.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 18.10.2022.
//

import SwiftUI

struct ProgressViewWithStep: View {

    let numberSteps: Int

    @Binding var currentStep: Int

    var body: some View {
        HStack {
            ForEach(1..<numberSteps + 1, id: \.self) { number in
                ZStack {
                    Circle().fill(Color.white).frame(width: 32, height: 32)
                    LinearGradient(colors: getColor(with: number), startPoint: .leading, endPoint: .trailing)
                        .frame(width: number == currentStep ? 32 : 24, height: number == currentStep ? 32 : 24)
                        .clipShape(Circle())
                    Text("\(number)")
                        .customFont(.bold, size: 16)
                        .foregroundColor(.white)
                        .animation(.default, value: currentStep)
                }
                .animation(.default, value: currentStep)

                if  number != numberSteps {
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundColor( number <= currentStep ? .orange : .gray)
                        .animation(.default, value: currentStep)
                        .frame(height: 1)
                }
            }
        }
    }

    private func getColor(with number: Int) -> [Color] {
        number <= currentStep ? Color.gradient : [Color.gray]
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

#if DEBUG
struct ProgressViewWithStep_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewWithStep(numberSteps: 5, currentStep: .constant(2))
            .previewLayout(.sizeThatFits)
    }
}
#endif
