Array.prototype.bubbleSort = function() {
  var sorted = false;
  while(!sorted){
    sorted = true;
    for(var i = 0; i < this.length; i++){
      if(this[i] > this[i + 1]){
        var temp = this[i + 1];
        this[i + 1] = this[i];
        this[i] = temp;
        sorted = false;
      }
    }
  }
  return this;
};

console.log([1, 3, 2, 5, 6, 2, 10, 9].bubbleSort());

String.prototype.substrings = function() {
  var results = [];
  for(var i = 0; i < this.length; i++) {
    for(var j = i + 1; j <= this.length; j++) {
      var sub = this.slice(i, j);
      if(results.indexOf(sub) === -1){
        results.push(sub);
      }
    }
  }
  return results;
};

console.log("hello".substrings());