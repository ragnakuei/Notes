# 加上 Light 的方式

1. 停用 Camera 的 Lighting

    把 Camera.ShowCameraLight 設定成 `Never`

    ```xml
    <cameras:TargetPositionCamera
        x:Name="SideViewCamera"
        Heading="0"
        Attitude="90"
        Bank="0"
        Distance="{Binding SideViewCameraDistance, Mode=TwoWay}"
        ShowCameraLight="Never"
        TargetPosition="0 0 0"
        TargetViewport3D="{Binding ElementName=SideView, Path=Viewport3D}" />
    ```

1. 加上 LightingRigVisual3D

在 Viewport3D 內加上 `LightingRigVisual3D`

```xml
<Viewport3D Name="MainViewport">

    <visuals:ObjModelVisual3D Source="/Resources/ObjFiles/WaltHead.obj"
                                Position="0 -30 0" PositionType="BottomCenter"
                                DefaultBackMaterial="Gray"/>

    <visuals:LightingRigVisual3D x:Name="LigthingRig" KeyLightDirection="0 0 -1" />

</Viewport3D>
```

就可以了 !