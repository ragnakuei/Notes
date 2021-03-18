# console.log 並非當下的資料

當把一個 js object 交由 console.log() 輸出時

會因為之後的處理，讓原本 console.log() 輸出的內容不是當下的資料

要換個思考方式來思考

> console.log(js object) 只是負責要輸出該物件的值，不是物件當下的值 !

最簡單的解法:

直接序列化，再反序列化

等於就是完整複製該物件當下的狀態出來給 console.log() 來輸出

> console.log(JSON.parse(JSON.stringify(`js object`)));
