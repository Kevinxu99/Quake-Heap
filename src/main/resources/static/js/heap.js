$(document).ready(function() {
    var canvas = d3.select(".canvas");
    var svg = canvas.append('svg')
        .attr('height',800)
        .attr('width',800);

    function getTreeCoordinates(tree, node, x, dist, inc) {
        var coordinates = [];
        var nodeInfo = {
            id: node.id,
            cx: x,
            cy: node.cy,
            data: node.data
        }
        coordinates.push(nodeInfo);

        if(node.leftId == "-1" && node.rightId == "-1") {
            return coordinates;
        }

        var leftChild = tree.find(function(d){return d.id == node.leftId;});
        if(node.rightId != "-1") {
            var leftCoordinates = getTreeCoordinates(tree, leftChild, x-dist, dist-inc, inc);
            coordinates = coordinates.concat(leftCoordinates);
            var rightChild = tree.find(function(d){return d.id == node.rightId;});
            var rightCoordinates = getTreeCoordinates(tree, rightChild, x+dist, dist-inc, inc);
            coordinates = coordinates.concat(rightCoordinates);
        } else {
            var leftCoordinates = getTreeCoordinates(tree, leftChild, x, dist-inc, inc);
            coordinates = coordinates.concat(leftCoordinates);
        }

        return coordinates;
    }

    function getCoordinates(data) {
        var y0 = 100;
        var x0 = 50;
        var xDist = 30;
        var yDist = 50;
        var xInc = 20;
        var heapCoordinates = [];
        var trees = data.treeList;
        for(var i=0; i<trees.length; i++) {
            var maxD = 0;
            var maxIndex;
            for(var j=0; j<trees[i].length; j++) {
                if(trees[i][j].degree > maxD) {
                    maxD = trees[i][j].degree;
                    maxIndex = j;
                }
                trees[i][j].cy = y0 + yDist*(data.maxDegree-trees[i][j].degree);
            }
            var treeHeight = trees[i][maxIndex].degree-1;
            var x = x0 + xDist*treeHeight + xInc*treeHeight*(treeHeight-1);
            var treeCoordinates = getTreeCoordinates(trees[i], trees[i][maxIndex], x, xDist+xInc*(treeHeight-1), xInc);
            heapCoordinates = heapCoordinates.concat(treeCoordinates);
            var xMax = x0;
            for(var j=0; j<treeCoordinates.length; j++) {
                if(treeCoordinates[j].cx > xMax) {
                    xMax = treeCoordinates[j].cx;
                }
            }
            x0 = xMax + xDist*2;
        }
        return heapCoordinates;
    }

    function drawHeap(heapCoordinates) {

        groups = svg.selectAll('g')
                     .data(heapCoordinates,(d)=>"group"+d.id)

        groupEnter = groups.enter()
                            .append('g')
                            .attr('id',(d)=>"group"+d.id)

        groups.selectAll('circle')
               .data(heapCoordinates,(d)=>"circle"+d.id)
               .transition()
               .duration(750)
               .ease(d3.easeLinear)
               .attr('cx',(d)=>d.cx)
               .attr('cy',(d)=>d.cy)
               .attr('r',10)
               .attr('fill','#f7ed7e')
               .attr('stroke','black');

        groups.selectAll('text')
               .data(heapCoordinates,(d)=>"text"+d.id)
               .transition()
               .duration(750)
               .ease(d3.easeLinear)
               .attr('x',(d)=>d.cx)
               .attr('y',(d)=>d.cy)
               .text((d)=>d.data)
               .attr('text-anchor','middle')
               .attr('dy','.35em')

        groupEnter.append('circle')
                   .attr('id',(d)=>"circle"+d.id)
                   .transition()
                   .duration(750)
                   .delay(500)
                   .ease(d3.easeLinear)
                   .attr('cx', (d)=> d.cx)
                   .attr('cy', (d)=> d.cy)
                   .attr('r',10)
                   .attr('fill','#f7ed7e')
                   .attr('stroke','black');

        groupEnter.append('text')
                   .attr('id',(d)=>"text"+d.id)
                   .transition()
                   .duration(750)
                   .delay(500)
                   .ease(d3.easeLinear)
                   .attr('x',(d)=>d.cx)
                   .attr('y',(d)=>d.cy)
                   .text((d)=>d.data)
                   .attr('text-anchor','middle')
                   .attr('dy','.35em')

        groups.exit()
               .transition()
               .duration(500)
               .ease(d3.easeLinear)
               .remove();
    }

    $('#insert').submit(function(event) {
        event.preventDefault();
        insertNode();
    });

    $('#delete').submit(function(event) {
        event.preventDefault();
        deleteNode();
    });

    function insertNode() {
        var formData = {
            data : $("#nodeVal").val()
        };
        $.ajax({
            type : "POST",
            contentType : "application/json",
            url : "insert",
            data : JSON.stringify(formData),
            dataType : 'json',
            success: function(result) {
                if(result.status == "success") {
                    console.log('Insertion was successful.');

                    var heapCoordinates = getCoordinates(result.data);
                    console.log(heapCoordinates);

                    drawHeap(heapCoordinates);

                }
                else {
                    console.log("Insertion failed.")
                }
                console.log(result);
                $("#nodeVal").val('');
            },
            error: function(e) {
                console.log("ERROR: ",e);
                $("#nodeVal").val('');
                alert("ERROR!");
            }
        });
    }

    function deleteNode() {
        var formData = {
            data : $("#nodeValDel").val()
        };

        $.ajax({
            type : "POST",
            contentType : "application/json",
            url : "delete",
            data : JSON.stringify(formData),
            dataType : 'json',
            success: function(result) {
                if(result.status == "success") {
                    console.log('Deletion was successful.');

                    var heapCoordinates = getCoordinates(result.data);
                    console.log(heapCoordinates);

                    drawHeap(heapCoordinates);

                }
                else {
                    console.log("Deletion failed.")
                }
                console.log(result);
                $("#nodeValDel").val('');
            },
            error: function(e) {
                console.log("ERROR: ",e);
                $("#nodeValDel").val('');
                alert("ERROR!");
            }
        });
    }
});