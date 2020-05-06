package heap.QuakeHeap;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SimpleNode {
    private int data;
    private int id;
    private int leftId;
    private int rightId;
    private int parentId;
    private int degree;
}
