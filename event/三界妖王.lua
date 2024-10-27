-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2023-04-30 06:48:23
-- @Last Modified time  : 2024-08-26 13:36:12

local 事件 = {
    名称 = '三界妖王',
    是否打开 = true,
    开始时间 = os.time {year = 2022, month = 7, day = 25, hour = 0, min = 0, sec = 00},
    结束时间 = os.time {year = 2025, month = 7, day = 30, hour = 0, min = 0, sec = 00}
}

function 事件:事件初始化()
    self.NPC = {}
end

function 事件:更新()
end

function 事件:事件开始()
end

function 事件:事件结束()
    self.是否结束 = true
end


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
        local r = 玩家:进入战斗('scripts/event/三界妖王.lua', self)
        if r then
            self:完成(玩家,self)
            self:删除()
        end
    end
end

--===============================================
local 技能表={[1]={{名称="失心狂乱",熟练度=18000}},[2]={{名称="阎罗追命",熟练度=15000},{名称="含情脉脉",熟练度=15000},{名称="魔神附身",熟练度=15000}},[3]={{名称="袖里乾坤",熟练度=15000},{名称="天诛地灭",熟练度=15000},{名称="九阴纯火",熟练度=15000},{名称="九龙冰封",熟练度=15000}},[4]={{名称="血海深仇",熟练度=15000}},[5]={{名称="万毒攻心",熟练度=20000}},[6]={{名称="天诛地灭",熟练度=20000}}}
local _怪物 = {
    { 名称 = "三界妖王", 外形 = 2018,等级 = 100, 血初值=3000,法初值=0,攻初值=108,敏初值=12,施法几率=70,技能=技能表[1],抗性={抗混乱=110,抗昏睡=80,抗震慑=15,物理吸收率=50}},
    { 名称 = "三界妖王", 外形 = 2018,等级 = 100, 血初值=3000,法初值=0,攻初值=108,敏初值=12,施法几率=70,技能=技能表[2],抗性={抗混乱=110,抗昏睡=80,抗震慑=15,物理吸收率=50}},
    { 名称 = "三界妖王", 外形 = 2018,等级 = 100, 血初值=3000,法初值=0,攻初值=108,敏初值=12,施法几率=70,技能=技能表[3],抗性={抗混乱=110,抗昏睡=80,抗震慑=15,物理吸收率=50,抗风=30,抗火=40,抗雷=40,抗水=40}},
    { 名称 = "千年黑熊精", 外形 = 2006,等级 = 100, 血初值=2600,法初值=0,攻初值=800,敏初值=72,抗性={抗混乱=80,连击率=75,连击次数=5,忽视防御几率=60,忽视防御程度=60}},
    { 名称 = "千年黑熊精", 外形 = 2006,等级 = 100, 血初值=2600,法初值=0,攻初值=800,敏初值=72,抗性={抗混乱=80,连击率=75,连击次数=5,忽视防御几率=60,忽视防御程度=60}},
    { 名称 = "蓝色妖王", 外形 = 2026,等级 = 100, 血初值=2600,法初值=0,攻初值=108,敏初值=12,施法几率=50,技能=技能表[4],抗性={抗混乱=80,抗昏睡=60,抗震慑=10,物理吸收率=40}},
    { 名称 = "千年老妖", 外形 = 2073,等级 = 100, 血初值=2600,法初值=0,攻初值=108,敏初值=12,施法几率=50,技能=技能表[5],抗性={抗混乱=80,抗昏睡=60,抗震慑=10,物理吸收率=40}},
    { 名称 = "地狱战神", 外形 = 2074,等级 = 100, 血初值=2600,法初值=0,攻初值=108,敏初值=12,施法几率=50,技能=技能表[6],抗性={抗混乱=80,抗昏睡=60,抗震慑=10,物理吸收率=40}},
}
function 事件:战斗初始化(玩家 , s)
    for i = 1, 8 do
        _怪物[i].等级 = 100
        if 玩家.等级 then
            _怪物[i].等级 = 玩家.等级
        end
        local r = 生成战斗怪物(生成怪物属性(_怪物[i]))
        self:加入敌方(i, r)
    end
end

function 事件:战斗回合开始(dt)
end

function 事件:战斗结束(x, y)
end
--===============================================
function 事件:完成(玩家,s)
    if 玩家.是否组队 then
        for _, v in 玩家:遍历队伍() do
            self:掉落包(v,s)
        end
    else
        self:掉落包(玩家,s)
    end
end

function 事件:掉落包(玩家,s)
    local 银子 = 28000
    local 经验 = 30000 * (玩家.等级 * 0.15)

    玩家:添加银子(银子)
    玩家:添加任务经验(经验, '地煞星')
    local 奖励 = 是否奖励(2001,玩家.等级,玩家.转生)
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