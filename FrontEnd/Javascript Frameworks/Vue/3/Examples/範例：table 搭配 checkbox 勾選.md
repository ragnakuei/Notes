# 範例：table 搭配 checkbox 勾選

設計意圖
- 額外建立一個 ref 變數，去記錄已經勾選的 value
- 勾選各 row 的情境
  - 按下 row 勾選該 row 的 checkbox
    - 要使用 toggleSelectedMemberId(id)
  - 按下 td 勾選該 td 內的 checkbox
    - 要使用 toggleSelectedMemberId(id)
  - checkbox 控制項，給定 value 
    - 直接用 v-model 
- 全選 checkbox 的做法
  - 用 computed 來計算，如果 row 筆數等於已勾選筆數，則勾選全選 checkbox

## 進入頁面後，要按下鈕才顯示要勾選的項目

額外增加的設計意圖
- opeartionMode 用來判斷目前按下按鈕的狀態，是 bulkRemove mode 還是一般模式
- showCheckBoxes 用來判斷是否要顯示 checkbox

```html
<template>
  <div>
    <h3>List</h3>
    <table class='table'>
      <thead>
        <tr>
          <th class='checkbox'
              v-on:click='selectAllMemberIds()'>
            <input type='checkbox'
                   v-if='showCheckBoxes'
                   v-bind:checked='allSelected'/>
          </th>
          <th>displayName</th>
          <th>role</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for='member in members'
            v-bind:key='member?.id'
            v-on:click='toggleSelectedMemberId(member?.id)'>
          <td>
            <input type='checkbox'
                   v-bind:checked='selectedMemberIds.includes(member?.id)'
                   v-if='showCheckBoxes'/>
          </td>
          <td>{{ member?.displayName }}</td>
          <td>{{ member?.roles[0] ?? "member" }}</td>
        </tr>
      </tbody>
    </table>
    <div class='d-flex gap-1'>
      <template v-if="opeartionMode === ''">
        <router-link class='btn btn-primary'
                     v-bind:to="{ name : 'TeamMembersAdd', params: { teamId : teamId } }">
            Bulk Add
        </router-link>
        <button class='btn btn-danger'
                v-on:click='toBulkRemoveMode()'>
          Bulk Remove
        </button>
      </template>
      <template v-if="opeartionMode !== ''">
        <button class='btn btn-danger'
                v-on:click='confirmBulkRemove()'>
          Confirm Bulk Remove
        </button>
        <button class='btn btn-primary'
                v-on:click='toNormalMode()'>
          Cancel
        </button>
      </template>
      <router-link v-bind:to="{ name: 'TeamsList' }"
                   class='btn btn-secondary'
                   type='button'>Back</router-link>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref, computed } from "vue";
import { useRoute, useRouter } from "vue-router";
import TeamMembersService from "../../../services/TeamMembersService";

const router = useRouter();
const route = useRoute();

const teamId = ref( route.params.teamId?.toString() );
const members = ref( [] );
const showCheckBoxes = ref( false );
const opeartionMode = ref( "" );

function getList() {
    TeamMembersService.getAll( teamId.value ).then( ( response ) => {
        members.value = response;
    } );
}

function toNormalMode() {
    selectedMemberIds.value = [];
    showCheckBoxes.value = false;
    opeartionMode.value = "";
}

function toBulkRemoveMode() {
    selectedMemberIds.value = [];
    showCheckBoxes.value = true;
    opeartionMode.value = "bulkRemove";
}

const selectedMemberIds = ref( [] );

const allSelected = computed( () => {
    return selectedMemberIds.value.length === members.value.length;
} );

function selectAllMemberIds() {
    if( showCheckBoxes.value ) {
        if( selectedMemberIds.value.length === members.value.length ) {
            selectedMemberIds.value = [];
        } else {
            selectedMemberIds.value = members.value.map( ( member ) => member.id );
        }
    }
}

function toggleSelectedMemberId( memberId ) {
    if( showCheckBoxes.value ) {
        if( selectedMemberIds.value.includes( memberId ) ) {
            selectedMemberIds.value = selectedMemberIds.value.filter( ( id ) => id !== memberId );
        } else {
            selectedMemberIds.value.push( memberId );
        }
    }
}

function confirmBulkRemove() {
    TeamMembersService.bulkRemove( teamId.value, selectedMemberIds.value )
        .then( ( response ) => {
            getList();
            toNormalMode();
        } );
}

onMounted( () => {
    getList();
} );
</script>

<style scoped>
.checkbox {
    width: 30px;
}
</style>
```


