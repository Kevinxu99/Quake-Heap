package heap.QuakeHeap;

public class QuakeNode implements Node{

		int degree, data, id;
		QuakeNode left, right, clone, highestClone, parent;
		boolean mark;
		
		
		
		public int getId() {
			return id;
		}

		public void setId(int id) {
			this.id = id;
		}

		public QuakeNode getParent() {
			return parent;
		}
		
		public void setParent(QuakeNode parent) {
			this.parent = parent;
		}
		
		public int getDegree() {
			return degree;
		}
		
		public void setDegree(int degree) {
			this.degree = degree;
		}
		
		public int getData() {
			return data;
		}
		
		public void setData(int data) {
			this.data = data;
		}
		
		public QuakeNode getLeft() {
			return left;
		}
		
		public void setLeft(QuakeNode left) {
			this.left = left;
		}
		
		public QuakeNode(int data) {
			super();
			this.data = data;
			this.degree = 1;
			this.highestClone = this;
			this.clone = this;
			this.mark = false;
		}
		
		public boolean isMark() {
			return mark;
		}
		
		public void setMark(boolean mark) {
			this.mark = mark;
		}
		
		public QuakeNode getRight() {
			return right;
		}
		
		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + data;
			return result;
		}
	
		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			QuakeNode other = (QuakeNode) obj;
			if (data != other.data)
				return false;
			return true;
		}
		
		public QuakeNode getHighestClone() {
			return highestClone;
		}
		
		public void setHighestClone(QuakeNode highestClone) {
			this.highestClone = highestClone;
		}
		
		public void setRight(QuakeNode right) {
			this.right = right;
		}
		
		public QuakeNode getClone() {
			return clone;
		}
		
		public void setClone(QuakeNode clone) {
			this.clone = clone;
		}
		
	
}
