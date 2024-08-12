//
//  ArticleView.swift
//  FinalProject
//
//  Created by Kevin on 5/2/24.
//

import SwiftUI

struct ArticleView: View {
    @State var title: String
    @State var imageName: String
    @State var isNewsArticle: Bool
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                
                Text((isNewsArticle ? allNewsArticleInfo : allEventArticleInfo)[title]!["Text"]!)
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
            .padding(EdgeInsets(top: 20, leading: 15, bottom: 10, trailing: 15))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButtonView())
    }
}

#Preview {
    ArticleView(title: "Article1", imageName: "background", isNewsArticle: false)
}
