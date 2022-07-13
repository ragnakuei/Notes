# flex cards 都同高

- 直接以 `v-bind:ref="el => card_doms.push(el)"` 來綁定 ref([]) 即可 !
- 當 card_max_height 被給定超過 1 的值後，就不需要重新計算 & 給定 height !
  - 其中 card_max_height.value 2 的部份會跑二次
    - 第 1 次只抓得到 0 !
    - 第 2 次才抓得到所有 card dom 的 max height !

```html
<html lang="en">

<head>
    <meta charset="utf-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <style>
        [v-cloak] {
            display: none;    
        }

        .container {
            margin: 50px;
        }

        .card {
            width: 300px;
            margin: 5px;
        }

        .card-body {
            width: 200px;
        }
    </style>
</head>
<body>

    <div id="app" v-cloak class="container">
        <div class="d-flex flex-wrap">
            <div class="card" 
                 v-for="(item, itemIndex) in items" 
                 v-bind:ref="el => card_doms.push(el)"
                 v-bind:style="card_heignt"
                 >
                <div class="d-flex flex-row" >
                    <div class="card-image">
                        <img v-bind:src="item.image" class="card-img-top" alt="...">
                    </div>
                    <div>
                        <div class="card-body">
                            <h5 class="card-title">{{ itemIndex + 1 }} {{ item.title }}</h5>
                            <p class="card-text">{{ item.content }}</p>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
 

    <script src="https://unpkg.com/vue@next"></script>
    <script>
        const { createApp, ref, computed } = Vue;

        const app = createApp({
            setup() {

                const items = ref([
                    {
                        title: "Driffe",
                        content: "Fragmentation in Respiratory Tract, External Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Halsted",
                        content: "Release Right Subclavian Vein, Percutaneous Endoscopic Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Frill",
                        content: "Revision of Drainage Device in Left Hip Joint, External Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Dimitriev",
                        content: "Replacement of Right Toe Phalangeal Joint with Synthetic Substitute, Open Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Grabb",
                        content: "Inspection of Thoracolumbar Vertebral Joint, External Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Devany",
                        content: "Resection of Aortic Body, Open Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Eliaz",
                        content: "Release Right Acetabulum, Percutaneous Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Lycett",
                        content: "Reposition Left Metatarsal with Internal Fixation Device, Open Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Owbrick",
                        content: "Transfusion of Autologous Bone Marrow into Central Artery, Open Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Crown",
                        content: "Removal of External Fixation Device from Right Tarsal Joint, Percutaneous Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Smail",
                        content: "Extirpation of Matter from Left Orbit, Percutaneous Endoscopic Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Thornton-Dewhirst",
                        content: "Fusion of 8 or more Thoracic Vertebral Joints with Nonautologous Tissue Substitute, Anterior Approach, Anterior Column, Percutaneous Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Gabriel",
                        content: "Division of Left Knee Bursa and Ligament, Percutaneous Endoscopic Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Medforth",
                        content: "Dilation of Right Thyroid Artery with Four or More Drug-eluting Intraluminal Devices, Open Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Apfler",
                        content: "Dilation of Bladder with Intraluminal Device, Percutaneous Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Drable",
                        content: "Excision of Right Femoral Vein, Percutaneous Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Canfield",
                        content: "Beam Radiation of Mediastinum using Neutron Capture",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Piegrome",
                        content: "Dilation of Left Face Vein with Intraluminal Device, Open Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "Adney",
                        content: "Drainage of Right Parietal Bone with Drainage Device, Percutaneous Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }, {
                        title: "O'Malley",
                        content: "Bypass Left Common Iliac Artery to Right Internal Iliac Artery with Autologous Arterial Tissue, Percutaneous Endoscopic Approach",
                        image : "https://picsum.photos/seed/picsum/200/250"
                    }]
                );

                const card_doms = ref([]);
                
                const card_max_height = ref(0);

                const card_heignt = computed(() => {


                    if(card_max_height.value > 0) {
                        console.log('card_max_height.value 1', card_max_height.value);
                        return {
                            height: card_max_height.value + 'px',
                        }
                    }

                    const card_heights = card_doms.value.map(card_dom => card_dom.clientHeight);
                    card_max_height.value = Math.max(...card_heights, card_max_height.value);
                    console.log('card_max_height.value 2', card_max_height.value);

                    // 這段似乎不需要
                    // if(card_max_height.value > 0) {
                    //     return {
                    //         height: card_max_height.value + 'px',
                    //     }
                    // }

                    return { };
                });

                return {
                    items,
                    card_doms,
                    card_heignt,
                }
            }
        });

        const vm = app.mount('#app');
    </script>



</body>

</html>
```