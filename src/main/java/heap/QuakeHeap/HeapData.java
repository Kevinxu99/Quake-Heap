package heap.QuakeHeap;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class HeapData {
    private List<List<SimpleNode>> treeList;
    private int maxDegree;
    private int heapMin;
    private int leavesCount;
}
