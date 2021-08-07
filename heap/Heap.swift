//
//  Heap.swift
//  heap
//
//  Created by shunnamiki on 2021/08/06.
//

import Foundation

class Solution {
    static func findKthLargest(_ nums: [Int], _ k: Int) -> Int? {
        let heap = Heap.init(by: <);
      
        // Insert array
        for val in nums {
           heap.add(val)
        }

        // Get kth num
        for _ in 1..<k {
          _ = heap.extract()
        }
        return heap.extract()
    }
}

class Heap {
    var values = [0];
    
//    let comperator = {(_ n1: Int, _ n2: Int) -> Bool in n1 < n2} // smallest
    var comperator: (Int, Int) -> Bool;
    
    init(by: @escaping (_ n1: Int, _ n2: Int) -> Bool){
        self.comperator = by;
    }
    
    public func add(_ val: Int){
        values.append(val)
        self.heapifyUp()
    }

    public func extract() -> Int? {
        guard self.hasValues() else { return nil }
        if self.hasOnlyOne() { return values.popLast() }
        let first = self.popFirstAndReplaceWithLast()
        self.heapifyDown()
        return first
    }
    
    private func heapifyUp(){
        var idx = values.count - 1 // start from idx of last item
        while(
            self.hasParent(idx) &&
            self.comperator(self.values[idx], self.getParent(idx)!)
        ){
            let parentIdx = self.getParentIdx(idx)
            self.values.swapAt(idx, parentIdx)
            idx = parentIdx
        }
    }
    
    private func heapifyDown(){
        var idx = 1; // top idx
        while(self.hasLeftChild(idx)){
            let shouldChooseRight = self.hasRightChild(idx)
                && self.comperator(
                    self.getRightChild(idx)!,
                    self.getLeftChild(idx)!
                )
            
            let childIdx = shouldChooseRight ? self.getRightChildIdx(idx) : self.getLeftChildIdx(idx)
            self.values.swapAt(idx, childIdx)
            idx = childIdx
            continue;
        }
    }

    //
    private func hasValues () -> Bool { return values.count > 1 }
    private func hasOnlyOne () -> Bool { return values.count == 2 }
    
    // move
    private func popFirstAndReplaceWithLast() -> Int {
        let first = self.values[1]
        let last = self.values.popLast()!
        self.values[1] = last
        return first
    }
    
    // has
    private func hasParent(_ idx: Int) -> Bool { return idx != 1 }
    private func hasLeftChild (_ idx: Int) -> Bool { return self.getLeftChildIdx(idx) < self.values.count }
    private func hasRightChild(_ idx: Int) -> Bool { return self.getRightChildIdx(idx) < self.values.count }
    
    // idx getter
    private func getParentIdx(_ idx: Int) -> Int { return idx / 2 }
    private func getLeftChildIdx (_ idx: Int) -> Int { return 2 * idx }
    private func getRightChildIdx(_ idx: Int) -> Int { return (2 * idx) + 1 }
    
    // val getter
    private func getParent(_ idx: Int) -> Int? {
        guard self.hasParent(idx) else { return nil }
        return self.values[self.getParentIdx(idx)]
    }
    private func getLeftChild(_ idx: Int) -> Int? {
        guard self.hasLeftChild(idx) else { return nil }
        return self.values[self.getLeftChildIdx(idx)]
    }
    private func getRightChild(_ idx: Int) -> Int? {
        guard self.hasRightChild(idx) else { return nil }
        return self.values[self.getRightChildIdx(idx)]
    }
}

