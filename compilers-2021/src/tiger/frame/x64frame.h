//
// Created by wzl on 2021/10/12.
//

#ifndef TIGER_COMPILER_X64FRAME_H
#define TIGER_COMPILER_X64FRAME_H

#include "tiger/frame/frame.h"

namespace frame {
  class InFrameAccess : public Access {
public:
  int offset;

  explicit InFrameAccess(int offset,bool is=0) :Access(INFRAME,is),offset(offset) {}
  /* TODO: Put your lab5 code here */
};


class InRegAccess : public Access {
public:
  temp::Temp *reg;

  explicit InRegAccess(temp::Temp *reg,bool is=0) : Access(INREG,is),reg(reg) {}
  /* TODO: Put your lab5 code here */
};
class X64RegManager : public RegManager {
  /* TODO: Put your lab5 code here */
  public:
  X64RegManager()
  {
    colors=new std::vector<std::string>();
    temp_map_= temp::Map::Empty();
    temp::Temp * regtmp;
     regtmp=temp::TempFactory::NewTemp();
    temp_map_->Enter(regtmp,new std::string("%rax"));
    colors->push_back("%rax");
    regs_.push_back(regtmp);
     regtmp=temp::TempFactory::NewTemp();
    temp_map_->Enter(regtmp,new std::string("%rbx"));
    colors->push_back("%rbx");
    regs_.push_back(regtmp);
    regtmp=temp::TempFactory::NewTemp();
    temp_map_->Enter(regtmp,new std::string("%rcx"));
    colors->push_back("%rcx");
    regs_.push_back(regtmp);
     regtmp=temp::TempFactory::NewTemp();
    temp_map_->Enter(regtmp,new std::string("%rdx"));
    colors->push_back("%rdx");
    regs_.push_back(regtmp);
     regtmp=temp::TempFactory::NewTemp();
    temp_map_->Enter(regtmp,new std::string("%rsi"));
    colors->push_back("%rsi");
    regs_.push_back(regtmp);
     regtmp=temp::TempFactory::NewTemp();
    temp_map_->Enter(regtmp,new std::string("%rdi"));
    colors->push_back("%rdi");
    regs_.push_back(regtmp);
    regtmp=temp::TempFactory::NewTemp();
    temp_map_->Enter(regtmp,new std::string("%rbp"));
    colors->push_back("%rbp");
    regs_.push_back(regtmp);
     regtmp=temp::TempFactory::NewTemp();
    temp_map_->Enter(regtmp,new std::string("%rsp"));
    // colors->push_back("%rsp");
    regs_.push_back(regtmp);
    for (int i=8;i<=15;i++)
    {
      std::string *name=new std::string("%r"+std::to_string(i));
      regtmp=temp::TempFactory::NewTemp();
    temp_map_->Enter(regtmp,name);
    colors->push_back(*name);
    regs_.push_back(regtmp);
    }
   
  }
    temp::TempList *Registers() {
      temp::TempList * tmp=new temp::TempList();
      for (int i=0;i<regs_.size();i++)
      {
        tmp->Append(regs_[i]);
      }
      return tmp;
   };
   temp::TempList * Registers_rsp(){
      temp::TempList * tmp=new temp::TempList();
      for (int i=0;i<regs_.size();i++)
      {
        if (i!=7)
        tmp->Append(regs_[i]);
      }
      return tmp;
   }
   std::vector<std::string> * Colors()
   {
     return colors;
   }

   temp::TempList *ArgRegs(){
    static temp::TempList * tmp=new temp::TempList();
     for (int i=5;i>=2;i--)
     {
       tmp->Append(regs_[i]);
     }
     tmp->Append(regs_[8]);
     tmp->Append(regs_[9]);
     return tmp;

  };
  bool Is_precolored(temp::Temp * tmp){
    for (auto j:regs_){
      if (j==tmp){
        return true;
      }
    }
    return false;
  }
  


   temp::TempList *CallerSaves() {
    static temp::TempList * tmp=new temp::TempList();
     tmp->Append(regs_[0]);
     tmp->Append(regs_[4]);
     tmp->Append(regs_[5]);
     tmp->Append(regs_[2]);
     tmp->Append(regs_[3]);
     tmp->Append(regs_[8]);
     tmp->Append(regs_[9]);
     tmp->Append(regs_[10]);
     tmp->Append(regs_[11]);
     return tmp;

  };


   temp::TempList *CalleeSaves(){
    static temp::TempList * tmp=new temp::TempList();
     tmp->Append(regs_[1]);
     tmp->Append(regs_[6]);
     tmp->Append(regs_[12]);
     tmp->Append(regs_[13]);
     tmp->Append(regs_[14]);
     tmp->Append(regs_[15]);
     return tmp;

  };

 
   temp::TempList *ReturnSink(){

  };

  
   int WordSize() {
     return 8;

  };

  temp::Temp *FramePointer() {
    return regs_[6];

  };

   temp::Temp *StackPointer() {
     return regs_[7];

  };

   temp::Temp *ReturnValue() {
     return regs_[0];

  };
   temp::Temp * RDI() {
     return regs_[5];

  };
   temp::Temp * RSI() {
     return regs_[4];

  };
   temp::Temp * RDX() {
     return regs_[3];

  };
  temp::Temp * RBX(){
    return regs_[1];
  }
  temp::Temp *RBP(){
    return regs_[6];
  }
   temp::Temp * RCX() {
     return regs_[2];

  };
   temp::Temp * R8() {
     return regs_[8];

  };
   temp::Temp * R9() {
     return regs_[9];

  };
   temp::Temp * R12() {
     return regs_[12];

  };
   temp::Temp * R13() {
     return regs_[13];

  };
   temp::Temp * R14() {
     return regs_[14];

  };
   temp::Temp * R15() {
     return regs_[15];

  };



};
class X64Frame : public Frame {
  /* TODO: Put your lab5 code here */
  public:
  static const int wordSize=8;
  // static frame::X64RegManager reg_manager;
  virtual Access *allocLocal(bool escape,bool is=0);
  static Frame * newFrame(temp::Label *name,std::list<bool> *escapes,std::list<bool> * is_ptrs=nullptr);
  static tree::Exp *externalCall(const std::string &s, tree::ExpList *args);
  X64Frame(){
    formals=new std::list<Access *>();
    locals=new std::list<Access *>();
    viewShift=new std::list<tree::Stm *>();
    // offset_ptr=new std::vector<int>();
  }
 

};

} // namespace frame
#endif // TIGER_COMPILER_X64FRAME_H
