//
//  Community.swift
//  FinalProject
//
//  Created by Koko Jimenez  on 4/18/24.
//

import SwiftUI

struct CommunityView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Community")
                    .font(.title)
                    .bold()
                ScrollView {
                    VStack {
                        
                        NewsSection
                            .padding(.bottom, 20)

                        EventsSection
                    }
                }
            }
            .foregroundStyle(Color("Orange"))
        }
    }
             
    private var NewsSection: some View {
        
        VStack(alignment: .leading) {
            Text("News")
                .font(.title2)
            
            ForEach(Array(allNewsArticleInfo.keys), id: \.self) {
                title in
                NavigationLink(destination: ArticleView(title: title, imageName: allNewsArticleInfo[title]!["Image"]!, isNewsArticle: true)) {
                    getBlogEntryView(backgroundImage: allNewsArticleInfo[title]!["Image"]!, title: title, isNewsSection: true)
                        .navigationBarHidden(true)
                }
            }
        }
        .foregroundColor(Color("Orange"))
    }
    
    private var EventsSection: some View {
        
        VStack(alignment: .leading) {
            Text("Events")
                .font(.title2)
            
            ForEach(Array(allEventArticleInfo.keys), id: \.self) {
                title in
                NavigationLink(destination: ArticleView(title: title, imageName: allEventArticleInfo[title]!["Image"]!, isNewsArticle: false)) {
                    getBlogEntryView(backgroundImage: allEventArticleInfo[title]!["Image"]!, title: title, isNewsSection: false)
                        .navigationBarHidden(true)
                }
            }
        }
        .foregroundColor(Color("Orange"))
    }
    
    private func getBlogEntryView(backgroundImage imageName: String, title: String, isNewsSection: Bool) -> some View {
        
        
        let height = isNewsSection ? 150.0 : 100.0
        return ZStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: height)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 350, height: height)
                .foregroundColor(.black.opacity(0.5))
            
            Text(title)
                .font(.system(size: 18))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    CommunityView()
}
