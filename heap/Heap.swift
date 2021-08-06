//
//  Heap.swift
//  heap
//
//  Created by shunnamiki on 2021/08/06.
//

import Foundation

class Solution {
    static func findKthLargest(_ nums: [Int], _ k: Int) -> Int? {
        let heap = Heap();
      
        // Insert array
        for val in nums {
           heap.add(val)
        }
        
        // Get kth num
        for _ in 1...k {
          _ = heap.extract()
        }
        return heap.extract()
    }
}

class Heap {
    var values = [Int]();
    
    public func  add(_ val: Int){
    //    values.append
        values.append(val)
        self.heapifyUp()
    }

    public func extract() -> Int? {
        let top = values[0]
        if let popped = self.values.popLast() {
            values[0] = popped
            self.heapifyDown()
        }
        return top
    }
    
    private func heapifyUp(){}
    private func heapifyDown(){}
    
}

