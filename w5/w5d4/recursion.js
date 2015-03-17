var range = function(start, end){
  if(end < start){
    return [];
  }
  else {
    return range(start, end - 1).concat(end);
  }
};

console.log(range(1, 10));

var arraySum = function(array){
  if (array.length === 0) {
    return 0;
  }
  else {
    return array[0] + arraySum(array.slice(1));
  }
};

console.log(arraySum([1, 2, 3]));

var exponentiation1 = function (b, n) {
  if (n === 0){
    return 1;
  }
  else {
    return b * exponentiation1(b, n - 1);
  }
};

console.log(exponentiation1(2, 5));

var exponentiation2 = function (b, n) {
  if (n === 0){
    return 1;
  } else if (n % 2 === 0){
    return Math.pow(exponentiation2(b, n / 2), 2);
  } else {
    return b * Math.pow(exponentiation2(b, (n - 1) / 2), 2);
  }
};

console.log(exponentiation2(2, 5));

var fibonacci = function (n) {
  if (n === 1) {
    return [1];
  } else if (n === 2) {
    return [1, 1];
  } else {
    var previousFibs = fibonacci(n - 1);
    var len = previousFibs.length;
    var nextFib = previousFibs[len - 1] + previousFibs[len - 2];
    previousFibs.push(nextFib);
    
    return previousFibs;
  }
};

console.log(fibonacci(10));

var bsearch = function(array, target){
  var pivot = Math.floor(array.length / 2);
  if(array.length === 0) {
    return null;
  }
  if(array[pivot] === target) {
    return pivot;
  } else if (array[pivot] < target) {
    var nextSearch = bsearch(array.slice(pivot + 1), target);
    
    if (nextSearch === null){
      return null;
    } else {
      return pivot + 1 + nextSearch;
    }
  } else {
    return bsearch(array.slice(0, pivot), target);
  }
};

console.log(bsearch([1, 3, 4, 6, 8, 11, 13, 20], 3)); //1
console.log(bsearch([1, 3, 4, 6, 8, 11, 13, 20], 13)); //6
console.log(bsearch([1, 3, 4, 6, 8, 11, 13, 20], 5)); //null

var makeChange = function(amount, denominations){
  if(amount === 0 || denominations.length === 0){
    return [];
  }
  
  var combinations = [];
  
  for(var i = 0; i < denominations.length; i++){
    if(amount >= denominations[i]){
        var remainder = amount - denominations[i];
        var nextChange = makeChange(remainder, denominations);
        nextChange.push(denominations[i]);
        combinations.push(nextChange);
    }
    else{
      combinations.push(makeChange(amount, denominations.slice(1)));
    }
  }
  
  var bestChoice = combinations[0];
  for(var i = 1; i < combinations.length; i++){
    if(combinations[i].length < bestChoice.length){
      bestChoice = combinations[i];
    }
  }
  
  return bestChoice;
};

console.log(makeChange(14, [10, 7, 1]));

var mergeSort = function(array){
  if (array.length <= 1){
    return array;
  }
  else{
    var pivot = Math.floor(array.length / 2);
    var array1 = array.slice(pivot);
    var array2 = array.slice(0, pivot);
    return merge(mergeSort(array1), mergeSort(array2));
  }
};

var merge = function(array1, array2){
  var sortedArray = [];
  while(array1.length > 0 && array2.length > 0){
    if (array1[0] > array2[0]){
      sortedArray.push(array2.shift());
    }
    else{
      sortedArray.push(array1.shift());
    }
  }
  sortedArray = sortedArray.concat(array1).concat(array2);
  return sortedArray;
};

console.log(mergeSort([1, 3, 4, 6, 2, 3, 5, 5]));
console.log(mergeSort([10, 7, 8, 3, 6, 15, 4, 3, 2, 1]));

var subsets = function(array) {
  if(array.length === 0) {
    return [[]];
  }
  var previousSubs = subsets(array.slice(0, array.length - 1));
  var resultsArray = previousSubs.slice(0);
  for(var i = 0; i < previousSubs.length; i++){
    var previousSub = previousSubs[i].slice(0);
    //console.log(previousSub);
    previousSub.push(array[array.length - 1]);
    //console.log(previousSub);
    resultsArray.push(previousSub);
  }
  
  return resultsArray;
};

console.log(subsets([1, 2, 3, 4]));