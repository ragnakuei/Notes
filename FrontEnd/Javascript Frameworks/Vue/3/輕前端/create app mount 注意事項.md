# create app mount 注意事項

- 不要 mount 在 form tag 上
  - 否則 v-on:submit 會無效
- 不要 mount 在 template tag 上
  - 不符合 vue 的設計
