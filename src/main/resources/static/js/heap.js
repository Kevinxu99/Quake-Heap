$(document).ready(function() {
    var canvas = d3.select(".canvas");
    var svg = canvas.append('svg')
        .attr('height', 800)
        .attr('width', 1000);
    var radius = 15;

    function getTreeCoordinates(coordinates, tree, node, x, dist, inc) {

        var nodeInfo = {
            id: node.id,
            cx: x,
            cy: node.cy,
            data: node.data
        }
        coordinates.heapCoordinates.push(nodeInfo);

        if(node.leftId == "-1" && node.rightId == "-1") {
            return coordinates;
        }

        var leftChild = tree.find(function(d){return d.id == node.leftId;});

        var lineDist = Math.sqrt(dist**2+(node.cy-leftChild.cy)**2);
        var lineLeft = {
            id1 : node.id,
            id2 : leftChild.id,
            x1 : x-dist*(radius/lineDist),
            y1 : node.cy-(node.cy-leftChild.cy)*(radius/lineDist),
            x2 : x-dist+dist*(radius/lineDist),
            y2 : leftChild.cy+(node.cy-leftChild.cy)*(radius/lineDist)
        }

        if(node.rightId != "-1") {

            coordinates.lineCoordinates.push(lineLeft);
            coordinates = getTreeCoordinates(coordinates, tree, leftChild, x-dist, dist-inc, inc);

            var rightChild = tree.find(function(d){return d.id == node.rightId;});
            coordinates = getTreeCoordinates(coordinates, tree, rightChild, x+dist, dist-inc, inc);

            var lineRight = {
                id1 : node.id,
                id2 : rightChild.id,
                x1 : x+dist*(radius/lineDist),
                y1 : node.cy-(node.cy-leftChild.cy)*(radius/lineDist),
                x2 : x+dist-dist*(radius/lineDist),
                y2 : rightChild.cy+(node.cy-leftChild.cy)*(radius/lineDist)
            }
            coordinates.lineCoordinates.push(lineRight);

        } else {

            lineLeft.x1 = x;
            lineLeft.x2 = x;
            lineLeft.y1 = node.cy+radius;
            lineLeft.y2 = leftChild.cy-radius;
            coordinates.lineCoordinates.push(lineLeft);
            coordinates = getTreeCoordinates(coordinates, tree, leftChild, x, dist-inc, inc);

        }

        return coordinates;
    }

    function getCoordinates(data) {

        var y0 = 100;
        var x0 = 100;
        var xDist = 30;
        var yDist = 50;
        var xInc = 20;
        var coordinates = {
            heapCoordinates : [],
            lineCoordinates : []
        };
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
            coordinates = getTreeCoordinates(coordinates, trees[i], trees[i][maxIndex], x, xDist+xInc*(treeHeight-1), xInc);
            console.log(coordinates);
            var xMax = x0;
            for(var j=0; j<coordinates.heapCoordinates.length; j++) {
                if(coordinates.heapCoordinates[j].cx > xMax) {
                    xMax = coordinates.heapCoordinates[j].cx;
                }
            }
            x0 = xMax + xDist*2;
        }
        return coordinates;
    }

    function drawHeap(heapCoordinates) {

        groups = svg.selectAll('g')
                     .data(heapCoordinates,(d)=>"group"+d.id);
        groupEnter = groups.enter()
                            .append('g')
                            .attr('id',(d)=>"group"+d.id);

        groups.selectAll('circle')
               .data(heapCoordinates,(d)=>"circle"+d.id)
               .transition()
               .duration(750)
               .ease(d3.easeLinear)
               .attr('cx',(d)=>d.cx)
               .attr('cy',(d)=>d.cy)
               .attr('r',radius)
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
               .attr('dy','.35em');


        groupEnter.append('circle')
                   .attr('id',(d)=>"circle"+d.id)
                   .transition()
                   .duration(750)
                   .delay(500)
                   .ease(d3.easeLinear)
                   .attr('cx', (d)=> d.cx)
                   .attr('cy', (d)=> d.cy)
                   .attr('r',radius)
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
                   .attr('dy','.35em');

        groups.exit()
               .attr("fill-opacity", 1)
               .attr("stroke-opacity", 1)
               .transition()
               .duration(500)
               .attr("fill-opacity", 0)
               .attr("stroke-opacity", 0)
               .remove();

    }

    function drawLines(lineCoordinates) {

        lines = svg.selectAll('line')
                    .data(lineCoordinates,(d)=>d.id1+"to"+d.id2)
                    .attr('x1',(d)=>d.x1)
                    .attr('x2',(d)=>d.x2)
                    .attr('y1',(d)=>d.y1)
                    .attr('y2',(d)=>d.y2)
                    .attr('stroke','black')

        lines.transition()
              .duration(750)
              .delay(750)
              .ease(d3.easeLinear);

        lines.enter()
              .append('line')
              .attr('id',(d)=>d.id1+"to"+d.id2)
              .transition()
              .duration(750)
              .delay(500)
              .ease(d3.easeLinear)
              .attr('x1',(d)=>d.x1)
              .attr('x2',(d)=>d.x2)
              .attr('y1',(d)=>d.y1)
              .attr('y2',(d)=>d.y2)
              .attr('stroke','black');

        lines.exit()
              .attr("stroke-opacity", 1)
              .transition()
              .duration(500)
              .attr("stroke-opacity", 0)
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
                    console.log(result.message);
                    var coordinates = getCoordinates(result.data);
                    drawHeap(coordinates.heapCoordinates);
                    drawLines(coordinates.lineCoordinates);
                }
                else {
                    alert(result.message);
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
                    console.log(result.message);
                    var coordinates = getCoordinates(result.data);
                    drawHeap(coordinates.heapCoordinates);
                    drawLines(coordinates.lineCoordinates);
                }
                else {
                    alert(result.message);
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

    $("#decrease").submit(function(event) {
        event.preventDefault();
        $('#decModal').modal('hide');
        console.log($("#nodeDec").val())
        var formData = {
            data : $("#nodeDec").val(),
            id: $("#valDec").val()
        }
        $.ajax({
            type : "POST",
            contentType : "application/json",
            url : "decrease",
            data : JSON.stringify(formData),
            dataType : 'json',
            success: function(result) {
                if(result.status == "success") {
                    console.log(result.message);
                    var coordinates = getCoordinates(result.data);
                    drawHeap(coordinates.heapCoordinates);
                    drawLines(coordinates.lineCoordinates);
                }
                else {
                    alert(result.message);
                }
                console.log(result);
                $("#nodeDec").val('');
                $("#valDec").val('');
            },
            error: function(e) {
                console.log("ERROR: ",e);
                alert("ERROR!");
                $("#nodeDec").val('');
                $("#valDec").val('');
            }
        });
    });

    $("#confirm").click(function() {
        $("#decrease").submit();
    });

    $('#extract').click(function() {
        $.ajax({
            type : "POST",
            contentType : "application/json",
            url : "extract",
            success: function(result) {
                if(result.status == "success") {
                    console.log(result.message);
                    var coordinates = getCoordinates(result.data);
                    drawHeap(coordinates.heapCoordinates);
                    drawLines(coordinates.lineCoordinates);
                }
                else {
                    alert(result.message);
                }
                console.log(result);
            },
            error: function(e) {
                console.log("ERROR: ",e);
                alert("ERROR!");
            }
        });
    });

});