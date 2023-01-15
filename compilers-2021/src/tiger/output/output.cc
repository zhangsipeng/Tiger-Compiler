#include "tiger/output/output.h"

#include <cstdio>

#include "tiger/output/logger.h"

extern frame::RegManager *reg_manager;
extern frame::Frags *frags;
extern std::vector<assem::Gc_Root> * GC_Roots;
extern std::vector<tr::Rec_Description> * Rec_Des;

namespace output {
void AssemGen::GenAssem(bool need_ra) {
  frame::Frag::OutputPhase phase;

  // Output proc
  phase = frame::Frag::Proc;
  fprintf(out_, ".text\n");
  for (auto &&frag : frags->GetList())
    frag->OutputAssem(out_, phase, need_ra);

  // Output string
  phase = frame::Frag::String;
  fprintf(out_, ".section .rodata\n");
  for (auto &&frag : frags->GetList())
    frag->OutputAssem(out_, phase, need_ra);
    //add gc Record_Dec
    fprintf(out_, ".globl %s\n", "GLOBAL_REC_DEC");
    fprintf(out_, "%s\n", "GLOBAL_REC_DEC:");
    for (int i=0;i<Rec_Des->size();i++){
      auto Rec=(*Rec_Des)[i];
      fprintf(out_, "%s\n", ("REC_"+std::to_string(Rec.index)+":").data());
      if (i+1<Rec_Des->size())
      fprintf(out_, ".quad %s\n",("REC_"+std::to_string((*Rec_Des)[i+1].index)).data());//next
      else
      fprintf(out_, ".quad %s\n","-1");
      for (auto rep:Rec.field_desc){
        fprintf(out_, ".quad %d\n",rep);
      }
      fprintf(out_, ".quad %s\n","-1");
      
    }
    //
    //add gc
  fprintf(out_, ".globl %s\n", "GLOBAL_GC_ROOTS");
  fprintf(out_, "%s\n", "GLOBAL_GC_ROOTS:");
     for (int i=0;i<GC_Roots->size();i++){
      fprintf(out_, "%s:\n",(*GC_Roots)[i].name.data());

      if (i+1<GC_Roots->size())
      fprintf(out_, ".quad %s\n",(*GC_Roots)[i+1].name.data());//next
      else
      fprintf(out_, ".quad %s\n","-1");

      fprintf(out_, ".quad %s\n",(*GC_Roots)[i].retaddr.data());//retaddr
      fprintf(out_, ".quad %s\n",((*GC_Roots)[i].callerstacksize+"_framesize").data());//stacksize
      for (auto itr1:(*GC_Roots)[i].stackPtr){
        fprintf(out_, ".quad %s\n",((*GC_Roots)[i].callerstacksize+"_framesize"+std::to_string(itr1)).data());
      }
      // fprintf(out_, ".quad -1\n");
      // for (auto itr2:(*GC_Roots)[i].RegPtr){
      //  fprintf(out_, ".quad %d\n",itr2);
      // }
      fprintf(out_, ".quad -1\n");
    }
  //
}

} // namespace output

