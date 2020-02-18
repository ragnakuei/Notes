# refs

---

可以用來直接存取 template 指定的 element

在 template 中，指定 refs 的名稱

在 script 內，透過 `this.$refs["refs 名稱"]` 來取出所有符合 refs 的 Array

好處是可以不用在 parent component 記下所有 child component 的狀態

在需要的時候，透過 `this.$refs["refs 名稱"]` 就可以一次取出所有 child component 狀態

---

## 範例

parent component

```html
<template>
    <div>
        <checkedButton v-for="value in buttons"
                       v-bind:id="'checkedButton'+value.id"
                       ref="checkedButtons"
                       v-bind:itemId="value.id" 
                       v-bind:initialChecked="value.isChecked" 
                       v-on:onButtonClick="checkedButtonClick" />
    </div>
</template>

<script>
    import checkedButton from "@/views/CheckedButton.vue"
    
    export default {
        components : {
            checkedButton
        },
        props:[
        ],
        data() {
            return {
                buttons : [
                    {id : 1, isChecked : false},
                    {id : 2, isChecked : true},
                    {id : 3, isChecked : false},
                ]
            }
        },
        methods : {
            checkedButtonClick : function(target) {
                console.log(target);

                // 取出 this.$refs 的資料
                console.log(this.$refs["checkedButtons"]);

                // 一次取出指定 component 內所有資料，省去儲存子類狀態
                this.$refs["checkedButtons"].forEach(element => {
                    console.log(element.itemId);                    
                    console.log(element.isChecked);                    
                });
            }
        }
    } 
</script>
```

child component

```html
<template>
    <button @click="onClick">Checked : {{ isChecked }}</button>
</template>

<script>
    export default {
        name: "checkedButton",
        props: {
            initialChecked : Boolean,
            itemId: Number,
        },
        data() {
            return {
                isChecked : this.initialChecked
            }
        },
        methods : {
            onClick : function(t) {
                // t : MouseEvent
                // console.log(t);
                
                this.isChecked = !this.isChecked;
                
                this.$emit("onButtonClick", {
                    id: this.itemId,
                    isChecked: this.isChecked,
                });
            }
        }
    }
</script>
```