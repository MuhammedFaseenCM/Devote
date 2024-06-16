//
//  BlankView.swift
//  Devote
//
//  Created by bosctech on 15/06/24.
//

import SwiftUI

struct BlankView: View {
    //MARK:  - PROPERTY
    
    var backGroundColor: Color
    var backGroundOpacity: Double
    
    //MARK: - BODY
    var body: some View {
        VStack{
            Spacer()
        }
        .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity,alignment: .center)
        .background(backGroundColor)
        .opacity(backGroundOpacity)
        .blendMode(.overlay)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(backGroundColor: Color.black, backGroundOpacity: 0.3)
            .background(BackgroundImageView())
            .background(backgroundGradient.ignoresSafeArea(.all))
    }
}
