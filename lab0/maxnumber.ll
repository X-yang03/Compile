@formatString = private constant [4 x i8] c"%d\0"    ; 格式化字符串
declare i32 @printf(i8*, ...)                         ; printf函数声明
declare i32 @scanf(i8*, ...)                          ; scanf函数声明
define i32 @main() {
    ; 声明变量
    %num1 = alloca i32
    %num2 = alloca i32
    %num3 = alloca i32

    ; 输入三个整数
    %format = getelementptr [4 x i8], [4 x i8]* @formatString, i32 0, i32 0
    %addr_num1 = getelementptr i32, i32* %num1
    call i32 (i8*, ...) @scanf(i8* %format, i32* %addr_num1)
    %addr_num2 = getelementptr i32, i32* %num2
    call i32 (i8*, ...) @scanf(i8* %format, i32* %addr_num2)
    %addr_num3 = getelementptr i32, i32* %num3
    call i32 (i8*, ...) @scanf(i8* %format, i32* %addr_num3)
    
    ; 加载输入的整数
    %loaded_num1 = load i32, i32* %num1
    %loaded_num2 = load i32, i32* %num2
    %loaded_num3 = load i32, i32* %num3
    ; 比较num1和num2
    %cmp1 = icmp sgt i32 %loaded_num1, %loaded_num2
    %num1_or_num2 = select i1 %cmp1, i32 %loaded_num1, i32 %loaded_num2
    
    ; 比较num1_or_num2和num3
    %cmp2 = icmp sgt i32 %num1_or_num2, %loaded_num3
    %max = select i1 %cmp2, i32 %num1_or_num2, i32 %loaded_num3
    ; 输出最大的整数
    %formatOut = getelementptr [4 x i8], [4 x i8]* @formatString, i32 0, i32 0
    call i32 (i8*, ...) @printf(i8* %formatOut, i32 %max)
    ret i32 0
}
