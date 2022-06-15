# 範例 01 - Hello World

```html
<script crossorigin src="https://unpkg.com/react@18/umd/react.development.js"></script>
<script crossorigin src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>

<div id="app"></div>

<script>
    class Hello extends React.Component {
        render() {
            return React.createElement('div', null, `Hello ${this.props.toWhat}`);
        }
    }
    
    const app = ReactDOM.createRoot(document.getElementById('app'));
    app.render(React.createElement(Hello, { toWhat: 'World' }, null));
</script>
```