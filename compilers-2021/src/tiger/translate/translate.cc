#include "tiger/translate/translate.h"

#include <tiger/absyn/absyn.h>

#include "tiger/env/env.h"
#include "tiger/errormsg/errormsg.h"
#include "tiger/frame/x64frame.h"
#include "tiger/frame/temp.h"
#include "tiger/frame/frame.h"

extern frame::Frags *frags;
extern frame::RegManager *reg_manager;
extern std::vector<assem::Gc_Root> * GC_Roots;
extern std::vector<tr::Rec_Description> * Rec_Des;

namespace tr {

Access *Access::AllocLocal(Level *level, bool escape,bool is) {
  /* TODO: Put your lab5 code here */
  frame::Access * tmp= level->frame_->allocLocal(escape,is);
  return new tr::Access(level,tmp);
}

  Level *NewLevel(Level *parent,temp::Label * name,std::list<bool> *formals,std::list<bool> * is_ptrs=nullptr){
    formals->push_front(true);
    frame::Frame * fr=frame::X64Frame::newFrame(name,formals,is_ptrs);
    return new Level(fr,parent);
  }

class Cx {
public:
  temp::Label **trues_;
  temp::Label **falses_;
  tree::Stm *stm_;

  Cx(temp::Label **trues, temp::Label **falses, tree::Stm *stm)
      : trues_(trues), falses_(falses), stm_(stm) {}
};

class Exp {
public:
  [[nodiscard]] virtual tree::Exp *UnEx() const = 0;
  [[nodiscard]] virtual tree::Stm *UnNx() const = 0;
  [[nodiscard]] virtual Cx UnCx(err::ErrorMsg *errormsg) const = 0;
};

class ExpAndTy {
public:
  tr::Exp *exp_;
  type::Ty *ty_;

  ExpAndTy(tr::Exp *exp, type::Ty *ty) : exp_(exp), ty_(ty) {}
};

class ExExp : public Exp {
public:
  tree::Exp *exp_;

  explicit ExExp(tree::Exp *exp) : exp_(exp) {}

  [[nodiscard]] tree::Exp *UnEx() const override { 
    /* TODO: Put your lab5 code here */
    return exp_;
  }
  [[nodiscard]] tree::Stm *UnNx() const override {
    /* TODO: Put your lab5 code here */
    return new tree::ExpStm(exp_);
  }
  [[nodiscard]] Cx UnCx(err::ErrorMsg *errormsg) const override {
    /* TODO: Put your lab5 code here */
     temp::Label *t = temp::LabelFactory::NewLabel(), *f = temp::LabelFactory::NewLabel();
    temp::Label ** trues;
   temp::Label ** falses;
    tree::CjumpStm *stm = new tree::CjumpStm(tree::NE_OP, exp_, new tree::ConstExp(0), t, f);
  
   trues=&(stm->true_label_);
  //  trues[1]=nullptr;
   falses=&(stm->false_label_);
  //  falses[1]=nullptr;
    return Cx(trues, falses, stm);
   
  }
};

class NxExp : public Exp {
public:
  tree::Stm *stm_;

  explicit NxExp(tree::Stm *stm) : stm_(stm) {}

  [[nodiscard]] tree::Exp *UnEx() const override {
    /* TODO: Put your lab5 code here */
    return new tree::EseqExp(stm_,new tree::ConstExp(0));
  }
  [[nodiscard]] tree::Stm *UnNx() const override { 
    /* TODO: Put your lab5 code here */
    return stm_;
  }
  [[nodiscard]] Cx UnCx(err::ErrorMsg *errormsg) const override {
    /* TODO: Put your lab5 code here */
    printf("nx Uncx failed!");
    assert(0);
  }
};

class CxExp : public Exp {
public:
  Cx cx_;

  CxExp(temp::Label** trues, temp::Label** falses, tree::Stm *stm)
      : cx_(trues, falses, stm) {}
  
