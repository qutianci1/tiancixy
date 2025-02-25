-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-07-27 13:51:21
-- @Last Modified time  : 2024-08-26 13:35:38
--{year =2022, month = 7, day =27, hour =0, min =0, sec = 00}
--年月日 时分秒
local 事件 = {
    名称 = '高级地煞星',
    是否打开 = true,
    开始时间 = os.time {year = 2022, month = 7, day = 25, hour = 0, min = 0, sec = 00},
    结束时间 = os.time {year = 2025, month = 7, day = 30, hour = 0, min = 0, sec = 00}
}

function 事件:事件初始化()
    self.NPC = {}
end
local _地图 = {
    {名称 = '地速星', 外形范围 = {40, 45}, 数量 = 2, 地图 = {1208, 1213, 1214, 1215, 1216}},
    {名称 = '地走星', 外形范围 = {40, 45}, 数量 = 2, 地图 = {1193}},
    {名称 = '地暗星', 外形范围 = {50, 55}, 数量 = 1, 地图 = {1236}},
    {名称 = '地魁星', 外形范围 = {50, 55}, 数量 = 1, 地图 = {1001}}
}

function 事件:更新()
    for i = 1, 4 do
        local 刷新范围 = {}
        if #_地图[i].地图 == 1 then
            for n=1,_地图[i].数量 do
                刷新范围[n] = _地图[i].地图[1]
            end
        else
            刷新范围[1] = _地图[i].地图[math.random(1, #_地图[i].地图)]
            local 临时地图 = _地图[i].地图[math.random(1, #_地图[i].地图)]
            while 刷新范围[1] == 临时地图 do
                临时地图 = _地图[i].地图[math.random(1, #_地图[i].地图)]
            end
            刷新范围[2] = 临时地图
        end
        for n=1,#刷新范围 do
            local map = self:取地图(刷新范围[n])
            if map then

                local X, Y = map:取随机坐标()
                local 外形 = math.random(_地图[i].外形范围[1], _地图[i].外形范围[2])
                local 种族 = 0
                if 外形 >= 40 and 外形 <= 41 or 外形 >= 50 and 外形 <= 51 then
                    种族 = 1
                elseif 外形 >= 42 and 外形 <= 43 or 外形 >= 52 and 外形 <= 53 then
                    种族 = 2
                elseif 外形 >= 44 and 外形 <= 45 or 外形 >= 54 and 外形 <= 55 then
                    种族 = 3
                end

                print('第十'..i..'星,刷新在'..map.名称..'场景'..',外形为'..外形..'种族为'..种族,X, Y)

                local NPC =
                    map:添加NPC {
                    名称 = _地图[i].名称,
                    外形 = 外形,
                    种族 = 种族,
                    等级 = i + 10,
                    时间 = 7200,--实际秒数*2
                    脚本 = 'scripts/event/高级地煞星.lua',
                    X = X,
                    Y = Y,
                    事件 = self
                }
            end
        end
    end
    self:发送系统('#C天下太平，国泰民安！#R第11、12、13、14、15级#C地煞星慕名下凡，现身于#R东海渔村、珊瑚海岛、海岛洞窟、长安城东、洛阳城、长安城...#C等各个地图角落，#C想与各英雄豪杰一较高下，奖励丰厚，机不可失，大家有胆的就上呀！#43')
    return not self.是否结束 and 7200
end

function 事件:事件开始()
    self:更新()
end

function 事件:事件结束()
    self.是否结束 = true
end
--=======================================================
local 对话 = [[没想到我躲在这里，也会被你们发现，休想抓我回去。#4
menu
1|妖孽，受死吧
2|我认错人了
]]
function 事件:NPC对话(玩家, i)
    return 对话
end

function 事件:NPC菜单(玩家, i)
    if i == '1' then
        local r = 玩家:进入战斗('scripts/event/高级地煞星.lua', self)
        if r then
            self:完成(玩家,self)
            self:删除()
        end
    end
end

--===============================================
--

function 事件:战斗初始化(玩家 , s)
    local 外形表 = {
        [1] = {
            [1] = {
                [1] = {40,40,40},
                [2] = {41,41,41}
            },
            [2] = {
                [1] = {42,42,42},
                [2] = {43,43,43}
            },
            [3] = {
                [1] = {44,44,44},
                [2] = {45,45,45}
            },
            [4] = {
                [1] = {44,44,44},
                [2] = {45,45,45}
            },
        },
        [2] = {
            [1] = {
                [1] = {40,40,40},
                [2] = {41,41,41}
            },
            [2] = {
                [1] = {42,42,42},
                [2] = {43,43,43}
            },
            [3] = {
                [1] = {44,44,44},
                [2] = {45,45,45}
            },
            [4] = {
                [1] = {44,44,44},
                [2] = {45,45,45}
            },
        },
        [3] = {
            [1] = {
                [1] = {50,50,50},
                [2] = {51,51,51}
            },
            [2] = {
                [1] = {52,52,52},
                [2] = {53,53,53}
            },
            [3] = {
                [1] = {54,54,54},
                [2] = {55,55,55}
            },
            [4] = {
                [1] = {54,54,54},
                [2] = {55,55,55}
            },
        },
        [4] = {
            [1] = {
                [1] = {50,50,50},
                [2] = {51,51,51}
            },
            [2] = {
                [1] = {52,52,52},
                [2] = {53,53,53}
            },
            [3] = {
                [1] = {54,54,54},
                [2] = {55,55,55}
            },
            [4] = {
                [1] = {54,54,54},
                [2] = {55,55,55}
            },
        }
    }
    local 怪物列表 = {
        [1] = {"地察星","地全星","地妖星","地藏星","地损星","地空星","地伏星","地角星","地嵇星","地速星"},
        [2] = {"地乐星","地退星","地妖星","地嵇星","地隐星","地遂星","地理星","地速星","地明星","地走星"},
        [3] = {"地佑星","地狂星","地兽星","地魁星","地然星","地正星","地猛星","地彗星","地暗星","地会星"},
        [4] = {"地魁星","地幽星","地魔星","地文星","地彗星","地灵星","地然星","地隐星","地奇星","地巧星"}
    }
    for i=1,3 do
        for n = #怪物列表[i] , 2 , -1 do
            local j = math.random(n)
            怪物列表[i][n] , 怪物列表[i][j] = 怪物列表[i][j] , 怪物列表[i][n]
        end
    end
    local 种族列表 = {
        [1] = {"地察星","地全星","地妖星","地乐星","地退星","地佑星","地狂星","地兽星","地魁星"},
        [2] = {"地藏星","地损星","地空星","地嵇星","地然星","地正星","地幽星","地魔星"},
        [3] = {"地伏星","地角星","地遂星","地理星","地速星","地猛星","地彗星","地文星","地灵星"},
        [4] = {"地嵇星","地速星","地明星","地走星","地暗星","地会星","地然星","地隐星","地奇星","地巧星"}
    }
    local 技能配置 = {
        [1] = {
            [1] = {
                [1] = {技能 = {{'谗言相加','借刀杀人', '失心狂乱'}, {'离魂咒','迷魂醉', '百日眠'}, {'天罗地网','作壁上观', '四面楚歌'}},抗性 = {{加强混乱 = 15 , 忽视抗混 = 10} , {加强昏睡 = 15 , 忽视抗睡 = 10} , {加强封印 = 15 , 忽视抗封 = 10} }},
                [2] = {技能 = {{'断肠烈散', '鹤顶红粉', '万毒攻心'}, {'离魂咒','迷魂醉', '百日眠'}, {'天罗地网','作壁上观', '四面楚歌'}},抗性 = {{加强毒伤害 = 10 } , {加强昏睡 = 15 , 忽视抗睡 = 10} , {加强封印 = 15 , 忽视抗封 = 10} }},
            },
            [2] = {
                [1] = {技能 = {{'魔神飞舞', '天外飞魔', '乾坤借速'},{'狮王之怒', '兽王神力', '魔神附身'},{'魔音摄心', '销魂蚀骨', '阎罗追命'}},抗性 = {{加强加速法术 = 5 } , {加强加攻法术 = 5} , {加强震慑 = 5} }},
                [2] = {技能 = {{'楚楚可怜', '魔神护体', '含情脉脉'},{'狮王之怒', '兽王神力', '魔神附身'},{'魔音摄心', '销魂蚀骨', '阎罗追命'}},抗性 = {{加强加防法术 = 5 } , {加强加攻法术 = 5} , {加强震慑 = 5} }},
            },
            [3] = {
                [1] = {技能 = {{'太乙生风', '风雷涌动', '袖里乾坤'},{'雷神怒击', '电闪雷鸣', '天诛地灭'},{'龙啸九天', '蛟龙出海', '九龙冰封'}},抗性 = {{加强风 = 15 , 忽视抗风 = 15 } , {加强雷 = 15 , 忽视抗雷 = 15} , {加强水 = 15 , 忽视抗水 = 15} }},
                [2] = {技能 = {{'三味真火', '烈火骄阳', '九阴纯火'},{'雷神怒击', '电闪雷鸣', '天诛地灭'},{'龙啸九天', '蛟龙出海', '九龙冰封'}},抗性 = {{加强火 = 15 , 忽视抗火 = 15 } , {加强雷 = 15 , 忽视抗雷 = 15} , {加强水 = 15 , 忽视抗水 = 15} }},
            },
            [4] = {
                 [1] = {技能 = {{'太乙生风', '风雷涌动', '袖里乾坤'},{'雷神怒击', '电闪雷鸣', '天诛地灭'},{'龙啸九天', '蛟龙出海', '九龙冰封'}},抗性 = {{加强风 = 15 , 忽视抗风 = 15 } , {加强雷 = 15 , 忽视抗雷 = 15} , {加强水 = 15 , 忽视抗水 = 15} }},
                [2] = {技能 = {{'三味真火', '烈火骄阳', '九阴纯火'},{'雷神怒击', '电闪雷鸣', '天诛地灭'},{'龙啸九天', '蛟龙出海', '九龙冰封'}},抗性 = {{加强火 = 15 , 忽视抗火 = 15 } , {加强雷 = 15 , 忽视抗雷 = 15} , {加强水 = 15 , 忽视抗水 = 15} }},
            }
        },
        [2] = {
            [1] = {
                [1] = {技能 = {{'谗言相加', '失心狂乱'}, {'离魂咒', '百日眠'}, {'天罗地网', '四面楚歌'}},抗性 = {{加强混乱 = 20 , 忽视抗混 = 15} , {加强昏睡 = 20 , 忽视抗睡 = 15} , {加强封印 = 20 , 忽视抗封 = 15} }},
                [2] = {技能 = {{'断肠烈散', '万毒攻心'}, {'离魂咒', '百日眠'}, {'天罗地网', '四面楚歌'}},抗性 = {{加强毒伤害 = 15 } , {加强昏睡 = 20 , 忽视抗睡 = 15} , {加强封印 = 20 , 忽视抗封 = 15} }},
            },
            [2] = {
                [1] = {技能 = {{'魔神飞舞', '乾坤借速'},{'狮王之怒', '魔神附身'},{'魔音摄心', '阎罗追命'}},抗性 = {{加强加速法术 = 8 } , {加强加攻法术 = 8} , {加强震慑 = 8} }},
                [2] = {技能 = {{'楚楚可怜', '含情脉脉'},{'狮王之怒', '魔神附身'},{'魔音摄心', '阎罗追命'}},抗性 = {{加强加防法术 = 8 } , {加强加攻法术 = 8} , {加强震慑 = 8} }},
            },
            [3] = {
                [1] = {技能 = {{'太乙生风', '袖里乾坤'},{'雷神怒击', '天诛地灭'},{'龙啸九天', '九龙冰封'}},抗性 = {{加强风 = 25 , 忽视抗风 = 20 } , {加强雷 = 25 , 忽视抗雷 = 20} , {加强水 = 25 , 忽视抗水 = 20} }},
                [2] = {技能 = {{'三味真火', '九阴纯火'},{'雷神怒击', '天诛地灭'},{'龙啸九天', '九龙冰封'}},抗性 = {{加强火 = 25 , 忽视抗火 = 20 } , {加强雷 = 25 , 忽视抗雷 = 20} , {加强水 = 25 , 忽视抗水 = 20} }},
            },
            [4] = {
                [1] = {技能 = {{'太乙生风', '袖里乾坤'},{'雷神怒击', '天诛地灭'},{'龙啸九天', '九龙冰封'}},抗性 = {{加强风 = 25 , 忽视抗风 = 20 } , {加强雷 = 25 , 忽视抗雷 = 20} , {加强水 = 25 , 忽视抗水 = 20} }},
                [2] = {技能 = {{'三味真火', '九阴纯火'},{'雷神怒击', '天诛地灭'},{'龙啸九天', '九龙冰封'}},抗性 = {{加强火 = 25 , 忽视抗火 = 20 } , {加强雷 = 25 , 忽视抗雷 = 20} , {加强水 = 25 , 忽视抗水 = 20} }},
            }
        },
        [3] = {
            [1] = {
                [1] = {技能 = {{'借刀杀人', '失心狂乱' , '作壁上观', '四面楚歌'}},抗性 = {{加强混乱 = 25 , 忽视抗混 = 18 , 加强封印 = 25 , 忽视抗封 = 18} }},
                [2] = {技能 = {{'鹤顶红粉', '万毒攻心' , '迷魂醉', '百日眠'} },抗性 = {{加强毒伤害 = 20 , 加强昏睡 = 25 , 忽视抗睡 = 18} }},
            },
            [2] = {
                [1] = {技能 = {{'魔神飞舞', '乾坤借速' , '魔音摄心', '阎罗追命'}},抗性 = {{加强加速法术 = 11 , 加强震慑 = 11} }},
                [2] = {技能 = {{'楚楚可怜', '含情脉脉' , '魔音摄心', '阎罗追命'}},抗性 = {{加强加防法术 = 11 , 加强震慑 = 11} }},
            },
            [3] = {
                [1] = {技能 = {{'太乙生风', '袖里乾坤' , '龙啸九天', '九龙冰封'}},抗性 = {{加强风 = 35 , 忽视抗风 = 25 , 加强水 = 35 , 忽视抗水 = 25} }},
                [2] = {技能 = {{'三味真火', '九阴纯火' , '雷神怒击', '天诛地灭'}},抗性 = {{加强火 = 35 , 忽视抗火 = 25 , 加强雷 = 35 , 忽视抗雷 = 25} }},
            },
            [4] = {
                [1] = {技能 = {{'太乙生风', '袖里乾坤' , '龙啸九天', '九龙冰封'}},抗性 = {{加强风 = 35 , 忽视抗风 = 25 , 加强水 = 35 , 忽视抗水 = 25} }},
                [2] = {技能 = {{'三味真火', '九阴纯火' , '雷神怒击', '天诛地灭'}},抗性 = {{加强火 = 35 , 忽视抗火 = 25 , 加强雷 = 35 , 忽视抗雷 = 25} }},
            }
        },
        [4] = {
            [1] = {
                [1] = {技能 = {{'失心狂乱' , '四面楚歌'}},抗性 = {{加强混乱 = 30 , 忽视抗混 = 22 , 加强封印 = 30 , 忽视抗封 = 22} }},
                [2] = {技能 = {{'万毒攻心' , '百日眠'} },抗性 = {{加强毒伤害 = 25 , 加强昏睡 = 30 , 忽视抗睡 = 22} }},
            },
            [2] = {
                [1] = {技能 = {{'乾坤借速' , '阎罗追命'}},抗性 = {{加强加速法术 = 15 , 加强震慑 = 15} }},
                [2] = {技能 = {{'含情脉脉' , '阎罗追命'}},抗性 = {{加强加防法术 = 15 , 加强震慑 = 15} }},
            },
            [3] = {
                [1] = {技能 = {{'袖里乾坤' , '九龙冰封'}},抗性 = {{加强风 = 45 , 忽视抗风 = 30 , 风系狂暴几率 = 20 , 加强水 = 35 , 忽视抗水 = 25 , 水系狂暴几率 = 20} }},
                [2] = {技能 = {{'九阴纯火' , '天诛地灭'}},抗性 = {{加强火 = 45 , 忽视抗火 = 30 , 火系狂暴几率 = 20 , 加强雷 = 35 , 忽视抗雷 = 25 , 雷系狂暴几率 = 20} }},
            },
            [4] = {
                [1] = {技能 = {{'袖里乾坤' , '九龙冰封'}},抗性 = {{加强风 = 45 , 忽视抗风 = 30 , 风系狂暴几率 = 20 , 加强水 = 35 , 忽视抗水 = 25 , 水系狂暴几率 = 20} }},
                [2] = {技能 = {{'九阴纯火' , '天诛地灭'}},抗性 = {{加强火 = 45 , 忽视抗火 = 30 , 火系狂暴几率 = 20 , 加强雷 = 35 , 忽视抗雷 = 25 , 雷系狂暴几率 = 20} }},
            }
        }
    }
    local 初值表 = {
        [1] = {
            [1] = {血初值 = {30000 , 8000} , 法初值 = {800 , 800} , 攻初值 = {200 , 200} , 敏初值 = {0 , 500}},--人族
            [2] = {血初值 = {30000 , 8000} , 法初值 = {800 , 800} , 攻初值 = {900 , 200} , 敏初值 = {0 , 1000}},--魔族
            [3] = {血初值 = {30000 , 9800} , 法初值 = {800 , 800} , 攻初值 = {900 , 200} , 敏初值 = {-100 , 600}},--仙族
            [4] = {血初值 = {30000 , 9800} , 法初值 = {800 , 800} , 攻初值 = {900 , 200} , 敏初值 = {-100 , 600}}--鬼族
        },
        [2] = {
            [1] = {血初值 = {80000 , 15000} , 法初值 = {800 , 800} , 攻初值 = {200 , 200} , 敏初值 = {0 , 900}},--人族
            [2] = {血初值 = {50000 , 10000} , 法初值 = {800 , 800} , 攻初值 = {1900 , 200} , 敏初值 = {0 , 1300}},--魔族
            [3] = {血初值 = {60000 , 18000} , 法初值 = {800 , 800} , 攻初值 = {900 , 200} , 敏初值 = {-100 , 1000}},--仙族
            [4] = {血初值 = {60000 , 18000} , 法初值 = {800 , 800} , 攻初值 = {900 , 200} , 敏初值 = {-100 , 1000}}--鬼族
        },
        [3] = {
            [1] = {血初值 = {80000 , 21000} , 法初值 = {800 , 800} , 攻初值 = {200 , 200} , 敏初值 = {200 , 1200}},--人族
            [2] = {血初值 = {55000 , 18000} , 法初值 = {800 , 800} , 攻初值 = {2200 , 200} , 敏初值 = {0 , 1700}},--魔族
            [3] = {血初值 = {85000 , 20000} , 法初值 = {800 , 800} , 攻初值 = {900 , 200} , 敏初值 = {-100 , 1400}},--仙族
            [4] = {血初值 = {60000 , 20000} , 法初值 = {800 , 800} , 攻初值 = {900 , 200} , 敏初值 = {-100 , 1400}}--鬼族
        },
        [4] = {
            [1] = {血初值 = {90000 , 21000} , 法初值 = {800 , 800} , 攻初值 = {200 , 200} , 敏初值 = {200 , 1200}},--人族
            [2] = {血初值 = {65000 , 18000} , 法初值 = {800 , 800} , 攻初值 = {2200 , 200} , 敏初值 = {0 , 1700}},--魔族
            [3] = {血初值 = {75000 , 20000} , 法初值 = {800 , 800} , 攻初值 = {900 , 200} , 敏初值 = {-100 , 1400}},--仙族
            [4] = {血初值 = {80000 , 20000} , 法初值 = {800 , 800} , 攻初值 = {900 , 200} , 敏初值 = {-100 , 1400}}--鬼族
        },
    }
    local 列表 = 怪物列表[s.等级 - 10]
    local 种族 , 性别
    local _怪物 = {}
    for i = 1 , #列表 do
        local 综合等级 = 20 + s.等级 * 10
        _怪物[i] = {名称 = 列表[i] , 等级 = 20 + s.等级 * 10 , 施法几率 = 100 , AI = {'互相拉血'} , 技能 = {}}
        for n = 1 , #种族列表 do
            for k = 1 , #种族列表[n] do
                if 列表[i] == 种族列表[n][k] then
                    种族 = n
                    break
                end
            end
        end

        if 种族 then
            _怪物[i].抗性 = 取种族抗性(种族,综合等级)
            _怪物[i].抗性.抗震慑 = 15 + ( s.等级 - 10 ) * 6
            性别 = math.random(1, 2)
            _怪物[i].外形 = 外形表[s.等级 - 10][种族][性别][math.random(1, #外形表[s.等级 - 10][种族][性别])]
            local 随机 = math.random(1, #技能配置[s.等级 - 10][种族][性别].技能)
            local 技能 = 技能配置[s.等级 - 10][种族][性别].技能[随机]
            if 技能 then
                for n = 1 , #技能 do
                    _怪物[i].技能[n] = {名称 = 技能[n] , 熟练度 = 13000 + (s.等级 - 10) * 3000}
                end
            end
            local 强法 = 技能配置[s.等级 - 10][种族][性别].抗性[随机]
            for k,v in pairs(强法) do
                if _怪物[i].抗性[k] then
                    _怪物[i].抗性[k] = _怪物[i].抗性[k] + v
                else
                    _怪物[i].抗性[k] = v
                end
            end
        end

        随机 = math.random(1, 2)
        _怪物[i].血初值 = 初值表[s.等级 - 10][种族].血初值[随机]
        _怪物[i].法初值 = 初值表[s.等级 - 10][种族].法初值[随机]
        _怪物[i].攻初值 = 初值表[s.等级 - 10][种族].攻初值[随机]
        _怪物[i].敏初值 = 初值表[s.等级 - 10][种族].敏初值[随机]
        if s.等级 < 14 then
            if 种族 == 1 or 种族 == 3 or 种族 == 4 then
                if 随机 == 1 then
                    _怪物[i].抗性.抗火 = 50
                    _怪物[i].抗性.抗水 = 50
                    _怪物[i].抗性.抗风 = 50
                    _怪物[i].抗性.抗雷 = 50
                end
            elseif 种族 == 2 then
                if 随机 == 1 then
                    _怪物[i].抗性.抗火 = 50
                    _怪物[i].抗性.抗水 = 50
                    _怪物[i].抗性.抗风 = 50
                    _怪物[i].抗性.抗雷 = 50
                    _怪物[i].抗性.忽视防御几率 = 100
                    _怪物[i].抗性.忽视防御程度 = 50
                    _怪物[i].抗性.连击次数 = 5
                    _怪物[i].抗性.连击率 = 80
                    _怪物[i].抗性.致命几率 = 50
                    _怪物[i].抗性.狂暴几率 = 50
                    _怪物[i].施法几率 = 0
                else
                    _怪物[i].抗性.连击次数 = 6
                    _怪物[i].抗性.连击率 = 80
                    _怪物[i].施法几率 = 80
                end
            end
        else
            if i == 1 then
                _怪物[i].血初值=888880
                _怪物[i].敏初值=300
                _怪物[i].抗性.抗火=60
                _怪物[i].抗性.抗水=60
                _怪物[i].抗性.抗风=60
                _怪物[i].抗性.抗雷=60
                _怪物[i].抗性.抗封印=140
                _怪物[i].抗性.抗混乱=140
                _怪物[i].抗性.抗昏睡=140
                _怪物[i].抗性.抗遗忘=140
                _怪物[i].抗性.忽视抗混=35
                _怪物[i].抗性.加强混乱=30
            elseif i == 2  then
                _怪物[i].血初值=388880
                _怪物[i].攻初值=3800
                _怪物[i].敏初值=-500
                _怪物[i].抗性.抗火=60
                _怪物[i].抗性.抗水=60
                _怪物[i].抗性.抗风=60
                _怪物[i].抗性.抗雷=60
                _怪物[i].抗性.抗封印=120
                _怪物[i].抗性.抗混乱=120
                _怪物[i].抗性.抗昏睡=120
                _怪物[i].抗性.抗遗忘=120
                _怪物[i].抗性.忽视抗震慑=15
                _怪物[i].抗性.忽视防御几率=100
                _怪物[i].抗性.忽视防御程度=85
                _怪物[i].抗性.连击次数=5
                _怪物[i].抗性.连击率=80
                _怪物[i].抗性.致命几率=75
                _怪物[i].抗性.狂暴几率=75
                _怪物[i].施法几率=50
            elseif i == 3 then
                _怪物[i].血初值=388880
                _怪物[i].攻初值=3800
                _怪物[i].敏初值=1100
                _怪物[i].抗性.抗火=60
                _怪物[i].抗性.抗水=60
                _怪物[i].抗性.抗风=60
                _怪物[i].抗性.抗雷=60
                _怪物[i].抗性.抗封印=120
                _怪物[i].抗性.抗混乱=120
                _怪物[i].抗性.抗昏睡=120
                _怪物[i].抗性.抗遗忘=120
                _怪物[i].抗性.忽视抗震慑=15
                _怪物[i].抗性.忽视防御几率=100
                _怪物[i].抗性.忽视防御程度=85
                _怪物[i].抗性.连击次数=5
                _怪物[i].抗性.连击率=100
                _怪物[i].抗性.致命几率=75
                _怪物[i].抗性.狂暴几率=75
                _怪物[i].施法几率=50
            elseif i == 4 or i == 5 then
                _怪物[i].血初值=130880
                _怪物[i].敏初值=2300
                _怪物[i].抗性.抗火=60
                _怪物[i].抗性.抗水=60
                _怪物[i].抗性.抗风=60
                _怪物[i].抗性.抗雷=60
                _怪物[i].抗性.抗封印=120
                _怪物[i].抗性.抗混乱=120
                _怪物[i].抗性.抗昏睡=120
                _怪物[i].抗性.抗遗忘=120
            elseif i == 6 then
                _怪物[i].血初值=158880
                _怪物[i].敏初值=1400
                _怪物[i].抗性.抗火=60
                _怪物[i].抗性.抗水=60
                _怪物[i].抗性.抗风=60
                _怪物[i].抗性.抗雷=60
                _怪物[i].抗性.抗封印=120
                _怪物[i].抗性.抗混乱=120
                _怪物[i].抗性.抗昏睡=120
                _怪物[i].抗性.抗遗忘=120
            elseif i == 7 or i == 9 then
                _怪物[i].血初值=88880
                _怪物[i].敏初值=-1000
                _怪物[i].抗性.抗火=60
                _怪物[i].抗性.抗水=60
                _怪物[i].抗性.抗风=60
                _怪物[i].抗性.抗雷=60
                _怪物[i].抗性.抗封印=140
                _怪物[i].抗性.抗混乱=140
                _怪物[i].抗性.抗昏睡=140
                _怪物[i].抗性.抗遗忘=140
            elseif i == 8 or i == 10 then
                _怪物[i].血初值=78880
                _怪物[i].敏初值=800
                _怪物[i].抗性.抗火=60
                _怪物[i].抗性.抗水=60
                _怪物[i].抗性.抗风=60
                _怪物[i].抗性.抗雷=60
                _怪物[i].抗性.抗封印=140
                _怪物[i].抗性.抗混乱=140
                _怪物[i].抗性.抗昏睡=140
                _怪物[i].抗性.抗遗忘=140
            end
        end
    end
    for i = 1, #列表 do
        local r = 生成战斗怪物(生成怪物属性(_怪物[i]))
        self:加入敌方(i, r)
    end
end

function 事件:战斗回合开始(dt)
end

function 事件:战斗结束(x, y)
end
--===============================================
function 事件:完成(玩家)
    if 玩家.是否组队 then
        for _, v in 玩家:遍历队伍() do
            self:掉落包(v)
        end
    else
        self:掉落包(玩家)
    end
end
local _掉落 = {
    {几率 = 880, 名称 = '神兵礼盒', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 900, 名称 = '仙器礼盒', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 750, 名称 = '神兽碎片', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 810, 名称 = '六魂之玉', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 811, 名称 = '高级悔梦石', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 812, 名称 = '神兵石', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 813, 名称 = '悔梦石', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 814, 名称 = '见闻录', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 815, 名称 = '天外飞石', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 816, 名称 = '超级人参果王', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 817, 名称 = '超级元气丹', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 818, 名称 = '超级神兽丹', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 819, 名称 = '超级炼妖自选礼包', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 850, 名称 = '超级金柳露', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 851, 名称 = '高级金柳露', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 852, 名称 = '盘古精铁', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 856, 名称 = '补天神石', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 854, 名称 = '超级变色丹', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
    {几率 = 855, 名称 = '超级炼妖自选礼包', 数量 = 1, 广播 = '#C玩家%s在挑战高级地煞星中 获得了一个#G#m(%s)[%s]#m#n#50'},
}
function 事件:掉落包(玩家)
    local 银子 = 55555
    local 经验 = 50000 * (玩家.等级 * 0.15)
    --(1+玩家.其它.鬼王次数*1.2)

    if 玩家:判断等级是否高于(142) and 玩家:判断等级是否低于(90) then --90-142
        -- 玩家:常规提示("#Y适合事件90-142级玩家参与！")
        玩家:添加参战召唤兽经验(经验, "高级地煞星")
        return
    end
    玩家:添加参战召唤兽经验(经验 * 1.5)
    玩家:添加银子(银子)
    玩家:添加经验(经验)

    if 玩家:取活动限制次数('小金鲤') > 200 then
        return
    end
    玩家:增加活动限制次数('小金鲤')
    for i, v in ipairs(_掉落) do
        if math.random(1000) <= v.几率 then
            local r = 生成物品 {名称 = v.名称, 数量 = v.数量, 参数 = v.参数}
            if r then
                玩家:添加物品({r})
                if v.广播 then
                    玩家:发送系统(v.广播, 玩家.名称, r.ind, r.名称)
                end
                break
            end
        end
    end
end
return 事件
