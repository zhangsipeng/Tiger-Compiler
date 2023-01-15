#include <cstdio>
#include <fstream>
#include "tiger/output/output.h"
#include "tiger/absyn/absyn.h"
#include "tiger/parse/parser.h"

// define here to parse compilation
frame::RegManager *reg_manager;
frame::Frags frags;
std::vector<assem::Gc_Root> * GC_Roots;
std::vector<tr::Rec_Description> * Rec_Des;
int main(int argc, char **argv) {
  std::unique_ptr<absyn::AbsynTree> absyn_tree;
  GC_Roots=new std::vector<assem::Gc_Root>();
  if (argc < 2) {
    fprintf(stderr, "usage: a.out filename\n");
    exit(1);
  }

  Parser parser(argv[1], std::cerr);
  parser.parse();
  absyn_tree = parser.TransferAbsynTree();
  absyn_tree->Print(stderr);
  fprintf(stderr, "\n");
  return 0;
}
