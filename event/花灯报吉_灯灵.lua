-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-07-27 13:51:21
-- @Last Modified time  : 2024-08-26 13:35:42
--{year =2022, month = 7, day =27, hour =0, min =0, sec = 00}
--年月日 时分秒
local 事件 = {
    名称 = '花灯报吉_灯灵',
    是否打开 = true,
    开始时间 = os.time {year = 2022, month = 7, day = 25, hour = 0, min = 0, sec = 00},
    结束时间 = os.time {year = 2025, month = 7, day = 30, hour = 0, min = 0, sec = 00}
}

function 事件:事件初始化()
    self.NPC = {}
end

local _地图 = {1110, 1173, 1174, 1092, 1217, 101299}
local _模型 = {2113, 2096}

function 事件:更新()
    for a, b in pairs(_地图) do
        local map = self:取地图(b)
        local 随机 = math.random(25, 35)
        for i = 1, 随机 do
            local X, Y = map:取随机坐标()
            local NPC =
                map:添加NPC {
                名称 = '灯灵',
                称谓 = '花灯报吉',
                外形 = _模型[math.random(#_模型)],
                脚本 = 'scripts/event/花灯报吉_灯灵.lua',
                时间 = 7200,
                X = X,
                Y = Y,
                事件 = self
            }
        end
    end
    self:发送系统('#G王母娘娘让代表着祥和与安康的灯灵下凡人间为人们送去祝福，不料有些灯灵却被妖怪感化与妖怪一起祸害人间，各位侠士可组队前往#W大唐境内、大唐边境、北俱芦洲、傲来国、蟠桃园后、万寿山 #G这个六个地方寻找灯灵并降服。')
    return not self.是否结束 and 900000
end

function 事件:事件开始()
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
        local r = 玩家:进入战斗('scripts/event/花灯报吉_灯灵.lua', self)
        if r then
            self:完成(玩家)
            self:删除()
        end
    end
end

--===============================================

function 事件:战斗初始化(玩家,NPC)
    local 等级 = 玩家:取队伍平均等级()
    local _怪物 = {
        { 名称 = NPC.名称, 外形 = NPC.外形, 等级=等级, 血初值 = 4800, 法初值 = 50, 攻初值 = 50, 敏初值 = 300 , 施法几率 = 50,是否消失 = false},
        { 名称 = "花魂", 外形 = 2012, 等级=等级, 血初值 = 3500, 法初值 = 50, 攻初值 = 20, 敏初值 = 120,施法几率 = 50,是否消失 = false},
        { 名称 = "琴妖", 外形 = 2100, 等级=等级, 血初值 = 3500, 法初值 = 50, 攻初值 = 20, 敏初值 = 120,施法几率 = 50,是否消失 = false},
        { 名称 = "剑魄", 外形 = 2109, 等级=等级, 血初值 = 3500, 法初值 = 50, 攻初值 = 20, 敏初值 = 120,施法几率 = 50,是否消失 = false},
        { 名称 = "罗刹", 外形 = 2107, 等级=等级, 血初值 = 3500, 法初值 = 50, 攻初值 = 20, 敏初值 = 120,施法几率 = 50,是否消失 = false},
        { 名称 = "雪魂", 外形 = 2099, 等级=等级, 血初值 = 3500, 法初值 = 50, 攻初值 = 20, 敏初值 = 120,施法几率 = 50,是否消失 = false},
        { 名称 = "玉魅", 外形 = 2011, 等级=等级, 血初值 = 3500, 法初值 = 50, 攻初值 = 20, 敏初值 = 120,施法几率 = 50,是否消失 = false},
        { 名称 = "画魂", 外形 = 2115, 等级=等级, 血初值 = 3500, 法初值 = 50, 攻初值 = 20, 敏初值 = 120,施法几率 = 50,是否消失 = false},
    }
    for i=1,8 do
        local r = {}
        if i ~= 1 then
            r = 生成战斗怪物(生成怪物属性(_怪物[i],'中等',nil,'低级法术'))
        else
            r = 生成战斗怪物(生成怪物属性(_怪物[i],'困难',nil,'高级法术'))
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
    if 玩家:取活动限制次数('灯灵') >= 120 then
        玩家:常规提示('本日奖励次数已尽,无法继续获得奖励')
        return
    end
    玩家:增加活动限制次数('灯灵')
    local 银子 = 22222
    local 经验 = 30000 * (玩家.等级 * 0.15)
    --(1+玩家.其它.鬼王次数*1.2)
    玩家:添加参战召唤兽经验(经验 * 1.5, "灯灵")
    玩家:添加银子(银子, "灯灵")
    玩家:添加经验(经验, "灯灵")
    local 奖励 = 是否奖励(2010,玩家.等级,玩家.转生)
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
