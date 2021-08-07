//
//  main.swift
//  heap
//
//  Created by shunnamiki on 2021/08/06.
//

import Foundation

let testCaseList = [
    [9,8,7,6,5,4,3,2,1],
    [1,2,3,4,5,6,7,8,9],
    [0,3,5,7,1,4,5,6],
    [2,2,3,3,4,5,2,2,3],
    [-1,-2,3,4,-100,100],
    [-1,-2,-3,-4,-5,-6,-7,-8]
]

let pickedNum = 3

func doTest(){
    for testCase in testCaseList {
        let expected = testCase.sorted(by: >)[pickedNum - 1]
        let result = Solution.findKthLargest(testCase, pickedNum)!
        let resultStr = expected == result ? "  OK" : "x NG"
        print(resultStr, "|",
              "expeted:", expected,
              "result:", result,
              "testCase:",testCase
              
        );
    }

}

doTest()

//if let r = Solution.findKthLargest(testCaseList[1], 3) {
//    print("R", r)
//}