  [[nodiscard]] tree::Exp *UnEx() const override {
    /* TODO: Put your lab5 code here */
    temp::Temp *r = temp::TempFactory::NewTemp();
    temp::Label *t = temp::LabelFactory::NewLabel(), *f = temp::LabelFactory::NewLabel();
    temp::Label ** tlist=cx_.trues_;
    temp::Label ** flist=cx_.falses_;
    // while (*tlist)
    // {
      (*tlist)=t;
    //   tlist++;
    // }
    // while (*flist)
    // {
      (*flist)=f;
    //   flist++;
    // }
    return new tree::EseqExp(new tree::MoveStm(new tree::TempExp(r), new tree::ConstExp(1)),
             new tree::EseqExp(cx_.stm_,
               new tree::EseqExp(new tree::LabelStm((*flist)),
                 new tree::EseqExp(new tree::MoveStm(new tree::TempExp(r), new tree::ConstExp(0)),
                   new tree::EseqExp(new tree::LabelStm((*tlist)), new tree::TempExp(r))))));
  }
  [[nodiscard]] tree::Stm *UnNx() const override {
    /* TODO: Put your lab5 code here */
    return cx_.stm_;
  }
  [[nodiscard]] Cx UnCx(err::ErrorMsg *errormsg) const override { 
    /* TODO: Put your lab5 code here */
    return cx_;
  }
};

Level * Outermost() {
  static Level *lv = nullptr;
  if (lv != nullptr) return lv;
  frame::Frame *frame = frame::X64Frame::newFrame(temp::LabelFactory::NamedLabel("tigermain"), nullptr);
  lv = new Level(frame, nullptr);


  //add gc
  // assem::Gc_Root gtmp;
  // gtmp.name="GC"+std::to_string(gtmp.GetAndAddIdx());
  // gtmp.retaddr="-1";//唯一确定的
  // gtmp.stacksize="tigermain";
  // gtmp.callerstacksize="-1";
  // GC_Roots->push_back(gtmp);
  //
  return lv;
}
ProgTr::ProgTr(std::unique_ptr<absyn::AbsynTree> absyn_tree,std::unique_ptr<err::ErrorMsg> errormsg):absyn_tree_(std::move(absyn_tree)),errormsg_(std::move(errormsg))
{
  frags=new frame::Frags();
  tr::Level * tmp =Outermost();
  main_level_ = std::unique_ptr<tr::Level> (tmp);
  tenv_ = std::unique_ptr<env::TEnv> (new env::TEnv);
  venv_ = std::unique_ptr<env::VEnv> (new env::VEnv);
  FillBaseTEnv();
  FillBaseVEnv();
}

void ProgTr::Translate() {
  /* TODO: Put your lab5 code here */
  temp::Label *mainLabel = temp::LabelFactory::NewLabel();
  tr::ExpAndTy * root_expty = absyn_tree_->Translate(&(*venv_), &(*tenv_), &(*main_level_), &(*mainLabel),&(*errormsg_));
  tree::Stm *stm = new tree::MoveStm(new tree::TempExp(((frame::X64RegManager *)reg_manager)->ReturnValue()), root_expty->exp_->UnEx());
  stm = frame::procEntryExit1(main_level_->frame_, stm);
  frags->PushBack(new frame::ProcFrag(stm, main_level_->frame_));
}



tr::Exp * SimpleVar(tr::Access * access,tr::Level *level){
  
  if (typeid(*(access->access_))==typeid(frame::InFrameAccess))
  {
    tree::Exp * frameptr=new tree::TempExp(((frame::X64RegManager *)reg_manager)->FramePointer());
      while (level != access->level_) {
    frameptr = new tree::MemExp(new tree::BinopExp(tree::PLUS_OP, frameptr, new tree::ConstExp(-frame::X64Frame::wordSize)));
    level = level->parent_;
  }
  frameptr = new tree::MemExp(new tree::BinopExp(tree::PLUS_OP,frameptr,new tree::ConstExp(((frame::InFrameAccess *) (access->access_))->offset)),access->access_->is_ptr);
  return new tr::ExExp(frameptr);//use the var
  }
  else{
    tree::Exp * reg=new tree::TempExp(((frame::InRegAccess*)(access->access_))->reg,access->access_->is_ptr);
    return new tr::ExExp(reg);
    // printf("var should not be in register!");
    // exit(1);
  }
  
}

tr::Exp * fieldVar(tr::Exp *exp,int offset){
  //add gc
    return new tr::ExExp(new tree::MemExp(new tree::BinopExp(tree::PLUS_OP, exp->UnEx(), new tree::ConstExp(offset+8))));
}
tr::Exp * subscriptVar(tr::Exp * exp1,tr::Exp * exp2)
{
  //add gc
  tree::BinopExp * pad=new tree::BinopExp(tree::PLUS_OP,exp2->UnEx(),new tree::ConstExp(1));
  //
  return new tr::ExExp( new tree::MemExp(new tree::BinopExp(tree::PLUS_OP,exp1->UnEx(), new tree::BinopExp(tree::MUL_OP, pad, new tree::ConstExp(frame::X64Frame::wordSize)))));
}

tr::Exp *calc(absyn::Oper op, tr::Exp *lhs, tr::Exp *rhs) {
  if (op == absyn::PLUS_OP) {
    return new tr::ExExp(new tree::BinopExp(tree::PLUS_OP, lhs->UnEx(), rhs->UnEx()));
  } else if (op == absyn::MINUS_OP) {
    return new tr::ExExp(new tree::BinopExp(tree::MINUS_OP, lhs->UnEx(), rhs->UnEx()));
  } else if (op == absyn::TIMES_OP) {
    return new tr::ExExp(new tree::BinopExp(tree::MUL_OP, lhs->UnEx(), rhs->UnEx()));
  } else if (op == absyn::DIVIDE_OP) {
    return new tr::ExExp(new tree::BinopExp(tree::DIV_OP, lhs->UnEx(), rhs->UnEx()));
  }
}

tr::Exp *stringEqual(tr::Exp *lhs, tr::Exp *rhs) {
  tree::ExpList * args=new tree::ExpList();
  args->Append(lhs->UnEx());
  args->Append(rhs->UnEx());
  return new tr::ExExp(frame::X64Frame::externalCall("string_equal",args));
}

tr::Exp *cmp(absyn::Oper op, tr::Exp *lhs, tr::Exp *rhs) {
  tree::CjumpStm *stm;
  if (op == absyn::EQ_OP) {
    stm = new tree::CjumpStm(tree::EQ_OP, lhs->UnEx(), rhs->UnEx(),  temp::LabelFactory::NewLabel(),  temp::LabelFactory::NewLabel());
  } else if (op == absyn::NEQ_OP) {
    stm = new tree::CjumpStm(tree::NE_OP, lhs->UnEx(), rhs->UnEx(),  temp::LabelFactory::NewLabel(),  temp::LabelFactory::NewLabel());
  } else if (op == absyn::LT_OP) {
    stm = new tree::CjumpStm(tree::LT_OP, lhs->UnEx(), rhs->UnEx(),  temp::LabelFactory::NewLabel(),  temp::LabelFactory::NewLabel());
  } else if (op == absyn::LE_OP) {
    stm = new tree::CjumpStm(tree::LE_OP, lhs->UnEx(), rhs->UnEx(),  temp::LabelFactory::NewLabel(),  temp::LabelFactory::NewLabel());
  } else if (op == absyn::GE_OP) {
    stm = new tree::CjumpStm(tree::GE_OP, lhs->UnEx(), rhs->UnEx(),  temp::LabelFactory::NewLabel(),  temp::LabelFactory::NewLabel());
  } else if (op == absyn::GT_OP) {
    stm = new tree::CjumpStm(tree::GT_OP, lhs->UnEx(), rhs->UnEx(),  temp::LabelFactory::NewLabel(),  temp::LabelFactory::NewLabel());
  }

  // temp::Label ** trues=new temp::Label*[2];
  // temp::Label ** falses=new temp::Label*[2];
  // trues[0]=stm->true_label_;
  // trues[1]=nullptr;
  // falses[0]=stm->false_label_;
  // falses[1]=nullptr;
  temp::Label ** trues;
  temp::Label ** falses;
  trues=&(stm->true_label_);
  falses=&(stm->false_label_);
  return new CxExp(trues, falses, stm);
}

tree::Stm * make_record(std::vector<tree::Exp *> * explist, temp::Temp * r, int offset) {
  //TODO::Add is_ptr for record
  if (explist->size() == 1) {
    return new tree::MoveStm(new tree::MemExp(new tree::BinopExp(tree::PLUS_OP, new tree::TempExp(r), new tree::ConstExp((offset+1) * frame::X64Frame::wordSize))), (*explist)[offset]);
  } else if (offset == explist->size() - 2) {
    return new tree::SeqStm(
            new tree::MoveStm(new tree::MemExp(new tree::BinopExp(tree::PLUS_OP, new tree::TempExp(r), new tree::ConstExp((offset+1) * frame::X64Frame::wordSize))), (*explist)[offset]),
            new tree::MoveStm(new tree::MemExp(new tree::BinopExp(tree::PLUS_OP, new tree::TempExp(r), new tree::ConstExp((offset + 2) * frame::X64Frame::wordSize))), (*explist)[offset + 1]));
  } else {
    return new tree::SeqStm(
            new tree::MoveStm(new tree::MemExp(new tree::BinopExp(tree::PLUS_OP, new tree::TempExp(r), new tree::ConstExp((offset+1) * frame::X64Frame::wordSize))), (*explist)[offset]),
            tr::make_record(explist, r, offset + 1));
  }
}

tr::Exp *seq(tr::Exp *lhs, tr::Exp *rhs) {
  if (rhs) {
    //add gc
    tree::Exp * tmp=rhs->UnEx();
    return new tr::ExExp(new tree::EseqExp(lhs->UnNx(), tmp,tmp->is_ptr));
  } else {
    return new tr::ExExp(new tree::EseqExp(lhs->UnNx(), new tree::ConstExp(0)));
  }
}
tr::Exp *while_(tr::Exp *test, tr::Exp *body, temp::Label *doneLabel) {
  Cx testCx = test->UnCx(nullptr);
  temp::Label *bodyLabel = temp::LabelFactory::NewLabel(), *testLabel = temp::LabelFactory::NewLabel();
  temp::Label ** tlist=testCx.trues_;
  temp::Label ** flist=testCx.falses_;
  // while (*(tlist))
  // {
    (*tlist)=bodyLabel;
  //   tlist++;
  // }
  //  while (*(flist))
  // {
    (*flist)=doneLabel;
  //   flist++;
  // }
  std::vector<temp::Label *> * js=new std::vector<temp::Label *>();
  js->push_back(testLabel);

  return new tr::NxExp(
      new tree::SeqStm(new tree::LabelStm(testLabel),
      new tree::SeqStm(testCx.stm_,
        new tree::SeqStm(new tree::LabelStm((*tlist)),
         new tree::SeqStm(body->UnNx(),
          new tree::SeqStm(new tree::JumpStm(new tree::NameExp(testLabel), js),
           new tree::LabelStm((*flist))))))));
}

//用test，do body，add的方式改写，不考虑溢出，这应该是程序的问题
tr::Exp *for_(frame::Access *access, tr::Exp *lo, tr::Exp *hi, tr::Exp *body, temp::Label *doneLabel) {
  temp::Label *bodyLabel = temp::LabelFactory::NewLabel(), *testLabel = temp::LabelFactory::NewLabel();
  tree::Exp * i;
  if (typeid(*access)==typeid(frame::InFrameAccess))
   i=new tree::MemExp(new tree::BinopExp(tree::PLUS_OP, new tree::TempExp(((frame::X64RegManager *)reg_manager)->FramePointer()), new tree::ConstExp(((frame::InFrameAccess *) access)->offset)));
  else{
   i=new tree::TempExp(((frame::InRegAccess*)access)->reg);
  }
   std::vector<temp::Label *> * js=new std::vector<temp::Label *>();
  js->push_back(testLabel);
  return new tr::NxExp(
      new tree::SeqStm(new tree::MoveStm(i, lo->UnEx()),
      new tree::SeqStm(new tree::LabelStm(testLabel),
       new tree::SeqStm(new tree::CjumpStm(tree::LE_OP, i, hi->UnEx(), bodyLabel, doneLabel),
        new tree::SeqStm(new tree::LabelStm(bodyLabel),
         new tree::SeqStm(body->UnNx(),
          new tree::SeqStm(new tree::MoveStm(i, new tree::BinopExp(tree::PLUS_OP, i, new tree::ConstExp(1))),
           new tree::SeqStm(new tree::JumpStm(new tree::NameExp(testLabel), js),
            new tree::LabelStm(doneLabel)))))))));
}



} // namespace tr


