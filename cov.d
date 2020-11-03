int fun(bool b) {
  return b ? 1 : 0;
}

unittest {
  assert(fun(true) == 1);
  assert(fun(false) == 0);
}

int fun2(bool b) {
  return b
    ? 1
    : 0;
}

unittest {
  assert(fun2(true) == 1);
  assert(fun2(false) == 0);
}

bool complexCondition(int a, int b) {
  return a == 10 && b == 20 || a > 20 || b < 5 ? true : false;
}

unittest {
  assert(complexCondition(1,2));
}

bool complexCondition2(int a, int b) {
  return a == 10 
      && b == 20 
      || a > 20 
      || b < 5 
    ? true 
    : false;
}

unittest {
  assert( complexCondition2(1,2));
  assert( complexCondition2(10,20));
  assert(!complexCondition2(1,50));
}
