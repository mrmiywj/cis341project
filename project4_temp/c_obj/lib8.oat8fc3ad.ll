declare i8* @string_of_array({ i32, [ 0 x i32 ] }*)
declare { i32, [ 0 x i32 ] }* @array_of_string(i8*)
declare void @print_string(i8*)
declare void @print_int(i32)
declare void @print_bool(i1)
declare i32* @oat_malloc(i32)
declare { i32, [ 0 x i32 ] }* @oat_alloc_array(i32)
declare void @oat_array_bounds_check(i32, i32)
@_oat_string2395.str. = private unnamed_addr constant [ 14 x i8 ] c "Hello world!
\00", align 4
@_oat_string2395 = global i8* getelementptr inbounds ([ 14 x i8 ]* @_oat_string2395.str., i32 0, i32 0), align 4
define void @oat_init (){

__fresh417:
  ret void
}


define i32 @program (i32 %argc2393, { i32, [ 0 x i8* ] }* %argv2391){

__fresh416:
  %argc_slot2394 = alloca i32
  store i32 %argc2393, i32* %argc_slot2394
  %argv_slot2392 = alloca { i32, [ 0 x i8* ] }*
  store { i32, [ 0 x i8* ] }* %argv2391, { i32, [ 0 x i8* ] }** %argv_slot2392
  %strval2396 = load i8** @_oat_string2395
  %str2397 = alloca i8*
  store i8* %strval2396, i8** %str2397
  %_lhs2398 = load i8** %str2397
  call void @print_string( i8* %_lhs2398 )
  ret i32 0
}