namespace absyn {

tr::ExpAndTy *AbsynTree::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                   tr::Level *level, temp::Label *label,
                                   err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  return root_->Translate(venv,tenv,level,label,errormsg);
}

tr::ExpAndTy *SimpleVar::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                   tr::Level *level, temp::Label *label,
                                   err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  env::EnvEntry * tmp = venv->Look(sym_);
  if (typeid(*tmp)==typeid(env::VarEntry))
  {
    return new tr::ExpAndTy(tr::SimpleVar(((env::VarEntry *) tmp)->access_, level), ((env::VarEntry *) tmp)->ty_);
  }
  else{
    errormsg->Error(this->pos_,"expect simple var but got func");
    return new tr::ExpAndTy(nullptr, type::IntTy::Instance());
  }
}

tr::ExpAndTy *FieldVar::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                  tr::Level *level, temp::Label *label,
                                  err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  // printf("label %s\n",sym_->Name().c_str());
  tr::ExpAndTy * tmp=var_->Translate(venv,tenv,level,label,errormsg);
  type::Ty * varTy=tmp->ty_->ActualTy();
   if (typeid(*varTy)==typeid(type::RecordTy))
  {
    type::FieldList *list = ((type::RecordTy *) varTy)->fields_;
    int offset=0;
    for (auto itr=list->GetList().begin();itr!=list->GetList().end();itr++)
    {
      if ((*itr)->name_==sym_)
      {
        return new tr::ExpAndTy(tr::fieldVar(tmp->exp_, offset), (*itr)->ty_);
      }
      offset+=frame::X64Frame::wordSize;
    }
    return new tr::ExpAndTy(tr::SimpleVar(((env::VarEntry *) tmp)->access_, level), ((env::VarEntry *) tmp)->ty_);
  }
  else{
    errormsg->Error(this->pos_,"expect record var but not got! ");
    exit(1);
    return new tr::ExpAndTy(nullptr, type::VoidTy::Instance());
  }
}

