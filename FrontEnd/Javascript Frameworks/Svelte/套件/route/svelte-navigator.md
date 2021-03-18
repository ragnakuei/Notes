# [svelte-navigator](https://github.com/mefechoel/svelte-navigator)

## 以 memory 來建立 history

- 切換 route 時，url 不會跟著變動

```html
<script>
    import {Router, Link, Route, createHistory, createMemorySource} from "svelte-navigator";
    import Home from "./routes/Home.svelte";
    import About from "./routes/About.svelte";
    import Blog from "./routes/Blog.svelte";
    import BlogPost from "./routes/BlogPost.svelte";
    import Search from "./routes/Search.svelte";

    // 主要是這部份
    const memoryHistory = createHistory(createMemorySource());
</script>

<p>App</p>

<Router history="{memoryHistory}">
    <nav>
        <Link to="/">Home</Link>
        <Link to="about">About</Link>
        <Link to="blog">Blog</Link>
    </nav>
    <div>
        <Route path="/">
            <Home />
        </Route>

        <Route path="about"
               component={About} />

        <Route path="blog/*">
            <Route path="/">
                <Blog />
            </Route>
            <Route path=":id"
                   component={BlogPost} />
        </Route>

        <Route path="search/:query"
               let:params>
            <Search query={params.query} />
        </Route>

        <Route>
            <h3>404 Not Found</h3>
            <p>No Route could be matched.</p>
        </Route>
    </div>
</Router>

<style>

</style>
```
