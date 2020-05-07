package heap.QuakeHeap;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.*;

@Controller
public class Demo {

    QuakeHeap quakeHeap = new QuakeHeap();

    public List<SimpleNode> transformTree(QuakeNode q) {

        List<SimpleNode> nodeList = new ArrayList<SimpleNode>();
        int parentId = (q.getParent() != null)? q.getParent().getId() : -1;
        int leftId = (q.getLeft() != null)? q.getLeft().getId() : -1;
        int rightId = (q.getRight() != null)? q.getRight().getId() : -1;

        nodeList.add(new SimpleNode(q.getData(), q.getId(), leftId, rightId, parentId, q.getDegree()));

        if(q.getLeft() == null && q.getRight() == null) {
            return nodeList;
        }

        nodeList.addAll(transformTree(q.getLeft()));

        if(q.getRight() != null) {
            nodeList.addAll(transformTree(q.getRight()));
        }

        return nodeList;
    }

    public List<List<SimpleNode>> transformHeap() {
        List<List<SimpleNode>> treeList = new ArrayList<List<SimpleNode>>();
        for (QuakeNode q : quakeHeap.heap) {
            treeList.add(transformTree(q));
        }
        return treeList;
    }

    public QuakeNode findNodeInTree(QuakeNode q, int val) {
        if(q.getData() == val) {return q;}
        if(q.getLeft() == null && q.getRight() == null) {return null;}
        QuakeNode qLeft = findNodeInTree(q.getLeft(), val);
        if(qLeft != null) return qLeft;
        if(q.getRight() != null) {
            QuakeNode qRight = findNodeInTree(q.getRight(), val);
            if(qRight != null) return qRight;
        }
        return null;
    }

    public QuakeNode findNode(int val) {
        for(QuakeNode i : quakeHeap.heap) {
            QuakeNode q = findNodeInTree(i, val);
            if(q != null) return q;
        }
        return null;
    }

    @GetMapping("/")
    public String start() {
        return "index";
    }

    @GetMapping("/demo")
    public String demo() {
        return "demo";
    }

    @PostMapping("/insert")
    public ResponseEntity<Object> insert(@RequestBody SimpleNode node) {
        quakeHeap.insert(node.getData());
        List<List<SimpleNode>> treeList = transformHeap();
        HeapData data = new HeapData(treeList, quakeHeap.getMaxDegree(), quakeHeap.getMin(), quakeHeap.getLeavesCount());
        ServiceResponse<HeapData> response = new ServiceResponse<HeapData>("success",data,"Insertion Successful");
        return new ResponseEntity<Object>(response, HttpStatus.OK);
    }

    @PostMapping("/delete")
    public ResponseEntity<Object> delete(@RequestBody SimpleNode node) {
        QuakeNode q = findNode(node.getData());
        ServiceResponse<HeapData> response;
        if(q != null) {
            quakeHeap.delete(q);
            List<List<SimpleNode>> treeList = transformHeap();
            HeapData data = new HeapData(treeList, quakeHeap.getMaxDegree(), quakeHeap.getMin(), quakeHeap.getLeavesCount());
            response = new ServiceResponse<HeapData>("success",data,"Deletion Successful");
        } else {
            response = new ServiceResponse<HeapData>("failed",new HeapData(),"Node Not Found");
        }
        return new ResponseEntity<Object>(response, HttpStatus.OK);
    }

    @PostMapping("/decrease")
    public ResponseEntity<Object> decrease(@RequestBody SimpleNode node) {
        ServiceResponse<HeapData> response;
        if(node.getId() >= node.getData()) {
            response = new ServiceResponse<HeapData>("failed",new HeapData(),"Decreased Value Invalid");
            return new ResponseEntity<Object>(response, HttpStatus.OK);
        }
        QuakeNode q = findNode(node.getData());
        if(q != null) {
            quakeHeap.decreaseKey(q, node.getId());
            List<List<SimpleNode>> treeList = transformHeap();
            HeapData data = new HeapData(treeList, quakeHeap.getMaxDegree(), quakeHeap.getMin(), quakeHeap.getLeavesCount());
            response = new ServiceResponse<HeapData>("success",data,"Key Decreased");
        } else {
            response = new ServiceResponse<HeapData>("failed",new HeapData(),"Node Not Found");
        }
        return new ResponseEntity<Object>(response, HttpStatus.OK);
    }

    @PostMapping("/extract")
    public ResponseEntity<Object> extract() {
        quakeHeap.extractMin();
        List<List<SimpleNode>> treeList = transformHeap();
        HeapData data = new HeapData(treeList, quakeHeap.getMaxDegree(), quakeHeap.getMin(), quakeHeap.getLeavesCount());
        ServiceResponse<HeapData> response = new ServiceResponse<HeapData>("success",data,"Min Extracted");
        return new ResponseEntity<Object>(response, HttpStatus.OK);
    }
}
