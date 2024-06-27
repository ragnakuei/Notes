# File Layout

可以透過 ReSharper 設定後，轉成 XAML ，再貼到 Rider 來套用 !

路徑

> Settings > Editor > Code Style > C#

## 已套用之設定

```xml
<?xml version="1.0" encoding="utf-16"?>
<Patterns xmlns="urn:schemas-jetbrains-com:member-reordering-patterns">
    <TypePattern DisplayName="Non-reorderable types">
        <TypePattern.Match>
            <Or>
                <And>
                    <Kind Is="Interface" />
                    <Or>
                        <HasAttribute Name="System.Runtime.InteropServices.InterfaceTypeAttribute" />
                        <HasAttribute Name="System.Runtime.InteropServices.ComImport" />
                    </Or>
                </And>
                <Kind Is="Struct" />
                <HasAttribute Name="JetBrains.Annotations.NoReorderAttribute" />
                <HasAttribute Name="JetBrains.Annotations.NoReorder" />
            </Or>
        </TypePattern.Match>
    </TypePattern>
    <TypePattern DisplayName="xUnit.net Test Classes" RemoveRegions="All">
        <TypePattern.Match>
            <And>
                <Kind Is="Class" />
                <HasMember>
                    <And>
                        <Kind Is="Method" />
                        <HasAttribute Name="Xunit.FactAttribute" Inherited="True" />
                    </And>
                </HasMember>
            </And>
        </TypePattern.Match>
        <Entry DisplayName="Setup/Teardown Methods">
            <Entry.Match>
                <Or>
                    <Kind Is="Constructor" />
                    <And>
                        <Kind Is="Method" />
                        <ImplementsInterface Name="System.IDisposable" />
                    </And>
                </Or>
            </Entry.Match>
            <Entry.SortBy>
                <Kind Order="Constructor" />
            </Entry.SortBy>
        </Entry>
        <Entry DisplayName="All other members" />
        <Entry DisplayName="Test Methods" Priority="100">
            <Entry.Match>
                <And>
                    <Kind Is="Method" />
                    <HasAttribute Name="Xunit.FactAttribute" />
                </And>
            </Entry.Match>
            <Entry.SortBy>
                <Name />
            </Entry.SortBy>
        </Entry>
    </TypePattern>
    <TypePattern DisplayName="NUnit Test Fixtures" RemoveRegions="All">
        <TypePattern.Match>
            <And>
                <Kind Is="Class" />
                <HasAttribute Name="NUnit.Framework.TestFixtureAttribute" Inherited="True" />
            </And>
        </TypePattern.Match>
        <Entry DisplayName="Setup/Teardown Methods">
            <Entry.Match>
                <And>
                    <Kind Is="Method" />
                    <Or>
                        <HasAttribute Name="NUnit.Framework.SetUpAttribute" Inherited="True" />
                        <HasAttribute Name="NUnit.Framework.TearDownAttribute" Inherited="True" />
                        <HasAttribute Name="NUnit.Framework.FixtureSetUpAttribute" Inherited="True" />
                        <HasAttribute Name="NUnit.Framework.FixtureTearDownAttribute" Inherited="True" />
                    </Or>
                </And>
            </Entry.Match>
        </Entry>
        <Entry DisplayName="All other members" />
        <Entry DisplayName="Test Methods" Priority="100">
            <Entry.Match>
                <And>
                    <Kind Is="Method" />
                    <HasAttribute Name="NUnit.Framework.TestAttribute" />
                </And>
            </Entry.Match>
            <Entry.SortBy>
                <Name />
            </Entry.SortBy>
        </Entry>
    </TypePattern>
    <TypePattern DisplayName="Default Pattern">
        <Entry DisplayName="Constructors" Priority="100">
            <Entry.Match>
                <Kind Is="Constructor" />
            </Entry.Match>
            <Entry.SortBy>
                <Static />
            </Entry.SortBy>
        </Entry>
        <Entry DisplayName="Interface Implementations" Priority="100">
            <Entry.Match>
                <And>
                    <Kind Is="Member" />
                    <ImplementsInterface />
                </And>
            </Entry.Match>
            <Entry.SortBy>
                <ImplementsInterface Immediate="True" />
            </Entry.SortBy>
        </Entry>
        <Entry DisplayName="Static Fields and Constants">
            <Entry.Match>
                <Or>
                    <Kind Is="Constant" />
                    <And>
                        <Kind Is="Field" />
                        <Static />
                    </And>
                </Or>
            </Entry.Match>
            <Entry.SortBy>
                <Kind />
                <Access />
            </Entry.SortBy>
        </Entry>
        <Entry DisplayName="Public Member">
            <Entry.Match>
                <Access Is="Public" />
            </Entry.Match>
            <Entry.SortBy>
                <Name />
            </Entry.SortBy>
        </Entry>
        <Entry DisplayName="Internal Member">
            <Entry.Match>
                <Access Is="Internal" />
            </Entry.Match>
            <Entry.SortBy>
                <Name />
            </Entry.SortBy>
        </Entry>
        <Entry DisplayName="Protected Member">
            <Entry.Match>
                <Access Is="Protected" />
            </Entry.Match>
            <Entry.SortBy>
                <Name />
            </Entry.SortBy>
        </Entry>
        <Entry DisplayName="Private Member">
            <Entry.Match>
                <Access Is="Private" />
            </Entry.Match>
            <Entry.SortBy>
                <Name />
            </Entry.SortBy>
        </Entry>
        <Entry DisplayName="Properties, Indexers">
            <Entry.Match>
                <Or>
                    <Kind Is="Property" />
                    <Kind Is="Indexer" />
                </Or>
            </Entry.Match>
        </Entry>
        <Entry DisplayName="Fields">
            <Entry.Match>
                <And>
                    <Kind Is="Field" />
                    <Not>
                        <Static />
                    </Not>
                </And>
            </Entry.Match>
            <Entry.SortBy>
                <Readonly />
                <Name />
            </Entry.SortBy>
        </Entry>
        <Entry DisplayName="Public Enums">
            <Entry.Match>
                <And>
                    <Access Is="Public" />
                    <Kind Is="Enum" />
                </And>
            </Entry.Match>
            <Entry.SortBy>
                <Name />
            </Entry.SortBy>
        </Entry>
        <Entry DisplayName="Nested Types">
            <Entry.Match>
                <Kind Is="Type" />
            </Entry.Match>
        </Entry>
        <Entry DisplayName="All other members" />
    </TypePattern>
</Patterns>
```