tr::ExpAndTy *SubscriptVar::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                      tr::Level *level, temp::Label *label,
                                      err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  tr::ExpAndTy * tmp=var_->Translate(venv,tenv,level,label,errormsg);
  type::Ty * varTy=tmp->ty_->ActualTy();
  tr::ExpAndTy * sub=subscript_->Translate(venv,tenv,level,label,errormsg);
  if (typeid(*varTy)==typeid(type::ArrayTy))
  {
    return new tr::ExpAndTy(tr::subscriptVar(tmp->exp_, sub->exp_),((type::ArrayTy *)varTy)->ty_);
  }
  else{
    errormsg->Error(this->pos_,"expect arr var but not got! ");
    return new tr::ExpAndTy(nullptr, type::VoidTy::Instance());
  }

}

tr::ExpAndTy *VarExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                tr::Level *level, temp::Label *label,
                                err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  tr::ExpAndTy * res=var_->Translate(venv,tenv,level,label,errormsg);
  return res;
}

tr::ExpAndTy *NilExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                tr::Level *level, temp::Label *label,
                                err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  return new tr::ExpAndTy(new tr::ExExp(new tree::ConstExp(0)), type::NilTy::Instance());
}

tr::ExpAndTy *IntExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                tr::Level *level, temp::Label *label,
                                err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  return new tr::ExpAndTy(new tr::ExExp(new tree::ConstExp(val_)), type::IntTy::Instance());
}

tr::ExpAndTy *StringExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                   tr::Level *level, temp::Label *label,
                                   err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  temp::Label * string_label = temp::LabelFactory::NewLabel();
  frags->PushBack(new frame::StringFrag(string_label,str_));
  return new tr::ExpAndTy( new tr::ExExp(new tree::NameExp(string_label)),type::StringTy::Instance());
}

