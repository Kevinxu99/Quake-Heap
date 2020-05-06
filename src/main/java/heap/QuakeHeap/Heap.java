package heap.QuakeHeap;

public interface Heap {
	
	public Node insert(int n);
	public void insertNode(Node node);
	public int getMin();
	public Node extractMin();
	public boolean isEmpty();
	public void delete(Node node);
	public void decreaseKey(Node node, int val);
}
