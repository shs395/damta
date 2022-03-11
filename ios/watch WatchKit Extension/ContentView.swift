//
//  ContentView.swift
//  watch WatchKit Extension
//
//  Created by 신현석 on 2022/03/06.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WatchViewModel = WatchViewModel()
    
    @ViewBuilder
    var body: some View {
        if viewModel.isStopSmoking {
            VStack {
                Text("금연 \(viewModel.stopSmokingDays) 일")
                    .padding()
                Button(action: {
                    viewModel.sendDataMessage(for: .requestUpdateToFlutter, data: ["counter": viewModel.todaySmokingCount])
                }) {
                    Text("정보 새로고침")
                }
            }
        } else {
            VStack {
                Text("오늘 \(viewModel.todaySmokingCount) 개")
                    .padding()
                Button(action: {
                    viewModel.sendDataMessage(for: .addSmokingRecordToFlutter, data: ["counter": viewModel.todaySmokingCount])
                }) {
                    Text("지금 흡연")
                }
                Button(action: {
                    viewModel.sendDataMessage(for: .requestUpdateToFlutter, data: ["counter": viewModel.todaySmokingCount])
                }) {
                    Text("정보 새로고침")
                }
            }
        }
    }
    // var body: some View {
    //     VStack {
    //         Text("Counter: \(viewModel.counter)")
    //             .padding()
    //         Text("지금 흡연 : \(viewModel.counter2)")
    //             .padding()
    //         Button(action: {
    //             viewModel.sendDataMessage(for: .sendCounterToFlutter, data: ["counter": viewModel.counter + 1])
    //         }) {
    //             Text("+ 1")
    //         }
    //     }
    // }
}

