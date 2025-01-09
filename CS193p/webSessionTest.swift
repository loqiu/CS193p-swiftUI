//
//  webSessionTest.swift
//  CS193p
//
//  Created by 王崇锦 on 08/01/2025.
//
import Foundation


func fetchSomeData(_ url: URL){

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        // 回到主线程前，可以先处理一些后端返回的数据
        if let error = error {
            print("请求出错：\(error.localizedDescription)")
            return
        }
        
        // 如果需要判断状态码，可转成 HTTPURLResponse
        if let httpResponse = response as? HTTPURLResponse {
            print("HTTP 状态码：\(httpResponse.statusCode)")
        }
        
        // 3. 解析数据
        guard let data = data else {
            print("返回数据为空")
            return
        }
        
        // 这里以 JSON 为例做示范
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            print("返回 JSON 数据：\(jsonObject)")
        } catch {
            print("JSON 解析失败：\(error.localizedDescription)")
        }
    }
    
    // 启动请求
    task.resume()
}

func login(username: String, password: String) {
    // 1. 构建 URL
    guard let url = URL(string: "https://api.example.com/login") else {
        print("URL 无效")
        return
    }

    // 2. 创建 URLRequest
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    // 设置请求头
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // 3. 构造请求体（JSON）
    let body: [String: Any] = [
        "username": username,
        "password": password
    ]
    do {
        // 将字典转换为 JSON Data
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    } catch {
        print("请求体转换 JSON 失败：\(error.localizedDescription)")
        return
    }
    
    // 4. 创建并启动 URLSession 任务
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("请求出错：\(error.localizedDescription)")
            return
        }
        
        // 如果需要判断状态码，可转成 HTTPURLResponse
        if let httpResponse = response as? HTTPURLResponse {
            print("HTTP 状态码：\(httpResponse.statusCode)")
        }
        
        // 5. 解析返回的数据
        guard let data = data else {
            print("返回数据为空")
            return
        }
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            print("返回 JSON 数据：\(jsonObject)")
        } catch {
            print("JSON 解析失败：\(error.localizedDescription)")
        }
    }
    task.resume()
}

func fetchData() async throws -> Any {
    guard let url = URL(string: "https://api.example.com/data") else {
        throw URLError(.badURL)
    }
    
    // 使用 async/await 的方法获取 (data, response)
    let (data, response) = try await URLSession.shared.data(from: url)
    
    // 判断 response 是否为 HTTPURLResponse，并检查状态码
    guard let httpResponse = response as? HTTPURLResponse,
          200..<300 ~= httpResponse.statusCode else {
        throw URLError(.badServerResponse)
    }
    
    // 解析 JSON
    return try JSONSerialization.jsonObject(with: data, options: [])
}

// 在某个异步上下文中调用
@MainActor
func load() {
    Task {
        do {
            let result = try await fetchData()
            print("返回结果：\(result)")
        } catch {
            print("网络请求/解析出错：\(error.localizedDescription)")
        }
    }
}

