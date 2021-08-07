//
//  Heap.swift
//  heap
//
//  Created by shunnamiki on 2021/08/06.
//

import Foundation

class Solution {
    static func findKthLargest(_ nums: [Int], _ k: Int) -> Int? {
        let minHeap = Heap.init(by: <, size: k); // use < if largest, otherwise use >
      
        // Insert array
        for val in nums {
           minHeap.push(val)
        }

        return minHeap.peak()
    }
}

class Heap {
    let topIdx = 1;
    var values = [0]; // the 0 idx is not used because of getting easy when calculating
    var comperator: (Int, Int) -> Bool;
    var size: Int;
    
    init(by: @escaping (_ n1: Int, _ n2: Int) -> Bool, size: Int){
        self.comperator = by;
        self.size = size;
    }
        
    public func push(_ val: Int) {
        self.hasNumOfValuesLessThanSize() // Heap has space
            ? self.add(val)
            : self.replace(val)
    }
    
    private func add(_ val: Int){
        values.append(val)
        self.heapifyUp()
    }
    
    private func replace(_ val: Int) {
        let top = self.values[topIdx]
        if self.comperator(top, val) {
            self.values[topIdx] = val
            self.heapifyDown()
        }
    }
    
    public func peak() -> Int? {
        return values[topIdx]
    }

//    public func extract() -> Int? {
//        guard self.hasValues() else { return nil }
//        if self.hasOnlyOne() { return values.popLast() }
//        let first = self.popFirstAndReplaceWithLast()
//        self.heapifyDown()
//        return first
//    }
    
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
        var idx = topIdx;
        while(self.hasLeftChild(idx)){
            // pick right or left
            let childIdx: Int = {() in
                if !self.hasRightChild(idx) { return self.getLeftChildIdx(idx) }
                let shouldChooseRight = self.comperator(self.getRightChild(idx)!, self.getLeftChild(idx)!)
                return shouldChooseRight ? self.getRightChildIdx(idx) : self.getLeftChildIdx(idx)
            }()
            
            // compare parent and child
            if self.comperator(self.values[idx], self.values[childIdx]) { return }
            
            // swap and move idx
            self.values.swapAt(idx, childIdx)
            idx = childIdx
            continue;
        }
    }

    //
//    private func hasValues () -> Bool { return values.count > 1 }
//    private func hasOnlyOne () -> Bool { return values.count == 2 }
    private func hasNumOfValuesLessThanSize() -> Bool { return values.count - 1 < self.size }
    
    // move
//    private func popFirstAndReplaceWithLast() -> Int {
//        let first = self.values[topIdx]
//        let last = self.values.popLast()!
//        self.values[topIdx] = last
//        return first
//    }
    
    // has
    private func hasParent(_ idx: Int) -> Bool { return idx != topIdx }
    private func hasLeftChild (_ idx: Int) -> Bool { return self.getLeftChildIdx(idx) < self.values.count }
    private func hasRightChild(_ idx: Int) -> Bool { return self.getRightChildIdx(idx) < self.values.count }
    
    // idx getter
    private func getParentIdx(_ idx: Int) -> Int { return idx / 2 }
    private func getLeftChildIdx (_ idx: Int) -> Int { return 2 * idx }
    private func getRightChildIdx(_ idx: Int) -> Int { return (2 * idx) + 1 }
    
    // val getter
    private func getParent(_ idx: Int) -> Int? { return self.values[self.getParentIdx(idx)] }
    private func getLeftChild(_ idx: Int) -> Int? { return self.values[self.getLeftChildIdx(idx)] }
    private func getRightChild(_ idx: Int) -> Int? { return self.values[self.getRightChildIdx(idx)] }
}

