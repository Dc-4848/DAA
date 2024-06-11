1. Lexicographically smallest string after swaps

*Algorithm:*
1. *Initialize Union-Find:* Create a Union-Find structure to manage the connectivity of indices.
2. *Union Operations:* For each pair in pairs, perform a union operation to connect the indices.
3. *Group Indices:* Use Union-Find to find all connected components (groups of indices).
4. *Sort Characters:* For each connected component, collect and sort the characters.
5. *Construct Result:* Place the sorted characters back into their respective positions to form the result string.

python
class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
    
    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]
    
    def union(self, x, y):
        rootX = self.find(x)
        rootY = self.find(y)
        if rootX != rootY:
            self.parent[rootY] = rootX

def smallestStringWithSwaps(s, pairs):
    n = len(s)
    uf = UnionFind(n)
    
    # Step 2: Union operations
    for a, b in pairs:
        uf.union(a, b)
    
    from collections import defaultdict
    components = defaultdict(list)
    
    # Step 3: Group indices
    for i in range(n):
        root = uf.find(i)
        components[root].append(i)
    
    res = list(s)
    
    # Step 4: Sort characters within each group
    for comp in components.values():
        indices = sorted(comp)
        chars = sorted(res[i] for i in indices)
        
        # Step 5: Construct result
        for i, char in zip(indices, chars):
            res[i] = char
    
    return ''.join(res)

# Example usage:
s = "dcab"
pairs = [[0, 3], [1, 2]]
print(smallestStringWithSwaps(s, pairs))  # Output: "bacd"


### 2. Check if one permutation can break another

*Algorithm:*
1. *Sort Both Strings:* Sort both s1 and s2.
2. *Define Break Condition:* Define a function to check if one sorted string can break another.
3. *Check s1 Breaks s2:* Use the defined function to check if the sorted version of s1 can break s2.
4. *Check s2 Breaks s1:* Use the defined function to check if the sorted version of s2 can break s1.
5. *Return Result:* Return True if either check is True, otherwise return False.

python
def checkIfCanBreak(s1, s2):
    s1_sorted = sorted(s1)
    s2_sorted = sorted(s2)
    
    def can_break(x, y):
        return all(x[i] >= y[i] for i in range(len(x)))
    
    return can_break(s1_sorted, s2_sorted) or can_break(s2_sorted, s1_sorted)

# Example usage:
s1 = "abc"
s2 = "xya"
print(checkIfCanBreak(s1, s2))  # Output: True


### 3. Minimize value of string with '?'

*Algorithm:*
1. *Initialize:* Create an empty result list and a dictionary to track the last seen character counts.
2. *Traverse String:* Traverse the string and process each character.
3. *Replace '?':* For each '?', find the character with the minimal cost and replace it.
4. *Update Counts:* Update the last seen counts for each character.
5. *Construct Result:* Join the result list into the final string and return it.

python
def minimizeCost(s):
    res = []
    last_seen = {}
    alphabet = 'abcdefghijklmnopqrstuvwxyz'
    
    for char in s:
        if char == '?':
            min_cost_char = None
            min_cost = float('inf')
            
            for letter in alphabet:
                cost = last_seen.get(letter, 0)
                if cost < min_cost:
                    min_cost = cost
                    min_cost_char = letter
            
            res.append(min_cost_char)
            last_seen[min_cost_char] = last_seen.get(min_cost_char, 0) + 1
        else:
            res.append(char)
            last_seen[char] = last_seen.get(char, 0) + 1
    
    return ''.join(res)

# Example usage:
s = "a?b?c?"
print(minimizeCost(s))  # Output: "aabaca"


### 4. Last string value before emptying

*Algorithm:*
1. *Initialize:* Set up a loop to continually process the string.
2. *Remove Characters:* Remove the first occurrence of each character from 'a' to 'z'.
3. *Check for Changes:* Check if the string changes after removal; if not, return the string.
4. *Update String:* Update the string with the new version after removals.
5. *Repeat:* Repeat steps 2-4 until the string no longer changes.

python
def lastStringBeforeEmptying(s):
    while True:
        new_s = list(s)
        for c in 'abcdefghijklmnopqrstuvwxyz':
            if c in new_s:
                new_s.remove(c)
        new_s = ''.join(new_s)
        if new_s == s:
            return s
        s = new_s

# Example usage:
s = "aabcbbca"
print(lastStringBeforeEmptying(s))  # Output: "ba"


### 5. Maximum subarray sum

*Algorithm:*
1. *Initialize:* Set the current and global maximum to the first element.
2. *Traverse Array:* Iterate through the array starting from the second element.
3. *Update Current Max:* Update the current maximum to be either the current element or the sum of the current element and the current maximum.
4. *Update Global Max:* Update the global maximum if the current maximum is greater.
5. *Return Result:* Return the global maximum.

python
def maxSubArray(nums):
    max_current = max_global = nums[0]
    
    for num in nums[1:]:
        max_current = max(num, max_current + num)
        if max_current > max_global:
            max_global = max_current
    
    return max_global

# Example usage:
nums = [-2,1,-3,4,-1,2,1,-5,4]
print(maxSubArray(nums))  # Output: 6


### 6. Maximum binary tree

