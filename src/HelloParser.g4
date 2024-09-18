
parser grammar HelloParser;

options {
    tokenVocab = HelloLexer;
}

start: (NEWLINE | stmt)* EOF;

classdef: 'class' class_name ('extends' class_name)? ':' NEWLINE constructor_def NEWLINE block* ;

constructor_def: TAB (PUBLIC | PRIVATE) class_name '(' parameters? ')' ':' NEWLINE block;

funcdef: (PUBLIC | PRIVATE) STATIC? type name '(' parameters? ')' ':' NEWLINE block;

parameters: type name ('=' value)? (',' type name ('=' value)?)* ;

//variables
variable_def:
            ('var' name type?)
            | ('var' name var1 value)
            | (name var2 value)
            | 'var' '(' name type ('=' value)? var3 ')'
            | array_def;

var1: ',' name var1 value ',' | type? '=';

var2: ',' name var2 value ',' | '=:';

var3: ',' name type ('=' value)? var3? ;

//arrays
array_def: (('var' name '=') | (name '=:')) '[' (INTEGER | '...') ']' type '{' value values_serie '}';

values_serie: ',' value values_serie? ;

stmt: simple_stmt | compound_stmt;

simple_stmt:
        expr_stmt
        | flow_stmt
        | import_stmt
        | variable_def ;

expr_stmt
    : testlist_star_expr (annassign | augassign testlist | ('=' testlist_star_expr)*) ;

annassign: ':' test ('=' test)? ;

testlist_star_expr
    : (test | star_expr) (',' (test | star_expr))* ','?
    ;

augassign:
        '+='
        | '-='
        | '*='
        | '/='
        | '%='
        | '&='
        | '|='
        | '^='
        | '<<='
        | '>>='
        | '**='
        | '//=' ;

flow_stmt
    : 'break'
    | 'continue'
    | return_stmt
    ;

return_stmt: 'return' testlist?;

import_stmt: extern_import (NEWLINE+ use_import)? ;

extern_import: EXTERN  CREATE  name;

use_import :  USE name (FOUR_DOTS name)? (AS name)? ;

compound_stmt:
    if_stmt
    | while_stmt
    | for_stmt
    | funcdef
    | classdef
    | match_stmt ;

if_stmt: 'if' test ':' NEWLINE  block ('elif' test ':' block)* ('else' ':' block)?;

while_stmt: 'while' test ':' block ('else' ':' block)? ;

for_stmt: 'for' exprlist 'in' testlist ':' block ('else' ':' block)? ;

block: (TAB stmt NEWLINE)+ ;

match_stmt: 'match' name ':' NEWLINE  case_block+ ;

case_block: (TAB 'case' value ':' NEWLINE block )+ (TAB DEFAULT ':' NEWLINE block)?;

test: or_test;

or_test
    : and_test ('||' and_test)*
    ;

and_test
    : not_test ('&&' not_test)*
    ;

not_test
    : '!' not_test
    | comparison
    ;

comparison
    : expr (comp_op expr)*
    ;

// <> isn't actually a valid comparison operator in Python. It's here for the
// sake of a __future__ import described in PEP 401 (which really works :-)
comp_op:
    '=='
    | '==='
    | '<>'
    | '!='
    | '<'
    | '>'
    | '>='
    | '<=' ;

star_expr: '*' expr;

expr
    : atom_expr
    | expr '**' expr
    | ('+' | '-')+ expr
    | expr ('*' | '/' | '%' | '//') expr
    | expr ('+' | '-') expr
    | expr ('<<' | '>>') expr
    | expr '&' expr
    | expr '^' expr
    | expr '|' expr
    ;


atom_expr: atom trailer*;

atom
    : '(' testlist_comp? ')'
    | name
    | number
    | STRING
    | '...'
    | 'None'
    | 'True'
    | 'False'
    ;

name: CLASS_NAME | NAME;

class_name : CLASS_NAME;

value: NAME | STRING | number;


testlist_comp
    : (test | star_expr) (',' (test | star_expr)* ','?)
    ;

trailer
    : '(' arglist? ')'
    | '.' name
    ;

exprlist: (expr | star_expr) (',' (expr | star_expr))* ;

testlist: test (',' test)* ','?;

arglist: argument (',' argument)* ;

argument: (test | test '=' test | '**' test | '*' test) ;

number: INTEGER | FLOAT_NUMBER | IMAG_NUMBER;

type: PRIMITIVE | CLASS_NAME;