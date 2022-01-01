# custom-theme

從保哥那邊改的 


```json
{
    "final_space": true,
    "console_title": true,
    "console_title_style": "folder",
    "blocks": [
        {
            "type": "prompt",
            "alignment": "left",
            "horizontal_offset": 0,
            "vertical_offset": 0,
            "segments": [
                {
                  "type": "os",
                  "style": "diamond",
                  "foreground": "#000000",
                  "background": "#d3d7cf",
                  "leading_diamond": ""
                },
                {
                  "type": "battery",
                  "style": "powerline",
                  "powerline_symbol": "\uE0B0",
                  "foreground": "#193549",
                  "background": "#ffeb3b",
                  "properties": {
                    "battery_icon": "",
                    "discharging_icon": "\uE231 ",
                    "charging_icon": "\uE234 ",
                    "charged_icon": "\uE22F ",
                    "color_background": true,
                    "charged_color": "#4caf50",
                    "charging_color": "#40c4ff",
                    "discharging_color": "#ff5722",
                    "postfix": "\uF295 ",
                    "display_charging": true,
                    "display_charged": true
                  }
                },
                {
                    "type": "path",
                    "style": "powerline",
                    "powerline_symbol": "",
                    "invert_powerline": false,
                    "foreground": "#ffffff",
                    "background": "#ff479c",
                    "properties": {
                        "style": "folder"
                    }
                },
                {
                    "type": "git",
                    "style": "powerline",
                    "powerline_symbol": "",
                    "invert_powerline": false,
                    "foreground": "#193549",
                    "background": "#fffb38",
                    "leading_diamond": "",
                    "trailing_diamond": "",
                    "properties": {
                        "display_status": true,
                        "display_stash_count": true,
                        "display_upstream_icon": true,
                        "github_icon": "",
                        "gitlab_icon": "",
                        "branch_behind_icon": "<#88C0D0>\u21e3 </>",
                        "local_working_icon": "<#FFAFD7>\u002a</>"
                    }
                },
                {
                    "type": "dotnet",
                    "style": "powerline",
                    "powerline_symbol": "",
                    "invert_powerline": false,
                    "foreground": "#ffffff",
                    "background": "#6CA35E",
                    "leading_diamond": "",
                    "trailing_diamond": "",
                    "properties": {
                        "display_version": true,
                        "prefix": "  "
                    }
                },
                {
                    "type": "azfunc",
                    "style": "powerline",
                    "powerline_symbol": "\uE0B0",
                    "foreground": "#ffffff",
                    "background": "#FEAC19",
                    "properties": {
                        "prefix": " \uf0e7 ",
                        "display_version": true,
                        "display_mode": "files"
                    }
                },
                {
                  "type": "node",
                  "style": "powerline",
                  "powerline_symbol": "\uE0B0",
                  "foreground": "#ffffff",
                  "background": "#6CA35E",
                  "properties": {
                    "prefix": " \uE718 "
                  }
                },
                {
                  "type": "java",
                  "style": "powerline",
                  "powerline_symbol": "\uE0B0",
                  "foreground": "#ffffff",
                  "background": "#4063D8",
                  "properties": {
                    "prefix": " \uE738 "
                  }
                },
                {
                  "type": "go",
                  "style": "powerline",
                  "powerline_symbol": "\uE0B0",
                  "foreground": "#ffffff",
                  "background": "#7FD5EA",
                  "properties": {
                    "prefix": " \uFCD1 "
                  }
                },
                {
                    "type": "root",
                    "style": "powerline",
                    "powerline_symbol": "",
                    "invert_powerline": false,
                    "foreground": "#ffffff",
                    "background": "#ffff66",
                    "leading_diamond": "",
                    "trailing_diamond": "",
                    "properties": null
                },
                {
                    "type": "exit",
                    "style": "powerline",
                    "powerline_symbol": "",
                    "invert_powerline": false,
                    "foreground": "#ffffff",
                    "background": "#2e9599",
                    "leading_diamond": "",
                    "trailing_diamond": "",
                    "properties": {
                        "always_enabled": true,
                        "color_background": true,
                        "display_exit_code": false,
                        "error_color": "#f1184c",
                        "prefix": " "
                    }
                }
            ]
        }
    ]
}
```