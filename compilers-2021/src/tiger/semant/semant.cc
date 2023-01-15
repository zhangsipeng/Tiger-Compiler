#include "tiger/absyn/absyn.h"
#include "tiger/semant/semant.h"

namespace {
static type::TyList *make_formal_tylist(env::TEnvPtr tenv, absyn::FieldList *params,err::ErrorMsg *errormsg) {
  type::TyList * res=new type::TyList();
  if (params == nullptr) {
    return nullptr;
  }
  auto itr=params->GetList().begin();
  for (itr;itr!=params->GetList().end();itr++)
  {
    type::Ty *ty = tenv->Look((*itr)->typ_);
  if (ty == nullptr) {
    errormsg->Error((*itr)->pos_, "undefined type %s",
                   (*itr)->typ_->Name().c_str());
  }
  res->Append(ty);
  }

  return res;
}
}
namespace absyn {

void AbsynTree::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                           err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  if (root_) root_->SemAnalyze(venv, tenv,0,errormsg);
}

type::Ty *SimpleVar::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                                int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
    env::EnvEntry *x = venv->Look(this->sym_);
    if (x&&typeid(*x)==typeid(env::VarEntry))
    {
      return ((env::VarEntry *)x)->ty_->ActualTy();
    }
    else
    {
      errormsg->Error(pos_, "undefined variable %s", sym_->Name().c_str());
    return type::IntTy::Instance();
    }
 
}

type::Ty *FieldVar::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                               int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
    type::Ty *ty = var_->SemAnalyze(venv, tenv, labelcount,errormsg);
  // ty = ty->ActualTy();

  if(typeid(*ty)!=typeid(type::RecordTy)){
    errormsg->Error(pos_, "not a record type");
    return type::IntTy::Instance();
  }

  type::FieldList *fields = ((type::RecordTy *)ty)->fields_;
 auto itr=fields->GetList().begin();
 for (itr;itr!=fields->GetList().end();itr++)
 {
   if ((*itr)->name_==sym_)
   return (*itr)->ty_;
 }

  errormsg->Error(pos_, "field %s doesn't exist", sym_->Name().c_str());
  return type::IntTy::Instance();
}

type::Ty *SubscriptVar::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                                   int labelcount,
                                   err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
   type::Ty *var_ty = var_->SemAnalyze(venv, tenv, labelcount,errormsg);
  type::Ty *exp_ty = subscript_->SemAnalyze(venv, tenv, labelcount,errormsg);
  // var_ty = var_ty->ActualTy();

  if(typeid(*var_ty) != typeid(type::ArrayTy)){
    errormsg->Error(pos_, "array type required");
    return type::IntTy::Instance();
  }

  if(typeid(*exp_ty) != typeid(type::IntTy)){
    errormsg->Error(pos_, "array index must be integer");
    return type::IntTy::Instance();
  }

  return ((type::ArrayTy *)var_ty)->ty_->ActualTy();

}

type::Ty *VarExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                             int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  if (typeid(*var_)==typeid(absyn::SimpleVar))
  {
    return ((SimpleVar *)var_)->SemAnalyze(venv, tenv, labelcount,errormsg);
  }
  else if (typeid(*var_)==typeid(absyn::FieldVar))
  {
     return ((FieldVar *)var_)->SemAnalyze(venv, tenv, labelcount,errormsg);
  }
  else if (typeid(*var_)==typeid(SubscriptVar))
  {
    return ((absyn::SubscriptVar *)var_)->SemAnalyze(venv, tenv, labelcount,errormsg);
  }
  else {
    assert(0);
  }


}

type::Ty *NilExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                             int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
   return type::NilTy::Instance();
}

type::Ty *IntExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                             int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  return type::IntTy::Instance();
}

type::Ty *StringExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                                int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  return type::StringTy::Instance();
}

