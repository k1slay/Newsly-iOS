//
//  ContentView.swift
//  Newsly
//
//  Created by Kislay Kishore on 15/04/21.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("AppName").font(.custom("Sail", size: 56))
            ProgressView()
                .scaleEffect(1.5, anchor: .center)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