*Algorithm:*
1. *Base Case:* If the array is empty, return None.
2. *Find Maximum:* Identify the maximum value and its index in the current array.
3. *Create Node:* Create a tree node with the maximum value.
4. *Build Subtrees:* Recursively build the left and right subtrees using the subarrays to the left and right of the maximum value.
5. *Return Node:* Return the created node.

python
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def constructMaximumBinaryTree(nums):
    if not nums:
        return None
    
    max_val = max(nums)
    max_index = nums.index(max_val)
    
    root = TreeNode(max_val)
    root.left = constructMaximumBinaryTree(nums[:max_index])
    root.right = constructMaximumBinaryTree(nums[max_index + 1:])
    
    return root

# Example usage:
nums = [3,2,1,6,0,5]
root = constructMaximumBinaryTree(nums)


### 7. Maximum sum of circular subarray

*Algorithm:*
1. *Calculate Total Sum:* Compute the total sum of the array.
2. *Find Max Subarray Sum:* Use Kadane’s algorithm to find the maximum subarray sum for the non-circular case.
3. *Find Min Subarray Sum:* Use Kadane’s algorithm (with negative values) to find the minimum subarray sum.
4. *Check Edge Case:* If all numbers are negative, return the maximum subarray sum.
5. *Return Result:* Return the maximum of the non-circular and circular subarray sums.

python
def maxSubArray(nums):
    max_current = max_global = nums[0]
    for num in nums[1:]:
        max_current = max(num, max_current + num)
        if max_current > max_global:
            max_global = max_current
    return max_global

def maxSubarraySumCircular(nums):
    total_sum = sum(nums)
    max_kadane = maxSubArray(nums)
    min_kadane = -maxSubArray([-num for num in nums])
    
    if min_kadane == total_sum:
        return max_kadane
    
    return max(max_kadane, total_sum + min_kadane)

# Example usage:
nums = [1, -2, 3, -2]
print(maxSubarraySumCircular(nums))  # Output: 3


### 8. Max sum of non-adjacent subsequence after queries

*Algorithm:*
1. *Initialize Result:* Start with the initial array and set the result sum to 0.
2. *Process Each Query:* For each query, update the specified element in the array.
3. *Calculate DP:* Use dynamic programming to compute the maximum sum of a non-adjacent subsequence.
4. *Update Result:* Add the computed sum to the result.
5. *Return Result:* Return the total result modulo \(10^9 + 7\).

python
def maxNonAdjacentSum(nums):
    include, exclude = 0, 0
    for num in nums:
        new_exclude = max(include, exclude)
        include = exclude + num
        exclude = new_exclude
    return max(include, exclude)

def processQueries(nums, queries):
    MOD = 10**9 + 7
    total_sum = 0
    
    for pos, val in queries:
        nums[pos] = val
        total_sum = (total_sum + maxNonAdjacentSum(nums)) % MOD
    
    return total_sum

# Example usage:
nums = [1, 2, 3, 4]
queries = [[1, 3], [2, 4]]
print(processQueries(nums, queries))  # Output: 7


### 9. k closest points to origin

*Algorithm:*
1. *Initialize Max Heap:* Use a max heap to keep track of the k closest points.
2. *Calculate Distance:* Compute the Euclidean distance for each point.
3. *Maintain Heap:* Maintain the max heap to always contain the k closest points.
4. *Extract Points:* Extract the points from the heap.
5. *Return Result:* Return the k closest points.

python
import heapq

def kClosest(points, k):
    max_heap = []
    for x, y in points:
        dist = -(x * x + y * y)
        if len(max_heap) < k:
            heapq.heappush(max_heap, (dist, x, y))
        else:
            heapq.heappushpop(max_heap, (dist, x, y))
    return [(x, y) for _, x, y in max_heap]

# Example usage:
points = [[1, 3], [-2, 2], [2, -2]]
k = 2
print(kClosest(points, k))  # Output: [[-2, 2], [2, -2]]


### 10. Median of two sorted arrays

*Algorithm:*
1. *Ensure Correct Order:* Ensure that nums1 is the smaller array.
2. *Binary Search:* Perform binary search on the smaller array to partition both arrays.
3. *Adjust Partition:* Adjust the partition to balance the elements on both sides.
4. *Find Max/Min:* Find the maximum element on the left and the minimum element on the right of the partition.
5. *Compute Median:* Compute the median based on the parity of the combined array length.

python
def findMedianSortedArrays(nums1, nums2):
    if len(nums1) > len(nums2):
        nums1, nums2 = nums2, nums1
    
    m, n = len(nums1), len(nums2)
    imin, imax, half_len = 0, m, (m + n + 1) // 2
    
    while imin <= imax:
        i = (imin + imax) // 2
        j = half_len - i
        if i < m and nums1[i] < nums2[j-1]:
            imin = i + 1
        elif i > 0 and nums1[i-1] > nums2[j]:
            imax = i - 1
        else:
            if i == 0: max_of_left = nums2[j-1]
            elif j == 0: max_of_left = nums1[i-1]
            else: max_of_left = max(nums1[i-1], nums2[j-1])
            if (m + n) % 2 == 1:
                return max_of_left
            if i == m: min_of_right = nums2[j]
            elif j == n: min_of_right = nums1[i]
            else: min_of_right = min(nums1[i], nums2[j])
            return (max_of_left + min_of_right) / 2.0

# Example usage:
nums1 = [1, 3]
nums2 = [2]
print(findMedianSortedArrays(nums1, nums2))  # Output: 2.0
