curl https://atlas.hashicorp.com/api/v1/box/3drobotics/ardupilot-sitl/version/1.0/release \
        -X PUT \
        -d access_token='$ATLAS_TOKEN'

{"version":"1.0","status":"active","description_html":"<p>Initial SITL upload</p>\n","description_markdown":"Initial SITL upload","created_at":"2015-03-10T23:32:07.896Z","updated_at":"2015-03-24T17:29:54.027Z","number":"1.0","release_url":"https://atlas.hashicorp.com/api/v1/box/3drobotics/ardupilot-sitl/version/1.0/release","revoke_url":"https://atlas.hashicorp.com/api/v1/box/3drobotics/ardupilot-sitl/version/1.0/revoke","providers":[{"name":"virtualbox","hosted":true,"hosted_token":"98501d60-4613-450c-89c7-5c992816ed18","original_url":null,"created_at":"2015-03-10T23:32:35.269Z","updated_at":"2015-03-10T23:32:35.269Z","download_url":"https://atlas.hashicorp.com/3drobotics/boxes/ardupilot-sitl/versions/1.0/providers/virtualbox.box"}]}

{
  "version":"1.0",
  "status":"active",
  "description_html":"<p>Initial SITL upload</p>\n",
  "description_markdown":"Initial SITL upload",
  "created_at":"2015-03-10T23:32:07.896Z",
  "updated_at":"2015-03-24T17:29:54.027Z",
  "number":"1.0",
  "release_url":"https://atlas.hashicorp.com/api/v1/box/3drobotics/ardupilot-sitl/version/1.0/release",
  "revoke_url":"https://atlas.hashicorp.com/api/v1/box/3drobotics/ardupilot-sitl/version/1.0/revoke",
  "providers":[
    {
      "name":"virtualbox",
      "hosted":true,
      "hosted_token":"98501d60-4613-450c-89c7-5c992816ed18",
      "original_url":null,
      "created_at":"2015-03-10T23:32:35.269Z",
      "updated_at":"2015-03-10T23:32:35.269Z",
      "download_url":"https://atlas.hashicorp.com/3drobotics/boxes/ardupilot-sitl/versions/1.0/providers/virtualbox.box"
    }
  ]
}
