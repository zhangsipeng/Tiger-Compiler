#include "tiger/frame/x64frame.h"

extern frame::RegManager *reg_manager;

namespace frame {
/* TODO: Put your lab5 code here */
// class InFrameAccess : public Access {
// public:
//   int offset;

//   explicit InFrameAccess(int offset) :Access(INFRAME),offset(offset) {}
//   /* TODO: Put your lab5 code here */
// };


// class InRegAccess : public Access {
// public:
//   temp::Temp *reg;

//   explicit InRegAccess(temp::Temp *reg) : Access(INREG),reg(reg) {}
//   /* TODO: Put your lab5 code here */
// };

// class X64Frame : public Frame {
//   /* TODO: Put your lab5 code here */
//   public:
//   static const int wordSize=8;
//   static frame::X64RegManager reg_manager;
//   virtual Access *allocLocal(bool escape);
//   static Frame * newFrame(temp::Label *name,std::list<bool> *escapes);
//   static tree::Exp *externalCall(const std::string &s, tree::ExpList *args);
//   X64Frame(){
//     formals=new std::list<Access *>();
//     locals=new std::list<Access *>();
//     viewShift=new std::list<tree::Stm *>();
//   }
 

// };
/* TODO: Put your lab5 code here */
Access *X64Frame::allocLocal(bool escape,bool is) {
  frame::Access *access;
  if (escape) {
    access = new InFrameAccess(offset,is);
    offset -= wordSize;
  } else {
    access = new InRegAccess(temp::TempFactory::NewTemp(is),is);
  }
  locals->push_back(access);
  return access;
}
tree::Stm * procEntryExit1(frame::Frame * frame,tree::Stm * stm)
{
  //把入口传参和翻译好的函数体连接起来形成整体
  tree::Stm * res=stm;
  for (auto itr=frame->viewShift->begin();itr!=frame->viewShift->end();itr++)
  {
    res=new tree::SeqStm(*itr,res);
  }
  return res;

}
assem::InstrList * procEntryExit2(assem::InstrList * il){
  temp::TempList * extra=new temp::TempList();
  extra->Append(reg_manager->ReturnValue());
  extra->Append(reg_manager->StackPointer());
  for (auto tmp:(reg_manager->CalleeSaves()->GetList())){
    extra->Append(tmp);
  }
  il->Append(new assem::OperInstr("", nullptr, extra, nullptr));
}
assem::Proc * ProcEntryExit3(frame::Frame * frame,assem::InstrList * Instr)
{
  std::string prologue = frame->name_->Name() + ":\n";
  prologue += ".set " + frame->name_->Name() + "_framesize, " + std::to_string(-frame->offset) + "\n";
  prologue += "subq $" + std::to_string(-frame->offset) + ", %rsp\n";
  //
  // int i=frame->formals->size();
  // if (i>6)
  // {
  //   i=i-6;
  // }
  // else{
  //   i=0;
  // }
  //
  std::string epilog = "addq $" + std::to_string(-frame->offset) + ", %rsp\nretq\n";
  return new assem::Proc(prologue, Instr, epilog);
}

tree::Exp *X64Frame::externalCall(const std::string &s, tree::ExpList *args) {
  bool is_ptr=0;
  if (s=="init_array"||s=="alloc_record")
  is_ptr=1;
  return new tree::CallExp(new tree::NameExp(temp::LabelFactory::NamedLabel(s)), args,is_ptr);
}

Frame *X64Frame::newFrame(temp::Label *name, std::list<bool> * escapes,std::list<bool> * is_ptrs) {
  Frame *frame = new X64Frame();
  frame->name_ = name;
  frame->offset = -wordSize;//调用者帧指针压栈
  if (!escapes)
  {
    return frame;
  }
  auto itr=escapes->begin();
  Access * access;
  if (!is_ptrs)
  {while (itr!=escapes->end())
  {
    if (*itr){
       access=new InFrameAccess(frame->offset);
      frame->offset-=wordSize;
      
    }
    else{
       access=new InRegAccess(temp::TempFactory::NewTemp());
    }
    frame->formals->push_back(access);
    itr++;
  }
  }
  else{
    auto isitr=is_ptrs->begin();
    while (itr!=escapes->end())
  {
    if (*itr){
       access=new InFrameAccess(frame->offset,(*isitr));
      frame->offset-=wordSize;
      
    }
    else{
       access=new InRegAccess(temp::TempFactory::NewTemp(*isitr));
    }
    frame->formals->push_back(access);
    itr++;
    isitr++;
  }
  }
  
  
  int i = 0;
  for (auto accessPtr = frame->formals->begin(); accessPtr!=frame->formals->end(); accessPtr++) {
    Access *access = (*accessPtr);
    tree::Exp *dstExp;
    if (access->kind == Access::INFRAME) {
      dstExp = new tree::MemExp(new tree::BinopExp(tree::PLUS_OP, new tree::TempExp(((frame::X64RegManager *)reg_manager)->FramePointer()), new tree::ConstExp(((frame::InFrameAccess *) access)->offset)));
    } else {
      dstExp = new tree::TempExp(((frame::InRegAccess *) access)->reg);
    }
    tree::Stm *stm;
    switch (i) {
      case 0: {
        stm = new tree::MoveStm(dstExp, new tree::TempExp(((frame::X64RegManager *)reg_manager)->RDI()));
        break;
      }
      case 1: {
        stm = new tree::MoveStm(dstExp, new tree::TempExp(((frame::X64RegManager *)reg_manager)->RSI()));
        break;
      }
      case 2: {
        stm = new tree::MoveStm(dstExp, new tree::TempExp(((frame::X64RegManager *)reg_manager)->RDX()));
        break;
      }
      case 3: {
        stm = new tree::MoveStm(dstExp, new tree::TempExp(((frame::X64RegManager *)reg_manager)->RCX()));
        break;
      }
      case 4: {
        stm = new tree::MoveStm(dstExp, new tree::TempExp(((frame::X64RegManager *)reg_manager)->R8()));
        break;
      }
      case 5: {
        stm = new tree::MoveStm(dstExp, new tree::TempExp(((frame::X64RegManager *)reg_manager)->R9()));
        break;
      }
      default: {
        int size=frame->formals->size();
        stm = new tree::MoveStm(dstExp, new tree::MemExp(new tree::BinopExp(tree::BinOp::PLUS_OP, new tree::TempExp(((frame::X64RegManager *)reg_manager)->FramePointer()), new tree::ConstExp((size-i) * frame::X64Frame::wordSize))));
        break;
      }
    }
   frame->viewShift->push_back(stm);
    i++;
  }
  return frame;
}

} // namespace frame