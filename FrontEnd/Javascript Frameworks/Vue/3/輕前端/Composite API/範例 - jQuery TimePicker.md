# 範例 - jQuery TimePicker

```html
<div id='app'>

  <time-picker id='begin_time' v-model:value="time_value"></time-picker>

  <hr>

  <p>Time:{{time_value}}</p>
</div>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css" />

<script src="https://unpkg.com/vue@next"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>

<script>
  const { createApp, ref, reactive, onMounted, computed } = Vue;
  const app = createApp({
    setup() {
      const time_value = ref('');
      onMounted(() => {})
      return {
        time_value,
      }
    }
  });
</script>
<script>
  window.TimePicker = {
    template: `
                 <input v-bind:id="id"
                        v-model="dom_value">
    `,
    props: {
      id: String,
      value: String,
      name: String,
    },
    setup(props, { emit }) {
      const dom_value = computed({
        get: () => {
          console.log('get', props.value);
          return props.value;
        },
        set: (v) => {
          console.log('set', v);
          emit('update:value', v);
        },
      });
      const time_picker = ref({});
      onMounted(() => {
        time_picker.value = $('#' + props.id).timepicker({
          timeFormat: "HH:mm", // 時間隔式
          interval: 30, //時間間隔
          // minTime: "06", //最小時間
          // maxTime: "23:55pm", //最大時間
          // defaultTime: "06", //預設起始時間
          // startTime: "01:00", // 開始時間
          dynamic: true, //是否顯示項目，使第一個項目按時間順序緊接在所選時間之後
          dropdown: true, //是否顯示時間條目的下拉列表
          scrollbar: true, //是否顯示捲軸
          change: function(time) {
            
            console.log('time' ,time_picker.value.value);
            dom_value.value = time_picker.value.value;
          },
        })[0];
      });
      return {
        dom_value,
      }
    }
  }
  app.component("time-picker", window.TimePicker);
</script>
<script>
  const vm = app.mount('#app');
</script>
```