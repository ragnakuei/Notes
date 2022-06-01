# OnlineMeeting

### jointInformation.content 顯示為 HTML

二種方式

- 第一種

    ```html
    <div v-html="decodeURIComponent(meeting?.joinInformation?.content.replace('data:text/html,', '').replaceAll('+', ' '))"></div>
    ```

- 第二種

    ```html
    <iframe v-bind:src="meeting?.joinInformation?.content.replaceAll('+', ' ')" sandbox class='joinInformationContent' />

    <style>
    .joinInformationContent {
        width: 700px;
        height: 300px;
    }
    </style>
    ```