#include "tiger/escape/escape.h"
#include "tiger/absyn/absyn.h"

namespace esc {
void EscFinder::FindEscape() { absyn_tree_->Traverse(env_.get()); }
} // namespace esc

namespace absyn {

void AbsynTree::Traverse(esc::EscEnvPtr env) {
  /* TODO: Put your lab5 code here */
  root_->Traverse(env,1);

}

void SimpleVar::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  
esc::EscapeEntry * tmp=env->Look(this->sym_);
if (tmp->depth_<depth)
  *(tmp->escape_)=true;

  return;
}

void FieldVar::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */

  this->var_->Traverse(env,depth);
  
}

void SubscriptVar::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  this->var_->Traverse(env,depth);
}

void VarExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  this->var_->Traverse(env,depth);
}

void NilExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  return;
}

void IntExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  return;
}

void StringExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  return;
}

void CallExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  auto ptr=this->args_->GetList().begin();
  while (ptr!=this->args_->GetList().end())
  {
    (*ptr)->Traverse(env,depth);
    ptr++;
  }
  


}

void OpExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  this->left_->Traverse(env,depth);
  this->right_->Traverse(env,depth);

}

void RecordExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
 

   auto ptr=this->fields_->GetList().begin();
   while (ptr!=this->fields_->GetList().end())
  {
    (*ptr)->exp_->Traverse(env,depth);
    ptr++;
  }



}

void SeqExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
   auto ptr=this->seq_->GetList().begin();
  while (ptr!=this->seq_->GetList().end())
  {
    (*ptr)->Traverse(env,depth);
    ptr++;
  }

}

void AssignExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  this->var_->Traverse(env,depth);
  this->exp_->Traverse(env,depth);
}

void IfExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  if (test_)
  test_->Traverse(env,depth);
  if (then_)
  then_->Traverse(env,depth);
  if (elsee_)
  elsee_->Traverse(env,depth);



}

void WhileExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  test_->Traverse(env,depth);
  body_->Traverse(env,depth);

}

void ForExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  //循环变量不会escape?
  escape_=false;
  env->BeginScope();
  env->Enter(this->var_,new esc::EscapeEntry(depth,&escape_));
  lo_->Traverse(env,depth);
  hi_->Traverse(env,depth);
  body_->Traverse(env,depth);
  env->EndScope();

}

void BreakExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  return;
}

void LetExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  env->BeginScope();
  auto ptr=decs_->GetList().begin();
  while (ptr!=decs_->GetList().end())
  {
    (*ptr)->Traverse(env,depth);
    ptr++;
  }
  body_->Traverse(env,depth);
  env->EndScope();

}

void ArrayExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  size_->Traverse(env,depth);
  init_->Traverse(env,depth);

}

void VoidExp::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  return;
}

void FunctionDec::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  auto ptr=this->functions_->GetList().begin();
  while (ptr!=this->functions_->GetList().end())
  {
    env->BeginScope();
     auto itra = (*ptr)->params_->GetList().begin();
     while (itra!=(*ptr)->params_->GetList().end())
     {
       (*itra)->escape_=false;
       env->Enter((*itra)->name_,new esc::EscapeEntry(depth+1,&((*itra)->escape_)));
       itra++;
     }
     (*ptr)->body_->Traverse(env,depth+1);
      ptr++;
      env->EndScope();
  }
  
}

void VarDec::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  
  escape_=false;
  // if (typeid(*init_)==typeid(RecordExp)||typeid(*init_)==typeid(ArrayExp))
  // {
  //   escape_=true;
  // }
  init_->Traverse(env,depth);
  env->Enter(var_,new esc::EscapeEntry(depth,&escape_));



}

void TypeDec::Traverse(esc::EscEnvPtr env, int depth) {
  /* TODO: Put your lab5 code here */
  return;

}

} // namespace absyn