type::Ty *CallExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                              int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
   env::EnvEntry *entry = venv->Look(func_);
  if(!entry || typeid(*entry) != typeid(env::FunEntry)){
    errormsg->Error(pos_, "undefined function %s", this->func_->Name().c_str());
    return type::IntTy::Instance();
  }

  type::TyList *formals = ((env::FunEntry *)entry)->formals_;
  ExpList *args_p = args_;
  auto ftr=formals->GetList().begin();
  auto atr=args_p->GetList().begin();
  while(ftr!=formals->GetList().end()){
    if(atr==args_p->GetList().end()){
      errormsg->Error(pos_, "too little params in function %s", this->func_->Name().c_str());
      return type::IntTy::Instance();
    }

    type::Ty *ty = (*atr)->SemAnalyze(venv, tenv, labelcount,errormsg);
    if(!ty->IsSameType(*ftr)){
      errormsg->Error(pos_, "para type mismatch");
      return type::IntTy::Instance();
    }
    
    atr++;
    ftr++;
  }

  if(atr!=args_p->GetList().end())
    errormsg->Error(pos_, "too many params in function %s", this->func_->Name().c_str());
  return ((env::FunEntry *)entry)->result_->ActualTy();
}

type::Ty *OpExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                            int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  type::Ty *left_ty = left_->SemAnalyze(venv, tenv, labelcount,errormsg);
  type::Ty *right_ty = right_->SemAnalyze(venv, tenv, labelcount,errormsg);

  switch(oper_){
    case Oper::PLUS_OP:
    case Oper::MINUS_OP:
    case Oper::TIMES_OP:
    case Oper::DIVIDE_OP:
      if(typeid(*left_ty) != typeid(type::IntTy))
        errormsg->Error(left_->pos_, "integer required");
      if(typeid(*right_ty) != typeid(type::IntTy))
        errormsg->Error(right_->pos_, "integer required");
      break;

    case Oper::LT_OP:
    case Oper::LE_OP:
    case Oper::GT_OP:
    case Oper::GE_OP:
      if(typeid(*left_ty) != typeid(type::IntTy) && typeid(*left_ty) !=typeid(type::StringTy))
        errormsg->Error(left_->pos_, "integer or string required");
      if(typeid(*right_ty) !=typeid( type::IntTy) && typeid(*right_ty) != typeid(type::StringTy))
        errormsg->Error(right_->pos_, "integer or string required");
      if(!left_ty->IsSameType(right_ty))
        errormsg->Error(pos_, "same type required");
      break;

    case Oper::EQ_OP:
    case Oper::NEQ_OP:
    //change
      if(typeid(*(left_ty->ActualTy())) != typeid(type::IntTy) && typeid(*(left_ty->ActualTy())) != typeid(type::StringTy)
      && typeid(*(left_ty->ActualTy())) != typeid(type::RecordTy) && typeid(*(left_ty->ActualTy())) != typeid(type::ArrayTy))
        errormsg->Error(left_->pos_, "integer or string or record or array required");
      if(typeid(*(right_ty->ActualTy())) != typeid(type::IntTy) && typeid(*(right_ty->ActualTy()))  != typeid(type::StringTy)
      && typeid(*(right_ty->ActualTy()))  != typeid(type::RecordTy) && typeid(*(right_ty->ActualTy()))  != typeid(type::ArrayTy)&&(typeid(*right_ty)!=typeid(type::NilTy)))
        errormsg->Error(right_->pos_, "integer or string or record or array required");
      if (typeid(*left_ty)  == typeid(type::NilTy) &&typeid(*right_ty)  == typeid(type::NilTy))
				errormsg->Error(this->pos_, "least one operand should not be NIL");
      if(!left_ty->IsSameType(right_ty) 
      && !(typeid(*left_ty)  == typeid(type::RecordTy) && typeid(*right_ty)  == typeid(type::NilTy)))
        errormsg->Error(pos_, "same type required");
      break;

    default:
      assert(0);
  }

  return type::IntTy::Instance();
}

