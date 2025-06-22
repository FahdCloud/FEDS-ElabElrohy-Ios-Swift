import SwiftUI

struct PullToRefresh: View {
    
    private enum Constants {
        static let refreshTriggerOffset = CGFloat(-140)
    }
    
    @Binding private var needsRefresh: Bool
    private let coordinateSpaceName: String
    private let onRefresh: () -> Void
    
    init(needsRefresh: Binding<Bool>, coordinateSpaceName: String, onRefresh: @escaping () -> Void) {
        self._needsRefresh = needsRefresh
        self.coordinateSpaceName = coordinateSpaceName
        self.onRefresh = onRefresh
    }
    
    var body: some View {
        HStack(alignment: .center) {
            if needsRefresh {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .frame(height: 60)
            }
        }
        .background(GeometryReader {
            Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self,
                                   value: -$0.frame(in: .named(coordinateSpaceName)).origin.y)
        })
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { offset in
            guard !needsRefresh, offset < Constants.refreshTriggerOffset else { return }
            withAnimation { needsRefresh = true }
            onRefresh()
        }
    }
}


private struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}


private enum Constantss {
    static let coordinateSpaceName = "PullToRefreshScrollView"
}

struct PullToRefreshScrollView<Content: View>: View {
    @Binding private var needsRefresh: Bool
    private let onRefresh: () -> Void
    private let content: () -> Content
    
    init(needsRefresh: Binding<Bool>,
         onRefresh: @escaping () -> Void,
         @ViewBuilder content: @escaping () -> Content) {
        self._needsRefresh = needsRefresh
        self.onRefresh = onRefresh
        self.content = content
    }
    
    var body: some View {
        ScrollView {
            PullToRefresh(needsRefresh: $needsRefresh,
                          coordinateSpaceName: Constantss.coordinateSpaceName,
                          onRefresh: onRefresh)
            content()
        }
        .coordinateSpace(name: Constantss.coordinateSpaceName)
    }
}
