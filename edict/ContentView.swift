//
//  ContentView.swift
//  edict
//
//  Created by Mac on 2024/7/26.
//

import SwiftUI

struct ContentView: View {
    @State private var serverUrl: String = "http://192.168.123.36:10002"
    @State private var showSheet = false


    var body: some View {

        ZStack{
            LinearGradient(colors: [Color.blue, Color.white], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
        
            VStack {
                
            
                Text("Edict")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)
                
                Spacer()
                
                
                VStack{
                    HStack{
                        Image(systemName: "globe")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.accentColor)
                            .offset(x: 10, y: 0)
                        
                        TextField("http://edict.byzhao.cn", text: $serverUrl)
                            .frame(width:.infinity, height:30)
                            .foregroundColor(Color.blue)
                            .padding()
                        
                    }
                
                }
                .frame(width: .infinity, height: 50)
                .background(Color.white).padding(5).cornerRadius(20)
                
                
                Spacer()
                
          
                
                
//                Image(systemName: "globe").resizable().frame(width: 30, height: 30).imageScale(.large).foregroundColor(.accentColor)
//                Text("你好， 世界！")
//                Button(action: signIn) {
//                    Text("Sign In")
//                }.padding() // 为按钮添加内边距
//                    .background(Color.blue.opacity(0.5)) // 为按钮设置背景色和透明度
//                    .cornerRadius(10) // 设置按钮的圆角
//
                
                Button{
                    signIn()
                    fetchData()
                } label: {
                    Text("连接服务器").font(.system(size: 20))
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(.white)
                        .cornerRadius(10)
                }
                Button("查看帮助") {
                                self.showSheet = true
                            }
                
            }
            .sheet(isPresented: $showSheet) {
                SheetView()
//                VStack{
//                    Rectangle().frame(width: 50, height: 4).cornerRadius(10)
//                    Text("如何使用Edict").font(.title)
//                    Spacer()
//                }.padding(10).cornerRadius(20)
            }
        }
        
    }
    func fetchData() {

        guard let url = URL(string: "\(serverUrl)" + "/king/getDrive?id=1") else {
            print("url 不合法")
            return
        }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    // 处理错误
                    print(error?.localizedDescription ?? "Unknown error")
                    return
                }
                
                if let responseString = String(data: data, encoding: .utf8) {
                    // 使用 responseString
                    print(responseString)
                    // 解析JSON（这里只是示例，你需要根据自己的数据结构来解析）
                     let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    
                    // 更新UI，注意这里需要回到主线程
                    DispatchQueue.main.async {
//                        self.resultText = "请求成功: \(responseString ?? "")"
                    }
                    
                } else {
                    // 数据无法以指定的编码方式解码
                    print("数据无法解码为UTF-8字符串")
                }
            }
      
            task.resume()
        }
}

func signIn(){
    print("按钮被点击了！")
}

struct SheetView: View {
    var body: some View {
        LinearGradient(colors: [Color.orange, Color.white], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            .edgesIgnoringSafeArea(.all) // 如果还需要进一步忽略安全区域
            .overlay(
                VStack{

                    Rectangle().frame(width: 50, height: 4).cornerRadius(10)
                    Text("如何使用Edict").font(.title)
                    
                    Spacer()
                }.padding(10).cornerRadius(20)
            )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
