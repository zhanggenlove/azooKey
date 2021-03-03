//
//  TimeMesureTools.swift
//  Keyboard
//
//  Created by β α on 2020/12/14.
//  Copyright © 2020 DevEn3. All rights reserved.
//

import Foundation

final class TimeMesureTools{
    private static var start: Date?

    static func startTimeMesure(){
        #if DEBUG
        Self.start = Date()
        #endif
    }

    static func endTimeMesure(_ message: String = ""){
        #if DEBUG
        debug(message, -(Self.start?.timeIntervalSinceNow ?? .nan))
        Self.start = nil
        #endif
    }

    static func endAndStart(_ message: String = ""){
        #if DEBUG
        Self.endTimeMesure(message)
        Self.startTimeMesure()
        #endif
    }
}

protocol BenchmarkTarget{
    associatedtype ProcessType: Hashable, CustomDebugStringConvertible
}

struct Kana2KanjiTarget: BenchmarkTarget{
    enum ProcessType: String, CustomDebugStringConvertible{
        case 変換全体
        case 結果の処理全体
        case 結果の処理_文節化
        case 結果の処理_文全体変換
        case 結果の処理_予測変換_全体
        case 結果の処理_予測変換_日本語
        case 結果の処理_予測変換_外国語
        case 結果の処理_予測変換_ゼロヒント
        case 結果の処理_付加候補
        case 結果の処理_並び替え
        case 辞書読み込み
        case 変換処理
        case 変換処理_N_Best計算
        case 変換処理_連接コスト計算_全体
        case 変換処理_連接コスト計算_CCValue
        case 変換処理_連接コスト計算_Memory


        var debugDescription: String {
            return self.rawValue
        }
    }
}

final class BenchmarkTool<Target: BenchmarkTarget>{
    var benchmarks: [Target.ProcessType: Double] = [:]
    private var timers: [Target.ProcessType: Date] = [:]

    func start(process: Target.ProcessType){
        #if DEBUG
        self.timers[process] = Date()
        #endif
    }

    func end(process: Target.ProcessType){
        #if DEBUG
        guard let time = timers[process] else{
            return
        }
        let benchmark = -time.timeIntervalSinceNow
        benchmarks[process, default: .zero] += benchmark
        #endif
    }

    func reset(){
        self.benchmarks = [:]
        self.timers = [:]
    }

    func result(){
        #if DEBUG
        let pairs = self.benchmarks.map{(key: $0.key, value: $0.value)}
        debug("=== Benchmark Result ===")
        debug(pairs.sorted{$0.value > $1.value}.map{"\($0.key.debugDescription): \($0.value)"}.joined(separator: "\n"))
        debug("=== === ===  === === ===")
        #endif
    }
}

var conversionTool = BenchmarkTool<Kana2KanjiTarget>()
