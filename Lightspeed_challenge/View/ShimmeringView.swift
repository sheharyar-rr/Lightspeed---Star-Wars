import SwiftUI

public struct Shimmer: ViewModifier {
    
    let animation: Animation
    @State private var phase: CGFloat = 0
    public init(animation: Animation = Self.defaultAnimation) {
        self.animation = animation
    }

    public static let defaultAnimation = Animation.linear(duration: 1.5).repeatForever(autoreverses: false)

    public init(duration: Double = 1.5, bounce: Bool = false, delay: Double = 0) {
        self.animation = .linear(duration: duration)
            .repeatForever(autoreverses: bounce)
            .delay(delay)
    }

    public func body(content: Content) -> some View {
        content
            .modifier(
                AnimatedMask(phase: phase).animation(animation)
            )
            .onAppear { phase = 0.8 }
    }

    struct AnimatedMask: AnimatableModifier {
        var phase: CGFloat = 0

        var animatableData: CGFloat {
            get { phase }
            set { phase = newValue }
        }

        func body(content: Content) -> some View {
            content
                .mask(GradientMask(phase: phase).scaleEffect(3))
        }
    }
    
    struct GradientMask: View {
        let phase: CGFloat
        let centerColor = Color.black
        let edgeColor = Color.black.opacity(0.3)

        var body: some View {
            LinearGradient(gradient:
                Gradient(stops: [
                    .init(color: edgeColor, location: phase),
                    .init(color: centerColor, location: phase + 0.1),
                    .init(color: edgeColor, location: phase + 0.2),
                ]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

public extension View {
    @ViewBuilder func shimmering(
        active: Bool = true, duration: Double = 1.5, bounce: Bool = false, delay: Double = 0
    ) -> some View {
        if active {
            modifier(Shimmer(duration: duration, bounce: bounce, delay: delay))
        } else {
            self
        }
    }

    @ViewBuilder func shimmering(active: Bool = true, animation: Animation = Shimmer.defaultAnimation) -> some View {
        if active {
            modifier(Shimmer(animation: animation))
        } else {
            self
        }
    }
}
