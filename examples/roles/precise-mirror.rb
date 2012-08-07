name "precise-mirror"
description "Mirror 'precise' from Ubuntu"

override_attributes(
  "apt-mirror" => {
    "arch" => "amd64",
    "sources" => {
      "http://us.mirror.ubuntu.com" => {
        "/ubuntu" => {
          "release" => "precise",
          "suites" => [
            "main",
            "universe",
            "multiverse"
          ]
        }
      }
    }
  }
)
