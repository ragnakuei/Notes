# ErrorBoundary

有 ErrorBoundary 的保護下，不會導致 circuit 中斷，但會強制 rerender component !

-   Circuit 中斷後，就只能 reload page 來重新連線 circuit !

### InteractiveServer

Routes 的 render mode 也要指定 InteractiveServer，ErroryBoundary 才會生效 !