tr::ExpAndTy *CallExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                 tr::Level *level, temp::Label *label,
                                 err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  env::EnvEntry * function=venv->Look(func_);
  type::Ty *res=((env::FunEntry*)function)->result_;
  //add gc
  bool is_ptr=0;
  if (res&&(typeid(*(res->ActualTy()))==typeid(type::RecordTy)||typeid(*(res->ActualTy()))==typeid(type::ArrayTy)))
  is_ptr=1;
  //
  tree::ExpList * new_args=new tree::ExpList();
  tree::Exp * func_name_label=new tree::NameExp(((env::FunEntry*)function)->label_);
  //构造带静态链的参数表
  tree::Exp * staticlink=new tree::TempExp(((frame::X64RegManager *)reg_manager)->FramePointer());
  tr::Level * calleelevel=((env::FunEntry*)function)->level_;
  tr::Level * callerlevel=level;
  
    while (callerlevel != calleelevel->parent_) {
    staticlink = new tree::MemExp(new tree::BinopExp(tree::MINUS_OP, staticlink, new tree::ConstExp(frame::X64Frame::wordSize)));
    callerlevel = callerlevel->parent_;
  }
  for (auto itr=args_->GetList().begin();itr!=args_->GetList().end();itr++)
  {
    new_args->Append((*itr)->Translate(venv,tenv,level,label,errormsg)->exp_->UnEx());
    
  }
 
  if (calleelevel->parent_)
  {
    new_args->Insert(staticlink);
    
    return new tr::ExpAndTy(new tr::ExExp(new tree::CallExp(func_name_label,new_args,is_ptr)),res);
  }
  else{
    
    return new tr::ExpAndTy(new tr::ExExp(frame::X64Frame::externalCall(func_->Name(),new_args)),res);
  }

}

tr::ExpAndTy *OpExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                               tr::Level *level, temp::Label *label,
                               err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  tr::ExpAndTy *left = this->left_->Translate(venv, tenv, level, label,errormsg);
  tr::ExpAndTy *right = this->right_->Translate(venv, tenv, level, label,errormsg);
  type::Ty *leftTy = left->ty_->ActualTy();
  type::Ty *rightTy = right->ty_->ActualTy();

  if (this->oper_ == absyn::PLUS_OP || this->oper_ == absyn::MINUS_OP || this->oper_ == absyn::TIMES_OP || this->oper_ == absyn::DIVIDE_OP) {
    return new tr::ExpAndTy(tr::calc(this->oper_, left->exp_, right->exp_), type::IntTy::Instance());
  } else if (this->oper_ == absyn::EQ_OP && typeid(*leftTy)==typeid(type::StringTy)&&typeid(*rightTy)==typeid(type::StringTy)) {
    return new tr::ExpAndTy(tr::stringEqual(left->exp_, right->exp_), type::IntTy::Instance());
  } else {
    return new tr::ExpAndTy(tr::cmp(this->oper_, left->exp_, right->exp_), type::IntTy::Instance());
  }

  
}

tr::ExpAndTy *RecordExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                   tr::Level *level, temp::Label *label,      
                                   err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  type::Ty * ty=tenv->Look(typ_)->ActualTy();
 std::vector<tree::Exp *> * tmp=new std::vector<tree::Exp *>;
  for (auto itr=(fields_->GetList().begin());itr!=fields_->GetList().end();itr++)
  {
    tr::ExpAndTy * expty=(*itr)->exp_->Translate(venv,tenv,level,label,errormsg);
    tmp->push_back(expty->exp_->UnEx());
  }
  temp::Temp * r=temp::TempFactory::NewTemp(1);
  tree::ExpList * args=new tree::ExpList();
  //add gc: change size
  args->Append(new tree::ConstExp(frame::X64Frame::wordSize * (fields_->GetList().size()+1)));
  tree::Stm * stm=new tree::MoveStm(new tree::TempExp(r), frame::X64Frame::externalCall("alloc_record",args));
  //add gc
  int Rec_idx=-1;
  for (auto Rec:(*Rec_Des)){
    if ((Rec.ty->ActualTy())==(ty->ActualTy())){
      Rec_idx=Rec.index;
      break;
    }
  }
  if (Rec_idx==-1){
    printf("not found type!\n");
    exit(1);
  }
  //
  stm=new tree::SeqStm(stm,new tree::MoveStm(new tree::MemExp( new tree::TempExp(r)), new tree::ConstExp(Rec_idx)));
  stm = new tree::SeqStm(stm, tr::make_record(tmp, r, 0));
  return new tr::ExpAndTy(new tr::ExExp(new tree::EseqExp(stm, new tree::TempExp(r),1)), ty);

}

