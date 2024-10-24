//
//  CardView.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 23/10/24.
//

import SwiftUI

struct CardView: View{
    var width: CGFloat
    private var height: CGFloat{
        get{
            self.width * 1.35
        }
    }
    
    var hidden = true
    var text = "Ducimus et cupiditate aliquid nam molestiae."
    var icon = ""
    var indexnum = 30
    
    var body: some View {
        
        ZStack(){
            RoundedRectangle(cornerRadius: width/20)
                .fill(Color.white)
            
            if(hidden){
                Image(systemName:"questionmark")
                    .resizable()
                    .scaledToFit()
                    .fontWeight(.heavy)
                    .padding(width/3)
            }else{
                VStack(alignment:.leading,spacing: width/18){
                    Text(text)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: width/14))
                    Image(systemName: icon)
                        .font(.system(size: width/5))
                    Text("\(indexnum)")
                        .font(.system(size: width/5))
                        .fontWeight(.heavy)
                }
                .padding(width/6)
            }
        }
        .frame(width: width, height: height)
        .background{
            RoundedRectangle(cornerRadius: width/20)
                .padding(.leading, -width/30)
                .opacity(0.1)
        }
    }
    
}
#Preview {
    CardView(width: 170, hidden: false, text: "Lorem Ipsum", icon: "pencil", indexnum: 100)
}
