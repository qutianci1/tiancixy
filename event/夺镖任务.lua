-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-07-27 13:51:21
-- @Last Modified time  : 2024-08-23 22:21:32
--{year =2022, month = 7, day =27, hour =0, min =0, sec = 00}
--年月日 时分秒
local 事件 = {
    名称 = '夺镖任务',
    是否打开 = true,
    开始时间 = os.time {year = 2022, month = 7, day = 25, hour = 0, min = 0, sec = 00},
    结束时间 = os.time {year = 2025, month = 7, day = 30, hour = 0, min = 0, sec = 00}
}

function 事件:事件初始化()
    self.NPC = {}
end

local _主怪信息 = {
    [1] = {名称 = '长风镖局', 模型 = 3117},
    [2] = {名称 = '龙虎镖局', 模型 = 3015},
    [3] = {名称 = '鼎信镖局', 模型 = 2083}
}
function 事件:更新()
    self.刷出地图 = {1193, 1110, 1194, 1173, 1091, 1092}
    local 地图组 = {}
    for _ = 1, 2 do
        local map = self:取随机地图(self.刷出地图)
        for i, v in ipairs(self.刷出地图) do
            if v == map.id then
                table.remove(self.刷出地图, i)
                break
            end
        end
        table.insert(地图组, map.名称)
        for _ = 1, 15 do
            local X, Y = map:取随机坐标()
            local xz = math.random(#_主怪信息)
            local NPC =
                map:添加NPC {
                名称 = _主怪信息[xz].名称,
                外形 = _主怪信息[xz].模型,
                时间 = 7200,
                脚本 = 'scripts/event/夺镖任务.lua',
                X = X,
                Y = Y,
                事件 = self
            }
        end
    end
    self.刷出地图 = {1193, 1110, 1194, 1173, 1091, 1092}
    self:发送系统('#G押运贪官镖银的车队正在路过#W%s，#G请各位有志之士火速前往，夺取镖银。#90', table.concat(地图组, '、'))
    return not self.是否结束 and 3600000
    --3600000
end

function 事件:事件开始()
    if os.date('%w', os.time()) == '1' then
        print('夺镖任务活动开始了')
        self:定时(3600000, self.更新)
    end
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
        local 通过 = true
        if 玩家.是否组队 then
            for _, v in 玩家:遍历队伍() do
                if v.外形 ~= 2044 then
                    通过 = false
                end
            end
        else
            if 玩家.外形 ~= 2044 then
                通过 = false
            end
        end
        if not 通过 then
            玩家:提示窗口('#Y去去去,小孩别闹,不然吃了你#4#R需变身强盗')
            return
        end
        local r = 玩家:进入战斗('scripts/event/夺镖任务.lua')
        if r then
            self:完成(玩家)
        end
    end
end

--===============================================
local _怪物 = {
    { 名称 = "总镖师", 外形 = 2077,等级 = 1, 血初值=1120,法初值=200,攻初值=168,敏初值=68,成长 = 3,施法几率=60,技能={{名称 = '谗言相加' , 熟练度 = 12000},{名称 = '借刀杀人' , 熟练度 = 12000},{名称 = '失心狂乱' , 熟练度 = 12000}},抗性={抗混乱=90,抗昏睡=90,抗封印=50,抗遗忘=50,抗震慑=10,抗风=15,抗雷=15,抗水=15,抗火=15,物理吸收率=30,忽视抗混=3,忽视抗封=3,忽视抗睡=3}},
    { 名称 = "副总镖师", 外形 = 3,等级 = 1, 血初值=1650,法初值=200,攻初值=1080,敏初值=120,成长 = 3,施法几率=50,技能={{名称 = '离魂咒' , 熟练度 = 12000},{名称 = '迷魂醉' , 熟练度 = 12000},{名称 = '百日眠' , 熟练度 = 12000}},抗性={抗混乱=80,抗昏睡=80,抗封印=50,抗遗忘=50,抗震慑=8,抗风=10,抗雷=10,抗水=10,抗火=10,物理吸收率=20,忽视抗混=3,忽视抗封=3,忽视抗睡=3}},
    { 名称 = "副总镖师", 外形 = 3,等级 = 1, 血初值=1480,法初值=200,攻初值=1080,敏初值=120,成长 = 3,施法几率=50,技能={{名称 = '离魂咒' , 熟练度 = 12000},{名称 = '迷魂醉' , 熟练度 = 12000},{名称 = '百日眠' , 熟练度 = 12000}},抗性={抗混乱=80,抗昏睡=80,抗封印=50,抗遗忘=50,抗震慑=8,抗风=10,抗雷=10,抗水=10,抗火=10,物理吸收率=20,忽视抗混=3,忽视抗封=3,忽视抗睡=3}},
    { 名称 = "镖师", 外形 = 2048,等级 = 1, 血初值=960,法初值=200,攻初值=80,敏初值=68,成长 = 3,施法几率=50,抗性={抗混乱=70,抗昏睡=70,抗封印=40,抗遗忘=40,抗震慑=5,物理吸收率=20,忽视抗混=3,忽视抗封=3,忽视抗睡=3,加强风=20,加强水=20,加强火=20,加强雷=20,加强鬼火=20}},
    { 名称 = "镖师", 外形 = 2048,等级 = 1, 血初值=840,法初值=200,攻初值=680,敏初值=108,成长 = 3,施法几率=50,抗性={抗混乱=70,抗昏睡=70,抗封印=40,抗遗忘=40,抗震慑=5,物理吸收率=20,忽视抗混=3,忽视抗封=3,忽视抗睡=3,加强风=20,加强水=20,加强火=20,加强雷=20,加强鬼火=20}},
    { 名称 = "镖师", 外形 = 2048,等级 = 1, 血初值=890,法初值=200,攻初值=64,敏初值=76,成长 = 3,施法几率=50,抗性={抗混乱=70,抗昏睡=70,抗封印=40,抗遗忘=40,抗震慑=5,物理吸收率=20,忽视抗混=3,忽视抗封=3,忽视抗睡=3,加强风=20,加强水=20,加强火=20,加强雷=20,加强鬼火=20}},
    { 名称 = "镖师", 外形 = 2048,等级 = 1, 血初值=890,法初值=200,攻初值=27,敏初值=58,成长 = 3,施法几率=50,抗性={抗混乱=70,抗昏睡=70,抗封印=40,抗遗忘=40,抗震慑=5,物理吸收率=20,忽视抗混=3,忽视抗封=3,忽视抗睡=3,加强风=20,加强水=20,加强火=20,加强雷=20,加强鬼火=20}},
}

function 事件:战斗初始化(玩家)
    for i=1,7 do
        _怪物[i].等级 = 80
        if 玩家.等级 then
            _怪物[i].等级 = 玩家.等级
        end
        local r = {}
        if i <= 3 then
            r = 生成战斗怪物(生成怪物属性(_怪物[i]))
        else
            r = 生成战斗怪物(生成怪物属性(_怪物[i] , nil , nil , '高级法术'))
        end
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

function 事件:掉落包(玩家)
    if 玩家:取活动限制次数('夺镖任务') >= 120 then
        玩家:提示窗口('本日奖励次数已尽,无法继续获得奖励')
        return
    end
    玩家:增加活动限制次数('夺镖任务')

    local 银子 = 3333
    local 经验 = 30000 * (玩家.等级 * 0.15)
    玩家:添加参战召唤兽经验(经验 * 1.5)
    玩家:添加银子(银子)
    玩家:添加经验(经验)
    local 奖励 = 是否奖励(2013,玩家.等级,玩家.转生)
    if 奖励 ~= nil and type(奖励) == 'table' then
        local r = 生成物品 { 名称 = 奖励.道具信息.道具, 数量 = 奖励.道具信息.数量, 参数 = 奖励.道具信息.参数 }
        if r then
            玩家:添加物品({ r })
            if 奖励.道具信息.是否广播 == 1 and 奖励.广播 ~= nil then
                玩家:发送系统(奖励.广播, 玩家.名称, r.ind, r.名称)
            end
        end
    end
end

return 事件
