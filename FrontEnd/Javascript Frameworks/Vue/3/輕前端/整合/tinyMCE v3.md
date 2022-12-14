# [tinyMCE v3](https://www.tiny.cloud/docs-3x/)

- 重點
  - 要多一個 bool 變數，目的：
    - 套用至 v-if 上，在 popup 視窗重複開啟時，都可以重新執行 tinyMCE.init()
    - 讓 vue 判斷是否為相同的 instance 

- 語法

    ```js
    <script>
        window.vue_tiny_mce = {
            template: `
                <textarea v-bind:id="id"
                        v-bind:rows="rows"
                        v-model="inputed_content"
                        class="width100"
                ></textarea>

                <!-- 用來讓 vue 判斷此 component 的狀態，如果不給，在重複 開關 popup 後就會讓 vue 一直產生新的 tiny_mce editor -->
                <input type="hidden" v-bind:value="enabled" />
            `,
            props: {
            id: String, 
            rows: String, 
            enabled: Boolean,
            modelValue: String,
            },
            setup(props, { emit }) {
                
            onMounted(() => {
                // 如果放在 magnificPupup 內，就必須靠 setTimeout 去緩衝初始化的流程
                setTimeout(() => {
                    tinyMCE.init({
                                // General options
                                mode: "exact",     // exact / textareas
                                elements: props.id,  // 指定要使用的textarea的id，多个用逗号隔开
                                theme: "advanced",
                                plugins: "autolink,lists,spellchecker,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",
                        
                                // Theme options
                                theme_advanced_buttons1: "newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,fontselect,fontsizeselect",
                                theme_advanced_buttons2: "cut,copy,paste,|,search,replace,|,bullist,numlist,|,undo,redo,|,outdent,indent,blockquote,|,insertdate,inserttime,preview,|,forecolor,backcolor",
                                theme_advanced_buttons3: "tablecontrols,|,hr,|,charmap",
                                theme_advanced_toolbar_location: "top",
                                theme_advanced_toolbar_align: "left",
                                theme_advanced_statusbar_location: "bottom",
                                theme_advanced_resizing: false,
                                theme_advanced_path: false,
                        
                                // Skin options
                                skin: "o2k7",
                                skin_variant: "silver",
                        
                                // Example content CSS (should be your site CSS)
                                //content_css: "css/example.css",
                        
                                // Drop lists for link/image/media/template dialogs
                                template_external_list_url: "js/template_list.js",
                                external_link_list_url: "js/link_list.js",
                                external_image_list_url: "js/image_list.js",
                                media_external_list_url: "js/media_list.js",
                        
                                // Replace values for the template plugin
                                template_replace_values: {
                                    username: "Some User",
                                    staffid: "991234"
                                },
                                onchange_callback : function () {
                                    inputed_content.value = tinyMCE.get(props.id).getContent();
                                }
                            })
                }, 0);
            });
            
            const inputed_content = computed({
                get: () => props.modelValue,
                set: (v) => emit('update:modelValue', v),
            });
            
            return {
                inputed_content,
            };
            },
        };
    </script>

    ```

- 引用方式：


    ```js
    app.component('vue_tiny_mce',  vue_tiny_mce);
    ```

    

    ```html
    <vue_tiny_mce id="content"
                ref="content"
                v-if="content_enabled"
                v-model="dto.content"
                v-bind:enabled="content_enabled"
                rows="15"></vue_tiny_mce>
    ```