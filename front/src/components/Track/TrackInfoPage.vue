<template>
  <div class="flex-wrap p-2 sm:ml-64">
    <div
      class="p-2 border-gray-200 border-dashed rounded-lg dark:border-gray-700 mt-14"
    >
      <div class="gap-10 sticky top-0">
        <div class="flex flex-col gap-10">
          <!-- NOTE: list view -->
          <div
            class="text-gray-900 dark:text-white mb-5 pb-5 border-gray-600 border-b"
          >
            <p class="text-3xl text-center font-bold">이력 조회</p>
          </div>
          <div class="flex flex-row m-auto">
            <div class="items-center px-3">
              <label
                for="default-input"
                class="block mb-3 text-xl font-medium text-gray-900 dark:text-white"
                >이력관리번호(조회하려는 이력관리번호를 입력)</label
              >
              <input
                type="text"
                v-model="track_info.tra_mng_no"
                id="default-input"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-xl rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
              />
            </div>
            <div class="items-center px-3">
              <label
                for="default-input"
                class="block mb-3 text-xl font-medium text-gray-900 dark:text-white"
                >상품일련번호(상품일련번호를 입력)
              </label>
              <input
                type="text"
                v-model="track_info.gds_seq"
                id="default-input"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-xl rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
              />
            </div>
            <div class="items-center px-3">
              <label
                for="default-input"
                class="block mb-3 text-xl font-medium text-gray-900 dark:text-white"
                >단계구분(10:생산, 20: 유통, 30: 판매)</label
              >
              <input
                type="text"
                v-model="track_info.mng_dvs"
                id="default-input"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-xl rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
              />
            </div>
          </div>

          <div class="m-auto px-3">
            <button
              @click="getTrackInfoUrl"
              class="relative inline-flex items-center px-5 py-2.5 text-xl font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
            >
              선택
            </button>
          </div>

          <div>
            <div class="gap-5 grow h-min">
              <div
                class="p-4 bg-white border rounded-lg sm:p-8 dark:bg-gray-800 dark:border-gray-700 flex flex-col gap-5"
              >
                <h5
                  class="text-2xl text-center font-bold leading-none text-gray-900 dark:text-white pb-5 border-gray-600 border-b"
                >
                  <div class="flex-wrap gap-6">
                    <button
                      v-for="(track_info, index) in all_track_info"
                      :key="index"
                      class="relative inline-flex p-0.5 mb-2 mr-2 overflow-hidden text-xl font-medium text-gray-900 rounded-lg group bg-gradient-to-br from-purple-600 to-blue-500 group-hover:from-purple-600 group-hover:to-blue-500 hover:text-white dark:text-white focus:ring-4 focus:outline-none focus:ring-blue-300 dark:focus:ring-blue-800"
                      v-on:click="selectTrackInfo(index)"
                    >
                      <span
                        class="relative px-5 py-2.5 transition-all ease-in duration-75 rounded-md group-hover:bg-opacity-0"
                      >
                        {{ track_info.sale_loc[0] }}
                      </span>
                    </button>
                  </div>
                </h5>

                <div id="export" class="relative sm:rounded-lg">
                  <div class="flex flex-col">
                    <div
                      v-for="(value, key) in selected_track_info"
                      :key="key"
                      class="m-auto relative inline-flex p-0.5 mb-2 text-xl font-medium text-gray-900 dark:text-white"
                    >
                      {{ key }} : {{ value[0] }}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
const xml2js = require("xml2js");
const parser = new xml2js.Parser(/* options */);

export default {
  name: "app",
  data() {
    return {
      track_info: {
        tra_mng_no: "003178111111",
        gds_seq: "2",
        mng_dvs: "10",
      },
      all_track_info: [],
      selected_track_info: {},
    };
  },
  methods: {
    getTrackInfoUrl() {
      var url = "https://cors-anywhere.herokuapp.com/";
      url +=
        "http://data.naqs.go.kr/openapi/services/rest/FrmprdHistManageInfoInqireSvc/getGoodsAttrbInfoInqire"; /*URL*/
      var queryParams =
        "?" +
        encodeURIComponent("serviceKey") +
        "=" +
        "DwrUTa6PFAjNeMuw8LcmpTeOD8AcBJb6pxu43DZo7NxKfQWlNUYh%2FZdoW8afVnB%2BeqtHxWevizngU9Wwm9X1OQ%3D%3D"; /*Service Key*/
      queryParams +=
        "&" +
        encodeURIComponent("tra_mng_no") +
        "=" +
        encodeURIComponent("003178111111"); /**/
      queryParams +=
        "&" +
        encodeURIComponent("gds_seq") +
        "=" +
        encodeURIComponent("2"); /**/
      queryParams +=
        "&" +
        encodeURIComponent("mng_dvs") +
        "=" +
        encodeURIComponent("10"); /**/
      url += queryParams;
      this.getTrackInfo(url);
    },
    getTrackInfo(url) {
      this.$axios
        .get(url, {})
        .then((res) => {
          var json_data = [];
          parser.parseString(res.data, function (err, result) {
            console.log(err);
            result.response.body[0].items[0].item.forEach((element1, index) => {
              var keys = Object.keys(element1); //키를 가져옵니다.
              console.log(index + 1 + "번째");
              json_data.push({});

              keys.forEach((element2) => {
                if (element1[element2] != "") {
                  console.log(
                    "key : " + element2 + " || value : " + element1[element2]
                  );
                  json_data[index][element2] = element1[element2];
                }
              });
            });
          });
          this.all_track_info = json_data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    selectTrackInfo(index) {
      console.log(index);
      this.selected_track_info = this.all_track_info[index];
      console.log(this.all_track_info[index]);
    },
  },
};
</script>
