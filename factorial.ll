declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...) 
@.format = private constant [4 x i8] c"%d\0"
@formatString = private constant [4 x i8] c"%d\0"    ; 格式化字符串
define i32 @factorial(i32 %n) {
    %result = alloca i32
    store i32 1, i32* %result ; 初始化结果为1
    %i = alloca i32
    store i32 1, i32* %i ; 初始化计数器为1
    ; 开始计算阶乘
    br label %loop_start
loop_start:
    %current_result = load i32, i32* %result
    %current_i = load i32, i32* %i
    ; 检查是否达到N
    %cmp = icmp sle i32 %current_i, %n
    br i1 %cmp, label %loop_body, label %loop_end
loop_body:
    ; 计算当前结果乘以计数器
    %next_result = mul i32 %current_result, %current_i
    ; 更新结果
    store i32 %next_result, i32* %result
    ; 更新计数器
    %next_i = add i32 %current_i, 1
    store i32 %next_i, i32* %i
    ; 回到循环开始
    br label %loop_start
loop_end:
    %factorial_result = load i32, i32* %result

    ret i32 %factorial_result
}
define i32 @main() {
    %n = alloca i32
    ; 输入一个整数
    %format = getelementptr [4 x i8], [4 x i8]* @.format, i32 0, i32 0
    call i32 (i8*, ...) @scanf(i8* %format, i32* %n)
    ; 调用计算阶乘的函数
    %n_val = load i32, i32* %n
    %result = call i32 @factorial(i32 %n_val)

   %formatOut = getelementptr [4 x i8], [4 x i8]* @formatString, i32 0, i32 0
    call i32 (i8*, ...) @printf(i8* %formatOut, i32 %result)    
    
    ret i32 %result
}
