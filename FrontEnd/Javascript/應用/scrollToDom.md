# scrollToDom


```js
$(document).on("click", "#btnSubmit", function()
{
    const elements = document.querySelectorAll("#form input,#form select,#form textarea");
    for (const i = 1; i < elements.length; i++)
    {
        if (elements[i].checkValidity() === false)
        {
            const invalidDom = elements[i];
            ScrollToDom(invalidDom);
            break;
        }
    }
});

function ScrollToDom(invalidDom)
{
    if (invalidDom !== null)
    {
        console.log(invalidDom.validity);
        const bodyRect = document.body.getBoundingClientRect(),
            elemRect = invalidDom.getBoundingClientRect(),
            objTop = elemRect.top - bodyRect.top;
        window.scrollTo(0, objTop - (window.innerHeight / 2));
    }
}
```