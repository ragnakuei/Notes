# Windows 10 上啟用 Nested Virtualization

參考

- [Run Hyper-V in a Virtual Machine with Nested Virtualization](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/user-guide/nested-virtualization)

## 步驟

1. 以下步驟都在 power shell 中執行

1. 列出所有的 VM Name

    ```
    Get-VM
    ```

1. 啟用 nested virtualization。 您可以使用以下命令啟用 nested virtualization：

    ```
    Set-VMProcessor -VMName <VMName> -ExposeVirtualizationExtensions $true
    ```

    其中，<VMName> 是您想要啟用 nested virtualization 的虛擬機器的名稱。