type::Ty *RecordExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                                int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  type::Ty *ty = tenv->Look(typ_);
  if(!ty){
    errormsg->Error(pos_, "undefined type %s", typ_->Name().c_str());
    return type::IntTy::Instance();
  }
  
  ty = ty->ActualTy();
  if(!ty){
    errormsg->Error(pos_, "undefined type %s", typ_->Name().c_str());
    return type::IntTy::Instance();
  }
  if(typeid(*ty) != typeid(type::RecordTy)){
    errormsg->Error(pos_, "not record type %s", typ_->Name().c_str());
    return type::IntTy::Instance();
  }

  absyn::EFieldList *FIELDS = this->fields_;
  type::FieldList *RECORDS = ((type::RecordTy *)ty)->fields_;
  auto fitr=FIELDS->GetList().begin();
  auto ritr=RECORDS->GetList().begin();
  while (fitr!=FIELDS->GetList().end()&& ritr!=RECORDS->GetList().end()) {
    absyn::EField *field = *fitr;
    type::Field *record = *ritr;
    type::Ty *field_ty = field->exp_->SemAnalyze(venv, tenv, labelcount,errormsg);
    if (field->name_ != record->name_) {
      errormsg->Error(this->pos_, "field not defined");
      return type::IntTy::Instance();
    }
    if ((typeid(*(field_ty->ActualTy())) !=typeid(*(record->ty_->ActualTy())))&&(typeid(*(field_ty))!=typeid(type::NilTy))) {
      errormsg->Error(this->pos_, "field type mismatch");
      return type::IntTy::Instance();
    }
    fitr++;
    ritr++;
  }
  if (fitr!=FIELDS->GetList().end()|| ritr!=RECORDS->GetList().end()) {
    errormsg->Error(this->pos_, "field amount mismatch");
    return type::IntTy::Instance();
  }

  return ty;//->ActualTy();
}

type::Ty *SeqExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                             int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  ExpList *seq_p = seq_;
  if(!seq_p)
    return type::VoidTy::Instance();
  type::Ty *ty;
  auto itr=seq_p->GetList().begin();
  while(itr!=seq_p->GetList().end()){
    ty = (*itr)->SemAnalyze(venv, tenv, labelcount,errormsg);
    itr++;
  }

  return ty;//->ActualTy();
}

type::Ty *AssignExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                                int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  if(typeid(*var_) == typeid(absyn::SimpleVar)){
    env::EnvEntry *entry = venv->Look(((SimpleVar *)var_)->sym_);
    
    if(entry->readonly_){
      errormsg->Error(pos_, "loop variable can't be assigned");
      return type::IntTy::Instance();
    }
  }

  type::Ty *var_ty = var_->SemAnalyze(venv, tenv, labelcount,errormsg);
  type::Ty *exp_ty = exp_->SemAnalyze(venv, tenv, labelcount,errormsg);
  if(!var_ty->IsSameType(exp_ty))
    errormsg->Error(pos_, "unmatched assign exp");

  //change
  return type::VoidTy::Instance();//->ActualTy();
}

type::Ty *IfExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                            int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
    if (typeid(*this->test_->SemAnalyze(venv, tenv, labelcount,errormsg)) !=typeid(type::IntTy)) {
    errormsg->Error(this->pos_, "integer required");
    return type::IntTy::Instance();
  }
  type::Ty *ty = this->then_->SemAnalyze(venv, tenv, labelcount,errormsg);
  if (this->elsee_ == nullptr) {
    if (typeid(*ty) != typeid(type::VoidTy)) {
      errormsg->Error(this->pos_, "if-then exp's body must produce no value");
      return type::IntTy::Instance();
    }
    return type::VoidTy::Instance();
  } else {
    if (ty->IsSameType(this->elsee_->SemAnalyze(venv, tenv, labelcount,errormsg))) 
      return ty;
    else {
      errormsg->Error(this->pos_, "then exp and else exp type mismatch");
      return type::VoidTy::Instance();
    }
  }
}

type::Ty *WhileExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                               int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  type::Ty *test_ty = test_->SemAnalyze(venv, tenv, labelcount,errormsg);
  type::Ty *body_ty = body_->SemAnalyze(venv, tenv, 1,errormsg);
  if(typeid(*test_ty) != typeid(type::IntTy))
    errormsg->Error(test_->pos_, "integer required");
  if(typeid(*body_ty) !=typeid(type::VoidTy))
    errormsg->Error(body_->pos_, "while body must produce no value");

  return type::VoidTy::Instance();
}

type::Ty *ForExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                             int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  type::Ty *lo_ty = lo_->SemAnalyze(venv, tenv, labelcount,errormsg);
  type::Ty *hi_ty = hi_->SemAnalyze(venv, tenv, labelcount,errormsg);

  if(typeid(*lo_ty) != typeid(type::IntTy))
    errormsg->Error(lo_->pos_, "for exp's range type is not integer");
  if(typeid(*hi_ty) != typeid(type::IntTy))
    errormsg->Error(hi_->pos_, "for exp's range type is not integer");

  venv->BeginScope();
  tenv->BeginScope();
  venv->Enter(var_, new env::VarEntry(type::IntTy::Instance(),true));
  type::Ty *body_ty = body_->SemAnalyze(venv, tenv, 1,errormsg);
  venv->EndScope();
  tenv->EndScope();

  return type::VoidTy::Instance();
}

