var Cat = function(catName, owner){
  this.catName = catName;
  this.owner = owner;
};

Cat.prototype.cuteStatement = function(){
  return this.owner + " loves " + this.catName;
};

var earl = new Cat("Earl", "Ned");
console.log(earl.cuteStatement());

Cat.prototype.cuteStatement = function(){
  return "Everyone loves " + this.catName;
};

var markov = new Cat("Markov", "Ned");
console.log(markov.cuteStatement());

Cat.prototype.meow = function(){
  return "meow";
};


markov.meow = function() {
  return "MEOW";
};

console.log(earl.meow());
console.log(markov.meow());