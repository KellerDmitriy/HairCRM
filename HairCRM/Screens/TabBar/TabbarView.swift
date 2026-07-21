//
//  TabbarView.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 27.06.2025.
//

import SwiftUI

// MARK: - Tab Enum
enum Tab: String, CaseIterable {
    case home
    case clients
    case calculator
    case materials
    case profile
    
    
    // MARK: - Icon for Tabs
    var icon: String {
        switch self {
        case .home:
            return "plus.viewfinder"
        case .clients:
            return "person.crop.circle.badge"
        case .calculator:
            return "highlighter"
        case .materials:
            return "lightspectrum.horizontal"
        case .profile:
            return "person.crop.circle.fill"
        }
    }
}

struct TabbarView: View {
    @Binding var selectedTab: Tab
    var switchTab: (Tab) -> Void
    @Namespace private var animation

    private enum Drawing {
        static let height: CGFloat = 72
        static let cornerRadius: CGFloat = 26
        static let iconSize: CGFloat = 22
        static let buttonSize: CGFloat = 48
        static let barHorizontalPadding: CGFloat = 14
        static let barBottomPadding: CGFloat = 12
        static let itemPadding: CGFloat = 8
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                tabButton(tab: tab)
            }
        }
        .padding(.horizontal, Drawing.barHorizontalPadding)
        .frame(height: Drawing.height)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: Drawing.cornerRadius, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: Drawing.cornerRadius, style: .continuous)
                .stroke(Color.white.opacity(0.14), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.18), radius: 18, x: 0, y: 8)
        .padding(.horizontal, 16)
        .padding(.bottom, Drawing.barBottomPadding)
    }

    private func tabButton(tab: Tab) -> some View {
        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.78)) {
                switchTab(tab)
            }
        } label: {
            ZStack {
                if selectedTab == tab {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white.opacity(0.14))
                        .matchedGeometryEffect(id: "selectedTab", in: animation)
                }

                Image(systemName: tab.icon)
                    .font(.system(size: Drawing.iconSize, weight: .semibold))
                    .foregroundStyle(selectedTab == tab ? .white : .white.opacity(0.62))
                    .symbolEffect(.bounce, value: selectedTab == tab)
            }
            .frame(width: Drawing.buttonSize, height: Drawing.buttonSize)
        }
        .buttonStyle(.plain)
        .padding(.vertical, Drawing.itemPadding)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [.black, .gray.opacity(0.7)],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()

        VStack {
            Spacer()
            TabbarView(selectedTab: .constant(.clients), switchTab: { _ in })
        }
    }
}
