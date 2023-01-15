#include "straightline/slp.h"

#include <iostream>

namespace A {
int A::CompoundStm::MaxArgs() const {
  // TODO: put your code here (lab1).
  int s1 = stm1->MaxArgs();
  int s2 = stm2->MaxArgs();
  if (s1 > s2) {
    return s1;
  } else {
    return s2;
  }
}

Table *A::CompoundStm::Interp(Table *t) const {
  // TODO: put your code here (lab1).
  A::Table *env = stm1->Interp(t);
  env = stm2->Interp(env);
  return env;
}

int A::AssignStm::MaxArgs() const {
  // TODO: put your code here (lab1).
  return exp->MaxArgs();
}

Table *A::AssignStm::Interp(Table *t) const {
  // TODO: put your code here (lab1).
  int res = exp->Interp(t)->i;
  if (t)
    t = t->Update(id, res);
  else {
    t = new Table(id, res, nullptr);
  }
  return t;
}

int A::PrintStm::MaxArgs() const {
  // TODO: put your code here (lab1).
  if (exps->NumExps() > exps->MaxArgs()) {
    return exps->NumExps();
  } else {
    return exps->MaxArgs();
  }
}

Table *A::PrintStm::Interp(Table *t) const {
  // TODO: put your code here (lab1).
  Table *env = t;
  A::Exp *cur = exps->getCurExp();
  A::ExpList *next = exps->getNextExpList();
  while (true) {
    IntAndTable *tmp = cur->Interp(env);
    int res = tmp->i;
    Table *en = tmp->t;
    std::cout << res << " ";
    env = en;
    if (!next)
      break;
    cur = next->getCurExp();
    next = next->getNextExpList();
  }
  std::cout << std::endl;
  return env;
}
Exp *A::PairExpList::getCurExp() const { return exp; }
ExpList *A::PairExpList::getNextExpList() const { return tail; }
Exp *A::LastExpList::getCurExp() const { return exp; }
ExpList *A::LastExpList::getNextExpList() const { return nullptr; }

int A::IdExp::MaxArgs() const { return 0; }

IntAndTable *A::IdExp::Interp(Table *t) const {

  IntAndTable *res = new IntAndTable(t->Lookup(id), t);
  return res;
}

int A::NumExp::MaxArgs() const { return 0; }
IntAndTable *A::NumExp::Interp(Table *t) const {

  IntAndTable *res = new IntAndTable(num, t);
  return res;
}

int A::OpExp::MaxArgs() const {
  int s1 = left->MaxArgs();
  int s2 = right->MaxArgs();
  if (s1 > s2)
    return s1;
  else
    return s2;
}
IntAndTable *A::OpExp::Interp(Table *t) const {
  IntAndTable *tmp = (left->Interp(t));
  int s1 = tmp->i;
  Table *env = tmp->t;
  IntAndTable *tmp2 = right->Interp(env);
  int res = 0;
  switch (oper) {
  case PLUS:
    /* code */
    res = s1 + (tmp2->i);
    break;
  case MINUS:
    res = s1 - (tmp2->i);
    break;
  case DIV:
    res = s1 / (tmp2->i);
    break;
  case TIMES:
    res = s1 * (tmp2->i);
    break;

  default:
    break;
  }
  tmp2->i = res;
  return tmp2;
}

int A::EseqExp::MaxArgs() const {
  int s1 = stm->MaxArgs();
  int s2 = exp->MaxArgs();
  if (s1 > s2)
    return s1;
  else
    return s2;
}
IntAndTable *A::EseqExp::Interp(Table *t) const {
  Table *env = stm->Interp(t);
  IntAndTable *tmp = exp->Interp(env);
  IntAndTable *result = new IntAndTable(tmp->i, tmp->t);
  return result;
}

int A::PairExpList::MaxArgs() const {
  int s1 = exp->MaxArgs();
  int s2 = tail->MaxArgs();
  if (s1 > s2)
    return s1;
  else
    return s2;
}
IntAndTable *A::PairExpList::Interp(Table *t) const {
  IntAndTable *env = exp->Interp(t);
  IntAndTable *res = tail->Interp(env->t);
  return res;
}

int A::PairExpList::NumExps() const {
  if (tail)
    return tail->NumExps() + 1;
  else
    return 1;
}

int A::LastExpList::MaxArgs() const { return exp->MaxArgs(); }
IntAndTable *A::LastExpList::Interp(Table *t) const { return exp->Interp(t); }

int A::LastExpList::NumExps() const { return 1; }

int Table::Lookup(const std::string &key) const {
  if (id == key) {
    return value;
  } else if (tail != nullptr) {
    return tail->Lookup(key);
  } else {
    assert(false);
  }
}

Table *Table::Update(const std::string &key, int val) const {
  return new Table(key, val, this);
}

} // namespace A
