#include "tiger/codegen/codegen.h"

#include <cassert>
#include <sstream>

extern frame::RegManager *reg_manager;
extern std::vector<assem::Gc_Root> * GC_Roots;

namespace {

constexpr int maxlen = 1024;


} // namespace

namespace cg {

void CodeGen::Codegen() {
  /* TODO: Put your lab5 code here */
  // GC_Roots=new std::vector<Gc_Root>();
  fs_ = frame_->name_->Name();
  assem::InstrList * list=new assem::InstrList();
  assem_instr_=std::unique_ptr<AssemInstr>(new cg::AssemInstr(list));
  // SaveCalleeRegs
  temp::Temp * rbx=temp::TempFactory::NewTemp();
  temp::Temp * rbp=temp::TempFactory::NewTemp();
  temp::Temp * r12=temp::TempFactory::NewTemp();
  temp::Temp * r13=temp::TempFactory::NewTemp();
  temp::Temp * r14=temp::TempFactory::NewTemp();
  temp::Temp * r15=temp::TempFactory::NewTemp();
  assem_instr_->instr_list_->Append(new assem::MoveInstr("movq `s0, `d0", new temp::TempList(rbx), new temp::TempList(((frame::X64RegManager*)(reg_manager))->RBX())));
  assem_instr_->instr_list_->Append(new assem::MoveInstr("movq `s0, `d0", new temp::TempList(rbp), new temp::TempList(((frame::X64RegManager*)(reg_manager))->RBP())));
  assem_instr_->instr_list_->Append(new assem::MoveInstr("movq `s0, `d0", new temp::TempList(r12), new temp::TempList(((frame::X64RegManager*)(reg_manager))->R12())));
  assem_instr_->instr_list_->Append(new assem::MoveInstr("movq `s0, `d0", new temp::TempList(r13), new temp::TempList(((frame::X64RegManager*)(reg_manager))->R13())));
  assem_instr_->instr_list_->Append(new assem::MoveInstr("movq `s0, `d0", new temp::TempList(r14), new temp::TempList(((frame::X64RegManager*)(reg_manager))->R14())));
  assem_instr_->instr_list_->Append(new assem::MoveInstr("movq `s0, `d0", new temp::TempList(r15), new temp::TempList(((frame::X64RegManager*)(reg_manager))->R15())));
  for (auto itr=traces_->GetStmList()->GetList().begin();itr!=traces_->GetStmList()->GetList().end();itr++)
  {
    (*itr)->Munch(*(assem_instr_->GetInstrList()),fs_);
    // (*itr)->Munch(*(list),fs_);
  }
  // RestoreCalleeRegs
  assem_instr_->instr_list_->Append(new assem::MoveInstr("movq `s0, `d0", new temp::TempList(((frame::X64RegManager*)(reg_manager))->RBX()), new temp::TempList(rbx)));
  assem_instr_->instr_list_->Append(new assem::MoveInstr("movq `s0, `d0", new temp::TempList(((frame::X64RegManager*)(reg_manager))->RBP()), new temp::TempList(rbp)));
  assem_instr_->instr_list_->Append(new assem::MoveInstr("movq `s0, `d0", new temp::TempList(((frame::X64RegManager*)(reg_manager))->R12()), new temp::TempList(r12)));
  assem_instr_->instr_list_->Append(new assem::MoveInstr("movq `s0, `d0", new temp::TempList(((frame::X64RegManager*)(reg_manager))->R13()), new temp::TempList(r13)));
  assem_instr_->instr_list_->Append(new assem::MoveInstr("movq `s0, `d0", new temp::TempList(((frame::X64RegManager*)(reg_manager))->R14()), new temp::TempList(r14)));
  assem_instr_->instr_list_->Append(new assem::MoveInstr("movq `s0, `d0", new temp::TempList(((frame::X64RegManager*)(reg_manager))->R15()), new temp::TempList(r15)));
  // assem_instr_=std::unique_ptr<AssemInstr>(new cg::AssemInstr(frame::procEntryExit2(list)));
  frame::procEntryExit2(assem_instr_->instr_list_);
}

void AssemInstr::Print(FILE *out, temp::Map *map) const {
  for (auto instr : instr_list_->GetList())
    instr->Print(out, map);
  fprintf(out, "\n");
}
} // namespace cg

