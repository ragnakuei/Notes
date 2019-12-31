# [GridControl](https://documentation.devexpress.com/WPF/6084/Controls-and-Libraries/Data-Grid)

套件
> DevExpress.Xpf.Grid.v19.2
> DevExpress.Xpf.Grid.v19.2.Core
> DevExpress.Xpf.Grid.v19.2.Extensions

- FilterString 的 Binding 需要以下𤨔境
  - ViewModel 只能用 ViewModelSource 的方式來達成，不能用 PocoModel，也不能用 ViewModelBase
  - Binding Property 都使用 virtual 宣告
  - [reference](https://github.com/DevExpress-Examples/how-to-use-enumitemssourcebehavior-t196946)

```xml

```