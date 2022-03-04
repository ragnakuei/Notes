# 遞迴呼叫 component


```html
<div id="app">
    <item-component v-for="item in items" 
                    v-bind:item="item" >
    </item-component>
</div>

<script src="https://unpkg.com/vue@next"></script>
<style>
    .item-component {
        margin-left : 20px;
    }
</style>
<script>
    const { createApp, ref, reactive, onMounted, computed, watch, watchEffect } = Vue;

    const app = createApp({
        setup(){

            const items = ref([
                { 
                    name : 'A',
                    childNodes : [
                        { 
                            name : 'A1', 
                            childNodes : [
                                { 
                                    name : 'A11', 
                                    childNodes : null,
                                },
                                { 
                                    name : 'A12', 
                                    childNodes : null,
                                }
                            ],
                        },
                        { 
                            name : 'A2', 
                            childNodes : [
                                { 
                                    name : 'A21', 
                                    childNodes : null,
                                },
                                { 
                                    name : 'A22', 
                                    childNodes : null,
                                },
                                { 
                                    name : 'A23', 
                                    childNodes : null,
                                }
                            ],
                        },
                    ]
                },
                { 
                    name : 'B', 
                    childNodes : [
                        {
                            name : 'B1', 
                            childNodes : null,
                        }
                    ],
                }
            ]);

            return {
                items,
            }
        }
    });

    app.component('item-component', {
        template: `
            <div class="item-component">
                <label>
                    {{ item.name }}
                </label>
                <item-component v-for="child in item.childNodes" 
                                v-bind:item="child" >
                </item-component>
            </div>
        `,
        props: {
            item : {}
        },
        setup() {
            
        }
    });
    
    const vm = app.mount('#app');
</script>
```