tr::ExpAndTy *SeqExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                tr::Level *level, temp::Label *label,
                                err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  absyn::ExpList *list = seq_;
  tr::Exp *exp = new tr::ExExp(new tree::ConstExp(0));
  type::Ty *ty = nullptr;
  if (!list) {
    return new tr::ExpAndTy(nullptr, type::VoidTy::Instance());
  }
  for (auto itr=list->GetList().begin();itr!=list->GetList().end();itr++)
  {
    tr::ExpAndTy * expty=(*(itr))->Translate(venv,tenv,level,label,errormsg);
    exp=tr::seq(exp,expty->exp_);
    ty=expty->ty_;
  }

  return new tr::ExpAndTy(exp, ty);
}

tr::ExpAndTy *AssignExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                   tr::Level *level, temp::Label *label,                       
                                   err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  tr::ExpAndTy * var = var_->Translate(venv, tenv, level, label,errormsg);
  tr::ExpAndTy * exp = exp_->Translate(venv, tenv, level, label,errormsg);
  tr::Exp * tmp= new tr::NxExp(new tree::MoveStm(var->exp_->UnEx(), exp->exp_->UnEx()));
  return new tr::ExpAndTy(tmp, type::VoidTy::Instance());

}

tr::ExpAndTy *IfExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                               tr::Level *level, temp::Label *label,
                               err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  tr::ExpAndTy * test = test_->Translate(venv, tenv, level, label,errormsg);
  tr::ExpAndTy * then = then_->Translate(venv, tenv, level, label,errormsg);
  tr::ExpAndTy * elsee=new tr::ExpAndTy(nullptr,nullptr);
  type::Ty *thenTy = then->ty_->ActualTy();
  if (elsee_) {
    elsee = elsee_->Translate(venv, tenv, level, label,errormsg);
  }
  bool is_ptr=0;
  if (elsee->exp_&&(typeid(*(thenTy->ActualTy()))==typeid(type::ArrayTy)||typeid(*(thenTy->ActualTy()))==typeid(type::RecordTy)))
  is_ptr=1;

  tr::Cx  cx=test->exp_->UnCx(errormsg);
  temp::Temp * r=temp::TempFactory::NewTemp(is_ptr);
  temp::Label * t=temp::LabelFactory::NewLabel();
  temp::Label * f=temp::LabelFactory::NewLabel();
  temp::Label * u=temp::LabelFactory::NewLabel();
  temp::Label **  tlist=cx.trues_;
  temp::Label ** flist=cx.falses_;
  // while (*tlist)
  // {
    (*tlist)=t;
  //   tlist++;
  // }
  // while (*flist)
  // {
    (*flist)=f;
  //   flist++;
  // }
  if (elsee->exp_)
  {
    std::vector<temp::Label *> * js=new std::vector<temp::Label *>();
    js->push_back(u);
     return new tr::ExpAndTy(
     new tr::ExExp(
        new tree::EseqExp(cx.stm_,
         new tree::EseqExp(new tree::LabelStm((*tlist)),
          new tree::EseqExp(new tree::MoveStm(new tree::TempExp(r), then->exp_->UnEx()),
           new tree::EseqExp(new tree::JumpStm(new tree::NameExp(u), js),
            new tree::EseqExp(new tree::LabelStm((*flist)),
             new tree::EseqExp(new tree::MoveStm(new tree::TempExp(r), elsee->exp_->UnEx()),
              new tree::EseqExp(new tree::JumpStm(new tree::NameExp(u), js),
               new tree::EseqExp(new tree::LabelStm(u), new tree::TempExp(r),is_ptr),is_ptr),is_ptr)
               ,is_ptr)
               ,is_ptr)
               ,is_ptr)
               ,is_ptr)
               ,is_ptr)),
     thenTy);
  }
  else{
     return new tr::ExpAndTy(
     new tr::NxExp(
        new tree::SeqStm(cx.stm_,
          new tree::SeqStm(new tree::LabelStm((*tlist)),
            new tree::SeqStm(then->exp_->UnNx(), new tree::LabelStm((*flist)))))),
     thenTy);

  }

  
}

tr::ExpAndTy *WhileExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                  tr::Level *level, temp::Label *label,            
                                  err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  temp::Label *done = temp::LabelFactory::NewLabel();
  tr::ExpAndTy *test = test_->Translate(venv, tenv, level, label,errormsg);
  tr::ExpAndTy *body = body_->Translate(venv, tenv, level, done,errormsg);
  type::Ty *bodyTy = body->ty_;
  return new tr::ExpAndTy(tr::while_(test->exp_, body->exp_, done), bodyTy);
}

tr::ExpAndTy *ForExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                tr::Level *level, temp::Label *label,
                                err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  venv->BeginScope();
  temp::Label *done = temp::LabelFactory::NewLabel();
  tr::ExpAndTy * lo = lo_->Translate(venv, tenv, level, label,errormsg);
  tr::ExpAndTy * hi = hi_->Translate(venv, tenv, level, label,errormsg);


  tr::Access *access = tr::Access::AllocLocal(level, escape_);
  venv->Enter(var_, new env::VarEntry(access, lo->ty_, true));

  tr::ExpAndTy * body = body_->Translate(venv, tenv, level, done,errormsg);
  venv->EndScope();
  return new tr::ExpAndTy(tr::for_(access->access_, lo->exp_, hi->exp_, body->exp_, done), type::VoidTy::Instance());
}