namespace frame {

void ProcFrag::OutputAssem(FILE *out, OutputPhase phase, bool need_ra) const {
  std::unique_ptr<canon::Traces> traces;
  std::unique_ptr<cg::AssemInstr> assem_instr;
  std::unique_ptr<ra::Result> allocation;

  // When generating proc fragment, do not output string assembly
  if (phase != Proc)
    return;

  TigerLog("-------====IR tree=====-----\n");
  TigerLog(body_);

  {
    // Canonicalize
    TigerLog("-------====Canonicalize=====-----\n");
    canon::Canon canon(body_);

    // Linearize to generate canonical trees
    TigerLog("-------====Linearlize=====-----\n");
    tree::StmList *stm_linearized = canon.Linearize();
    TigerLog(stm_linearized);

    // Group list into basic blocks
    TigerLog("------====Basic block_=====-------\n");
    canon::StmListList *stm_lists = canon.BasicBlocks();
    TigerLog(stm_lists);

    // Order basic blocks into traces_
    TigerLog("-------====Trace=====-----\n");
    tree::StmList *stm_traces = canon.TraceSchedule();
    TigerLog(stm_traces);

    traces = canon.TransferTraces();
  }

  temp::Map *color = temp::Map::LayerMap(reg_manager->temp_map_, temp::Map::Name());
  {
    // Lab 5: code generation
    TigerLog("-------====Code generate=====-----\n");
    cg::CodeGen code_gen(frame_, std::move(traces));
    code_gen.Codegen();
    assem_instr = code_gen.TransferAssemInstr();
    TigerLog(assem_instr.get(), color);
  }

  assem::InstrList *il = assem_instr.get()->GetInstrList();
  //add gc
  // std::vector<temp::Temp *> Add_ptr;
  // for (auto instr_:il->GetList()){
  //    if (typeid(*instr_)==typeid(assem::MoveInstr)){
  //      auto instr=(assem::MoveInstr *)instr_;
  //      auto src=instr->src_->GetList().begin();
  //      auto dst=instr->dst_->GetList().begin();
  //      if (instr->src_->GetList().size()!=1||instr->dst_->GetList().size()!=1)
  //      {
  //        printf("bad move!\n");
  //        exit(1);
  //      }
  //      if ((*src)->is_ptr&&!(reg_manager->Is_precolored(*dst))){
  //        Add_ptr.push_back(*dst);
  //      }
  //    }
  // }
  // for (auto j:Add_ptr){
  //   j->is_ptr=1;
  // }
  //
  
  if (need_ra) {
    // Lab 6: register allocation
    TigerLog("----====Register allocate====-----\n");
    ra::RegAllocator reg_allocator(frame_, std::move(assem_instr));
    reg_allocator.RegAlloc();
    allocation = reg_allocator.TransferResult();
    il = allocation->il_;
    color = temp::Map::LayerMap(reg_manager->temp_map_, allocation->coloring_);
     for (auto pi = il->GetList().begin(); pi!=il->GetList().end(); pi++) {
    assem::Instr * instr_=(*pi);
    std::string sub="call";
      if (typeid(*(instr_))==typeid(assem::OperInstr)&& ((assem::OperInstr*)instr_)->assem_.find(sub)!=std::string::npos){
        pi++;
        assert(typeid(*(*pi))==typeid(assem::LabelInstr));
        assem::Instr * labelinstr_=(*pi);
        int callee;
        for (int i=0;i<GC_Roots->size();i++){
          if ((*GC_Roots)[i].retaddr==((assem::LabelInstr*)labelinstr_)->assem_){
            for (auto tmp:(*GC_Roots)[i].tmpArr){
              std::string * reg_alloc=color->Look(tmp);
              if ((*reg_alloc)=="%rdx"||(*reg_alloc)=="%rbp"||(*reg_alloc)=="%r12"||(*reg_alloc)=="%r13"||(*reg_alloc)=="%r14"||(*reg_alloc)=="%r15"){
                auto addinstr=--pi;
                pi++;
                frame_->offset-=8;
                std::string addassem="movq "+(*reg_alloc)+",("+(*GC_Roots)[i].callerstacksize+"_framesize"+std::to_string(frame_->offset)+")(%rsp)";
                il->Insert(addinstr,new assem::OperInstr(addassem,nullptr,nullptr,nullptr));
                (*GC_Roots)[i].stackPtr.push_back(frame_->offset);
              }
            }
          }
        }

      }
    }
    //  for (int i=0;i<GC_Roots->size();i++){
    //   for (auto por=(*GC_Roots)[i].tmpArr.begin();por!=(*GC_Roots)[i].tmpArr.end();por++){
    //     std::string * reg_alloc=color->Look((*por));
    //     if ((*reg_alloc)=="%rdx"){
    //       (*GC_Roots)[i].RegPtr[0]=1;
    //     }else if ((*reg_alloc)=="%rbp"){
    //       (*GC_Roots)[i].RegPtr[1]=1;

    //     }
    //     else if ((*reg_alloc)=="%r12"){
    //       (*GC_Roots)[i].RegPtr[2]=1;
    //     }
    //     else if ((*reg_alloc)=="%r13"){
    //       (*GC_Roots)[i].RegPtr[3]=1;
    //     }
    //     else if ((*reg_alloc)=="%r14"){
    //       (*GC_Roots)[i].RegPtr[4]=1;
    //     }
    //     else if ((*reg_alloc)=="%r15"){
    //       (*GC_Roots)[i].RegPtr[5]=1;
    //     }
    //   }
    // }
  }

  TigerLog("-------====Output assembly for %s=====-----\n",
           frame_->name_->Name().data());

  assem::Proc *proc = frame::ProcEntryExit3(frame_, il);
  
  std::string proc_name = frame_->GetLabel();

  fprintf(out, ".globl %s\n", proc_name.data());
  fprintf(out, ".type %s, @function\n", proc_name.data());
  // prologue
  fprintf(out, "%s", proc->prolog_.data());
  // body
  proc->body_->Print(out, color);
  // epilog_
  fprintf(out, "%s", proc->epilog_.data());
  fprintf(out, ".size %s, .-%s\n", proc_name.data(), proc_name.data());
}

void StringFrag::OutputAssem(FILE *out, OutputPhase phase, bool need_ra) const {
  // When generating string fragment, do not output proc assembly
  if (phase != String)
    return;

  fprintf(out, "%s:\n", label_->Name().data());
  int length = static_cast<int>(str_.size());
  // It may contain zeros in the middle of string. To keep this work, we need
  // to print all the charactors instead of using fprintf(str)
  fprintf(out, ".long %d\n", length);
  fprintf(out, ".string \"");
  for (int i = 0; i < length; i++) {
    if (str_[i] == '\n') {
      fprintf(out, "\\n");
    } else if (str_[i] == '\t') {
      fprintf(out, "\\t");
    } else if (str_[i] == '\"') {
      fprintf(out, "\\\"");
    } else {
      fprintf(out, "%c", str_[i]);
    }
  }
  fprintf(out, "\"\n");
}
} // namespace frame
