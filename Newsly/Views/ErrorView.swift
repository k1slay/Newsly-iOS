//
//  ErrorView.swift
//  Newsly
//
//  Created by Kislay Kishore on 19/04/21.
//

import SwiftUI

struct ErrorView: View {
    
    let errorMessage: String?
    let onRetryClick: () -> Void
  
    var body: some View {
        VStack{
            Text("(×﹏×)").font(.system(size: 52))
            Spacer().frame(height: 24)
            Text(errorMessage != nil ? errorMessage! : "defaultError").font(.system(size: 14))
            Spacer().frame(height: 32)
            Button(action: {onRetryClick.self()}) {
                HStack {
                    Image("refresh")
                    Text("retry").foregroundColor(Color.white)
                }.padding(.horizontal, 24).padding(.vertical, 8)
            }.background(Capsule()).foregroundColor(Color.accentColor)
        }.padding(40)
    }
}

//struct ErrorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ErrorView()
//    }
//}
