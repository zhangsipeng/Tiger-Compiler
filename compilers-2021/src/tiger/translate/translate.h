#ifndef TIGER_TRANSLATE_TRANSLATE_H_
#define TIGER_TRANSLATE_TRANSLATE_H_

#include <list>
#include <memory>

#include "tiger/absyn/absyn.h"
#include "tiger/env/env.h"
#include "tiger/errormsg/errormsg.h"
#include "tiger/frame/frame.h"
#include "tiger/semant/types.h"

static int Global_idx=0;
namespace tr {
   class Rec_Description{
    public:
    type::RecordTy * ty;
    std::vector<int> field_desc;
    int index;
    static int GetIdx(){
      Global_idx++;
      return Global_idx;
    }
  };

class Exp;
class ExpAndTy;
class Level;

class Access {
public:
  Level *level_;
  frame::Access *access_;

  Access(Level *level, frame::Access *access)
      : level_(level), access_(access) {}
  static Access *AllocLocal(Level *level, bool escape,bool is=0);
};

class Level {
public:
  frame::Frame *frame_;
  Level *parent_;

  /* TODO: Put your lab5 code here */
  static Level *NewLevel(Level *parent,temp::Label * name,std::list<bool> *formals);
  Level(frame::Frame * frame,Level * parent)
  {
    frame_=frame;
    parent_=parent;
  }
};

class ProgTr {
public:
  // TODO: Put your lab5 code here */
  ProgTr(std::unique_ptr<absyn::AbsynTree> absyn_tree,std::unique_ptr<err::ErrorMsg> errormsg);
// {
//   frags=new frame::Frags();
//   main_level_=Outermost();
//   tenv_=new env::TEnv();
//   venv_=new env::VEnv();
//   tenv_->FillBaseTEnv();
//   venv_->FillBaseVEnv();
//   absyn_tree_->Translate(venv_,tenv_,main_level_,null,errormsg_);
// }
  /**
   * Translate IR tree
   */
  void Translate();

  /**
   * Transfer the ownership of errormsg to outer scope
   * @return unique pointer to errormsg
   */
  std::unique_ptr<err::ErrorMsg> TransferErrormsg() {
    return std::move(errormsg_);
  }


private:
  std::unique_ptr<absyn::AbsynTree> absyn_tree_;
  std::unique_ptr<err::ErrorMsg> errormsg_;
  std::unique_ptr<Level> main_level_;
  std::unique_ptr<env::TEnv> tenv_;
  std::unique_ptr<env::VEnv> venv_;
  //  Level* main_level_;
  // env::TEnv * tenv_;
  // env::VEnv * venv_;

  // frame::Frags * frags;

  // Fill base symbol for var env and type env
  void FillBaseVEnv();
  void FillBaseTEnv();
};

} // namespace tr

#endif
