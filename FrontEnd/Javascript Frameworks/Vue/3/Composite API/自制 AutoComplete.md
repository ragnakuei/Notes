# 自制 AutoComplete

[範例來源](https://github.com/ragnakuei/ReserveRoom/blob/master/WebMvcServer/Views/Shared/vue/_FormFloatingTimePicker.cshtml)

```html
<time-picker div-class="mb-3 form-field"
             label="起"
             property-path="BeginTime"
             start-time="08:00"
             v-model:vue-model="vue_model">
</time-picker>
```

component

```html
<!--
已知狀況：
1. input onblur 做 close option 的動作時，會來不及觸發 click option 的動作，所以不使用 onblur !
2. 當 input 在螢幕最下方時，無法像原生的 select 把 option 往上方顯示 !
-->

<style>
    .auto-complete {
        position: relative;
    }

    .auto-complete-wrapper {
        width: 100%;
        position: absolute;
        border: 1px solid #747474;
        border-radius: 8px;

        z-index: 99;
        box-shadow: 10px 10px 20px #e4e4e4;

        top: 62px;

        overflow: hidden;
    }

    .auto-complete-wrapper-scroll {
        max-height: 300px;
        overflow-x: hidden;
        overflow-y: scroll;
    }

    .auto-complete-item {
        width: 100%;
        padding: 5px;
        cursor: pointer;
        background-color: #fff;
        border-bottom: 1px solid #d4d4d4;
    }

    .auto-complete-item.hover {
        /*when hovering an item:*/
        background-color: #767676;
        color: #ffffff;
    }

    .auto-complete-active {
        /*when navigating through the items using the arrow keys:*/
        background-color: DodgerBlue !important;
        color: #ffffff;
    }

    .auto-complete-overlay {
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        /*background: rgba(0, 0, 50, 50%); // debug 用*/
        z-index: 98;
    }
</style>
<script>
    app.component("vue-time-picker", {
        template: `
<div class="form-floating auto-complete"
     v-bind:class="divClass">
    <input type="text"
           v-bind:id="propertyPath"
           class="form-control"
           v-model="domValue"
           placeholder="x"
           v-bind="validateAttributes"
           v-on:focus="openTimeOptions()"
           v-on:input="inputDom()"
           v-on:keydown.tab="tabBlurDom()"
           v-on:keydown.up="changeHoverTimeOption(-1)"
           v-on:keyup.up="enableMouseMoveCheck()"
           v-on:keydown.down="changeHoverTimeOption(1)"
           v-on:keyup.down="enableMouseMoveCheck()"
           v-on:keydown.enter.prevent="selectHoverTimeOption()"
           v-bind:class="validateClass" />
    <label class="col-form-label text-sm-end text-start"
           v-bind:for="propertyPath">
        {{ label }}
    </label>
    <div v-if="showOptions" class="auto-complete-wrapper">
        <div class="auto-complete-wrapper-scroll">
            <div class="auto-complete-item"
                 v-for="timeOption in filterTimeOptions"
                 v-on:mousemove="mouseMovingTimeOption(timeOption)"
                 v-bind:class="itemClass(timeOption)"
                 v-bind:ref="setItemRefs"
                 v-on:click="clickTimeOption(timeOption)">
            {{ timeOption }}
            </div>
        </div>
    </div>
    <div v-if="showOptions"
         class="auto-complete-overlay"
         v-on:click="closeTimeOptions()">
    </div>
    <span class="invalid-feedback">
        {{ validateResult?.join('、')}}
    </span>
</div>
        `,
        props: {
            divClass: String,
            label: String,
            startTime: String,
            endTime: String,
            propertyPath: String,
            vueModel : {},
        },
        setup(props, { emit }) {

            props.vueModel.validationRules[props.propertyPath]['regex'] = {
                pattern : /^\d{2}:\d{2}$/ ,
                sampleFormat: 'HH:mm',
            };

            const baseSetup = BaseFormFieldComponent.baseSetup(props,  { emit });

            const timeOptions = ref(CommonJs.GenerateTimeOptions(props.startTime, props.endTime, 30));
            const filterTimeOptions = ref(timeOptions.value);

            const itemRefs = ref(new Set());
            const setItemRefs = function( element ) {
                itemRefs.value.add(element);
            }

            const showOptions = ref(false);
            const openTimeOptions = function( ) {
                baseSetup.isTouched.value = true;
                showOptions.value = true;
            }
            const closeTimeOptions = function( ) {
                showOptions.value = false;
                baseSetup.validateFrontEnd('input');
                filterTimeOptions.value = timeOptions.value;
            }

            // hover 項目
            const hoverTimeOption = ref({});

            const disableMouseMoveCheck = ref(false);
            const enableMouseMoveCheck = function() {
                disableMouseMoveCheck.value = false;
            }

            const mouseMovingTimeOption = function(timeOption) {
                if(disableMouseMoveCheck.value) {
                    return;
                }

                hoverTimeOption.value = timeOption;
            }

            //  按 上/下 來切換選取不同的 TimeOption
            const changeHoverTimeOption = function(indexOffset) {

                disableMouseMoveCheck.value = true;

                openTimeOptions();

                const currentIndex = filterTimeOptions.value.indexOf(hoverTimeOption.value);
                let targetIndex = currentIndex + indexOffset;

                if(targetIndex < 0) {
                    targetIndex = 0;
                }

                if(targetIndex > filterTimeOptions.value.length - 1) {
                    targetIndex = filterTimeOptions.value.length - 1;
                }

                Array.from(itemRefs.value)[targetIndex].scrollIntoView(
                    {
                        behavior: "smooth",
                        block: "center",
                        inline: "nearest"
                    }
                );

                hoverTimeOption.value = filterTimeOptions.value[targetIndex];
            }

            // 按下 enter 選取 hoverTimeOption
            const selectHoverTimeOption = function( ) {
                clickTimeOption(hoverTimeOption);
            }

            // 用來標示 TimeOption Item 的 class
            const itemClass = function(timeOption) {
                return {
                    "hover" : timeOption === hoverTimeOption.value,
                }
            }

            const clickTimeOption = function(selectTimeOption) {
                baseSetup.domValue.value = selectTimeOption;
                closeTimeOptions();
            }

            const validateCustomInput = function() {

                if( !baseSetup.domValue.value ) {
                    return;
                }

                if( baseSetup.domValue.value < props.startTime
                 || baseSetup.domValue.value > props.endTime ) {
                    baseSetup.validateFrontEndResult.value.push('超出指定時間區間');
                 }
            }

            const inputDom = function( ) {

                if(!baseSetup.domValue.value) {
                    filterTimeOptions.value = timeOptions.value;
                } else {
                    filterTimeOptions.value = timeOptions.value.filter(o => o.includes(baseSetup.domValue.value));
                }

                // 只要觸發 Input 就重新變更 hover 項目
                hoverTimeOption.value = filterTimeOptions.value[0];

                baseSetup.isTouched.value = true;
                baseSetup.validateFrontEnd('input');
                validateCustomInput();
            }

            const tabBlurDom = function( ) {
               closeTimeOptions();
               validateOnBlur();
            }

            const validateOnBlur = function() {
                // 後端驗証失敗先清空
                baseSetup.clearValidateBackendResult();

                // 再執行前端驗証
                baseSetup.validateFrontEnd('blur');
            }

            return {
                ...baseSetup,
                showOptions,
                filterTimeOptions,
                setItemRefs,
                openTimeOptions,
                closeTimeOptions,
                enableMouseMoveCheck,
                mouseMovingTimeOption,
                changeHoverTimeOption,
                selectHoverTimeOption,
                itemClass,
                clickTimeOption,
                inputDom,
                tabBlurDom,
            }
        }
    });
</script>
```