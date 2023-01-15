%filenames = "scanner"

 /*
  * Please don't modify the lines above.
  */

 /* You can add lex definitions here. */
 /* TODO: Put your lab2 code here */
 digits [0-9]+
 
 

%x COMMENT STR IGNORE

%%

 /*
  * Below is examples, which you can wipe out
  * and write regular expressions and actions of your own.
  *
  * All the tokens:
  *   Parser::ID
  *   Parser::STRING
  *   Parser::INT
  *   Parser::COMMA
  *   Parser::COLON
  *   Parser::SEMICOLON
  *   Parser::LPAREN
  *   Parser::RPAREN
  *   Parser::LBRACK
  *   Parser::RBRACK
  *   Parser::LBRACE
  *   Parser::RBRACE
  *   Parser::DOT
  *   Parser::PLUS
  *   Parser::MINUS
  *   Parser::TIMES
  *   Parser::DIVIDE
  *   Parser::EQ
  *   Parser::NEQ
  *   Parser::LT
  *   Parser::LE
  *   Parser::GT
  *   Parser::GE
  *   Parser::AND
  *   Parser::OR
  *   Parser::ASSIGN
  *   Parser::ARRAY
  *   Parser::IF
  *   Parser::THEN
  *   Parser::ELSE
  *   Parser::WHILE
  *   Parser::FOR
  *   Parser::TO
  *   Parser::DO
  *   Parser::LET
  *   Parser::IN
  *   Parser::END
  *   Parser::OF
  *   Parser::BREAK
  *   Parser::NIL
  *   Parser::FUNCTION
  *   Parser::VAR
  *   Parser::TYPE
  */

 /* reserved words */
<INITIAL>"array" {adjust(); return Parser::ARRAY;}

 /* TODO: Put your lab2 code here */
<INITIAL>if {adjust();return Parser::IF;}
<INITIAL>then {adjust();return Parser::THEN;}
<INITIAL>else {adjust();return Parser::ELSE;}
<INITIAL>do {adjust();return Parser::DO;}
<INITIAL>of {adjust();return Parser::OF;}
<INITIAL>nil {adjust();return Parser::NIL;}
<INITIAL>type {adjust();return Parser::TYPE;}
<INITIAL>var {adjust();return Parser::VAR;}
<INITIAL>function {adjust();return Parser::FUNCTION;}
<INITIAL>end {adjust();return Parser::END;}
<INITIAL>in {adjust();return Parser::IN;}
<INITIAL>let {adjust();return Parser::LET;}
<INITIAL>break {adjust();return Parser::BREAK;}
<INITIAL>to {adjust();return Parser::TO;}
<INITIAL>for {adjust();return Parser::FOR;}
<INITIAL>while {adjust();return Parser::WHILE;}
<INITIAL>{digits} {adjust();return Parser::INT;}
<INITIAL>\x22 {adjust();begin(StartCondition__::STR);}
<INITIAL>"/*" {adjust(); ++commentStartCount;begin(StartCondition__::COMMENT);}
<INITIAL>, {adjust();return Parser::COMMA;}
<INITIAL>:= {adjust();return Parser::ASSIGN;}
<INITIAL>: {adjust();return Parser::COLON;}
<INITIAL>; {adjust();return Parser::SEMICOLON;}
<INITIAL>"(" {adjust();return Parser::LPAREN;}
<INITIAL>")" {adjust();return Parser::RPAREN;}
<INITIAL>"[" {adjust();return Parser::LBRACK;}
<INITIAL>"]" {adjust();return Parser::RBRACK;}
<INITIAL>"{" {adjust();return Parser::LBRACE;}
<INITIAL>"}" {adjust();return Parser::RBRACE;}
<INITIAL>"." {adjust();return Parser::DOT;}
<INITIAL>"+" {adjust();return Parser::PLUS;}
<INITIAL>"-" {adjust();return Parser::MINUS;}
<INITIAL>"*" {adjust();return Parser::TIMES;}
<INITIAL>"/" {adjust();return Parser::DIVIDE;}
<INITIAL>"=" {adjust();return Parser::EQ;}
<INITIAL>"<>" {adjust();return Parser::NEQ;}
<INITIAL>"<=" {adjust();return Parser::LE;}
<INITIAL>"<" {adjust();return Parser::LT;}
<INITIAL>">" {adjust();return Parser::GT;}
<INITIAL>">=" {adjust();return Parser::GE;}
<INITIAL>"&" {adjust();return Parser::AND;}
<INITIAL>"|" {adjust();return Parser::OR;}
<INITIAL>[a-zA-Z][a-zA-Z0-9_]* {adjust();return Parser::ID;}

<INITIAL>(" "|"\t")+ {adjust();}
<INITIAL>"\n" {adjust(); errormsg_->Newline();}
<INITIAL>"." {adjust(); errormsg_->Error(errormsg_->tok_pos_, "illegal token");}

<COMMENT>{
    "/*" {adjust(); ++commentStartCount;}
"*/" {adjust(); --commentStartCount; if(commentStartCount==0) { begin(StartCondition__::INITIAL);}}
(" "|"\t")+ {adjust();}
"\n" {adjust();errormsg_->Newline();}
. {adjust();}

}

<STR>{
    \x22 {adjustStr();setMatched(matchedString);begin(StartCondition__::INITIAL);return Parser::STRING;}
    [a-zA-Z0-9] {adjustStr();matchedString+=matched();}
    [\\][n] {adjustStr();char n='\n';matchedString+=n;}
    " "  {adjustStr();matchedString+=" ";}
    [\\][t] {adjustStr();char n='\t';matchedString+=n;}
    [\\][\\] {adjustStr();char n='\\';matchedString+=n;}
    [\\]"^"[A-Z] {std::string a=matched();char tmp=a[2];char n=' '-31+(tmp-'A');adjustStr();matchedString+=n;}
    
    [\\][0-9][0-9][0-9] {adjustStr();std::string a=matched();std::string tmp(a,1,3);char t1=tmp[0];char t2=tmp[1];char t3=tmp[2];int len=(t1-'0')*100+(t2-'0')*10+(t3-'0');char n=' '+(len-32);matchedString+=n;}
    [\\]["] {adjustStr();char n='\"';matchedString+=n;}
    [\\][ \t\n]+[\\] {adjustStr();}
    
    "+" {adjustStr();matchedString+=matched();}
    "-" {adjustStr();matchedString+=matched();}
    "*" {adjustStr();matchedString+=matched();}
    "/" {adjustStr();matchedString+=matched();}



    ">" {adjustStr();matchedString+=matched();}
    "!" {adjustStr();matchedString+=matched();}




    ["."]{+}[","]{+}["'"]{+}[";"]{+}["="] {adjustStr();matchedString+=matched();}

}