namespace tree {
/* TODO: Put your lab5 code here */


void SeqStm::Munch(assem::InstrList &instr_list, std::string_view fs) {
  /* TODO: Put your lab5 code here */
  left_->Munch(instr_list,fs);
  right_->Munch(instr_list,fs);
}

void LabelStm::Munch(assem::InstrList &instr_list, std::string_view fs) {
  /* TODO: Put your lab5 code here */
  instr_list.Append(new assem::LabelInstr(label_->Name(),label_));
}

void JumpStm::Munch(assem::InstrList &instr_list, std::string_view fs) {
  /* TODO: Put your lab5 code here */
  
  instr_list.Append(new assem::OperInstr("jmp `j0",nullptr,nullptr,new assem::Targets(jumps_)));
}

void CjumpStm::Munch(assem::InstrList &instr_list, std::string_view fs) {
  /* TODO: Put your lab5 code here */
  std::string op;
  if (op_==tree::EQ_OP){op="je";}
  else if(op_==tree::NE_OP){op="jne";}
  else if (op_==tree::LT_OP){op="jl";}
  else if (op_==tree::GT_OP){op="jg";}
  else if (op_==tree::LE_OP){op="jle";}
  else if (op_==tree::GE_OP){op="jge";}
  else {
    printf("unexpected op");
    exit(1);
  }
  temp::Temp * lhs=left_->Munch(instr_list,fs);
  temp::Temp * rhs=right_->Munch(instr_list,fs);
  temp::TempList * src=new temp::TempList();
  src->Append(lhs);
  src->Append(rhs);
  std::vector<temp::Label*> *jpl=new std::vector<temp::Label*>();
  jpl->push_back(true_label_);
  jpl->push_back(false_label_);
  instr_list.Append(new assem::OperInstr("cmpq `s1, `s0",nullptr,src,nullptr));
  instr_list.Append(new assem::OperInstr(op+" `j0",nullptr,nullptr,new assem::Targets(jpl)));

}

void MoveStm::Munch(assem::InstrList &instr_list, std::string_view fs) {
  /* TODO: Put your lab5 code here */
  if (typeid(*dst_)==typeid(tree::MemExp))
  {
    tree::MemExp * me=(tree::MemExp *) dst_;
    if (typeid(*(me->exp_))==typeid(tree::BinopExp)&&((tree::BinopExp *) me->exp_)->op_ == tree::PLUS_OP
      && typeid(*(((tree::BinopExp *) me->exp_)->right_)) == typeid(tree::ConstExp))
    {
      temp::Temp * lft=((tree::BinopExp *) me->exp_)->left_->Munch(instr_list,fs);
      temp::Temp * asrc=src_->Munch(instr_list,fs);
       if (lft == reg_manager->FramePointer()) {
        temp::TempList * srcc=new temp::TempList();
        srcc->Append(asrc);
        srcc->Append(reg_manager->StackPointer());
        std::string assem_gen="movq `s0,("+std::string(fs)+"_framesize"+std::to_string(((tree::ConstExp *) ((tree::BinopExp *) me->exp_)->right_)->consti_)+")(`s1)";
        instr_list.Append(new assem::OperInstr(assem_gen,nullptr,srcc,nullptr));
      } else {
         temp::TempList * srcc=new temp::TempList();
         srcc->Append(asrc);
         srcc->Append(lft);
        std::string assem_gen ="movq `s0, "+std::to_string(((tree::ConstExp *) ((tree::BinopExp *) me->exp_)->right_)->consti_)+"(`s1)";
        instr_list.Append(new assem::OperInstr(assem_gen, nullptr,srcc,nullptr));
      }

    }
    else if (typeid(*(me->exp_))==typeid(tree::BinopExp)&&((tree::BinopExp *) me->exp_)->op_ == tree::PLUS_OP
      && typeid(*(((tree::BinopExp *) me->exp_)->left_)) == typeid(tree::ConstExp))
      {
      temp::Temp * rit=((tree::BinopExp *) me->exp_)->right_->Munch(instr_list,fs);
      temp::Temp * asrc=src_->Munch(instr_list,fs);
       if (rit == reg_manager->FramePointer()) {
        temp::TempList * srcc=new temp::TempList();
        srcc->Append(asrc);
        srcc->Append(reg_manager->StackPointer());
        std::string assem_gen="movq `s0,("+std::string(fs)+"_framesize"+std::to_string(((tree::ConstExp *) ((tree::BinopExp *) me->exp_)->left_)->consti_)+")(`s1)";
        instr_list.Append(new assem::OperInstr(assem_gen,nullptr,srcc,nullptr));
      } else {
         temp::TempList * srcc=new temp::TempList();
         srcc->Append(asrc);
         srcc->Append(rit);
        std::string assem_gen ="movq `s0,"+std::to_string(((tree::ConstExp *) ((tree::BinopExp *) me->exp_)->left_)->consti_)+"(`s1)";
        instr_list.Append(new assem::OperInstr(assem_gen, nullptr,srcc,nullptr ));
      }
      }
      else if (typeid(*src_)==typeid(tree::MemExp))
      {
      tree::Exp *dst = me->exp_, *src = ((tree::MemExp *) src_)->exp_;
      /** MOVE(MEM(e1), MEM(e2)) */
      temp::Temp * t = temp::TempFactory::NewTemp();
      temp::Temp *dsttemp = dst->Munch(instr_list,fs);
      temp::Temp *srctemp = src->Munch(instr_list,fs);
      assert(dsttemp != reg_manager->FramePointer());
      assert(srctemp != reg_manager->FramePointer());
      temp::TempList * src1=new temp::TempList();
      temp::TempList * dst1=new temp::TempList();
      src1->Append(srctemp);
      dst1->Append(t);
      temp::TempList * src2=new temp::TempList();
      temp::TempList * dst2=new temp::TempList();
      src2->Append(t);
      src2->Append(dsttemp);
      // dst2->Append(dsttemp);
      instr_list.Append(new assem::OperInstr("movq (`s0), `d0", dst1, src1,nullptr));
      instr_list.Append(new assem::OperInstr("movq `s0, (`s1)",nullptr, src2,nullptr));
      }
      else {
      tree::Exp *dst = me->exp_;
      temp::Temp *dsttemp=dst->Munch(instr_list,fs);
      temp::Temp * srctemp=src_->Munch(instr_list,fs);
      assert(dsttemp != reg_manager->FramePointer());
      assert(srctemp != reg_manager->FramePointer());
      temp::TempList * dstl=new temp::TempList();
      temp::TempList * srcl=new temp::TempList();
      // dstl->Append(dsttemp);
      srcl->Append(srctemp);
      srcl->Append(dsttemp);
      instr_list.Append(new assem::OperInstr("movq `s0, (`s1)", nullptr,srcl,nullptr));
        // this->Print(stderr,0);
        // printf("unexpected happened!");
        // exit(1);
      }
  }
  else if (typeid(*dst_)==typeid(tree::TempExp))
  {
    temp::Temp *srctmp= src_->Munch(instr_list,fs);
    if (srctmp==reg_manager->FramePointer())
    {
      temp::TempList * adst=new temp::TempList();
      temp::TempList * asrc=new temp::TempList();
      adst->Append(((tree::TempExp *)dst_)->temp_);
      asrc->Append(reg_manager->StackPointer());
      instr_list.Append(new assem::OperInstr("movq "+std::string(fs)+"_framesize(`s0), `d0",adst,asrc,nullptr));
    }
    else{
      temp::TempList * adst=new temp::TempList();
      temp::TempList * asrc=new temp::TempList();
      adst->Append(((tree::TempExp *)dst_)->temp_);
      asrc->Append(srctmp);
      instr_list.Append(new assem::MoveInstr("movq `s0, `d0",adst,asrc));
    }
  }

}

void ExpStm::Munch(assem::InstrList &instr_list, std::string_view fs) {
  /* TODO: Put your lab5 code here */
  exp_->Munch(instr_list,fs);

}

temp::Temp *BinopExp::Munch(assem::InstrList &instr_list, std::string_view fs) {
  /* TODO: Put your lab5 code here */
  temp::Temp * r=temp::TempFactory::NewTemp();
  switch(op_)
  {
    case tree::PLUS_OP:{
          
          temp::Temp *ltemp = left_->Munch(instr_list,fs);
          temp::Temp *rtemp = right_->Munch(instr_list,fs);
          assert(rtemp!=reg_manager->FramePointer());
          if (ltemp == reg_manager->FramePointer()) {
            temp::TempList * src=new temp::TempList();
            temp::TempList * dst=new temp::TempList();
            dst->Append(r);
            src->Append(reg_manager->StackPointer());
            instr_list.Append(new assem::OperInstr("leaq "+std::string(fs)+"_framesize(`s0), `d0",dst,src,nullptr));
          } else {
            temp::TempList * src=new temp::TempList();
            temp::TempList * dst=new temp::TempList();
            dst->Append(r);
            src->Append(ltemp);
            instr_list.Append(new assem::MoveInstr("movq `s0, `d0", dst, src));
          }
           temp::TempList * src=new temp::TempList();
           temp::TempList * dst=new temp::TempList();
            dst->Append(r);
            src->Append(rtemp);
            src->Append(r);
          instr_list.Append(new assem::OperInstr("addq `s0, `d0",dst, src, nullptr));
          return r;

    }
    case tree::MINUS_OP:{
       temp::Temp *ltemp = left_->Munch(instr_list,fs);
          temp::Temp *rtemp = right_->Munch(instr_list,fs);
          assert(rtemp!=reg_manager->FramePointer());
          if (ltemp == reg_manager->FramePointer()) {
            temp::TempList * src=new temp::TempList();
            temp::TempList * dst=new temp::TempList();
            dst->Append(r);
            src->Append(reg_manager->StackPointer());
            instr_list.Append(new assem::OperInstr("leaq "+std::string(fs)+"_framesize(`s0), `d0",dst,src,nullptr));
          } else {
            temp::TempList * src=new temp::TempList();
            temp::TempList * dst=new temp::TempList();
            dst->Append(r);
            src->Append(ltemp);
            instr_list.Append(new assem::MoveInstr("movq `s0, `d0", dst, src));
          }
           temp::TempList * src=new temp::TempList();
           temp::TempList * dst=new temp::TempList();
            dst->Append(r);
            src->Append(rtemp);
            src->Append(r);
          instr_list.Append(new assem::OperInstr("subq `s0, `d0",dst, src, nullptr));
          return r;

    }
    case tree::MUL_OP:{
      temp::Temp *ltemp = left_->Munch(instr_list,fs);
          temp::Temp *rtemp = right_->Munch(instr_list,fs);
          assert(ltemp!=reg_manager->FramePointer());
          assert(rtemp!=reg_manager->FramePointer());
            temp::TempList * src=new temp::TempList();
            temp::TempList * dst=new temp::TempList();
            dst->Append(reg_manager->ReturnValue());
            src->Append(ltemp);
            instr_list.Append(new assem::MoveInstr("movq `s0, `d0", dst, src));
            src=new temp::TempList();
            dst=new temp::TempList();
            dst->Append(reg_manager->ReturnValue());
            dst->Append(((frame::X64RegManager *)reg_manager)->RDX());
            src->Append(rtemp);
            src->Append(reg_manager->ReturnValue());
            instr_list.Append(new assem::OperInstr("imulq `s0",dst, src, nullptr));
            src=new temp::TempList();
            dst=new temp::TempList();
            dst->Append(r);
            src->Append(reg_manager->ReturnValue());
            instr_list.Append(new assem::MoveInstr("movq `s0, `d0",dst,src));
          return r;

    }
    case tree::DIV_OP:{
       temp::Temp *ltemp = left_->Munch(instr_list,fs);
          temp::Temp *rtemp = right_->Munch(instr_list,fs);
          assert(ltemp!=reg_manager->FramePointer());
          assert(rtemp!=reg_manager->FramePointer());
            temp::TempList * src=new temp::TempList();
            temp::TempList * dst=new temp::TempList();
            dst->Append(reg_manager->ReturnValue());
            src->Append(ltemp);
            instr_list.Append(new assem::MoveInstr("movq `s0, `d0", dst, src));
            dst=new temp::TempList();
            dst->Append(((frame::X64RegManager *)reg_manager)->RDX());
            dst->Append(reg_manager->ReturnValue());
            instr_list.Append(new assem::OperInstr("cqto",dst,new temp::TempList(reg_manager->ReturnValue()),nullptr));
            src=new temp::TempList();
            dst=new temp::TempList();
            dst->Append(reg_manager->ReturnValue());
            dst->Append(((frame::X64RegManager *)reg_manager)->RDX());
            src->Append(rtemp);
            src->Append(reg_manager->ReturnValue());
            instr_list.Append(new assem::OperInstr("idivq `s0",dst, src, nullptr));
            src=new temp::TempList();
            dst=new temp::TempList();
            dst->Append(r);
            src->Append(reg_manager->ReturnValue());
            instr_list.Append(new assem::MoveInstr("movq `s0, `d0",dst,src));
          return r;
    }
  }
}

temp::Temp *MemExp::Munch(assem::InstrList &instr_list, std::string_view fs) {
  /* TODO: Put your lab5 code here */
  temp::Temp * res=exp_->Munch(instr_list,fs);
  temp::TempList * src=new temp::TempList();
  temp::TempList * dst=new temp::TempList();
  temp::Temp * r=temp::TempFactory::NewTemp();
  src->Append(res);
  dst->Append(r);
  instr_list.Append(new assem::OperInstr("movq (`s0), `d0",dst,src,nullptr));
  return r;
  
}

temp::Temp *TempExp::Munch(assem::InstrList &instr_list, std::string_view fs) {
  /* TODO: Put your lab5 code here */
  return temp_;
}

temp::Temp *EseqExp::Munch(assem::InstrList &instr_list, std::string_view fs) {
  /* TODO: Put your lab5 code here */
  //应该被去掉？
  printf("unexpected eseqexp!");
  exit(1);
  stm_->Munch(instr_list,fs);
  temp::Temp * r=exp_->Munch(instr_list,fs);
  return r;
}

temp::Temp *NameExp::Munch(assem::InstrList &instr_list, std::string_view fs) {
  /* TODO: Put your lab5 code here */
  //用字符串常量
      temp::Temp *r = temp::TempFactory::NewTemp();
      temp::TempList * dst=new temp::TempList();
      dst->Append(r);
      instr_list.Append(new assem::OperInstr("leaq "+name_->Name()+"(%rip), `d0", dst, nullptr, nullptr));
      return r;
}

temp::Temp *ConstExp::Munch(assem::InstrList &instr_list, std::string_view fs) {
  /* TODO: Put your lab5 code here */
  temp::Temp *r = temp::TempFactory::NewTemp();
  temp::TempList * dst=new temp::TempList();
  dst->Append(r);
      instr_list.Append(new assem::OperInstr("movq $"+std::to_string(consti_)+", `d0",dst, nullptr,nullptr));
      return r;
}

temp::Temp *CallExp::Munch(assem::InstrList &instr_list, std::string_view fs) {
  /* TODO: Put your lab5 code here */
      temp::Temp *r = temp::TempFactory::NewTemp();
      std::string label = ((tree::NameExp*)(fun_))->name_->Name();
      temp::TempList * ag=args_->MunchArgs(instr_list,fs);
      std::string assem = std::string("callq ") + std::string(label);
      temp::TempList * callerSave= reg_manager->CallerSaves();
      instr_list.Append(new assem::OperInstr("callq "+label, callerSave, ag, nullptr));
      //add gc
      temp::Label * func_label=temp::LabelFactory::NewLabel();
      instr_list.Append(new assem::LabelInstr(func_label->Name(),func_label));
      assem::Gc_Root tmp;
      tmp.name="GC"+std::to_string(tmp.GetAndAddIdx());
      tmp.retaddr=func_label->Name();//唯一确定的
      tmp.stacksize=label;
      tmp.callerstacksize=std::string(fs);
      GC_Roots->push_back(tmp);
      //
      //
      int i=args_->GetList().size();
      if (i>6)
      {
        i=i-6;
      }
      else{
        i=0;
      }
      instr_list.Append(new assem::OperInstr("addq $"+std::to_string(8*i)+", %rsp",nullptr,nullptr,nullptr));

      //
      temp::TempList * src=new temp::TempList();
      temp::TempList * dst=new temp::TempList();
      src->Append(reg_manager->ReturnValue());
      dst->Append(r);
      instr_list.Append(new assem::MoveInstr("movq `s0, `d0", dst, src));
      return r;

}

temp::TempList *ExpList::MunchArgs(assem::InstrList &instr_list, std::string_view fs) {
  /* TODO: Put your lab5 code here */
  int i = 0;
  temp::TempList * returnvalue=new temp::TempList();
  for (auto itr=exp_list_.begin();itr!=exp_list_.end();itr++)
  {
    temp::Temp * arg=(*itr)->Munch(instr_list,fs);
    switch (i)
    {
       case 0: {
          if (arg == reg_manager->FramePointer()) {
            temp::TempList * src=new temp::TempList();
            temp::TempList * dst=new temp::TempList();
            src->Append(reg_manager->StackPointer());
            dst->Append(((frame::X64RegManager *)reg_manager)->RDI());
            instr_list.Append(new assem::OperInstr("leaq "+std::string(fs)+"_framesize(`s0), `d0", dst, src,nullptr));
          } else {
            temp::TempList * src=new temp::TempList();
            temp::TempList * dst=new temp::TempList();
            src->Append(arg);
            dst->Append(((frame::X64RegManager *)reg_manager)->RDI());
            instr_list.Append(new assem::MoveInstr("movq `s0, `d0", dst,src ));
          }
          returnvalue->Append(((frame::X64RegManager *)reg_manager)->RDI());
          break;
        }
        case 1: {
            temp::TempList * src=new temp::TempList();
            temp::TempList * dst=new temp::TempList();
            src->Append(arg);
            dst->Append(((frame::X64RegManager *)reg_manager)->RSI());
          assert(arg != reg_manager->FramePointer());
          instr_list.Append(new assem::MoveInstr("movq `s0, `d0", dst, src));
          returnvalue->Append(((frame::X64RegManager *)reg_manager)->RSI());
          break;
        }
        case 2: {
           temp::TempList * src=new temp::TempList();
            temp::TempList * dst=new temp::TempList();
            src->Append(arg);
            dst->Append(((frame::X64RegManager *)reg_manager)->RDX());
          assert(arg != reg_manager->FramePointer());
          instr_list.Append(new assem::MoveInstr("movq `s0, `d0", dst, src));
          returnvalue->Append(((frame::X64RegManager *)reg_manager)->RDX());
          break;
        }
        case 3: {
           temp::TempList * src=new temp::TempList();
            temp::TempList * dst=new temp::TempList();
            src->Append(arg);
            dst->Append(((frame::X64RegManager *)reg_manager)->RCX());
          assert(arg != reg_manager->FramePointer());
          instr_list.Append(new assem::MoveInstr("movq `s0, `d0", dst, src));
          returnvalue->Append(((frame::X64RegManager *)reg_manager)->RCX());
          break;
        }
        case 4: {
           temp::TempList * src=new temp::TempList();
            temp::TempList * dst=new temp::TempList();
            src->Append(arg);
            dst->Append(((frame::X64RegManager *)reg_manager)->R8());
          assert(arg != reg_manager->FramePointer());
          instr_list.Append(new assem::MoveInstr("movq `s0, `d0", dst, src));
          returnvalue->Append(((frame::X64RegManager *)reg_manager)->R8());
          break;
        }
        case 5: {
           temp::TempList * src=new temp::TempList();
            temp::TempList * dst=new temp::TempList();
            src->Append(arg);
            dst->Append(((frame::X64RegManager *)reg_manager)->R9());
          assert(arg != reg_manager->FramePointer());
          instr_list.Append(new assem::MoveInstr("movq `s0, `d0", dst, src));
          returnvalue->Append(((frame::X64RegManager *)reg_manager)->R9());
          break;
        }
        default: {
          temp::TempList * dst=new temp::TempList();
          dst->Append(reg_manager->StackPointer());
          instr_list.Append(new assem::OperInstr("subq $8, `d0", dst, nullptr,nullptr));
          temp::TempList * src=new temp::TempList();
          dst=new temp::TempList();
          dst->Append(reg_manager->StackPointer());
          src->Append(arg);
          src->Append(reg_manager->StackPointer());
          instr_list.Append(new assem::OperInstr("movq `s0, (`s1)",nullptr,src,nullptr));

          //  printf("not support more than 6 args!");
          //  exit(1);
        }
    }
    i++;
  }
  return returnvalue;
}

} // namespace tree
