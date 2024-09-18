lexer  grammar HelloLexer;

STRING: '"' (SMALL_LET | CAP_LETTER | ID_CONTINUE | ' ')* '"';

AS         : 'as';
BREAK      : 'break';
CASE       : 'case';
CLASS      : 'class';
CONTINUE   : 'continue';
DEF        : 'def';
ELIF       : 'elif';
ELSE       : 'else';
FALSE      : 'False';
FOR        : 'for';
FROM       : 'from';
IF         : 'if';
IMPORT     : 'import';
USE        : 'use';
IN         : 'in';
IS         : 'is';
MATCH      : 'match';
NONE       : 'None';
RETURN     : 'return';
TRUE       : 'True';
UNDERSCORE : '_';
WHILE      : 'while';
VOID       : 'void';
PRIVATE    : 'private';
PUBLIC     : 'public';
STATIC     : 'static';
THIS       : 'this';
RANGE      : 'range';
VAR        : 'var';
DEFAULT    : 'default';
EXTENDS    : 'extends';
EXTERN     : 'extern';
CREATE     : 'create';
OPEN       : 'open';
WRITE      : 'write';
CLOSE      : 'close';
PRIMITIVE   : 'int' | 'string' | 'float' | 'double';

NEWLINE: '\n';

TAB : '  ';

INTEGER: DECIMAL_INTEGER;

DECIMAL_INTEGER: DIGIT+;

FLOAT_NUMBER: POINT_FLOAT | EXPONENT_FLOAT;

IMAG_NUMBER: ( FLOAT_NUMBER | INT_PART) [jJ];

/// identifier   ::=  id_start id_continue+

CLASS_NAME: CAP_LETTER ID_CONTINUE+;

NAME: SMALL_LET ID_CONTINUE+;


DOT                : '.';
ELLIPSIS           : '...';
STAR               : '*';
OPEN_PAREN         : '(';
CLOSE_PAREN        : ')';
COMMA              : ',';
//QUO                : '"';
VAR_ASSIGN         : '=:';
COLON              : ':';
SEMI_COLON         : ';';
POWER              : '**';
ASSIGN             : '=';
OPEN_BRACK         : '[';
CLOSE_BRACK        : ']';
NOT                : '!';
BITWISE_OR         : '|';
BITWISE_AND        : '&';
LOGICAL_OR         : '||';
LOGICAL_AND        : '&&';
XOR                : '^';
LEFT_SHIFT         : '<<';
RIGHT_SHIFT        : '>>';
ADD                : '+';
MINUS              : '-';
DIV                : '/';
MOD                : '%';
IDIV               : '//';
NOT_OP             : '~';
OPEN_BRACE         : '{';
CLOSE_BRACE        : '}';
LESS_THAN          : '<';
GREATER_THAN       : '>';
EQUALS             : '==';
EQUALS_2           : '===';
GT_EQ              : '>=';
LT_EQ              : '<=';
NOT_EQ_1           : '<>';
NOT_EQ_2           : '!=';
ARROW              : '->';
ADD_ASSIGN         : '+=';
SUB_ASSIGN         : '-=';
MULT_ASSIGN        : '*=';
DIV_ASSIGN         : '/=';
MOD_ASSIGN         : '%=';
AND_ASSIGN         : '&=';
OR_ASSIGN          : '|=';
XOR_ASSIGN         : '^=';
LEFT_SHIFT_ASSIGN  : '<<=';
RIGHT_SHIFT_ASSIGN : '>>=';
POWER_ASSIGN       : '**=';
IDIV_ASSIGN        : '//=';
FOUR_DOTS          : '::';
AT                 : '@';

SKIP_: ( ' ' | COMMENT | MULT_COMMENT) -> skip;


/// nonzerodigit   ::=  "1"..."9"
fragment NON_ZERO_DIGIT: [1-9];

/// digit          ::=  "0"..."9"
fragment DIGIT: [0-9];

/// pointfloat    ::=  [intpart] fraction | intpart "."
fragment POINT_FLOAT: INT_PART? FRACTION | INT_PART '.';

/// exponentfloat ::=  (intpart | pointfloat) exponent
fragment EXPONENT_FLOAT: ( INT_PART | POINT_FLOAT) EXPONENT;

/// intpart       ::=  digit+
fragment INT_PART: DIGIT+;

/// fraction      ::=  "." digit+
fragment FRACTION: '.' DIGIT+;

/// exponent      ::=  ("e" | "E") ["+" | "-"] digit+
fragment EXPONENT: [eE] [+-]? DIGIT+;

fragment TB : [\t];

fragment COMMENT: '#' (.)*;

fragment MULT_COMMENT: '#*' ((.) | [\n])* '*#';

fragment SMALL_LET: [a-z];

fragment ID_CONTINUE: [a-zA-Z0-9$_];

fragment CAP_LETTER: [A-Z];