tr::ExpAndTy *BreakExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                  tr::Level *level, temp::Label *label,
                                  err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
   std::vector<temp::Label *> * js=new std::vector<temp::Label *>();
  js->push_back(label);
  tree::Stm * jump = new tree::JumpStm(new tree::NameExp(label),js);
  return new tr::ExpAndTy(new tr::NxExp(jump),type::VoidTy::Instance());
}


tr::ExpAndTy *LetExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                tr::Level *level, temp::Label *label,
                                err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  absyn::DecList *list = decs_;
  tr::Exp *seq = nullptr;
  for (auto itr=list->GetList().begin();itr!=list->GetList().end();itr++)
  {
    if (seq) {
      seq=tr::seq(seq,(*itr)->Translate(venv,tenv,level,label,errormsg));
    } else {
      seq = (*itr)->Translate(venv, tenv, level, label,errormsg);
    }
  }

  tr::ExpAndTy * body = body_->Translate(venv, tenv, level, label,errormsg);
  if (seq) {
    seq = tr::seq(seq, body->exp_);
  } else {
    seq = body->exp_;
  }
  
  return new tr::ExpAndTy(seq, body->ty_);
}

tr::ExpAndTy *ArrayExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                  tr::Level *level, temp::Label *label,                    
                                  err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  type::Ty * ty = tenv->Look(typ_)->ActualTy();
  tr::Exp *size = size_->Translate(venv, tenv, level, label,errormsg)->exp_;
  tr::Exp *init = init_->Translate(venv, tenv, level, label,errormsg)->exp_;
  tree::ExpList * args=new tree::ExpList();
  //add gc
  tree::BinopExp * pad=new tree::BinopExp(tree::PLUS_OP,size->UnEx(),new tree::ConstExp(1));
  //
  // args->Append(size->UnEx());
  args->Append(pad);
  args->Append(init->UnEx());
  return new tr::ExpAndTy(new tr::ExExp(frame::X64Frame::externalCall("init_array", args)), ty);
}

tr::ExpAndTy *VoidExp::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                 tr::Level *level, temp::Label *label,
                                 err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  return new tr::ExpAndTy(nullptr,type::VoidTy::Instance());
}

tr::Exp *FunctionDec::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                                tr::Level *level, temp::Label *label,
                                err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  absyn::FunDecList* list = functions_;
  //先把函数头加入venv
  for (auto itr=list->GetList().begin();itr!=list->GetList().end();itr++)
  {
    type::TyList * formalTyList= new type::TyList();
    temp::Label * name=temp::LabelFactory::NamedLabel((*itr)->name_->Name());
    std::list<bool > * args=new std::list<bool>();
    std::list<bool> * is_ptrs=new std::list<bool>();
    for (auto itr2=(*itr)->params_->GetList().begin();itr2!=(*itr)->params_->GetList().end();itr2++)
    {
      type::Ty * ty = tenv->Look((*itr2)->typ_);
      formalTyList->Append(ty->ActualTy());
      args->push_back((*itr2)->escape_);
      if (typeid(*(ty->ActualTy()))==typeid(type::ArrayTy)||typeid(*(ty->ActualTy()))==typeid(type::RecordTy))
      is_ptrs->push_back(1);
      else{
        is_ptrs->push_back(0);
      }
    }
    tr::Level * newLevel=tr::NewLevel(level,name,args,is_ptrs);
     if ((*itr)->result_) {
      type::Ty* resultTy = tenv->Look((*itr)->result_);
      venv->Enter((*itr)->name_, new env::FunEntry(newLevel, name, formalTyList, resultTy));
    } else {
      venv->Enter((*itr)->name_, new env::FunEntry(newLevel, name, formalTyList, type::VoidTy::Instance()));
    }

  }
  

    for (auto itr=list->GetList().begin();itr!=list->GetList().end();itr++)
  {
    //改环境，把传入参数加入环境，翻译代码
    type::TyList * formalTyList= new type::TyList();
    for (auto itr2=(*itr)->params_->GetList().begin();itr2!=(*itr)->params_->GetList().end();itr2++)
    {
      type::Ty * ty = tenv->Look((*itr2)->typ_);
      formalTyList->Append(ty);
    }
    venv->BeginScope();
    env::EnvEntry * entry=venv->Look((*itr)->name_);
    std::list<frame::Access *> * accessList=((env::FunEntry *) entry)->level_->frame_->getFormals();
    auto aitr=accessList->begin();
    aitr++;
    auto titr=formalTyList->GetList().begin();
    for (auto itr2=(*itr)->params_->GetList().begin();itr2!=(*itr)->params_->GetList().end();itr2++)
    {
      venv->Enter((*itr2)->name_, new env::VarEntry(new tr::Access(((env::FunEntry *) entry)->level_,(*aitr)), (*titr),false));
      aitr++;
      titr++;
    }
    tr::ExpAndTy * body = (*itr)->body_->Translate(venv, tenv, ((env::FunEntry *) entry)->level_, label,errormsg);
    type::Ty *bodyTy = body->ty_;
    venv->EndScope();

    //加入frags
      tree::Stm *stm = new tree::MoveStm(new tree::TempExp(((frame::X64RegManager *)reg_manager)->ReturnValue()), body->exp_->UnEx());
      stm = frame::procEntryExit1(((env::FunEntry *) entry)->level_->frame_, stm);
      frags->PushBack(new frame::ProcFrag(stm, ((env::FunEntry *) entry)->level_->frame_));
  }
  return new tr::ExExp(new tree::ConstExp(0));
}

