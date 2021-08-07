# Overview

Kth Largest in N elements.

## Presentation Doc

https://docs.google.com/presentation/d/19b7mZahFo7jGbhUH2ENsBqpzf_D8uN6Ml50ZmjAtPVw/edit#slide=id.gc6f73a04f_0_0

## Detail

- Use Priority Queue by Heap.
- Keep K numbers of data in MinHeap
  - Note that heap is not MaxHeap, but MinHeap!
  - Because of reducing space complexity.
- Point of Logic
  - During loop:
    - Ignore number if it is less than min num in heap.
    - Otherwise, replace number into min num in heap and then heapify-down.

## Order

- Time Complexity: O(N \* logK)
  - N: loop to insert number into heap.
  - logK: heapifyDown after inserting number into heap.
- Space Complexity: O(K)
  - It's not N, but K

## LICENSE

MIT
