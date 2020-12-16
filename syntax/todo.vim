" File:        todo.txt.vim
" Description: Todo.txt syntax settings
" Author:      Nick Murphy <comfortablynick@gmail.com>,David Beniamine <David@Beniamine.net>,Leandro Freitas <freitass@gmail.com>
" License:     Vim license
" Website:     http://github.com/dbeniamine/todo.txt-vim
let s:syn = 'b:current_syntax' | if exists(s:syn) | finish | endif

syntax  match  TodoDone       '^[x]\s.\+$'               contains=TodoKey,TodoDate,TodoProject,TodoContext
syntax  match  TodoPriorityA  '^(A) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityB  '^(B) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityC  '^(C) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityD  '^(D) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityE  '^(E) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityF  '^(F) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityG  '^(G) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityH  '^(H) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityI  '^(I) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityJ  '^(J) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityK  '^(K) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityL  '^(L) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityM  '^(M) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityN  '^(N) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityO  '^(O) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityP  '^(P) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityQ  '^(Q) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityR  '^(R) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityS  '^(S) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityT  '^(T) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityU  '^(U) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityV  '^(V) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityW  '^(W) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityX  '^(X) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityY  '^(Y) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoPriorityZ  '^(Z) .\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,TodoDueToday,TodoOverDueDate,TodoThresholdDate
syntax  match  TodoDate       '\d\{2,4\}-\d\{2\}-\d\{2\}' contains=NONE
syntax  match  TodoKey        '\S*\S:\S\S*'               contains=TodoDate
syntax  match  TodoProject    '\(^\|\W\)+[^[:blank:]]\+'  contains=NONE
syntax  match  TodoContext    '\(^\|\W\)@[^[:blank:]]\+'  contains=NONE

let s:todayDate=strftime('%Y\-%m\-%d')
execute 'syntax match TodoDueToday    /\v\c<due:' . s:todayDate . '>/ contains=NONE'

" Other priority colours might be defined by the user
highlight  default  link  TodoKey        Special
highlight  default  link  TodoDone       Comment
highlight  default  link  TodoPriorityA  Identifier
highlight  default  link  TodoPriorityB  statement
highlight  default  link  TodoPriorityC  type
highlight  default  link  TodoDate       PreProc
highlight  default  link  TodoProject    Special
highlight  default  link  TodoContext    Special
highlight  default  link  TodoDueToday   Todo


execute 'syntax match TodoOverDueDate /\v\c<due:' . todo#GetDateRegexForPastDates() . '>/'
highlight default link TodoOverDueDate Error

execute 'syntax match TodoThresholdDate /\v\c.*<t:' . todo#GetDateRegexForFutureDates() . '>/ contains=NONE'
highlight default link TodoThresholdDate Comment

let {s:syn} = 'todo'
