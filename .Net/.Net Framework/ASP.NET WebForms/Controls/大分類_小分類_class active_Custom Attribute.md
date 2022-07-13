# 大分類 / 小分類 / class active / Custom Attribute 

- 透過 Custom Attribute 給定 Category Id
- 透過 ViewState 記住 Category Id
- 給定 active class

##### aspx

```cs
<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Webform01._Default" %>
<%@ Import Namespace="Webform01" %>

<asp:Content ID="BodyContent"
             ContentPlaceHolderID="MainContent"
             runat="server">

    <ul class="nav nav-tabs">

        <asp:Repeater runat='server'
                      ID="MainCategoryRepeater">
            <ItemTemplate>
                <%-- <li class='<%# MainCategoryId == Eval(nameof(CategoryDto.Id)).ToString() ? "active" : "" %>'> --%>
                <li class='<%# Eval(nameof(CategoryDto.ActiveClass)) %>'>
                    <asp:LinkButton runat="server"
                                    NavigateUrl="#"
                                    ID="MainCategory"
                                    OnClick="MainCategory_OnClick"
                                    MainCategoryId='<%# Eval(nameof(CategoryDto.Id)) %>'>

                        <%# Eval(nameof(CategoryDto.Name)) %>
                    </asp:LinkButton>
                </li>
            </ItemTemplate>
        </asp:Repeater>

    </ul>

    <ul class="nav nav-tabs">
        <asp:Repeater runat='server'
                      ID="SubCategoryRepeater">
            <ItemTemplate>
                <li class='<%# Eval(nameof(CategoryDto.ActiveClass)) %>'>

                    <asp:LinkButton runat="server"
                                    NavigateUrl="#"
                                    ID="SubCategory"
                                    OnClick="SubCategory_OnClick"
                                    SubCategoryId='<%# Eval(nameof(CategoryDto.Id)) %>'>
                        <%# Eval(nameof(CategoryDto.Name)) %>
                    </asp:LinkButton>

                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>

    <div>
        <div>MainCategoryId: <%= MainCategoryId %></div>
        <div>SubCategoryId: <%= SubCategoryId %></div>
    </div>

</asp:Content>
```

##### aspx.cs

```cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Webform01
{
    public partial class _Default : Page
    {
        private Dictionary<int, CategoryDto> _categoryDtos;

        protected int? MainCategoryId
        {
            get => ViewState[nameof(MainCategoryId)] as int?;
            set => ViewState[nameof(MainCategoryId)] = value;
        }

        protected int? SubCategoryId
        {
            get => ViewState[nameof(SubCategoryId)] as int?;
            set => ViewState[nameof(SubCategoryId)] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // bind 預設值
                InitialCategoryDtos();
                BindMainCategory();
                BindSubCategory();
            }
        }

        private void InitialCategoryDtos()
        {
            _categoryDtos = new[]
                            {
                                new CategoryDto
                                {
                                    Id   = 1,
                                    Name = "Category 1",
                                    SubCategories = new[]
                                                    {
                                                        new CategoryDto { Id = 11, Name = " Category 11" },
                                                        new CategoryDto { Id = 12, Name = " Category 12" },
                                                        new CategoryDto { Id = 13, Name = " Category 13" },
                                                    }
                                },
                                new CategoryDto
                                {
                                    Id   = 2,
                                    Name = "Category 2",
                                    SubCategories = new[]
                                                    {
                                                        new CategoryDto { Id = 21, Name = " Category 21" },
                                                        new CategoryDto { Id = 22, Name = " Category 22" },
                                                        new CategoryDto { Id = 23, Name = " Category 23" },
                                                    }
                                },
                                new CategoryDto
                                {
                                    Id   = 3,
                                    Name = "Category 3",
                                    SubCategories = new[]
                                                    {
                                                        new CategoryDto { Id = 31, Name = " Category 31" },
                                                        new CategoryDto { Id = 32, Name = " Category 32" },
                                                        new CategoryDto { Id = 33, Name = " Category 33" },
                                                    }
                                },
                                new CategoryDto
                                {
                                    Id   = 4,
                                    Name = "Category 4",
                                    SubCategories = new[]
                                                    {
                                                        new CategoryDto { Id = 41, Name = " Category 41" },
                                                        new CategoryDto { Id = 42, Name = " Category 42" },
                                                        new CategoryDto { Id = 43, Name = " Category 43" },
                                                    }
                                },
                                new CategoryDto
                                {
                                    Id   = 5,
                                    Name = "Category 5",
                                    SubCategories = new[]
                                                    {
                                                        new CategoryDto { Id = 51, Name = " Category 51" },
                                                        new CategoryDto { Id = 52, Name = " Category 52" },
                                                        new CategoryDto { Id = 53, Name = " Category 53" },
                                                    }
                                },
                            }.ToDictionary(kv => kv.Id);

            // update active class
            var activeClass = "active";
            var emptyClass  = "";

            foreach (var mainCategoryDto in _categoryDtos.Values)
            {
                mainCategoryDto.ActiveClass = MainCategoryId == mainCategoryDto.Id ? activeClass : emptyClass;

                foreach (var subCategoryDto in mainCategoryDto.SubCategories)
                {
                    subCategoryDto.ActiveClass = SubCategoryId == subCategoryDto.Id ? activeClass : emptyClass;
                }
            }
        }

        private void BindMainCategory()
        {
            MainCategoryRepeater.DataSource = _categoryDtos.Values;
            MainCategoryRepeater.DataBind();
        }

        protected void MainCategory_OnClick(object sender, EventArgs e)
        {
            MainCategoryId = Int32.Parse(((LinkButton)sender).Attributes[nameof(MainCategoryId)]);

            // bind active class
            InitialCategoryDtos();
            BindMainCategory();

            SubCategoryId = null;
            BindSubCategory(MainCategoryId);
        }

        private void BindSubCategory(int? mainCategoryId = null)
        {
            if (mainCategoryId == null)
            {
                return;
            }

            var subCategories = _categoryDtos[mainCategoryId.GetValueOrDefault()].SubCategories;

            SubCategoryRepeater.DataSource = subCategories;
            SubCategoryRepeater.DataBind();
        }

        protected void SubCategory_OnClick(object sender, EventArgs e)
        {
            SubCategoryId = Int32.Parse(((LinkButton)sender).Attributes[nameof(SubCategoryId)]);

            // bind active class
            InitialCategoryDtos();
            BindSubCategory(MainCategoryId);
        }
    }

    public class CategoryDto
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string ActiveClass { get; set; }

        public CategoryDto[] SubCategories { get; set; }
    }
}
```