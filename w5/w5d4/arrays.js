Array.prototype.myUniq = function() {
  var uniqs = [];
  
  for(var i = 0; i < this.length; i++) {
    if (uniqs.indexOf(this[i]) == -1) {
      uniqs.push(this[i]);
    }
  }
  
  return uniqs;
};

console.log([1, 1, 2, 3, 3, 1, 4].myUniq());

Array.prototype.twoSum = function() {
  var sums = [];
  
  for(var i = 0; i < this.length; i++) {
    for(var j = i + 1; j < this.length; j++) {
      if(this[i] + this[j] === 0) {
        sums.push([i, j]);
      }
    }
  }
  
  return sums;
};

console.log([0, 1, -2, 2, -1, 3, 5].twoSum());

Array.prototype.myTranspose = function() {
  var cols = [];
  
  for(var i = 0; i < this.length; i++) {
    var col = [];
    for(var row = 0; row < this.length; row++) {
      col = col.concat(this[row][i]);
    }
    cols.push(col);
  }
  
  return cols;
};

console.log([[1, 2, 3], [4, 5, 6], [7, 8, 9]].myTranspose());