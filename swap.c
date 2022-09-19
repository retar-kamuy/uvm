#include<stdio.h>
  
int main(void)
{
  
  /* 変数の宣言 */
  int a, b, tmp;
  
  /* 2つの数値を入力 */
  printf("a = ");
  scanf("%d", &a);
 
  printf("b = ");
  scanf("%d", &b);
 
  /* 数値の入れ替え */
  tmp = b;
  b = a;
  a = tmp;
 
  printf("===== After =====\n");
  printf("a = %d\n", a);
  printf("b = %d\n", b);
 
  return 0;
}