type::Ty *BreakExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                               int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  if (labelcount==1)
  return type::VoidTy::Instance();
  else{
    errormsg->Error(pos_,"break is not inside any loop");
  }
}

type::Ty *LetExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                             int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  venv->BeginScope();
  tenv->BeginScope();
  const std::list<Dec *> dlist=decs_->GetList();
  auto itr=dlist.begin();
  while(itr!=dlist.end()){
    (*itr)->SemAnalyze(venv, tenv, labelcount,errormsg);
    itr++;
  } 
  type::Ty *ty = body_->SemAnalyze(venv, tenv, labelcount,errormsg);
  venv->EndScope();
  tenv->EndScope();
  return ty;
}

type::Ty *ArrayExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                               int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  type::Ty *ty = tenv->Look(this->typ_)->ActualTy();
  if (ty == nullptr) {
    errormsg->Error(this->pos_, "undefined type %s", typ_->Name().c_str());
    return type::VoidTy::Instance();
  }
  if (typeid(*(this->size_->SemAnalyze(venv, tenv, labelcount,errormsg))) !=typeid(type::IntTy)) {
    errormsg->Error(this->pos_, "undefined type %s", typ_->Name().c_str());
    return type::VoidTy::Instance();
  }
  if (typeid(*ty) != typeid(type::ArrayTy)) {
    errormsg->Error(this->pos_, "not array type ");
    return type::VoidTy::Instance();
  }
  type::ArrayTy *arrayTy = (type::ArrayTy *)ty;
  if (!this->init_->SemAnalyze(venv, tenv, labelcount,errormsg)->IsSameType(arrayTy->ty_)) {
    errormsg->Error(this->pos_, "type mismatch");
    return type::VoidTy::Instance();
  }
  return arrayTy;
}

type::Ty *VoidExp::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                              int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  return type::VoidTy::Instance();
}


void FunctionDec::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv,
                             int labelcount, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  auto Fitr=this->functions_->GetList().begin();
   for (Fitr; Fitr != functions_->GetList().end(); Fitr++) {
    absyn::FunDec *funDec = *Fitr;
    auto tmp=Fitr;
    tmp++;
    for (tmp; tmp != functions_->GetList().end();tmp++)
      if ((*tmp)->name_->Name() == funDec->name_->Name())
        errormsg->Error(funDec->pos_, "two functions have the same name");

    type::Ty *result;
    if (funDec->result_ != nullptr) {
      result = tenv->Look(funDec->result_);
      if (result == nullptr)
        errormsg->Error(this->pos_, "FunctionDec undefined result.");
    }
    else
      result = type::VoidTy::Instance();
    venv->Enter(funDec->name_, new env::FunEntry(make_formal_tylist(tenv, funDec->params_,errormsg), result));
  }
  Fitr=this->functions_->GetList().begin();
  for (Fitr;Fitr!=functions_->GetList().end();Fitr++)
  {
    absyn::FunDec * funDec=(*Fitr);
    venv->BeginScope();
    auto tmpitr=funDec->params_->GetList().begin();
    for (tmpitr; tmpitr != funDec->params_->GetList().end(); tmpitr++) {
      absyn::Field *field = *tmpitr;
      type::Ty *ty = tenv->Look(field->typ_);
      if (ty == nullptr)
        errormsg->Error(field->pos_, "undefined type %s", field->typ_->Name().c_str());
      venv->Enter((*tmpitr)->name_, new env::VarEntry(ty));
    }
    type::Ty *bodyTy = funDec->body_->SemAnalyze(venv, tenv, labelcount,errormsg);
    type::Ty *decTy = ((env::FunEntry *)venv->Look(funDec->name_))->result_;
    if (!bodyTy->IsSameType(decTy)) {
      if (typeid(*decTy) == typeid(type::VoidTy))
        errormsg->Error(funDec->body_->pos_, "procedure returns value");
      else
        errormsg->Error(funDec->body_->pos_, "return type mismatch");
    }
    venv->EndScope();
  }


}

