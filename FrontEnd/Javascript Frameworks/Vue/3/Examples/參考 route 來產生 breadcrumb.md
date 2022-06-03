# 參考 route 來產生 breadcrumb


route/index.js

- meta 可給定自訂的 properties
- 此範例給定 breadcrumbItem，之後用於生成 breadcrumb
- 可依照需要產生的 breadcrumb 結構，來給定 給定 breadcrumbItem
- 該 component 下的 breadcrumbItem 也可以給定其他 component 的 !
- 下面的範例，會在各個同性質的 components 加上 Base.vue，是為了預防會需要在同性質的 component 加上共通的資料

```js
import { createRouter, createWebHistory } from "vue-router";
import UsersBase from "../components/Users/Base.vue";
import UsersList from "../components/Users/List.vue";
import UserBase from "../components/Users/User/Base.vue";
import UserDetail from "../components/Users/User/Detail.vue";
import UserOnlineMeetingsBase from "../components/Users/User/OnlineMeetings/Base.vue";
import UserOnlineMeetings from "../components/Users/User/OnlineMeetings/List.vue";
import UserMeetingDetail from "../components/Users/User/OnlineMeetings/Detail.vue";
import UserMeetingEdit from "../components/Users/User/OnlineMeetings/Edit.vue";
import UserEvents from "../components/Users/User/Events.vue";
import UserCreateEvent from "../components/Users/User/Event/Create.vue";
import UserEditEvent from "../components/Users/User/Event/Create.vue";
import GroupsBase from "../components/Groups/Base.vue";
import GroupsList from "../components/Groups/List.vue";
import GroupCreate from "../components/Groups/Edit.vue";
import GroupEdit from "../components/Groups/Edit.vue";
import TeamsBase from "../components/Teams/Base.vue";
import TeamsList from "../components/Teams/List.vue";
import TeamBase from "../components/Teams/Team/Base.vue";
import TeamCreate from "../components/Teams/Team/Create.vue";
import TeamEdit from "../components/Teams/Team/Edit.vue";
import TeamMembersBase from "../components/Teams/Team/Members/Base.vue";
import TeamMembersList from "../components/Teams/Team/Members/List.vue";
import TeamMembersCreate from "../components/Teams/Team/Members/Create.vue";
import TeamMembersEdit from "../components/Teams/Team/Members/Edit.vue";

const routes = [
    {
        path: "/",
        name: "Home",
        component: () => import("../components/Home.vue"),
        meta: {
            breadcrumbItem: { text: "Home", linkTo: { name: "Home" } },
        }
    },
    {
        path: "/Users",
        name: "UsersBase",
        component: UsersBase,
        meta: {
            breadcrumbItem: { text: "Users", linkTo: { name: "UsersList" } },
        },
        children: [
            {
                path: '',
                name: 'UsersList',
                component: UsersList
            },
            {
                path: ':userId',
                name: 'UserBase',
                component: UserBase,
                meta: {
                    breadcrumbItem: { text: "User", linkTo: { name: "UserDetail" } },
                },
                children: [
                    {
                        path: '',
                        name: 'UserDetail',
                        component: UserDetail
                    },
                    {
                        path: 'OnlineMeetings',
                        name: 'UserOnlineMeetingsBase',
                        component: UserOnlineMeetingsBase,
                        children: [
                            {
                                path: 'List',
                                name: 'UserOnlineMeetingsList',
                                component: UserOnlineMeetings,
                                meta: {
                                    breadcrumbItem: { text: "OnlineMeetings", linkTo: { name: "UserOnlineMeetingsList" } },
                                },
                            },
                            {
                                path: 'Create',
                                name: 'MeetingCreate',
                                component: UserMeetingEdit,
                                meta: {
                                    breadcrumbItem: { text: "Create", linkTo: { name: "MeetingCreate" } },
                                },
                            },
                            {
                                path: ':meetingId/Detail',
                                name: 'MeetingDetail',
                                component: UserMeetingDetail,
                                meta: {
                                    breadcrumbItem: { text: "Detail", linkTo: { name: "MeetingDetail" } },
                                },
                            },
                            {
                                path: ':meetingId/Edit',
                                name: 'MeetingEdit',
                                component: UserMeetingEdit,
                                meta: {
                                    breadcrumbItem: { text: "Edit", linkTo: { name: "MeetingEdit" } },
                                },
                            },
                        ]
                    },
                    {
                        path: 'Events',
                        name: 'UserEvents',
                        component: UserEvents,
                        meta: {
                            breadcrumbItem: { text: "Events", linkTo: { name: "UserEvents" } },
                        },
                    },
                    {
                        path: 'Events/CreateEvent',
                        name: 'UserCreateEvent',
                        component: UserCreateEvent,
                        meta: {
                            breadcrumbItem: { text: "Create", linkTo: { name: "UserCreateEvent" } },
                        },
                    },
                    {
                        path: 'Events/:eventId/EditAttendees',
                        name: 'UserEditEvent',
                        component: UserEditEvent,
                        meta: {
                            breadcrumbItem: { text: "Edit", linkTo: { name: "UserEditEvent" } },
                        },
                    },
                ]
            }
        ]
    },
    {
        path: "/Groups",
        name: "GroupsBase",
        component: GroupsBase,
        children: [
            {
                path: '',
                name: 'GroupsList',
                component: GroupsList,
                meta: {
                    breadcrumbItem: { text: "Groups", linkTo: { name: "GroupsList" } },
                },
            },
            {
                path: 'Create',
                name: 'GroupCreate',
                component: GroupCreate,
                meta: {
                    breadcrumbItem: { text: "Create", linkTo: { name: "GroupCreate" } },
                },
            },
            {
                path: ':groupId/Edit',
                name: 'GroupEdit',
                component: GroupEdit,
                meta: {
                    breadcrumbItem: { text: "Edit", linkTo: { name: "GroupEdit" } },
                },
            }
        ]
    },
    {
        path: "/Teams",
        name: "TeamsBase",
        component: TeamsBase,
        children: [
            {
                path: '',
                name: 'TeamsList',
                component: TeamsList,
                meta: {
                    breadcrumbItem: { text: "Teams", linkTo: { name: "TeamsList" } },
                },
            },
            {
                path: 'Create',
                name: 'TeamCreate',
                component: TeamCreate,
                meta: {
                    breadcrumbItem: { text: "Create", linkTo: { name: "TeamCreate" } },
                },
            },
            {
                path: ':teamId',
                name: 'TeamBase',
                component: TeamBase,
                meta: {
                    breadcrumbItem: { text: "Teams", linkTo: { name: "TeamsList" } },
                },
                children: [
                    {
                        path: 'Edit',
                        name: 'TeamEdit',
                        component: TeamEdit,
                        meta: {
                            breadcrumbItem: { text: "Edit", linkTo: { name: "TeamEdit" } },
                        },
                    },
                    {
                        path: 'Members',
                        name: 'TeamMembersBase',
                        component: TeamMembersBase,
                        meta: {
                            breadcrumbItem: { text: "Members", linkTo: { name: "TeamMembersList" } },
                        },
                        children: [
                            {
                                path: '',
                                name: 'TeamMembersList',
                                component: TeamMembersList
                            },
                            {
                                path: 'Edit',
                                name: 'TeamMembersEdit',
                                component: TeamMembersEdit,
                                meta: {
                                    breadcrumbItem: { text: "Edit", linkTo: { name: "TeamMembersEdit" } },
                                },
                            },
                            {
                                path: 'Create',
                                name: 'TeamMembersCreate',
                                component: TeamMembersCreate,
                                meta: {
                                    breadcrumbItem: { text: "Create", linkTo: { name: "TeamMembersCreate" } },
                                },
                            },
                        ]
                    },
                ]
            },
        ]
    },
];
export default createRouter( {
    history: createWebHistory(),
    linkActiveClass: "active",
    routes,
} );
```

