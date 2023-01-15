#include "heap.h"

namespace gc
{
  
    
    // class Myheap :public TigerHeap{
        // public:
        char * Myheap::Allocate(uint64_t size){
            char * res=nullptr;
            for (auto itr=free_heap.begin();itr!=free_heap.end();itr++){
                if ((*itr).size>=size){
                    res=(*itr).start;
                    Used_heap.push_back(Seg((*itr).start,size));
                    if ((*itr).size>size)
                    {
                        free_heap.erase(itr);
                        Seg remain(((*itr).start+size),(*itr).size-size);
                        free_heap.push_back(remain);
                        
                    }
                    else {
                        free_heap.erase(itr);
                    }
                    break;
                }
            }
            return res;

        }
        uint64_t Myheap::Used() const{
            int total=0;
            for (auto tmp:Used_heap){
                total+=tmp.size;
            }
            return total;
        }
        uint64_t Myheap::MaxFree() const{
            int max=0;
            for (auto tmp:free_heap){
                if (tmp.size>max){
                    max=tmp.size;
                }
            }
            return max;

        }
        void Myheap::Initialize(uint64_t size){
            heap=new char[size];
            free_heap.push_back(Seg(heap,size));
        }
        void Myheap::GC(){
            unsigned long *sp;
            GET_TIGER_STACK(sp);
            std::vector<Seg> new_Used;
            // printf("%ld\n",*(sp));
            // printf("%ld\n",*(sp+1));
            // printf("%ld\n",*(sp+2));
            // printf("%ld\n",*(sp+3));
            // printf("%ld\n",*(sp+4));
            // printf("%ld\n",*(sp+5));
            // printf("%ld\n",*(sp+6));
            // printf("%ld\n",*(sp+7));
            // printf("%ld\n",*(u_int64_t *)(*(sp+2)));
            bool flag=false;
            std::set<uint64_t *> ptr_addr;
            Loop:
            uint64_t retaddr=*(sp);
            uint64_t * Roots=&GLOBAL_GC_ROOTS;
            while (*(Roots+1)!=retaddr){
                if (*(Roots)==-1){
                    flag=true;//找完了没有retaddr说明到了最外层
                    break;
                }
               Roots=(uint64_t*)(*Roots);
            }
            if (!flag){
                int i=3;
                while (*(Roots+i)!=-1){
                    ptr_addr.insert((uint64_t*)*(sp+1+(*(Roots+i)/8)));
                    i++;
                }
                sp=sp+1+(*(Roots+2)/8);
                goto Loop;
            }
           std::set<uint64_t *> searched_set;
            while (!ptr_addr.empty()){
                uint64_t * cur=*(ptr_addr.begin());
                searched_set.insert(cur);
                ptr_addr.erase(cur);
                //查找子指针
                if (!cur){
                    continue;
                }
                uint64_t idx=*(cur);
                
                if (idx)
                {uint64_t * Rec=&GLOBAL_REC_DEC;
                for (uint64_t i=1;i<idx;i++){
                    Rec=(uint64_t*)*(Rec);
                }
                int i=1;
                while (*(Rec+i)!=-1){
                    if (*(Rec+i)){
                        uint64_t * child=(uint64_t*)*(cur+i);
                        if (!searched_set.count(child)){
                            ptr_addr.insert(child);
                        }
                    }
                    i++;
                }
                }
                //
                //解放块
                bool assure=false;
                for (int i=0;i<Used_heap.size();i++){
                    if ((uint64_t*)Used_heap[i].start==cur){
                        new_Used.push_back(Seg(Used_heap[i].start,Used_heap[i].size));
                        assure=true;
                    }
                }
                if (!assure){
                    printf("required addr not found in heap!\n");
                    exit(1);
                }
            }
            for (auto tmp:Used_heap){
                if (std::find(new_Used.begin(),new_Used.end(),tmp)==new_Used.end()){
                    free_heap.push_back(tmp);
                }
                
            }
            Used_heap.swap(new_Used);
           
            
            // while ((*Roots)!=-1)
            // {
            // printf("%ld\n",*(Roots));
            // printf("%ld\n",*(Roots+1));
            // printf("%ld\n",*(Roots+2));
            // printf("%ld\n",*(Roots+3));
            // printf("end\n");
            // Roots=(uint64_t*)(*Roots);
            // }
            // uint64_t * Rec=&GLOBAL_REC_DEC;
            // printf("%ld\n",*(Rec));
            // printf("%ld\n",*(Rec+1));
            // printf("%ld\n",*(Rec+2));
            // printf("%ld\n",*(Rec+3));
            // printf("%ld\n",*(Rec+4));
            // printf("end\n");
            // exit(1);
        }
        
        // char * heap;
        // std::vector<Seg> Used_heap;
        // std::vector<Seg> free_heap;
        
    // };
} // namespace gc