void VarDec::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv, int labelcount,
                        err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
    if (this->typ_ == nullptr) {
    type::Ty *ty = this->init_->SemAnalyze(venv, tenv, labelcount,errormsg);
    if (typeid(*(ty->ActualTy())) == typeid(type::NilTy))
      errormsg->Error(this->pos_, "init should not be nil without type specified");
      venv->Enter(this->var_, new env::VarEntry(ty->ActualTy()));
  }
  else {
    type::Ty *ty = tenv->Look(this->typ_);
    if (ty == nullptr) {
      errormsg->Error(this->pos_, "undefined type %s", this->typ_->Name().c_str());
      return;
    }
    if (ty->IsSameType(this->init_->SemAnalyze(venv, tenv, labelcount,errormsg)))
      venv->Enter(this->var_, new env::VarEntry(tenv->Look(this->typ_)->ActualTy()));
    else
      errormsg->Error(this->pos_, "type mismatch");
  }

}

void TypeDec::SemAnalyze(env::VEnvPtr venv, env::TEnvPtr tenv, int labelcount,
                         err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
  const std::list<NameAndTy *> dlist=this->types_->GetList();
  auto itr=dlist.begin();
  while(itr!=dlist.end()){
    auto itr2=itr;
    itr2++;
    for (itr2;itr2!=dlist.end();itr2++)
    {
      if ((*itr2)->name_->Name()==(*itr)->name_->Name())
      {
         errormsg->Error(this->pos_, "two types have the same name");
      }
    }
    tenv->Enter((*itr)->name_,new type::NameTy((*itr)->name_,nullptr));
    itr++;
  } 
  itr=dlist.begin();
  for (itr;itr!=dlist.end();itr++)
  {
    type::NameTy * nameTy=(type::NameTy *)tenv->Look((*itr)->name_);
    nameTy->ty_=(*itr)->ty_->SemAnalyze(tenv,errormsg);
  }

  bool hasCycle = false;
  auto itr4=types_->GetList().begin();
  for (itr4;itr4!=types_->GetList().end();itr4++)
  {
       type::Ty *ty = tenv->Look((*itr4)->name_);
    if (typeid(*ty) ==typeid(type::NameTy)) {
      type::Ty *tyTy = ((type::NameTy *)ty)->ty_;
      while (typeid(*tyTy) == typeid(type::NameTy)) {
        type::NameTy *nameTy = (type::NameTy *)tyTy;
        if (nameTy->sym_->Name() == (*itr4)->name_->Name()) {
          errormsg->Error(pos_, "illegal type cycle");
          hasCycle = true;
          break;
        }
        tyTy = nameTy->ty_;
      }
    }
    if (hasCycle)
      break;
  }
 
}

type::Ty *NameTy::SemAnalyze(env::TEnvPtr tenv, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
   type::Ty *ty = tenv->Look(name_);
  if(!ty){
    errormsg->Error(pos_, "undefined type %s", name_->Name().c_str());
		return type::VoidTy::Instance();
  }
  return new type::NameTy(name_, ty);
  
}

type::Ty *RecordTy::SemAnalyze(env::TEnvPtr tenv,
                               err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
   type::FieldList *fields = new type::FieldList();
  if (record_==nullptr)
  {
    return nullptr;
  }
  else{
    auto itr=record_->GetList().begin();
    for (itr;itr!=record_->GetList().end();itr++)
    {
      type::Ty *ty = tenv->Look((*itr)->typ_);
      // if (typeid(*ty)==typeid(type::IntTy)){
      //   printf("int found\n");
      // }
      // else {
      //   printf("not found\n");
      // }
      if (!ty)
      {
         errormsg->Error(pos_, "undefined type %s", (*itr)->typ_->Name().c_str());
      }
      type::Field * tmp=new type::Field((*itr)->name_,ty);
      fields->Append(tmp);
    }
  }
  return new type::RecordTy(fields);

}



type::Ty *ArrayTy::SemAnalyze(env::TEnvPtr tenv,
                              err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab4 code here */
    type::Ty *ty = tenv->Look(array_);
  if(!ty){
    errormsg->Error(pos_, "undefined type %s", array_->Name().c_str());
    return type::VoidTy::Instance();
  }
  return new type::ArrayTy(ty);
}

} // namespace absyn

namespace sem {

void ProgSem::SemAnalyze() {
  FillBaseVEnv();
  FillBaseTEnv();
  absyn_tree_->SemAnalyze(venv_.get(), tenv_.get(), errormsg_.get());
}

} // namespace tr
