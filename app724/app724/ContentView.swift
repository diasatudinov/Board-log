//
//  ContentView.swift
//  app724
//
//  Created by Dias Atudinov on 17.07.2024.
//

import SwiftUI
import WebKit
//import FirebaseRemoteConfig

struct ContentView: View {
    @State private var lastVisitedURL: URL? = UserDefaults.standard.url(forKey: "lastVisitedURL") ?? URL(string: "https://google.com")

    var body: some View {
        WebView(lastVisitedURL: $lastVisitedURL)
            .onAppear {
                loadLastVisitedURL()
            }
    }

    private func loadLastVisitedURL() {
        if let savedURL = UserDefaults.standard.url(forKey: "lastVisitedURL") {
            lastVisitedURL = savedURL
        }
    }
}

#Preview {
    ContentView()
}


//struct WebView: UIViewRepresentable {
//    @Binding var lastVisitedURL: URL?
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.navigationDelegate = context.coordinator
//        loadCookies(into: webView)
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        if let url = lastVisitedURL {
//            let request = URLRequest(url: url)
//            uiView.load(request)
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    private func loadCookies(into webView: WKWebView) {
//        if let cookies = HTTPCookieStorage.shared.cookies {
//            for cookie in cookies {
//                webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
//            }
//        }
//    }
//
//    class Coordinator: NSObject, WKNavigationDelegate {
//        var parent: WebView
//
//        init(_ parent: WebView) {
//            self.parent = parent
//        }
//
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            HTTPCookieStorage.shared.cookies?.forEach { cookie in
//                webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
//            }
//            if let url = webView.url {
//                UserDefaults.standard.set(url, forKey: "lastVisitedURL")
//            }
//        }
//    }
//}



