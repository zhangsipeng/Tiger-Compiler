#include "tiger/liveness/liveness.h"
#include <set>

extern frame::RegManager *reg_manager;
extern std::vector<assem::Gc_Root> * GC_Roots;

namespace live {

bool MoveList::Contain(INodePtr src, INodePtr dst) {
  return std::any_of(move_list_.cbegin(), move_list_.cend(),
                     [src, dst](std::pair<INodePtr, INodePtr> move) {
                       return move.first == src && move.second == dst;
                     });
}

void MoveList::Delete(INodePtr src, INodePtr dst) {
  assert(src && dst);
  auto move_it = move_list_.begin();
  for (; move_it != move_list_.end(); move_it++) {
    if (move_it->first == src && move_it->second == dst) {
      break;
    }
  }
  move_list_.erase(move_it);
}

MoveList *MoveList::Union(MoveList *list) {
  auto *res = new MoveList();
  for (auto move: move_list_)
  {
    res->move_list_.push_back(move);
  }
  if (list)
  {
    for (auto move : list->GetList()) {
    if (!Contain(move.first, move.second))
      res->move_list_.push_back(move);
  }
  }
  return res;
}

MoveList *MoveList::Intersect(MoveList *list) {
  
  auto *res = new MoveList();
  if (!list) return res;
  for (auto move : list->GetList()) {
    if (Contain(move.first, move.second))
      res->move_list_.push_back(move);
  }
  return res;
}
bool contains(temp::TempList *list, temp::Temp *temp) {
  if (!list) return false;
  for (auto p = list->GetList().begin(); p!=list->GetList().end(); p++) {
    if ((*p) == temp) {
      return true;
    }
  }
  return false;
}

temp::TempList *Union(temp::TempList *lhs, temp::TempList *rhs) {
  temp::TempList *result = new temp::TempList();
  if (lhs)
  {for (auto p = lhs->GetList().begin(); p!=lhs->GetList().end(); p++) {
    if (!contains(result, (*p))) {
      result->Append((*p));
    }
  }
  }
  if (rhs)
  {
  for (auto p = rhs->GetList().begin(); p!=rhs->GetList().end(); p++) {
    if (!contains(result, (*p))) {
      result->Append((*p));
    }
  }
  }

  return result;
}

temp::TempList *Subtract(temp::TempList *lhs, temp::TempList *rhs) {
  temp::TempList *result = new temp::TempList();
  if (lhs)
  {
    for (auto p = lhs->GetList().begin(); p!=lhs->GetList().end(); p++) {
    if (!contains(rhs, (*p))) {
      result->Append((*p));
    }
  }
  }
  return result;
}

bool equal(temp::TempList *lhs, temp::TempList *rhs) {
  std::set<int> setlhs, setrhs;
  if (!lhs||!rhs)
  {
    return lhs==rhs;
  }
  for (auto p = lhs->GetList().begin(); p!=lhs->GetList().end(); p++) {
    setlhs.insert((*p)->Int());
  }

   for (auto p = rhs->GetList().begin(); p!=rhs->GetList().end(); p++) {
    setrhs.insert((*p)->Int());
  }

  return setlhs == setrhs;
}


void LiveGraphFactory::LiveMap() {
  /* TODO: Put your lab6 code here */
  //
  temp::Map * co=temp::Map::LayerMap(reg_manager->temp_map_, temp::Map::Name());
  //
   for (auto p = flowgraph_->Nodes()->GetList().begin(); p!=flowgraph_->Nodes()->GetList().end(); p++) {
      in_->Enter((*p),nullptr);
      out_ ->Enter((*p),nullptr);
    }

  while (true) {
    bool flag=false;
    for (auto p = flowgraph_->Nodes()->GetList().begin(); p!=flowgraph_->Nodes()->GetList().end(); p++) {
      temp::TempList *defs = (*p)->NodeInfo()->Def();
      temp::TempList *uses = (*p)->NodeInfo()->Use();
      temp::TempList * old_in=in_->Look((*p));
      temp::TempList * new_in=Union(uses,Subtract(out_->Look((*p)),defs));
      if (!equal(old_in,new_in))
      {
        // printf("1 diffs!\n");
        flag=true;
      }
      //
      if (old_in)
      delete old_in;
      //
      in_->Set((*p),new_in);
      temp::TempList * old_out=out_->Look((*p));
      temp::TempList * res=nullptr;
      for (auto itr = (*p)->Succ()->GetList().begin(); itr!=(*p)->Succ()->GetList().end(); itr++) {
        res = Union(res, in_->Look((*itr)));
      }
      if (!equal(old_out,res))
      {
        // printf("2 diffs!\n");
        flag=true;
      }
      if (old_out)
      delete old_out;
      out_->Set((*p),res);
    }
    //log
    // for (auto p = flowgraph_->Nodes()->GetList().begin(); p!=flowgraph_->Nodes()->GetList().end(); p++) {
    //   auto y=(*p)->NodeInfo();
    //   if (typeid(*y)==typeid(assem::LabelInstr)&&(((assem::LabelInstr*)y)->assem_=="L80")){
    //     printf("L80:\n");
    //     for (auto x:out_->Look((*p))->GetList()){
    //        printf("out var: %d\n",x->Int());
    //     }
    //   }
    //   if (typeid(*y)==typeid(assem::MoveInstr)&&(((assem::MoveInstr*)y)->assem_.find("movq t275")!=std::string::npos)){
    //      printf("movq t275, %rsi:\n");
    //     for (auto x:in_->Look((*p))->GetList()){
    //        printf("in var: %d\n",x->Int());
    //     }
    //   }
    // }
    //
    
    
 
    printf("do one time!\n");
    if (!flag) {
      break;
    }
  }
  //log
    //  in_->Dump([co](graph::Node<assem::Instr> * is,temp::TempList * list){
    //   is->NodeInfo()->Print(co);
    //   if (list)
    //   {
    //     printf("in_ variable:");
    //     for (auto tmp:list->GetList()){
    //       printf("%d ",tmp->Int());
    //     }
    //     printf("\n");
    //   }
    // });
    //   out_->Dump([co](graph::Node<assem::Instr> * is,temp::TempList * list){
    //  is->NodeInfo()->Print(co);
    //   if (list)
    //   {
    //     printf("out_ variable:");
    //     for (auto tmp:list->GetList()){
    //       printf("%d ",tmp->Int());
    //     }
    //     printf("\n");
    //   }
    // });
    //log


  for (auto p = flowgraph_->Nodes()->GetList().begin(); p!=flowgraph_->Nodes()->GetList().end(); p++) {
    assem::Instr * instr_=(*p)->NodeInfo();
    std::string sub="call";
      if (typeid(*(instr_))==typeid(assem::OperInstr)&& ((assem::OperInstr*)instr_)->assem_.find(sub)!=std::string::npos){
        p++;
        assert(typeid(*((*p)->NodeInfo()))==typeid(assem::LabelInstr));
        assem::Instr * labelinstr_=(*p)->NodeInfo();
        for (int i=0;i<GC_Roots->size();i++){
          if ((*GC_Roots)[i].retaddr==((assem::LabelInstr*)labelinstr_)->assem_){
            temp::TempList * outvar=out_->Look((*p));
            auto formal_list=frame->formals;
            auto local_list=frame->locals;
            // printf("return label:%s\n",(*GC_Roots)[i].retaddr.c_str());
            for (auto tmp:outvar->GetList()){
              //
              
              // printf("out var: %d\n",tmp->Int());
              if (tmp->is_ptr)
              (*GC_Roots)[i].tmpArr.push_back(tmp);
              //
              for (auto itr=formal_list->begin();itr!=formal_list->end();itr++){
                 if (typeid((*itr))==typeid(frame::InFrameAccess)&&((frame::InFrameAccess*)(*itr))->is_ptr){
                  (*GC_Roots)[i].stackPtr.push_back(((frame::InFrameAccess*)(*itr))->offset);
                }
                // if (typeid((*itr))==typeid(frame::InRegAccess)&&((frame::InRegAccess*)(*itr))->reg==tmp&&((frame::InRegAccess*)(*itr))->is_ptr){
                //   (*GC_Roots)[i].tmpArr.push_back(tmp);
                // }
              }
              // printf("prepare to enter!\n");
               for (auto itr=local_list->begin();itr!=local_list->end();itr++){
                 //
                 //  if (typeid((*itr))==typeid(frame::InRegAccess)){
                 //   printf("local tmp:%s,isptr:%d\n",((frame::InRegAccess*)(*itr))->reg->Int(),((frame::InRegAccess*)(*itr))->is_ptr);
                 // }
                 //
                   if (typeid((*itr))==typeid(frame::InFrameAccess)&&((frame::InFrameAccess*)(*itr))->is_ptr){
                  (*GC_Roots)[i].stackPtr.push_back(((frame::InFrameAccess*)(*itr))->offset);
                }
                // if (typeid((*itr))==typeid(frame::InRegAccess)&&((frame::InRegAccess*)(*itr))->reg==tmp&&((frame::InRegAccess*)(*itr))->is_ptr){
                //   (*GC_Roots)[i].tmpArr.push_back(tmp);
                // }
              }
              // printf("already leave!\n");

            }
            break;
          }
        }

      }
    }
  
}


void LiveGraphFactory::InterfGraph() {
  /* TODO: Put your lab6 code here */
  //加入机器寄存器
  for (temp::Temp *temp1 : reg_manager->Registers()->GetList()) {
    for (temp::Temp *temp2 : reg_manager->Registers()->GetList()) {
      graph::Node<temp::Temp> *temp1Node = GetNode(temp1);
      graph::Node<temp::Temp> *temp2Node = GetNode(temp2);
      if (temp1Node != temp2Node) {
        live_graph_.interf_graph->AddEdge(temp1Node,temp2Node);
        live_graph_.interf_graph->AddEdge(temp2Node,temp1Node);
        
      }
    }
  }
  //
  for (auto p = flowgraph_->Nodes()->GetList().begin(); p!=flowgraph_->Nodes()->GetList().end(); p++) {
    temp::TempList *defs = (*p)->NodeInfo()->Def();
    temp::TempList *uses = (*p)->NodeInfo()->Use();
    if (typeid(*((*p)->NodeInfo()))==typeid(assem::MoveInstr) && defs && uses) {
      graph::Node<temp::Temp> *srcNode = GetNode(uses->GetList().front());
      graph::Node<temp::Temp> *dstNode = GetNode( defs->GetList().front());
      live_graph_.moves->Append(srcNode,dstNode);
      for (auto q = out_->Look((*p))->GetList().begin(); q!=out_->Look((*p))->GetList().end();q++) {
        if ((*q) == uses->GetList().front()) {
          continue;
        }
        graph::Node<temp::Temp> *outNode = GetNode((*q));
        if (dstNode != outNode) {
         live_graph_.interf_graph->AddEdge(dstNode, outNode);
         live_graph_.interf_graph->AddEdge(outNode, dstNode);
        }
      }
    } else {
      if (!defs) continue;
      for (auto q=defs->GetList().begin(); q!=defs->GetList().end(); q++) {
        for (auto r = out_->Look((*p))->GetList().begin(); r!=out_->Look((*p))->GetList().end(); r++) {
          graph::Node<temp::Temp> *dstNode = GetNode(*(q));
          graph::Node<temp::Temp> *outNode = GetNode(*(r));
          if (dstNode != outNode) {
           live_graph_.interf_graph->AddEdge(dstNode, outNode);
          live_graph_.interf_graph->AddEdge(outNode, dstNode);
          }
        }
      }
    }
  }
  //
  for (auto p = flowgraph_->Nodes()->GetList().begin(); p!=flowgraph_->Nodes()->GetList().end(); p++) {
    temp::TempList *defs = (*p)->NodeInfo()->Def();
    temp::TempList *uses = (*p)->NodeInfo()->Use();
    for (auto q = defs->GetList().begin(); q!=defs->GetList().end(); q++) {
      (*(live_graph_.priority))[(*q)]++;
    }
    for (auto q = uses->GetList().begin(); q!= uses->GetList().end(); q++) {
      (*(live_graph_.priority))[(*q)]++;
    }
  }
  for (auto p = live_graph_.interf_graph->Nodes()->GetList().begin(); p!=live_graph_.interf_graph->Nodes()->GetList().end(); p++) {
    (*(live_graph_.priority))[(*p)->NodeInfo()]/=(*p)->Degree();
  }
  //


}

void LiveGraphFactory::Liveness() {
  LiveMap();
  printf("livemap done\n");
  InterfGraph();
  printf("interfgraph done\n");
}

} // namespace live