local NPC = {}
local 对话 = [[
欢迎到来本酒店！这位客官看了是辛苦了，是要住店吧？
menu
1|我要住店
2|我只是向了解以下价钱
3|我只是路过看看
]]

function NPC:NPC对话(玩家, i)
    return 对话
end

function NPC:NPC菜单(玩家, i)
    if i == '1' then
        if 玩家.银子 < 20000 then
            return "你没有那么多银子"
        end
        玩家:扣除银子(20000)
        玩家:住店()
        return "你的气血、魔法得到恢复"
    elseif i == '2' then
    elseif i == '3' then
    elseif i == '4' then
    end
end

return NPC