## 進入頁面就直接顯示要勾選的項目


```html
<template>
  <form v-on:submit.prevent='confirm()'>
    <h3>Bulk Add</h3>
    <table class='table'>
      <thead>
        <tr>
          <th class='checkbox'
              v-on:click='selectAllMemberIds()'>
            <input type='checkbox'
                   v-bind:checked='allSelected'/>
          </th>
          <th>displayName</th>
          <th>role</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for='user in notInTeamMemberUsers'
            v-bind:key='user?.id'>
          <td v-on:click='toggleSelectedMemberId(user?.id)'>
            <input type='checkbox'
                   v-bind:value='user?.id'
                   v-model='selectedMemberIds'/>
          </td>
          <td>{{ user?.displayName }}</td>
          <td>
            <select class='form-select'
                    v-bind:required='selectedMemberIds.includes(user?.id)'
                    v-model='user.role'>
              <option v-for='role in roles'
                      v-bind:key='role.Value'
                      v-bind:value='role.Value'>
                {{ role.Text }}
              </option>
            </select>
          </td>
        </tr>
      </tbody>
    </table>
    <div class='d-flex gap-1'>
      <button class='btn btn-danger'>Confirm Bulk Add</button>
      <button class='btn btn-secondary'
              v-on:click='toListPage()'
              type='bittpm'>
        Back
      </button>
    </div>
  </form>
</template>

<script setup>
import { onMounted, ref, computed } from "vue";
import { useRoute, useRouter } from "vue-router";
import UsersService from "../../../services/UsersService";
import TeamMembersService from "../../../services/TeamMembersService";
import OptionsService from "../../../services/OptionsService";

const router = useRouter();
const route = useRoute();

const teamId = ref( route.params.teamId?.toString() );
const teamMemberUserIds = ref( [] );
const notInTeamMemberUsers = ref( [] );
const allUsers = ref( [] );
const roles = ref( [] );

const selectedMemberIds = ref( [] );

const allSelected = computed( () => {
    return notInTeamMemberUsers.value.length > 0
        && selectedMemberIds.value.length === notInTeamMemberUsers.value.length;
} );

function selectAllMemberIds() {
    if( selectedMemberIds.value.length === notInTeamMemberUsers.value.length ) {
        selectedMemberIds.value = [];
    } else {
        selectedMemberIds.value = notInTeamMemberUsers.value.map(
            ( member ) => member.id
        );
    }
}

function toggleSelectedMemberId( memberId ) {
    if( selectedMemberIds.value.includes( memberId ) ) {
        selectedMemberIds.value = selectedMemberIds.value.filter(
            ( id ) => id !== memberId
        );
    } else {
        selectedMemberIds.value.push( memberId );
    }
}

function confirm() {
    const toBackendDtos = {
        values: selectedMemberIds.value.map(
            ( id ) => {
                const user = {
                    userId: id,
                    roles : []
                };

                const role = notInTeamMemberUsers.value.find( ( user ) => user.id === id ).role;
                if(role) {
                    user.roles.push( role );
                }

                return user;
            }
        )
    };

    TeamMembersService.bulkAdd( teamId.value, toBackendDtos ).then(
        ( response ) => {
            toListPage();
        }
    );
}

function toListPage() {
    router.push( { name: "TeamMembersList", params: { teamId: teamId.value } } );
}

onMounted( async() => {
    teamMemberUserIds.value = (await TeamMembersService.getAll( teamId.value )).map(
        ( user ) => user.userId
    );
    // console.log( 'teamMemberUserIds.value', teamMemberUserIds.value );

    allUsers.value = await UsersService.getAll();
    // console.log( 'allUsers.value', allUsers.value );

    roles.value = await OptionsService.getRole();

    notInTeamMemberUsers.value = allUsers.value.filter( ( user ) => {
        // console.log('user.id', user.id);
        // console.log( 'teamMemberUserIds.value.includes( user.id )', teamMemberUserIds.value.includes( user.id ) );

        return !teamMemberUserIds.value.includes( user.id );
    } );
    // console.log( 'notInTeamMemberUserIds.value', notInTeamMemberUsers.value );
} );
</script>

<style scoped>
.checkbox {
    width: 30px;
}
</style>
```

