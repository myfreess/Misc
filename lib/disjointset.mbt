struct DisjointSet[T] {
  roots:Array[Int]
  ranks:Array[Int] // 子树高度的上界
  elements:Array[T]
  // 不变量；parentOf.length() == elements.length()
}

pub fn from_array[T](arr:Array[T]) -> DisjointSet[T] {
  let n = arr.length()
  let rs = Array::make(n, -1)
  let ks = Array::make(n, 1)
  { roots : rs, ranks : ks, elements : arr }
}

fn rootOf[T](self:DisjointSet[T], x:Int) -> Int {
  if(self.roots[x] == -1){
    return x;
  } else {
    self.roots[x] = self.rootOf(self.roots[x])
    return self.roots[x];
  }
}

fn rankOf[T](self:DisjointSet[T], x:Int) -> Int {
  self.ranks[x]
}

pub fn merge[T](self:DisjointSet[T], i:Int, j:Int) {
  let x = self.rootOf(i)
  let y = self.rootOf(j)

  if(x == y){
    return;
  }

  if(self.rankOf(x) <= self.rankOf(y)){
    self.roots[x] = y
  } else {
    self.roots[y] = x
  }

  if(self.rankOf(x) == self.rankOf(y)){
    self.ranks[y] = self.ranks[y] + 1 // 启发式策略，上界相同的树合并有可能导致最大高度超过原上界
  }
}

pub fn op_get[T](self:DisjointSet[T], i: Int) -> (T, Int) {
  (self.elements[i], self.rootOf(i))
}