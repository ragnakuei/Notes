# setInterval 變慢

## [可能解法](https://johnresig.com/blog/how-javascript-timers-work/)

## [可能解法](./應用/倒數計時器.md)



```javascript
setInterval(syncTime, 10);

function syncTime() {
  document.getElementById("resultTime").innerText = new Date().toLocaleString();
}
```

```javascript
setTimeout(function() {
  document.getElementById("resultTime").innerText = new Date().toLocaleString();

  setTimeout(arguments.callee, 1000);
}, 1000);
```