store/breadcrumb.js
```js
import { computed, ref } from "vue";
export default new class store {
  
  // item 格式為 { text, linkTo }
  items = ref([]);

  constructor() {
  }

  set(items) {
    this.items.value = items;
  }
}
```

breadcrumb.vue

- 存取其他 js 內的 js ref 變數，要記得加上 .value !

```js
<template>
  <nav aria-label='breadcrumb' class='m-1'>
    <ol class='breadcrumb'>
      <template v-for='item in breadcrumbStore.items.value'>
        <template v-if='item?.linkTo'>
          <li class='breadcrumb-item'>
              <router-link v-bind:to='item?.linkTo'>
                  {{ item?.text }}
              </router-link>
          </li>
        </template>

        <template v-if='!item?.linkTo'>
          <li class='breadcrumb-item active'
              aria-current='page'>
              {{ item?.text }}
          </li>
        </template>
      </template>
    </ol>
  </nav>
</template>

<script setup>
import { onMounted, ref, computed } from "vue";
import breadcrumbStore from "../store/breadcrumb";
</script>

<style scoped></style>
```


App.vue

```js
<template>
  <div class='container'>
    <Nav></Nav>
    <Breadcrumb></Breadcrumb>
    <router-view></router-view>
    <Footer></Footer>
    <Spinner></Spinner>
  </div>
</template>

<script setup>
import { watch } from "vue";
import { useRoute, useRouter } from "vue-router";
import Nav from "./components/Nav.vue";
import Spinner from "./components/Spinner.vue";
import Footer from "./components/Footer.vue";
import Breadcrumb from "./components/Breadcrumb.vue";
import breadcrumbStore from "./store/breadcrumb";

const router = useRouter();
const route = useRoute();

watch( () => route.matched,
    ( newRoutes ) => {

        console.log( 'route.matched', newRoutes );
        console.log( 'route.params', route.params );

        const breadcrumbItems = [];

        for( const newRoute of newRoutes ) {

            if( !newRoute?.meta?.breadcrumbItem ) {
                continue;
            }

            newRoute.meta.breadcrumbItem.linkTo.params = JSON.parse(JSON.stringify(route.params));

            breadcrumbItems.push(newRoute.meta.breadcrumbItem);
        }

        console.log( 'breadcrumbItems', breadcrumbItems );

        breadcrumbStore.set( breadcrumbItems );

    } );

</script>
```
