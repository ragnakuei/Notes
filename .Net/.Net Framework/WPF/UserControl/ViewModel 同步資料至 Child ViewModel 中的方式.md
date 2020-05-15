# ViewModel 同步資料至 Child ViewModel 中的方式

因為 Child ViewModel 會將該 Property 給 Child View 做 Bind

當 ViewModel 更新資料時，直接呼叫 Child ViewModel 的 Public Property 就可以同步更新了!