tr::Exp *VarDec::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                           tr::Level *level, temp::Label *label,
                           err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  tr::ExpAndTy *init = init_->Translate(venv, tenv, level, label,errormsg);
  type::Ty * initTy = init->ty_->ActualTy();
  tr::Access * access;
  bool is_ptr=0;
  //
  // int a=(typeid(*initTy)==typeid(type::ArrayTy)||typeid(*initTy)==typeid(type::RecordTy));
  // printf("varname:%s\n",var_->Name().c_str());
  // printf("var is ptr:%d",a);
  //
  if (typ_){
    auto tp=tenv->Look(typ_);
    if (typeid(*(tp->ActualTy()))==typeid(type::ArrayTy)||typeid(*(tp->ActualTy()))==typeid(type::RecordTy)){
      is_ptr=1;
      access = tr::Access::AllocLocal(level ,escape_,1);
    }
    else{
      access = tr::Access::AllocLocal(level ,escape_,0);
    }
       
  }
  else{
  if (typeid(*initTy)==typeid(type::ArrayTy)||typeid(*initTy)==typeid(type::RecordTy))
  {
     is_ptr=1;
     access = tr::Access::AllocLocal(level ,escape_,1);
  }
  else{
    
     access = tr::Access::AllocLocal(level ,escape_,0);
  }
  }
  // printf("var alloc temp:%d",((frame::InRegAccess *)(access->access_))->reg->Int());
  venv->Enter(var_, new env::VarEntry(access, initTy));
  tr::Exp * vardst;
  if (escape_)
  {
    vardst=new tr::ExExp(new tree::MemExp(new tree::BinopExp(tree::PLUS_OP,new tree::TempExp(((frame::X64RegManager *)reg_manager)->FramePointer()),new tree::ConstExp(((frame::InFrameAccess* )(access->access_))->offset)),is_ptr));
  }
  else{
    vardst=new tr::ExExp(new tree::TempExp(((frame::InRegAccess *)(access->access_))->reg,is_ptr));
  }
  return new tr::NxExp(new tree::MoveStm(vardst->UnEx(), init->exp_->UnEx()));
}

tr::Exp *TypeDec::Translate(env::VEnvPtr venv, env::TEnvPtr tenv,
                            tr::Level *level, temp::Label *label,
                            err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  absyn::NameAndTyList* list = types_;
  for (auto itr=list->GetList().begin();itr!=list->GetList().end();itr++)
  {
    tenv->Enter((*itr)->name_,new type::NameTy((*itr)->name_,nullptr));
  }
  for (auto itr=list->GetList().begin();itr!=list->GetList().end();itr++)
  {
    type::NameTy * ty=(type::NameTy *)tenv->Look((*itr)->name_);
    ty->ty_=(*itr)->ty_->Translate(tenv,errormsg);
  }
  //add gc
  for (int i=0;i<Rec_Des->size();i++){
    auto ls=(*Rec_Des)[i].ty->fields_;
    int j=0;
    for (auto field:ls->GetList()){
      
      if (typeid(*(field->ty_->ActualTy()))==typeid(type::RecordTy)||typeid(*(field->ty_->ActualTy()))==typeid(type::ArrayTy)){
        (*Rec_Des)[i].field_desc[j]=1;
        
      }
      else{
        // (*Rec_Des)[i].field_desc[j]=0;
      }
      j++;
    }
  }

  //

  return  new tr::ExExp(new tree::ConstExp(0)) ;

}

type::Ty *NameTy::Translate(env::TEnvPtr tenv, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  return new type::NameTy(name_, tenv->Look(name_));
}

type::Ty *RecordTy::Translate(env::TEnvPtr tenv,
                              err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  
  absyn::FieldList * list=record_;
  type::FieldList * tmp=new type::FieldList();
  for (auto itr=list->GetList().begin();itr!=list->GetList().end();itr++)
  {
    
    type::Ty * ts=tenv->Look((*itr)->typ_);
     if (typeid(*ts)==typeid(type::IntTy)){
        printf("int found\n");
      }
      else {
        printf("not found\n");
      }
    tmp->Append(new type::Field((*itr)->name_,ts));
  }
  type::RecordTy * res=new type::RecordTy(tmp);
  //add gc
  tr::Rec_Description Desc;
  Desc.ty=res;
  Desc.index=tr::Rec_Description::GetIdx();
  Desc.field_desc.resize(list->GetList().size());
  Rec_Des->push_back(Desc);
  //
  return res;
}

type::Ty *ArrayTy::Translate(env::TEnvPtr tenv, err::ErrorMsg *errormsg) const {
  /* TODO: Put your lab5 code here */
  return new type::ArrayTy(tenv->Look(array_));
}

} // namespace absyn
